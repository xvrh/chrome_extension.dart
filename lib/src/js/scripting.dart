// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import
// ignore_for_file: unintended_html_in_doc_comment

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'extension_types.dart';

export 'chrome.dart';

extension JSChromeJSScriptingExtension on JSChrome {
  @JS('scripting')
  external JSScripting? get scriptingNullable;

  /// Use the `chrome.scripting` API to execute script in different
  /// contexts.
  JSScripting get scripting {
    var scriptingNullable = this.scriptingNullable;
    if (scriptingNullable == null) {
      throw ApiNotAvailableException('chrome.scripting');
    }
    return scriptingNullable;
  }
}

extension type JSScripting._(JSObject _) {
  /// Injects a script into a target context. The script will be run at
  /// `document_idle`. If the script evaluates to a promise,
  /// the browser will wait for the promise to settle and return the
  /// resulting value.
  /// |injection|: The details of the script which to inject.
  /// |callback|: Invoked upon completion of the injection. The resulting
  /// array contains the result of execution for each frame where the
  /// injection succeeded.
  external JSPromise executeScript(ScriptInjection injection);

  /// Inserts a CSS stylesheet into a target context.
  /// If multiple frames are specified, unsuccessful injections are ignored.
  /// |injection|: The details of the styles to insert.
  /// |callback|: Invoked upon completion of the insertion.
  external JSPromise insertCSS(CSSInjection injection);

  /// Removes a CSS stylesheet that was previously inserted by this extension
  /// from a target context.
  /// |injection|: The details of the styles to remove. Note that the
  /// `css`, `files`, and `origin` properties
  /// must exactly match the stylesheet inserted through [insertCSS].
  /// Attempting to remove a non-existent stylesheet is a no-op.
  /// |callback|: A callback to be invoked upon the completion of the removal.
  external JSPromise removeCSS(CSSInjection injection);

  /// Registers one or more content scripts for this extension.
  /// |scripts|: Contains a list of scripts to be registered. If there are
  /// errors during script parsing/file validation, or if the IDs specified
  /// already exist, then no scripts are registered.
  /// |callback|: A callback to be invoked once scripts have been fully
  /// registered or if an error has occurred.
  external JSPromise registerContentScripts(JSArray scripts);

  /// Returns all dynamically registered content scripts for this extension
  /// that match the given filter.
  /// |filter|: An object to filter the extension's dynamically registered
  /// scripts.
  external JSPromise getRegisteredContentScripts(ContentScriptFilter? filter);

  /// Unregisters content scripts for this extension.
  /// |filter|: If specified, only unregisters dynamic content scripts which
  /// match the filter. Otherwise, all of the extension's dynamic content
  /// scripts are unregistered.
  /// |callback|: A callback to be invoked once scripts have been unregistered
  /// or if an error has occurred.
  external JSPromise unregisterContentScripts(ContentScriptFilter? filter);

  /// Updates one or more content scripts for this extension.
  /// |scripts|: Contains a list of scripts to be updated. A property is only
  /// updated for the existing script if it is specified in this object. If
  /// there are errors during script parsing/file validation, or if the IDs
  /// specified do not correspond to a fully registered script, then no scripts
  /// are updated.
  /// |callback|: A callback to be invoked once scripts have been updated or
  /// if an error has occurred.
  external JSPromise updateContentScripts(JSArray scripts);

  /// An object available for content scripts running in isolated worlds to use
  /// and modify as a JS object. One instance exists per frame and is shared
  /// between all content scripts for a given extension. This object is
  /// initialized when the frame is created, before document_start.
  /// TODO(crbug.com/1054624): Enable this once implementation is complete.
  external int get globalParams;
}

/// The origin for a style change.
/// See [style
/// origins](https://developer.mozilla.org/en-US/docs/Glossary/Style_origin)
/// for more info.
typedef StyleOrigin = String;

/// The JavaScript world for a script to execute within.
typedef ExecutionWorld = String;
extension type InjectionTarget._(JSObject _) implements JSObject {
  external factory InjectionTarget({
    /// The ID of the tab into which to inject.
    int tabId,

    /// The [IDs](https://developer.chrome.com/extensions/webNavigation#frame_ids)
    /// of specific frames to inject into.
    JSArray? frameIds,

    /// The
    /// [IDs](https://developer.chrome.com/extensions/webNavigation#document_ids)
    /// of specific documentIds to inject into. This must not be set if
    /// `frameIds` is set.
    JSArray? documentIds,

    /// Whether the script should inject into all frames within the tab. Defaults
    /// to false.
    /// This must not be true if `frameIds` is specified.
    bool? allFrames,
  });

  /// The ID of the tab into which to inject.
  external int tabId;

  /// The [IDs](https://developer.chrome.com/extensions/webNavigation#frame_ids)
  /// of specific frames to inject into.
  external JSArray? frameIds;

  /// The
  /// [IDs](https://developer.chrome.com/extensions/webNavigation#document_ids)
  /// of specific documentIds to inject into. This must not be set if
  /// `frameIds` is set.
  external JSArray? documentIds;

  /// Whether the script should inject into all frames within the tab. Defaults
  /// to false.
  /// This must not be true if `frameIds` is specified.
  external bool? allFrames;
}
extension type ScriptInjection._(JSObject _) implements JSObject {
  external factory ScriptInjection({
    /// A JavaScript function to inject. This function will be serialized, and
    /// then deserialized for injection. This means that any bound parameters
    /// and execution context will be lost.
    /// Exactly one of `files` or `func` must be
    /// specified.
    JSAny? func,

    /// The arguments to pass to the provided function. This is only valid if
    /// the `func` parameter is specified. These arguments must be
    /// JSON-serializable.
    JSArray? args,

    /// We used to call the injected function `function`, but this is
    /// incompatible with JavaScript's object declaration shorthand (see
    /// https://crbug.com/1166438). We leave this silently in for backwards
    /// compatibility.
    /// TODO(devlin): Remove this in M95.
    JSAny? function,

    /// The path of the JS or CSS files to inject, relative to the extension's
    /// root directory.
    /// Exactly one of `files` or `func` must be
    /// specified.
    JSArray? files,

    /// Details specifying the target into which to inject the script.
    InjectionTarget target,

    /// The JavaScript "world" to run the script in. Defaults to
    /// `ISOLATED`.
    ExecutionWorld? world,

    /// Whether the injection should be triggered in the target as soon as
    /// possible. Note that this is not a guarantee that injection will occur
    /// prior to page load, as the page may have already loaded by the time the
    /// script reaches the target.
    bool? injectImmediately,
  });

  /// A JavaScript function to inject. This function will be serialized, and
  /// then deserialized for injection. This means that any bound parameters
  /// and execution context will be lost.
  /// Exactly one of `files` or `func` must be
  /// specified.
  external JSAny? func;

  /// The arguments to pass to the provided function. This is only valid if
  /// the `func` parameter is specified. These arguments must be
  /// JSON-serializable.
  external JSArray? args;

  /// We used to call the injected function `function`, but this is
  /// incompatible with JavaScript's object declaration shorthand (see
  /// https://crbug.com/1166438). We leave this silently in for backwards
  /// compatibility.
  /// TODO(devlin): Remove this in M95.
  external JSAny? function;

  /// The path of the JS or CSS files to inject, relative to the extension's
  /// root directory.
  /// Exactly one of `files` or `func` must be
  /// specified.
  external JSArray? files;

  /// Details specifying the target into which to inject the script.
  external InjectionTarget target;

  /// The JavaScript "world" to run the script in. Defaults to
  /// `ISOLATED`.
  external ExecutionWorld? world;

  /// Whether the injection should be triggered in the target as soon as
  /// possible. Note that this is not a guarantee that injection will occur
  /// prior to page load, as the page may have already loaded by the time the
  /// script reaches the target.
  external bool? injectImmediately;
}
extension type CSSInjection._(JSObject _) implements JSObject {
  external factory CSSInjection({
    /// Details specifying the target into which to insert the CSS.
    InjectionTarget target,

    /// A string containing the CSS to inject.
    /// Exactly one of `files` and `css` must be
    /// specified.
    String? css,

    /// The path of the CSS files to inject, relative to the extension's root
    /// directory.
    /// Exactly one of `files` and `css` must be
    /// specified.
    JSArray? files,

    /// The style origin for the injection. Defaults to `'AUTHOR'`.
    StyleOrigin? origin,
  });

  /// Details specifying the target into which to insert the CSS.
  external InjectionTarget target;

  /// A string containing the CSS to inject.
  /// Exactly one of `files` and `css` must be
  /// specified.
  external String? css;

  /// The path of the CSS files to inject, relative to the extension's root
  /// directory.
  /// Exactly one of `files` and `css` must be
  /// specified.
  external JSArray? files;

  /// The style origin for the injection. Defaults to `'AUTHOR'`.
  external StyleOrigin? origin;
}
extension type InjectionResult._(JSObject _) implements JSObject {
  external factory InjectionResult({
    /// The result of the script execution.
    JSAny? result,

    /// The frame associated with the injection.
    int frameId,

    /// The document associated with the injection.
    String documentId,
  });

  /// The result of the script execution.
  external JSAny? result;

  /// The frame associated with the injection.
  external int frameId;

  /// The document associated with the injection.
  external String documentId;
}
extension type RegisteredContentScript._(JSObject _) implements JSObject {
  external factory RegisteredContentScript({
    /// The id of the content script, specified in the API call. Must not start
    /// with a '_' as it's reserved as a prefix for generated script IDs.
    String id,

    /// Specifies which pages this content script will be injected into. See
    /// [Match Patterns](develop/concepts/match-patterns) for more
    /// details on the syntax of these strings. Must be specified for
    /// [registerContentScripts].
    JSArray? matches,

    /// Excludes pages that this content script would otherwise be injected into.
    /// See [Match Patterns](develop/concepts/match-patterns) for
    /// more details on the syntax of these strings.
    JSArray? excludeMatches,

    /// The list of CSS files to be injected into matching pages. These are
    /// injected in the order they appear in this array, before any DOM is
    /// constructed or displayed for the page.
    JSArray? css,

    /// The list of JavaScript files to be injected into matching pages. These
    /// are injected in the order they appear in this array.
    JSArray? js,

    /// If specified true, it will inject into all frames, even if the frame is
    /// not the top-most frame in the tab. Each frame is checked independently
    /// for URL requirements; it will not inject into child frames if the URL
    /// requirements are not met. Defaults to false, meaning that only the top
    /// frame is matched.
    bool? allFrames,

    /// Indicates whether the script can be injected into frames where the URL
    /// contains an unsupported scheme; specifically: about:, data:, blob:, or
    /// filesystem:. In these cases, the URL's origin is checked to determine if
    /// the script should be injected. If the origin is `null` (as is the case
    /// for data: URLs) then the used origin is either the frame that created
    /// the current frame or the frame that initiated the navigation to this
    /// frame. Note that this may not be the parent frame.
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
  });

  /// The id of the content script, specified in the API call. Must not start
  /// with a '_' as it's reserved as a prefix for generated script IDs.
  external String id;

  /// Specifies which pages this content script will be injected into. See
  /// [Match Patterns](develop/concepts/match-patterns) for more
  /// details on the syntax of these strings. Must be specified for
  /// [registerContentScripts].
  external JSArray? matches;

  /// Excludes pages that this content script would otherwise be injected into.
  /// See [Match Patterns](develop/concepts/match-patterns) for
  /// more details on the syntax of these strings.
  external JSArray? excludeMatches;

  /// The list of CSS files to be injected into matching pages. These are
  /// injected in the order they appear in this array, before any DOM is
  /// constructed or displayed for the page.
  external JSArray? css;

  /// The list of JavaScript files to be injected into matching pages. These
  /// are injected in the order they appear in this array.
  external JSArray? js;

  /// If specified true, it will inject into all frames, even if the frame is
  /// not the top-most frame in the tab. Each frame is checked independently
  /// for URL requirements; it will not inject into child frames if the URL
  /// requirements are not met. Defaults to false, meaning that only the top
  /// frame is matched.
  external bool? allFrames;

  /// Indicates whether the script can be injected into frames where the URL
  /// contains an unsupported scheme; specifically: about:, data:, blob:, or
  /// filesystem:. In these cases, the URL's origin is checked to determine if
  /// the script should be injected. If the origin is `null` (as is the case
  /// for data: URLs) then the used origin is either the frame that created
  /// the current frame or the frame that initiated the navigation to this
  /// frame. Note that this may not be the parent frame.
  external bool? matchOriginAsFallback;

  /// Specifies when JavaScript files are injected into the web page. The
  /// preferred and default value is `document_idle`.
  external RunAt? runAt;

  /// Specifies if this content script will persist into future sessions. The
  /// default is true.
  external bool? persistAcrossSessions;

  /// The JavaScript "world" to run the script in. Defaults to
  /// `ISOLATED`.
  external ExecutionWorld? world;
}
extension type ContentScriptFilter._(JSObject _) implements JSObject {
  external factory ContentScriptFilter(
      {
      /// If specified, [getRegisteredContentScripts] will only return scripts
      /// with an id specified in this list.
      JSArray? ids});

  /// If specified, [getRegisteredContentScripts] will only return scripts
  /// with an id specified in this list.
  external JSArray? ids;
}
