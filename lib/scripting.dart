// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'extension_types.dart';
import 'src/internal_helpers.dart';
import 'src/js/scripting.dart' as $js;

export 'src/chrome.dart' show chrome;

final _scripting = ChromeScripting._();

extension ChromeScriptingExtension on Chrome {
  /// Use the `chrome.scripting` API to execute script in different
  /// contexts.
  ChromeScripting get scripting => _scripting;
}

class ChromeScripting {
  ChromeScripting._();

  bool get isAvailable => $js.chrome.scriptingNullable != null && alwaysTrue;

  /// Injects a script into a target context. The script will be run at
  /// `document_idle`. If the script evaluates to a promise,
  /// the browser will wait for the promise to settle and return the
  /// resulting value.
  /// |injection|: The details of the script which to inject.
  /// |callback|: Invoked upon completion of the injection. The resulting
  /// array contains the result of execution for each frame where the
  /// injection succeeded.
  Future<List<InjectionResult>> executeScript(ScriptInjection injection) async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.scripting.executeScript(injection.toJS));
    return $res.toDart
        .cast<$js.InjectionResult>()
        .map((e) => InjectionResult.fromJS(e))
        .toList();
  }

  /// Inserts a CSS stylesheet into a target context.
  /// If multiple frames are specified, unsuccessful injections are ignored.
  /// |injection|: The details of the styles to insert.
  /// |callback|: Invoked upon completion of the insertion.
  Future<void> insertCSS(CSSInjection injection) async {
    await promiseToFuture<void>($js.chrome.scripting.insertCSS(injection.toJS));
  }

  /// Removes a CSS stylesheet that was previously inserted by this extension
  /// from a target context.
  /// |injection|: The details of the styles to remove. Note that the
  /// `css`, `files`, and `origin` properties
  /// must exactly match the stylesheet inserted through [insertCSS].
  /// Attempting to remove a non-existent stylesheet is a no-op.
  /// |callback|: A callback to be invoked upon the completion of the removal.
  Future<void> removeCSS(CSSInjection injection) async {
    await promiseToFuture<void>($js.chrome.scripting.removeCSS(injection.toJS));
  }

  /// Registers one or more content scripts for this extension.
  /// |scripts|: Contains a list of scripts to be registered. If there are
  /// errors during script parsing/file validation, or if the IDs specified
  /// already exist, then no scripts are registered.
  /// |callback|: A callback to be invoked once scripts have been fully
  /// registered or if an error has occurred.
  Future<void> registerContentScripts(
      List<RegisteredContentScript> scripts) async {
    await promiseToFuture<void>($js.chrome.scripting
        .registerContentScripts(scripts.toJSArray((e) => e.toJS)));
  }

  /// Returns all dynamically registered content scripts for this extension
  /// that match the given filter.
  /// |filter|: An object to filter the extension's dynamically registered
  /// scripts.
  Future<List<RegisteredContentScript>> getRegisteredContentScripts(
      ContentScriptFilter? filter) async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.scripting.getRegisteredContentScripts(filter?.toJS));
    return $res.toDart
        .cast<$js.RegisteredContentScript>()
        .map((e) => RegisteredContentScript.fromJS(e))
        .toList();
  }

  /// Unregisters content scripts for this extension.
  /// |filter|: If specified, only unregisters dynamic content scripts which
  /// match the filter. Otherwise, all of the extension's dynamic content
  /// scripts are unregistered.
  /// |callback|: A callback to be invoked once scripts have been unregistered
  /// or if an error has occurred.
  Future<void> unregisterContentScripts(ContentScriptFilter? filter) async {
    await promiseToFuture<void>(
        $js.chrome.scripting.unregisterContentScripts(filter?.toJS));
  }

  /// Updates one or more content scripts for this extension.
  /// |scripts|: Contains a list of scripts to be updated. A property is only
  /// updated for the existing script if it is specified in this object. If
  /// there are errors during script parsing/file validation, or if the IDs
  /// specified do not correspond to a fully registered script, then no scripts
  /// are updated.
  /// |callback|: A callback to be invoked once scripts have been updated or
  /// if an error has occurred.
  Future<void> updateContentScripts(
      List<RegisteredContentScript> scripts) async {
    await promiseToFuture<void>($js.chrome.scripting
        .updateContentScripts(scripts.toJSArray((e) => e.toJS)));
  }

  /// An object available for content scripts running in isolated worlds to use
  /// and modify as a JS object. One instance exists per frame and is shared
  /// between all content scripts for a given extension. This object is
  /// initialized when the frame is created, before document_start.
  /// TODO(crbug.com/1054624): Enable this once implementation is complete.
  int get globalParams => $js.chrome.scripting.globalParams;
}

/// The origin for a style change.
/// See [style
/// origins](https://developer.mozilla.org/en-US/docs/Glossary/Style_origin)
/// for more info.
enum StyleOrigin {
  author('AUTHOR'),
  user('USER');

  const StyleOrigin(this.value);

  final String value;

  String get toJS => value;
  static StyleOrigin fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The JavaScript world for a script to execute within.
enum ExecutionWorld {
  /// The isolated world, unique to this extension.
  isolated('ISOLATED'),

  /// The main world of the DOM, shared with the page's JavaScript.
  main('MAIN');

  const ExecutionWorld(this.value);

  final String value;

  String get toJS => value;
  static ExecutionWorld fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class InjectionTarget {
  InjectionTarget.fromJS(this._wrapped);

  InjectionTarget({
    /// The ID of the tab into which to inject.
    required int tabId,

    /// The
    /// [IDs](https://developer.chrome.com/extensions/webNavigation#frame_ids)
    /// of specific frames to inject into.
    List<int>? frameIds,

    /// The
    /// [IDs](https://developer.chrome.com/extensions/webNavigation#document_ids)
    /// of specific documentIds to inject into. This must not be set if
    /// `frameIds` is set.
    List<String>? documentIds,

    /// Whether the script should inject into all frames within the tab.
    /// Defaults
    /// to false.
    /// This must not be true if `frameIds` is specified.
    bool? allFrames,
  }) : _wrapped = $js.InjectionTarget(
          tabId: tabId,
          frameIds: frameIds?.toJSArray((e) => e),
          documentIds: documentIds?.toJSArray((e) => e),
          allFrames: allFrames,
        );

  final $js.InjectionTarget _wrapped;

  $js.InjectionTarget get toJS => _wrapped;

  /// The ID of the tab into which to inject.
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }

  /// The [IDs](https://developer.chrome.com/extensions/webNavigation#frame_ids)
  /// of specific frames to inject into.
  List<int>? get frameIds =>
      _wrapped.frameIds?.toDart.cast<int>().map((e) => e).toList();
  set frameIds(List<int>? v) {
    _wrapped.frameIds = v?.toJSArray((e) => e);
  }

  /// The
  /// [IDs](https://developer.chrome.com/extensions/webNavigation#document_ids)
  /// of specific documentIds to inject into. This must not be set if
  /// `frameIds` is set.
  List<String>? get documentIds =>
      _wrapped.documentIds?.toDart.cast<String>().map((e) => e).toList();
  set documentIds(List<String>? v) {
    _wrapped.documentIds = v?.toJSArray((e) => e);
  }

  /// Whether the script should inject into all frames within the tab. Defaults
  /// to false.
  /// This must not be true if `frameIds` is specified.
  bool? get allFrames => _wrapped.allFrames;
  set allFrames(bool? v) {
    _wrapped.allFrames = v;
  }
}

class ScriptInjection {
  ScriptInjection.fromJS(this._wrapped);

  ScriptInjection({
    /// A JavaScript function to inject. This function will be serialized, and
    /// then deserialized for injection. This means that any bound parameters
    /// and execution context will be lost.
    /// Exactly one of `files` and `func` must be
    /// specified.
    JSAny? func,

    /// The arguments to curry into a provided function. This is only valid if
    /// the `func` parameter is specified. These arguments must be
    /// JSON-serializable.
    List<Object>? args,

    /// We used to call the injected function `function`, but this is
    /// incompatible with JavaScript's object declaration shorthand (see
    /// https://crbug.com/1166438). We leave this silently in for backwards
    /// compatibility.
    /// TODO(devlin): Remove this in M95.
    JSAny? function,

    /// The path of the JS or CSS files to inject, relative to the extension's
    /// root directory.
    /// Exactly one of `files` and `func` must be
    /// specified.
    List<String>? files,

    /// Details specifying the target into which to inject the script.
    required InjectionTarget target,

    /// The JavaScript "world" to run the script in. Defaults to
    /// `ISOLATED`.
    ExecutionWorld? world,

    /// Whether the injection should be triggered in the target as soon as
    /// possible. Note that this is not a guarantee that injection will occur
    /// prior to page load, as the page may have already loaded by the time the
    /// script reaches the target.
    bool? injectImmediately,
  }) : _wrapped = $js.ScriptInjection(
          func: func,
          args: args?.toJSArray((e) => e.jsify()!),
          function: function,
          files: files?.toJSArray((e) => e),
          target: target.toJS,
          world: world?.toJS,
          injectImmediately: injectImmediately,
        );

  final $js.ScriptInjection _wrapped;

  $js.ScriptInjection get toJS => _wrapped;

  /// A JavaScript function to inject. This function will be serialized, and
  /// then deserialized for injection. This means that any bound parameters
  /// and execution context will be lost.
  /// Exactly one of `files` and `func` must be
  /// specified.
  JSAny? get func => _wrapped.func;
  set func(JSAny? v) {
    _wrapped.func = v;
  }

  /// The arguments to curry into a provided function. This is only valid if
  /// the `func` parameter is specified. These arguments must be
  /// JSON-serializable.
  List<Object>? get args =>
      _wrapped.args?.toDart.cast<JSAny>().map((e) => e.dartify()!).toList();
  set args(List<Object>? v) {
    _wrapped.args = v?.toJSArray((e) => e.jsify()!);
  }

  /// We used to call the injected function `function`, but this is
  /// incompatible with JavaScript's object declaration shorthand (see
  /// https://crbug.com/1166438). We leave this silently in for backwards
  /// compatibility.
  /// TODO(devlin): Remove this in M95.
  JSAny? get function => _wrapped.function;
  set function(JSAny? v) {
    _wrapped.function = v;
  }

  /// The path of the JS or CSS files to inject, relative to the extension's
  /// root directory.
  /// Exactly one of `files` and `func` must be
  /// specified.
  List<String>? get files =>
      _wrapped.files?.toDart.cast<String>().map((e) => e).toList();
  set files(List<String>? v) {
    _wrapped.files = v?.toJSArray((e) => e);
  }

  /// Details specifying the target into which to inject the script.
  InjectionTarget get target => InjectionTarget.fromJS(_wrapped.target);
  set target(InjectionTarget v) {
    _wrapped.target = v.toJS;
  }

  /// The JavaScript "world" to run the script in. Defaults to
  /// `ISOLATED`.
  ExecutionWorld? get world => _wrapped.world?.let(ExecutionWorld.fromJS);
  set world(ExecutionWorld? v) {
    _wrapped.world = v?.toJS;
  }

  /// Whether the injection should be triggered in the target as soon as
  /// possible. Note that this is not a guarantee that injection will occur
  /// prior to page load, as the page may have already loaded by the time the
  /// script reaches the target.
  bool? get injectImmediately => _wrapped.injectImmediately;
  set injectImmediately(bool? v) {
    _wrapped.injectImmediately = v;
  }
}

class CSSInjection {
  CSSInjection.fromJS(this._wrapped);

  CSSInjection({
    /// Details specifying the target into which to insert the CSS.
    required InjectionTarget target,

    /// A string containing the CSS to inject.
    /// Exactly one of `files` and `css` must be
    /// specified.
    String? css,

    /// The path of the CSS files to inject, relative to the extension's root
    /// directory.
    /// Exactly one of `files` and `css` must be
    /// specified.
    List<String>? files,

    /// The style origin for the injection. Defaults to `'AUTHOR'`.
    StyleOrigin? origin,
  }) : _wrapped = $js.CSSInjection(
          target: target.toJS,
          css: css,
          files: files?.toJSArray((e) => e),
          origin: origin?.toJS,
        );

  final $js.CSSInjection _wrapped;

  $js.CSSInjection get toJS => _wrapped;

  /// Details specifying the target into which to insert the CSS.
  InjectionTarget get target => InjectionTarget.fromJS(_wrapped.target);
  set target(InjectionTarget v) {
    _wrapped.target = v.toJS;
  }

  /// A string containing the CSS to inject.
  /// Exactly one of `files` and `css` must be
  /// specified.
  String? get css => _wrapped.css;
  set css(String? v) {
    _wrapped.css = v;
  }

  /// The path of the CSS files to inject, relative to the extension's root
  /// directory.
  /// Exactly one of `files` and `css` must be
  /// specified.
  List<String>? get files =>
      _wrapped.files?.toDart.cast<String>().map((e) => e).toList();
  set files(List<String>? v) {
    _wrapped.files = v?.toJSArray((e) => e);
  }

  /// The style origin for the injection. Defaults to `'AUTHOR'`.
  StyleOrigin? get origin => _wrapped.origin?.let(StyleOrigin.fromJS);
  set origin(StyleOrigin? v) {
    _wrapped.origin = v?.toJS;
  }
}

class InjectionResult {
  InjectionResult.fromJS(this._wrapped);

  InjectionResult({
    /// The result of the script execution.
    Object? result,

    /// The frame associated with the injection.
    required int frameId,

    /// The document associated with the injection.
    required String documentId,
  }) : _wrapped = $js.InjectionResult(
          result: result?.jsify(),
          frameId: frameId,
          documentId: documentId,
        );

  final $js.InjectionResult _wrapped;

  $js.InjectionResult get toJS => _wrapped;

  /// The result of the script execution.
  Object? get result => _wrapped.result?.dartify();
  set result(Object? v) {
    _wrapped.result = v?.jsify();
  }

  /// The frame associated with the injection.
  int get frameId => _wrapped.frameId;
  set frameId(int v) {
    _wrapped.frameId = v;
  }

  /// The document associated with the injection.
  String get documentId => _wrapped.documentId;
  set documentId(String v) {
    _wrapped.documentId = v;
  }
}

class RegisteredContentScript {
  RegisteredContentScript.fromJS(this._wrapped);

  RegisteredContentScript({
    /// The id of the content script, specified in the API call. Must not start
    /// with a '_' as it's reserved as a prefix for generated script IDs.
    required String id,

    /// Specifies which pages this content script will be injected into. See
    /// [Match Patterns](match_patterns) for more details on the
    /// syntax of these strings. Must be specified for
    /// [registerContentScripts].
    List<String>? matches,

    /// Excludes pages that this content script would otherwise be injected
    /// into.
    /// See [Match Patterns](match_patterns) for more details on the
    /// syntax of these strings.
    List<String>? excludeMatches,

    /// The list of CSS files to be injected into matching pages. These are
    /// injected in the order they appear in this array, before any DOM is
    /// constructed or displayed for the page.
    List<String>? css,

    /// The list of JavaScript files to be injected into matching pages. These
    /// are injected in the order they appear in this array.
    List<String>? js,

    /// If specified true, it will inject into all frames, even if the frame is
    /// not the top-most frame in the tab. Each frame is checked independently
    /// for URL requirements; it will not inject into child frames if the URL
    /// requirements are not met. Defaults to false, meaning that only the top
    /// frame is matched.
    bool? allFrames,

    /// TODO(devlin): Add documentation once the implementation is complete. See
    /// crbug.com/55084.
    bool? matchOriginAsFallback,

    /// Specifies when JavaScript files are injected into the web page. The
    /// preferred and default value is `document_idle`.
    RunAt? runAt,

    /// Specifies if this content script will persist into future sessions. The
    /// default is true.
    bool? persistAcrossSessions,

    /// The JavaScript "world" to run the script in. Defaults to
    /// `ISOLATED`.
    ExecutionWorld? world,
  }) : _wrapped = $js.RegisteredContentScript(
          id: id,
          matches: matches?.toJSArray((e) => e),
          excludeMatches: excludeMatches?.toJSArray((e) => e),
          css: css?.toJSArray((e) => e),
          js: js?.toJSArray((e) => e),
          allFrames: allFrames,
          matchOriginAsFallback: matchOriginAsFallback,
          runAt: runAt?.toJS,
          persistAcrossSessions: persistAcrossSessions,
          world: world?.toJS,
        );

  final $js.RegisteredContentScript _wrapped;

  $js.RegisteredContentScript get toJS => _wrapped;

  /// The id of the content script, specified in the API call. Must not start
  /// with a '_' as it's reserved as a prefix for generated script IDs.
  String get id => _wrapped.id;
  set id(String v) {
    _wrapped.id = v;
  }

  /// Specifies which pages this content script will be injected into. See
  /// [Match Patterns](match_patterns) for more details on the
  /// syntax of these strings. Must be specified for
  /// [registerContentScripts].
  List<String>? get matches =>
      _wrapped.matches?.toDart.cast<String>().map((e) => e).toList();
  set matches(List<String>? v) {
    _wrapped.matches = v?.toJSArray((e) => e);
  }

  /// Excludes pages that this content script would otherwise be injected into.
  /// See [Match Patterns](match_patterns) for more details on the
  /// syntax of these strings.
  List<String>? get excludeMatches =>
      _wrapped.excludeMatches?.toDart.cast<String>().map((e) => e).toList();
  set excludeMatches(List<String>? v) {
    _wrapped.excludeMatches = v?.toJSArray((e) => e);
  }

  /// The list of CSS files to be injected into matching pages. These are
  /// injected in the order they appear in this array, before any DOM is
  /// constructed or displayed for the page.
  List<String>? get css =>
      _wrapped.css?.toDart.cast<String>().map((e) => e).toList();
  set css(List<String>? v) {
    _wrapped.css = v?.toJSArray((e) => e);
  }

  /// The list of JavaScript files to be injected into matching pages. These
  /// are injected in the order they appear in this array.
  List<String>? get js =>
      _wrapped.js?.toDart.cast<String>().map((e) => e).toList();
  set js(List<String>? v) {
    _wrapped.js = v?.toJSArray((e) => e);
  }

  /// If specified true, it will inject into all frames, even if the frame is
  /// not the top-most frame in the tab. Each frame is checked independently
  /// for URL requirements; it will not inject into child frames if the URL
  /// requirements are not met. Defaults to false, meaning that only the top
  /// frame is matched.
  bool? get allFrames => _wrapped.allFrames;
  set allFrames(bool? v) {
    _wrapped.allFrames = v;
  }

  /// TODO(devlin): Add documentation once the implementation is complete. See
  /// crbug.com/55084.
  bool? get matchOriginAsFallback => _wrapped.matchOriginAsFallback;
  set matchOriginAsFallback(bool? v) {
    _wrapped.matchOriginAsFallback = v;
  }

  /// Specifies when JavaScript files are injected into the web page. The
  /// preferred and default value is `document_idle`.
  RunAt? get runAt => _wrapped.runAt?.let(RunAt.fromJS);
  set runAt(RunAt? v) {
    _wrapped.runAt = v?.toJS;
  }

  /// Specifies if this content script will persist into future sessions. The
  /// default is true.
  bool? get persistAcrossSessions => _wrapped.persistAcrossSessions;
  set persistAcrossSessions(bool? v) {
    _wrapped.persistAcrossSessions = v;
  }

  /// The JavaScript "world" to run the script in. Defaults to
  /// `ISOLATED`.
  ExecutionWorld? get world => _wrapped.world?.let(ExecutionWorld.fromJS);
  set world(ExecutionWorld? v) {
    _wrapped.world = v?.toJS;
  }
}

class ContentScriptFilter {
  ContentScriptFilter.fromJS(this._wrapped);

  ContentScriptFilter(
      {
      /// If specified, [getRegisteredContentScripts] will only return scripts
      /// with an id specified in this list.
      List<String>? ids})
      : _wrapped = $js.ContentScriptFilter(ids: ids?.toJSArray((e) => e));

  final $js.ContentScriptFilter _wrapped;

  $js.ContentScriptFilter get toJS => _wrapped;

  /// If specified, [getRegisteredContentScripts] will only return scripts
  /// with an id specified in this list.
  List<String>? get ids =>
      _wrapped.ids?.toDart.cast<String>().map((e) => e).toList();
  set ids(List<String>? v) {
    _wrapped.ids = v?.toJSArray((e) => e);
  }
}
