// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import
// ignore_for_file: unintended_html_in_doc_comment

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'extension_types.dart';

export 'chrome.dart';

extension JSChromeJSUserScriptsExtension on JSChrome {
  @JS('userScripts')
  external JSUserScripts? get userScriptsNullable;

  /// Use the `userScripts` API to execute user scripts in the User
  /// Scripts context.
  JSUserScripts get userScripts {
    var userScriptsNullable = this.userScriptsNullable;
    if (userScriptsNullable == null) {
      throw ApiNotAvailableException('chrome.userScripts');
    }
    return userScriptsNullable;
  }
}

extension type JSUserScripts._(JSObject _) {
  /// Registers one or more user scripts for this extension.
  /// |scripts|: Contains a list of user scripts to be registered.
  /// |Returns|: Promise that resolves once scripts have been fully
  /// registered. The promise will be rejected if an error occurs.
  external JSPromise register(JSArray scripts);

  /// Returns all dynamically-registered user scripts for this extension.
  /// |filter|: If specified, this method returns only the user scripts that
  /// match it.
  /// |Returns|: Promise that resolves with the registered scripts.
  /// The promise will be rejected if an error occurs.
  external JSPromise<JSArray> getScripts(UserScriptFilter? filter);

  /// Unregisters all dynamically-registered user scripts for this extension.
  /// |filter|: If specified, this method unregisters only the user scripts
  /// that match it.
  /// |Returns|: Promise that resolves once scripts have been fully
  /// unregistered. The promise will be rejected if an error occurs.
  external JSPromise unregister(UserScriptFilter? filter);

  /// Updates one or more user scripts for this extension.
  /// |scripts|: Contains a list of user scripts to be updated. A property is
  /// only updated for the existing script if it is specified in this object.
  /// If there are errors during script parsing/file validation, or if the IDs
  /// specified do not correspond to a fully registered script, then no scripts
  /// are updated.
  /// |Returns|: Promise that resolves once scripts have been fully updated.
  /// The promise will be rejected if an error occurs.
  external JSPromise update(JSArray scripts);

  /// Injects a script into a target context. By default, the script will be
  /// run at `document_idle`, or immediately if the page has already
  /// loaded. If the `injectImmediately` property is set, the script
  /// will inject without waiting, even if the page has not finished loading.
  /// If the script evaluates to a promise, the browser will wait for the
  /// promise to settle and return the resulting value.
  external JSPromise<JSArray> execute(UserScriptInjection injection);

  /// Configures the ``USER_SCRIPT`` execution environment.
  /// |properties|: Contains the user script world configuration.
  /// |Returns|: Promise that resolves once the world has been
  /// configured.
  external JSPromise configureWorld(WorldProperties properties);

  /// Retrieves all registered world configurations.
  /// |Returns|: Promise that resolves with the registered world
  /// configurations.
  external JSPromise<JSArray> getWorldConfigurations();

  /// Resets the configuration for a user script world. Any scripts that inject
  /// into the world with the specified ID will use the default world
  /// configuration.
  /// |worldId|: The ID of the user script world to reset. If omitted, resets
  /// the default world's configuration.
  /// |Returns|: Promise that resolves when the configuration is reset.
  external JSPromise resetWorldConfiguration(String? worldId);
}

/// The JavaScript world for a user script to execute within.
typedef ExecutionWorld = JSString;
extension type ScriptSource._(JSObject _) implements JSObject {
  external factory ScriptSource({
    /// A string containing the JavaScript code to inject. Exactly one of
    /// `file` or `code` must be specified.
    String? code,

    /// The path of the JavaScript file to inject relative to the extension's
    /// root directory. Exactly one of `file` or `code`
    /// must be specified.
    String? file,
  });

  /// A string containing the JavaScript code to inject. Exactly one of
  /// `file` or `code` must be specified.
  external String? code;

  /// The path of the JavaScript file to inject relative to the extension's
  /// root directory. Exactly one of `file` or `code`
  /// must be specified.
  external String? file;
}
extension type RegisteredUserScript._(JSObject _) implements JSObject {
  external factory RegisteredUserScript({
    /// If true, it will inject into all frames, even if the frame is not the
    /// top-most frame in the tab. Each frame is checked independently for URL
    /// requirements; it will not inject into child frames if the URL
    /// requirements are not met. Defaults to false, meaning that only the top
    /// frame is matched.
    bool? allFrames,

    /// Excludes pages that this user script would otherwise be injected into.
    /// See [Match Patterns](develop/concepts/match-patterns) for more
    /// details on the syntax of these strings.
    JSArray? excludeMatches,

    /// The ID of the user script specified in the API call. This property must
    /// not start with a '_' as it's reserved as a prefix for generated script
    /// IDs.
    String id,

    /// Specifies wildcard patterns for pages this user script will be injected
    /// into.
    JSArray? includeGlobs,

    /// Specifies wildcard patterns for pages this user script will NOT be
    /// injected into.
    JSArray? excludeGlobs,

    /// The list of ScriptSource objects defining sources of scripts to be
    /// injected into matching pages.
    /// This property must be specified for  ${ref:register}, and when specified
    /// it must be a non-empty array.
    JSArray? js,

    /// Specifies which pages this user script will be injected into. See
    /// [Match Patterns](develop/concepts/match-patterns) for more
    /// details on the syntax of these strings. This property must be specified
    /// for
    /// ${ref:register}.
    JSArray? matches,

    /// Specifies when JavaScript files are injected into the web page. The
    /// preferred and default value is `document_idle`.
    RunAt? runAt,

    /// The JavaScript execution environment to run the script in. The default is
    /// ``USER_SCRIPT``.
    ExecutionWorld? world,

    /// Specifies the user script world ID to execute in. If omitted, the script
    /// will execute in the default user script world. Only valid if `world` is
    /// omitted or is `USER_SCRIPT`. Values with leading underscores (`_`) are
    /// reserved.
    String? worldId,
  });

  /// If true, it will inject into all frames, even if the frame is not the
  /// top-most frame in the tab. Each frame is checked independently for URL
  /// requirements; it will not inject into child frames if the URL
  /// requirements are not met. Defaults to false, meaning that only the top
  /// frame is matched.
  external bool? allFrames;

  /// Excludes pages that this user script would otherwise be injected into.
  /// See [Match Patterns](develop/concepts/match-patterns) for more
  /// details on the syntax of these strings.
  external JSArray? excludeMatches;

  /// The ID of the user script specified in the API call. This property must
  /// not start with a '_' as it's reserved as a prefix for generated script
  /// IDs.
  external String id;

  /// Specifies wildcard patterns for pages this user script will be injected
  /// into.
  external JSArray? includeGlobs;

  /// Specifies wildcard patterns for pages this user script will NOT be
  /// injected into.
  external JSArray? excludeGlobs;

  /// The list of ScriptSource objects defining sources of scripts to be
  /// injected into matching pages.
  /// This property must be specified for  ${ref:register}, and when specified
  /// it must be a non-empty array.
  external JSArray? js;

  /// Specifies which pages this user script will be injected into. See
  /// [Match Patterns](develop/concepts/match-patterns) for more
  /// details on the syntax of these strings. This property must be specified
  /// for
  /// ${ref:register}.
  external JSArray? matches;

  /// Specifies when JavaScript files are injected into the web page. The
  /// preferred and default value is `document_idle`.
  external RunAt? runAt;

  /// The JavaScript execution environment to run the script in. The default is
  /// ``USER_SCRIPT``.
  external ExecutionWorld? world;

  /// Specifies the user script world ID to execute in. If omitted, the script
  /// will execute in the default user script world. Only valid if `world` is
  /// omitted or is `USER_SCRIPT`. Values with leading underscores (`_`) are
  /// reserved.
  external String? worldId;
}
extension type UserScriptFilter._(JSObject _) implements JSObject {
  external factory UserScriptFilter(
      {
      /// [getScripts] only returns scripts with the IDs specified in this
      /// list.
      JSArray? ids});

  /// [getScripts] only returns scripts with the IDs specified in this
  /// list.
  external JSArray? ids;
}
extension type InjectionTarget._(JSObject _) implements JSObject {
  external factory InjectionTarget({
    /// Whether the script should inject into all frames within the tab. Defaults
    /// to false. This must not be true if `frameIds` is specified.
    bool? allFrames,

    /// The IDs of specific documentIds to inject into. This must not be set if
    /// `frameIds` is set.
    JSArray? documentIds,

    /// The IDs of specific frames to inject into.
    JSArray? frameIds,

    /// The ID of the tab into which to inject.
    int tabId,
  });

  /// Whether the script should inject into all frames within the tab. Defaults
  /// to false. This must not be true if `frameIds` is specified.
  external bool? allFrames;

  /// The IDs of specific documentIds to inject into. This must not be set if
  /// `frameIds` is set.
  external JSArray? documentIds;

  /// The IDs of specific frames to inject into.
  external JSArray? frameIds;

  /// The ID of the tab into which to inject.
  external int tabId;
}
extension type InjectionResult._(JSObject _) implements JSObject {
  external factory InjectionResult({
    /// The document associated with the injection.
    String documentId,

    /// The frame associated with the injection.
    int frameId,

    /// The result of the script execution.
    JSAny? result,

    /// The error, if any. `error` and `result` are
    /// mutually exclusive.
    String? error,
  });

  /// The document associated with the injection.
  external String documentId;

  /// The frame associated with the injection.
  external int frameId;

  /// The result of the script execution.
  external JSAny? result;

  /// The error, if any. `error` and `result` are
  /// mutually exclusive.
  external String? error;
}
extension type UserScriptInjection._(JSObject _) implements JSObject {
  external factory UserScriptInjection({
    /// Whether the injection should be triggered in the target as soon as
    /// possible. Note that this is not a guarantee that injection will occur
    /// prior to page load, as the page may have already loaded by the time the
    /// script reaches the target.
    bool? injectImmediately,

    /// The list of ScriptSource objects defining sources of scripts to be
    /// injected into the target.
    JSArray js,

    /// Details specifying the target into which to inject the script.
    InjectionTarget target,

    /// The JavaScript "world" to run the script in. The default is
    /// `USER_SCRIPT`.
    ExecutionWorld? world,

    /// Specifies the user script world ID to execute in. If omitted, the script
    /// will execute in the default user script world. Only valid if `world` is
    /// omitted or is `USER_SCRIPT`. Values with leading underscores (`_`) are
    /// reserved.
    String? worldId,
  });

  /// Whether the injection should be triggered in the target as soon as
  /// possible. Note that this is not a guarantee that injection will occur
  /// prior to page load, as the page may have already loaded by the time the
  /// script reaches the target.
  external bool? injectImmediately;

  /// The list of ScriptSource objects defining sources of scripts to be
  /// injected into the target.
  external JSArray js;

  /// Details specifying the target into which to inject the script.
  external InjectionTarget target;

  /// The JavaScript "world" to run the script in. The default is
  /// `USER_SCRIPT`.
  external ExecutionWorld? world;

  /// Specifies the user script world ID to execute in. If omitted, the script
  /// will execute in the default user script world. Only valid if `world` is
  /// omitted or is `USER_SCRIPT`. Values with leading underscores (`_`) are
  /// reserved.
  external String? worldId;
}
extension type WorldProperties._(JSObject _) implements JSObject {
  external factory WorldProperties({
    /// Specifies the ID of the specific user script world to update.
    /// If not provided, updates the properties of the default user script world.
    /// Values with leading underscores (`_`) are reserved.
    String? worldId,

    /// Specifies the world csp. The default is the ``ISOLATED``
    /// world csp.
    String? csp,

    /// Specifies whether messaging APIs are exposed. The default is
    /// `false`.
    bool? messaging,
  });

  /// Specifies the ID of the specific user script world to update.
  /// If not provided, updates the properties of the default user script world.
  /// Values with leading underscores (`_`) are reserved.
  external String? worldId;

  /// Specifies the world csp. The default is the ``ISOLATED``
  /// world csp.
  external String? csp;

  /// Specifies whether messaging APIs are exposed. The default is
  /// `false`.
  external bool? messaging;
}
