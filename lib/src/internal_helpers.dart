import 'dart:async';
import 'dart:js_interop';
import '../runtime.dart';
import 'js/events.dart' as js;

export 'dart:async' show Completer;
export 'dart:js_interop';
export 'chrome.dart';

// A dummy property to use in all generated file to prevent unused imports of this file
final alwaysTrue = true;

extension ScopingFunctions<T extends Object?> on T {
  /// Calls the specified function [block] with `this` value
  /// as its argument and returns its result.
  R let<R>(R Function(T e) block) => block(this);
}

bool checkRuntimeLastError(Completer completer) {
  if (chrome.runtime.lastError case var error?) {
    completer.completeError(Exception('RuntimeLastError: ${error.message}'));
    return false;
  }
  return true;
}

extension ListToJsExtension<T> on List<T> {
  JSArray toJSArray(Object Function(T) mapper) {
    return map(mapper).cast<JSAny>().toList().toJS;
  }

  JSArray toJSArrayString() {
    return toJSArray((e) => e.toString());
  }
}

extension JSAnyExtension on JSAny {
  Map toDartMap() {
    var map = dartify()! as Map;
    return _convertNestedStructures(map) as Map;
  }

  dynamic _convertNestedStructures(dynamic value) {
    if (value is Map) {
      return value.map((k, v) => MapEntry(k, _convertNestedStructures(v)));
    } else if (value is List) {
      return value.map((item) => _convertNestedStructures(item)).toList();
    }
    return value;
  }
}

extension JSChoiceExtension<T extends JSAny> on T {
  Object when({
    int Function(int)? isInt,
    double Function(double)? isDouble,
    bool Function(bool)? isBool,
    String Function(String)? isString,
    List Function(JSArray)? isArray,
    Map Function(JSAny)? isMap,
    Object Function(Object)? isOther,
  }) {
    if (isArray != null && isA<JSArray>()) {
      // ignore: invalid_runtime_check_with_js_interop_types
      return isArray(this as JSArray);
    }
    if (isInt != null && (isA<JSNumber>())) {
      return isInt((dartify()! as num).toInt());
    }
    if (isDouble != null && (isA<JSNumber>())) {
      return isDouble((dartify()! as num).toDouble());
    }
    if (isBool != null && (isA<JSBoolean>())) {
      return isBool(dartify()! as bool);
    }
    if (isString != null && (isA<JSString>())) {
      return isString(dartify()! as String);
    }
    if (isMap != null && isA<JSObject>()) {
      return isMap(this as JSAny);
    }
    if (isOther != null) {
      return isOther(this);
    }

    throw Exception('Unknown javascript object $this $runtimeType');
  }
}

extension EventStreamExtension on js.Event {
  EventStream<T> asStream<T>(
    JSFunction Function(void Function(T)) callbackFactory,
  ) {
    return EventStream<T>(this, callbackFactory);
  }
}

class EventStream<T> extends Stream<T> {
  final js.Event _target;
  final JSFunction Function(void Function(T)) _callbackFactory;

  EventStream(this._target, this._callbackFactory);

  @override
  Stream<T> asBroadcastStream({
    void Function(StreamSubscription<T>)? onListen,
    void Function(StreamSubscription<T>)? onCancel,
  }) => this;

  @override
  bool get isBroadcast => true;

  @pragma('dart2js:tryInline')
  @override
  StreamSubscription<T> listen(
    dynamic Function(T)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) => _EventStreamSubscription<T>(this._target, onData, _callbackFactory);
}

class _EventStreamSubscription<T> implements StreamSubscription<T> {
  int _pauseCount = 0;
  js.Event? _target;
  dynamic Function(T)? _onData;
  late final JSFunction _callback;

  _EventStreamSubscription(
    this._target,
    this._onData,
    JSFunction Function(dynamic Function(T)) callbackFactory,
  ) {
    _callback = callbackFactory(_wrapZone(_addData));
    _tryResume();
  }

  dynamic _addData(T data) {
    return _onData?.call(data);
  }

  @override
  Future<void> cancel() {
    final emptyFuture = Future<void>.value();
    if (_canceled) return emptyFuture;

    _unlisten();
    // Clear out the target to indicate this is complete.
    _target = null;
    _onData = null;
    return emptyFuture;
  }

  bool get _canceled => _target == null;

  @override
  void onData(void Function(T)? handleData) {
    if (_canceled) {
      throw StateError('Subscription has been canceled.');
    }
    _unlisten();
    _onData = handleData;
    _tryResume();
  }

  @override
  void onError(Function? handleError) {}

  @override
  void onDone(void Function()? handleDone) {}

  @override
  void pause([Future<dynamic>? resumeSignal]) {
    if (_canceled) return;
    ++_pauseCount;
    _unlisten();

    if (resumeSignal != null) {
      resumeSignal.whenComplete(resume);
    }
  }

  @override
  bool get isPaused => _pauseCount > 0;

  @override
  void resume() {
    if (_canceled || !isPaused) return;
    --_pauseCount;
    _tryResume();
  }

  void _tryResume() {
    if (_onData != null && !isPaused) {
      _target!.addListener(_callback);
    }
  }

  void _unlisten() {
    if (_onData != null) {
      _target!.removeListener(_callback);
    }
  }

  @override
  Future<E> asFuture<E>([E? futureValue]) =>
      // We just need a future that will never succeed or fail.
      Completer<E>().future;
}

R Function(T) _wrapZone<T, R>(R Function(T) callback) {
  // For performance reasons avoid wrapping if we are in the root zone.
  if (Zone.current == Zone.root) return callback;
  return Zone.current.bindUnaryCallback(callback);
}
