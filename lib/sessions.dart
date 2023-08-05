// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/sessions.dart' as $js;
import 'tabs.dart';
import 'windows.dart';

export 'src/chrome.dart' show chrome;

final _sessions = ChromeSessions._();

extension ChromeSessionsExtension on Chrome {
  /// Use the `chrome.sessions` API to query and restore tabs and windows from a
  /// browsing session.
  ChromeSessions get sessions => _sessions;
}

class ChromeSessions {
  ChromeSessions._();

  bool get isAvailable => $js.chrome.sessionsNullable != null && alwaysTrue;

  /// Gets the list of recently closed tabs and/or windows.
  Future<List<Session>> getRecentlyClosed(Filter? filter) async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.sessions.getRecentlyClosed(filter?.toJS));
    return $res.toDart
        .cast<$js.Session>()
        .map((e) => Session.fromJS(e))
        .toList();
  }

  /// Retrieves all devices with synced sessions.
  Future<List<Device>> getDevices(Filter? filter) async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.sessions.getDevices(filter?.toJS));
    return $res.toDart.cast<$js.Device>().map((e) => Device.fromJS(e)).toList();
  }

  /// Reopens a [windows.Window] or [tabs.Tab], with an optional callback to run
  /// when the entry has been restored.
  /// [sessionId] The [windows.Window.sessionId], or [tabs.Tab.sessionId] to
  /// restore. If this parameter is not specified, the most recently closed
  /// session is restored.
  Future<Session> restore(String? sessionId) async {
    var $res = await promiseToFuture<$js.Session>(
        $js.chrome.sessions.restore(sessionId));
    return Session.fromJS($res);
  }

  /// The maximum number of [sessions.Session] that will be included in a
  /// requested list.
  int get maxSessionResults => $js.chrome.sessions.MAX_SESSION_RESULTS;

  /// Fired when recently closed tabs and/or windows are changed. This event
  /// does not monitor synced sessions changes.
  EventStream<void> get onChanged =>
      $js.chrome.sessions.onChanged.asStream(($c) => () {
            return $c(null);
          });
}

class Filter {
  Filter.fromJS(this._wrapped);

  Filter(
      {
      /// The maximum number of entries to be fetched in the requested list. Omit
      /// this parameter to fetch the maximum number of entries
      /// ([sessions.MAX_SESSION_RESULTS]).
      int? maxResults})
      : _wrapped = $js.Filter(maxResults: maxResults);

  final $js.Filter _wrapped;

  $js.Filter get toJS => _wrapped;

  /// The maximum number of entries to be fetched in the requested list. Omit
  /// this parameter to fetch the maximum number of entries
  /// ([sessions.MAX_SESSION_RESULTS]).
  int? get maxResults => _wrapped.maxResults;
  set maxResults(int? v) {
    _wrapped.maxResults = v;
  }
}

class Session {
  Session.fromJS(this._wrapped);

  Session({
    /// The time when the window or tab was closed or modified, represented in
    /// milliseconds since the epoch.
    required int lastModified,

    /// The [tabs.Tab], if this entry describes a tab. Either this or
    /// [sessions.Session.window] will be set.
    Tab? tab,

    /// The [windows.Window], if this entry describes a window. Either this or
    /// [sessions.Session.tab] will be set.
    Window? window,
  }) : _wrapped = $js.Session(
          lastModified: lastModified,
          tab: tab?.toJS,
          window: window?.toJS,
        );

  final $js.Session _wrapped;

  $js.Session get toJS => _wrapped;

  /// The time when the window or tab was closed or modified, represented in
  /// milliseconds since the epoch.
  int get lastModified => _wrapped.lastModified;
  set lastModified(int v) {
    _wrapped.lastModified = v;
  }

  /// The [tabs.Tab], if this entry describes a tab. Either this or
  /// [sessions.Session.window] will be set.
  Tab? get tab => _wrapped.tab?.let(Tab.fromJS);
  set tab(Tab? v) {
    _wrapped.tab = v?.toJS;
  }

  /// The [windows.Window], if this entry describes a window. Either this or
  /// [sessions.Session.tab] will be set.
  Window? get window => _wrapped.window?.let(Window.fromJS);
  set window(Window? v) {
    _wrapped.window = v?.toJS;
  }
}

class Device {
  Device.fromJS(this._wrapped);

  Device({
    required String info,

    /// The name of the foreign device.
    required String deviceName,

    /// A list of open window sessions for the foreign device, sorted from most
    /// recently to least recently modified session.
    required List<Session> sessions,
  }) : _wrapped = $js.Device(
          info: info,
          deviceName: deviceName,
          sessions: sessions.toJSArray((e) => e.toJS),
        );

  final $js.Device _wrapped;

  $js.Device get toJS => _wrapped;

  String get info => _wrapped.info;
  set info(String v) {
    _wrapped.info = v;
  }

  /// The name of the foreign device.
  String get deviceName => _wrapped.deviceName;
  set deviceName(String v) {
    _wrapped.deviceName = v;
  }

  /// A list of open window sessions for the foreign device, sorted from most
  /// recently to least recently modified session.
  List<Session> get sessions => _wrapped.sessions.toDart
      .cast<$js.Session>()
      .map((e) => Session.fromJS(e))
      .toList();
  set sessions(List<Session> v) {
    _wrapped.sessions = v.toJSArray((e) => e.toJS);
  }
}
