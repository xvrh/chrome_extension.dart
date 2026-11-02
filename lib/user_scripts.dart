// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'extension_types.dart';
import 'src/internal_helpers.dart';
import 'src/js/user_scripts.dart' as $js;

export 'src/chrome.dart' show chrome, EventStream;

final _userScripts = ChromeUserScripts._();

extension ChromeUserScriptsExtension on Chrome {
  /// Use the `userScripts` API to execute user scripts in the User
  /// Scripts context.
  ChromeUserScripts get userScripts => _userScripts;
}

class ChromeUserScripts {
  ChromeUserScripts._();

  bool get isAvailable => $js.chrome.userScriptsNullable != null && alwaysTrue;

  /// Registers one or more user scripts for this extension.
  /// |scripts|: Contains a list of user scripts to be registered.
  /// |Returns|: Promise that resolves once scripts have been fully
  /// registered. The promise will be rejected if an error occurs.
  Future<void> register(List<RegisteredUserScript> scripts) async {
    await $js.chrome.userScripts
        .register(scripts.toJSArray((e) => e.toJS))
        .toDart;
  }

  /// Returns all dynamically-registered user scripts for this extension.
  /// |filter|: If specified, this method returns only the user scripts that
  /// match it.
  /// |Returns|: Promise that resolves with the registered scripts.
  /// The promise will be rejected if an error occurs.
  Future<List<RegisteredUserScript>> getScripts(
      UserScriptFilter? filter) async {
    var $res = await $js.chrome.userScripts.getScripts(filter?.toJS).toDart;
    return $res.toDart
        .cast<$js.RegisteredUserScript>()
        .map((e) => RegisteredUserScript.fromJS(e))
        .toList();
  }

  /// Unregisters all dynamically-registered user scripts for this extension.
  /// |filter|: If specified, this method unregisters only the user scripts
  /// that match it.
  /// |Returns|: Promise that resolves once scripts have been fully
  /// unregistered. The promise will be rejected if an error occurs.
  Future<void> unregister(UserScriptFilter? filter) async {
    await $js.chrome.userScripts.unregister(filter?.toJS).toDart;
  }

  /// Updates one or more user scripts for this extension.
  /// |scripts|: Contains a list of user scripts to be updated. A property is
  /// only updated for the existing script if it is specified in this object.
  /// If there are errors during script parsing/file validation, or if the IDs
  /// specified do not correspond to a fully registered script, then no scripts
  /// are updated.
  /// |Returns|: Promise that resolves once scripts have been fully updated.
  /// The promise will be rejected if an error occurs.
  Future<void> update(List<RegisteredUserScript> scripts) async {
    await $js.chrome.userScripts
        .update(scripts.toJSArray((e) => e.toJS))
        .toDart;
  }

  /// Injects a script into a target context. By default, the script will be
  /// run at `document_idle`, or immediately if the page has already
  /// loaded. If the `injectImmediately` property is set, the script
  /// will inject without waiting, even if the page has not finished loading.
  /// If the script evaluates to a promise, the browser will wait for the
  /// promise to settle and return the resulting value.
  Future<List<InjectionResult>> execute(UserScriptInjection injection) async {
    var $res = await $js.chrome.userScripts.execute(injection.toJS).toDart;
    return $res.toDart
        .cast<$js.InjectionResult>()
        .map((e) => InjectionResult.fromJS(e))
        .toList();
  }

  /// Configures the ``USER_SCRIPT`` execution environment.
  /// |properties|: Contains the user script world configuration.
  /// |Returns|: Promise that resolves once the world has been
  /// configured.
  Future<void> configureWorld(WorldProperties properties) async {
    await $js.chrome.userScripts.configureWorld(properties.toJS).toDart;
  }

  /// Retrieves all registered world configurations.
  /// |Returns|: Promise that resolves with the registered world
  /// configurations.
  Future<List<WorldProperties>> getWorldConfigurations() async {
    var $res = await $js.chrome.userScripts.getWorldConfigurations().toDart;
    return $res.toDart
        .cast<$js.WorldProperties>()
        .map((e) => WorldProperties.fromJS(e))
        .toList();
  }

  /// Resets the configuration for a user script world. Any scripts that inject
  /// into the world with the specified ID will use the default world
  /// configuration.
  /// |worldId|: The ID of the user script world to reset. If omitted, resets
  /// the default world's configuration.
  /// |Returns|: Promise that resolves when the configuration is reset.
  Future<void> resetWorldConfiguration(String? worldId) async {
    await $js.chrome.userScripts.resetWorldConfiguration(worldId).toDart;
  }
}

/// The JavaScript world for a user script to execute within.
enum ExecutionWorld {
  /// Specifies the execution environment of the DOM, which is the execution
  /// environment shared with the host page's JavaScript.
  main('MAIN'),

  /// Specifies the execution environment that is specific to user scripts and
  /// is exempt from the page's CSP.
  userScript('USER_SCRIPT');

  const ExecutionWorld(this.value);

  final String value;

  JSString get toJS => value.toJS;

  static ExecutionWorld fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

class ScriptSource {
  ScriptSource.fromJS(this._wrapped);

  ScriptSource({
    /// A string containing the JavaScript code to inject. Exactly one of
    /// `file` or `code` must be specified.
    String? code,

    /// The path of the JavaScript file to inject relative to the extension's
    /// root directory. Exactly one of `file` or `code`
    /// must be specified.
    String? file,
  }) : _wrapped = $js.ScriptSource(
          code: code,
          file: file,
        );

  final $js.ScriptSource _wrapped;

  $js.ScriptSource get toJS => _wrapped;

  /// A string containing the JavaScript code to inject. Exactly one of
  /// `file` or `code` must be specified.
  String? get code => _wrapped.code;

  set code(String? v) {
    _wrapped.code = v;
  }

  /// The path of the JavaScript file to inject relative to the extension's
  /// root directory. Exactly one of `file` or `code`
  /// must be specified.
  String? get file => _wrapped.file;

  set file(String? v) {
    _wrapped.file = v;
  }
}

class RegisteredUserScript {
  RegisteredUserScript.fromJS(this._wrapped);

  RegisteredUserScript({
    /// If true, it will inject into all frames, even if the frame is not the
    /// top-most frame in the tab. Each frame is checked independently for URL
    /// requirements; it will not inject into child frames if the URL
    /// requirements are not met. Defaults to false, meaning that only the top
    /// frame is matched.
    bool? allFrames,

    /// Excludes pages that this user script would otherwise be injected into.
    /// See [Match Patterns](develop/concepts/match-patterns) for more
    /// details on the syntax of these strings.
    List<String>? excludeMatches,

    /// The ID of the user script specified in the API call. This property must
    /// not start with a '_' as it's reserved as a prefix for generated script
    /// IDs.
    required String id,

    /// Specifies wildcard patterns for pages this user script will be injected
    /// into.
    List<String>? includeGlobs,

    /// Specifies wildcard patterns for pages this user script will NOT be
    /// injected into.
    List<String>? excludeGlobs,

    /// The list of ScriptSource objects defining sources of scripts to be
    /// injected into matching pages.
    /// This property must be specified for  ${ref:register}, and when specified
    /// it must be a non-empty array.
    List<ScriptSource>? js,

    /// Specifies which pages this user script will be injected into. See
    /// [Match Patterns](develop/concepts/match-patterns) for more
    /// details on the syntax of these strings. This property must be specified
    /// for
    /// ${ref:register}.
    List<String>? matches,

    /// Specifies when JavaScript files are injected into the web page. The
    /// preferred and default value is `document_idle`.
    RunAt? runAt,

    /// The JavaScript execution environment to run the script in. The default
    /// is
    /// ``USER_SCRIPT``.
    ExecutionWorld? world,

    /// Specifies the user script world ID to execute in. If omitted, the script
    /// will execute in the default user script world. Only valid if `world` is
    /// omitted or is `USER_SCRIPT`. Values with leading underscores (`_`) are
    /// reserved.
    String? worldId,
  }) : _wrapped = $js.RegisteredUserScript(
          allFrames: allFrames,
          excludeMatches: excludeMatches?.toJSArray((e) => e.toJS),
          id: id,
          includeGlobs: includeGlobs?.toJSArray((e) => e.toJS),
          excludeGlobs: excludeGlobs?.toJSArray((e) => e.toJS),
          js: js?.toJSArray((e) => e.toJS),
          matches: matches?.toJSArray((e) => e.toJS),
          runAt: runAt?.toJS,
          world: world?.toJS,
          worldId: worldId,
        );

  final $js.RegisteredUserScript _wrapped;

  $js.RegisteredUserScript get toJS => _wrapped;

  /// If true, it will inject into all frames, even if the frame is not the
  /// top-most frame in the tab. Each frame is checked independently for URL
  /// requirements; it will not inject into child frames if the URL
  /// requirements are not met. Defaults to false, meaning that only the top
  /// frame is matched.
  bool? get allFrames => _wrapped.allFrames;

  set allFrames(bool? v) {
    _wrapped.allFrames = v;
  }

  /// Excludes pages that this user script would otherwise be injected into.
  /// See [Match Patterns](develop/concepts/match-patterns) for more
  /// details on the syntax of these strings.
  List<String>? get excludeMatches => _wrapped.excludeMatches?.toDart
      .cast<JSString>()
      .map((e) => e.toDart)
      .toList();

  set excludeMatches(List<String>? v) {
    _wrapped.excludeMatches = v?.toJSArray((e) => e.toJS);
  }

  /// The ID of the user script specified in the API call. This property must
  /// not start with a '_' as it's reserved as a prefix for generated script
  /// IDs.
  String get id => _wrapped.id;

  set id(String v) {
    _wrapped.id = v;
  }

  /// Specifies wildcard patterns for pages this user script will be injected
  /// into.
  List<String>? get includeGlobs => _wrapped.includeGlobs?.toDart
      .cast<JSString>()
      .map((e) => e.toDart)
      .toList();

  set includeGlobs(List<String>? v) {
    _wrapped.includeGlobs = v?.toJSArray((e) => e.toJS);
  }

  /// Specifies wildcard patterns for pages this user script will NOT be
  /// injected into.
  List<String>? get excludeGlobs => _wrapped.excludeGlobs?.toDart
      .cast<JSString>()
      .map((e) => e.toDart)
      .toList();

  set excludeGlobs(List<String>? v) {
    _wrapped.excludeGlobs = v?.toJSArray((e) => e.toJS);
  }

  /// The list of ScriptSource objects defining sources of scripts to be
  /// injected into matching pages.
  /// This property must be specified for  ${ref:register}, and when specified
  /// it must be a non-empty array.
  List<ScriptSource>? get js => _wrapped.js?.toDart
      .cast<$js.ScriptSource>()
      .map((e) => ScriptSource.fromJS(e))
      .toList();

  set js(List<ScriptSource>? v) {
    _wrapped.js = v?.toJSArray((e) => e.toJS);
  }

  /// Specifies which pages this user script will be injected into. See
  /// [Match Patterns](develop/concepts/match-patterns) for more
  /// details on the syntax of these strings. This property must be specified
  /// for
  /// ${ref:register}.
  List<String>? get matches =>
      _wrapped.matches?.toDart.cast<JSString>().map((e) => e.toDart).toList();

  set matches(List<String>? v) {
    _wrapped.matches = v?.toJSArray((e) => e.toJS);
  }

  /// Specifies when JavaScript files are injected into the web page. The
  /// preferred and default value is `document_idle`.
  RunAt? get runAt => _wrapped.runAt?.let(RunAt.fromJS);

  set runAt(RunAt? v) {
    _wrapped.runAt = v?.toJS;
  }

  /// The JavaScript execution environment to run the script in. The default is
  /// ``USER_SCRIPT``.
  ExecutionWorld? get world => _wrapped.world?.let(ExecutionWorld.fromJS);

  set world(ExecutionWorld? v) {
    _wrapped.world = v?.toJS;
  }

  /// Specifies the user script world ID to execute in. If omitted, the script
  /// will execute in the default user script world. Only valid if `world` is
  /// omitted or is `USER_SCRIPT`. Values with leading underscores (`_`) are
  /// reserved.
  String? get worldId => _wrapped.worldId;

  set worldId(String? v) {
    _wrapped.worldId = v;
  }
}

class UserScriptFilter {
  UserScriptFilter.fromJS(this._wrapped);

  UserScriptFilter(
      {
      /// [getScripts] only returns scripts with the IDs specified in this
      /// list.
      List<String>? ids})
      : _wrapped = $js.UserScriptFilter(ids: ids?.toJSArray((e) => e.toJS));

  final $js.UserScriptFilter _wrapped;

  $js.UserScriptFilter get toJS => _wrapped;

  /// [getScripts] only returns scripts with the IDs specified in this
  /// list.
  List<String>? get ids =>
      _wrapped.ids?.toDart.cast<JSString>().map((e) => e.toDart).toList();

  set ids(List<String>? v) {
    _wrapped.ids = v?.toJSArray((e) => e.toJS);
  }
}

class InjectionTarget {
  InjectionTarget.fromJS(this._wrapped);

  InjectionTarget({
    /// Whether the script should inject into all frames within the tab.
    /// Defaults
    /// to false. This must not be true if `frameIds` is specified.
    bool? allFrames,

    /// The IDs of specific documentIds to inject into. This must not be set if
    /// `frameIds` is set.
    List<String>? documentIds,

    /// The IDs of specific frames to inject into.
    List<int>? frameIds,

    /// The ID of the tab into which to inject.
    required int tabId,
  }) : _wrapped = $js.InjectionTarget(
          allFrames: allFrames,
          documentIds: documentIds?.toJSArray((e) => e.toJS),
          frameIds: frameIds?.toJSArray((e) => e.toJS),
          tabId: tabId,
        );

  final $js.InjectionTarget _wrapped;

  $js.InjectionTarget get toJS => _wrapped;

  /// Whether the script should inject into all frames within the tab. Defaults
  /// to false. This must not be true if `frameIds` is specified.
  bool? get allFrames => _wrapped.allFrames;

  set allFrames(bool? v) {
    _wrapped.allFrames = v;
  }

  /// The IDs of specific documentIds to inject into. This must not be set if
  /// `frameIds` is set.
  List<String>? get documentIds => _wrapped.documentIds?.toDart
      .cast<JSString>()
      .map((e) => e.toDart)
      .toList();

  set documentIds(List<String>? v) {
    _wrapped.documentIds = v?.toJSArray((e) => e.toJS);
  }

  /// The IDs of specific frames to inject into.
  List<int>? get frameIds => _wrapped.frameIds?.toDart
      .cast<JSNumber>()
      .map((e) => e.toDartInt)
      .toList();

  set frameIds(List<int>? v) {
    _wrapped.frameIds = v?.toJSArray((e) => e.toJS);
  }

  /// The ID of the tab into which to inject.
  int get tabId => _wrapped.tabId;

  set tabId(int v) {
    _wrapped.tabId = v;
  }
}

class InjectionResult {
  InjectionResult.fromJS(this._wrapped);

  InjectionResult({
    /// The document associated with the injection.
    required String documentId,

    /// The frame associated with the injection.
    required int frameId,

    /// The result of the script execution.
    Object? result,

    /// The error, if any. `error` and `result` are
    /// mutually exclusive.
    String? error,
  }) : _wrapped = $js.InjectionResult(
          documentId: documentId,
          frameId: frameId,
          result: result?.jsify(),
          error: error,
        );

  final $js.InjectionResult _wrapped;

  $js.InjectionResult get toJS => _wrapped;

  /// The document associated with the injection.
  String get documentId => _wrapped.documentId;

  set documentId(String v) {
    _wrapped.documentId = v;
  }

  /// The frame associated with the injection.
  int get frameId => _wrapped.frameId;

  set frameId(int v) {
    _wrapped.frameId = v;
  }

  /// The result of the script execution.
  Object? get result => _wrapped.result?.dartify();

  set result(Object? v) {
    _wrapped.result = v?.jsify();
  }

  /// The error, if any. `error` and `result` are
  /// mutually exclusive.
  String? get error => _wrapped.error;

  set error(String? v) {
    _wrapped.error = v;
  }
}

class UserScriptInjection {
  UserScriptInjection.fromJS(this._wrapped);

  UserScriptInjection({
    /// Whether the injection should be triggered in the target as soon as
    /// possible. Note that this is not a guarantee that injection will occur
    /// prior to page load, as the page may have already loaded by the time the
    /// script reaches the target.
    bool? injectImmediately,

    /// The list of ScriptSource objects defining sources of scripts to be
    /// injected into the target.
    required List<ScriptSource> js,

    /// Details specifying the target into which to inject the script.
    required InjectionTarget target,

    /// The JavaScript "world" to run the script in. The default is
    /// `USER_SCRIPT`.
    ExecutionWorld? world,

    /// Specifies the user script world ID to execute in. If omitted, the script
    /// will execute in the default user script world. Only valid if `world` is
    /// omitted or is `USER_SCRIPT`. Values with leading underscores (`_`) are
    /// reserved.
    String? worldId,
  }) : _wrapped = $js.UserScriptInjection(
          injectImmediately: injectImmediately,
          js: js.toJSArray((e) => e.toJS),
          target: target.toJS,
          world: world?.toJS,
          worldId: worldId,
        );

  final $js.UserScriptInjection _wrapped;

  $js.UserScriptInjection get toJS => _wrapped;

  /// Whether the injection should be triggered in the target as soon as
  /// possible. Note that this is not a guarantee that injection will occur
  /// prior to page load, as the page may have already loaded by the time the
  /// script reaches the target.
  bool? get injectImmediately => _wrapped.injectImmediately;

  set injectImmediately(bool? v) {
    _wrapped.injectImmediately = v;
  }

  /// The list of ScriptSource objects defining sources of scripts to be
  /// injected into the target.
  List<ScriptSource> get js => _wrapped.js.toDart
      .cast<$js.ScriptSource>()
      .map((e) => ScriptSource.fromJS(e))
      .toList();

  set js(List<ScriptSource> v) {
    _wrapped.js = v.toJSArray((e) => e.toJS);
  }

  /// Details specifying the target into which to inject the script.
  InjectionTarget get target => InjectionTarget.fromJS(_wrapped.target);

  set target(InjectionTarget v) {
    _wrapped.target = v.toJS;
  }

  /// The JavaScript "world" to run the script in. The default is
  /// `USER_SCRIPT`.
  ExecutionWorld? get world => _wrapped.world?.let(ExecutionWorld.fromJS);

  set world(ExecutionWorld? v) {
    _wrapped.world = v?.toJS;
  }

  /// Specifies the user script world ID to execute in. If omitted, the script
  /// will execute in the default user script world. Only valid if `world` is
  /// omitted or is `USER_SCRIPT`. Values with leading underscores (`_`) are
  /// reserved.
  String? get worldId => _wrapped.worldId;

  set worldId(String? v) {
    _wrapped.worldId = v;
  }
}

class WorldProperties {
  WorldProperties.fromJS(this._wrapped);

  WorldProperties({
    /// Specifies the ID of the specific user script world to update.
    /// If not provided, updates the properties of the default user script
    /// world.
    /// Values with leading underscores (`_`) are reserved.
    String? worldId,

    /// Specifies the world csp. The default is the ``ISOLATED``
    /// world csp.
    String? csp,

    /// Specifies whether messaging APIs are exposed. The default is
    /// `false`.
    bool? messaging,
  }) : _wrapped = $js.WorldProperties(
          worldId: worldId,
          csp: csp,
          messaging: messaging,
        );

  final $js.WorldProperties _wrapped;

  $js.WorldProperties get toJS => _wrapped;

  /// Specifies the ID of the specific user script world to update.
  /// If not provided, updates the properties of the default user script world.
  /// Values with leading underscores (`_`) are reserved.
  String? get worldId => _wrapped.worldId;

  set worldId(String? v) {
    _wrapped.worldId = v;
  }

  /// Specifies the world csp. The default is the ``ISOLATED``
  /// world csp.
  String? get csp => _wrapped.csp;

  set csp(String? v) {
    _wrapped.csp = v;
  }

  /// Specifies whether messaging APIs are exposed. The default is
  /// `false`.
  bool? get messaging => _wrapped.messaging;

  set messaging(bool? v) {
    _wrapped.messaging = v;
  }
}
