// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'devtools.dart';

export 'chrome.dart';
export 'devtools.dart';

extension JSChromeJSDevtoolsInspectedWindowExtension on JSChromeDevtools {
  @JS('inspectedWindow')
  external JSDevtoolsInspectedWindow? get inspectedWindowNullable;

  /// Use the `chrome.devtools.inspectedWindow` API to interact with the
  /// inspected window: obtain the tab ID for the inspected page, evaluate the
  /// code in the context of the inspected window, reload the page, or obtain
  /// the list of resources within the page.
  JSDevtoolsInspectedWindow get inspectedWindow {
    var inspectedWindowNullable = this.inspectedWindowNullable;
    if (inspectedWindowNullable == null) {
      throw ApiNotAvailableException('chrome.devtools.inspectedWindow');
    }
    return inspectedWindowNullable;
  }
}

@JS()
@staticInterop
class JSDevtoolsInspectedWindow {}

extension JSDevtoolsInspectedWindowExtension on JSDevtoolsInspectedWindow {
  /// Evaluates a JavaScript expression in the context of the main frame of the
  /// inspected page. The expression must evaluate to a JSON-compliant object,
  /// otherwise an exception is thrown. The eval function can report either a
  /// DevTools-side error or a JavaScript exception that occurs during
  /// evaluation. In either case, the `result` parameter of the callback is
  /// `undefined`. In the case of a DevTools-side error, the `isException`
  /// parameter is non-null and has `isError` set to true and `code` set to an
  /// error code. In the case of a JavaScript error, `isException` is set to
  /// true and `value` is set to the string value of thrown object.
  external void eval(
    /// An expression to evaluate.
    String expression,

    /// The options parameter can contain one or more options.
    EvalOptions? options,

    /// A function called when evaluation completes.
    JSFunction? callback,
  );

  /// Reloads the inspected page.
  external void reload(ReloadOptions? reloadOptions);

  /// Retrieves the list of resources from the inspected page.
  external void getResources(

      /// A function that receives the list of resources when the request
      /// completes.
      JSFunction callback);

  /// Fired when a new resource is added to the inspected page.
  external Event get onResourceAdded;

  /// Fired when a new revision of the resource is committed (e.g. user saves an
  /// edited version of the resource in the Developer Tools).
  external Event get onResourceContentCommitted;

  /// The ID of the tab being inspected. This ID may be used with chrome.tabs.*
  /// API.
  external int get tabId;
}

@JS()
@staticInterop
@anonymous
class Resource {
  external factory Resource(
      {
      /// The URL of the resource.
      String url});
}

extension ResourceExtension on Resource {
  /// The URL of the resource.
  external String url;

  /// Gets the content of the resource.
  external void getContent(

      /// A function that receives resource content when the request completes.
      JSFunction callback);

  /// Sets the content of the resource.
  external void setContent(
    /// New content of the resource. Only resources with the text type are
    /// currently supported.
    String content,

    /// True if the user has finished editing the resource, and the new content
    /// of the resource should be persisted; false if this is a minor change
    /// sent in progress of the user editing the resource.
    bool commit,

    /// A function called upon request completion.
    JSFunction? callback,
  );
}

@JS()
@staticInterop
@anonymous
class EvalExceptionInfo {
  external factory EvalExceptionInfo({
    /// Set if the error occurred on the DevTools side before the expression is
    /// evaluated.
    bool isError,

    /// Set if the error occurred on the DevTools side before the expression is
    /// evaluated.
    String code,

    /// Set if the error occurred on the DevTools side before the expression is
    /// evaluated.
    String description,

    /// Set if the error occurred on the DevTools side before the expression is
    /// evaluated, contains the array of the values that may be substituted into
    /// the description string to provide more information about the cause of the
    /// error.
    JSArray details,

    /// Set if the evaluated code produces an unhandled exception.
    bool isException,

    /// Set if the evaluated code produces an unhandled exception.
    String value,
  });
}

extension EvalExceptionInfoExtension on EvalExceptionInfo {
  /// Set if the error occurred on the DevTools side before the expression is
  /// evaluated.
  external bool isError;

  /// Set if the error occurred on the DevTools side before the expression is
  /// evaluated.
  external String code;

  /// Set if the error occurred on the DevTools side before the expression is
  /// evaluated.
  external String description;

  /// Set if the error occurred on the DevTools side before the expression is
  /// evaluated, contains the array of the values that may be substituted into
  /// the description string to provide more information about the cause of the
  /// error.
  external JSArray details;

  /// Set if the evaluated code produces an unhandled exception.
  external bool isException;

  /// Set if the evaluated code produces an unhandled exception.
  external String value;
}

@JS()
@staticInterop
@anonymous
class EvalOptions {
  external factory EvalOptions({
    /// If specified, the expression is evaluated on the iframe whose URL matches
    /// the one specified. By default, the expression is evaluated in the top
    /// frame of the inspected page.
    String? frameURL,

    /// Evaluate the expression in the context of the content script of the
    /// calling extension, provided that the content script is already injected
    /// into the inspected page. If not, the expression is not evaluated and the
    /// callback is invoked with the exception parameter set to an object that has
    /// the `isError` field set to true and the `code` field set to `E_NOTFOUND`.
    bool? useContentScriptContext,

    /// Evaluate the expression in the context of a content script of an extension
    /// that matches the specified origin. If given, scriptExecutionContext
    /// overrides the 'true' setting on useContentScriptContext.
    String? scriptExecutionContext,
  });
}

extension EvalOptionsExtension on EvalOptions {
  /// If specified, the expression is evaluated on the iframe whose URL matches
  /// the one specified. By default, the expression is evaluated in the top
  /// frame of the inspected page.
  external String? frameURL;

  /// Evaluate the expression in the context of the content script of the
  /// calling extension, provided that the content script is already injected
  /// into the inspected page. If not, the expression is not evaluated and the
  /// callback is invoked with the exception parameter set to an object that has
  /// the `isError` field set to true and the `code` field set to `E_NOTFOUND`.
  external bool? useContentScriptContext;

  /// Evaluate the expression in the context of a content script of an extension
  /// that matches the specified origin. If given, scriptExecutionContext
  /// overrides the 'true' setting on useContentScriptContext.
  external String? scriptExecutionContext;
}

@JS()
@staticInterop
@anonymous
class ReloadOptions {
  external factory ReloadOptions({
    /// When true, the loader will bypass the cache for all inspected page
    /// resources loaded before the `load` event is fired. The effect is similar
    /// to pressing Ctrl+Shift+R in the inspected window or within the Developer
    /// Tools window.
    bool? ignoreCache,

    /// If specified, the string will override the value of the `User-Agent` HTTP
    /// header that's sent while loading the resources of the inspected page. The
    /// string will also override the value of the `navigator.userAgent` property
    /// that's returned to any scripts that are running within the inspected page.
    String? userAgent,

    /// If specified, the script will be injected into every frame of the
    /// inspected page immediately upon load, before any of the frame's scripts.
    /// The script will not be injected after subsequent reloads-for example, if
    /// the user presses Ctrl+R.
    String? injectedScript,
  });
}

extension ReloadOptionsExtension on ReloadOptions {
  /// When true, the loader will bypass the cache for all inspected page
  /// resources loaded before the `load` event is fired. The effect is similar
  /// to pressing Ctrl+Shift+R in the inspected window or within the Developer
  /// Tools window.
  external bool? ignoreCache;

  /// If specified, the string will override the value of the `User-Agent` HTTP
  /// header that's sent while loading the resources of the inspected page. The
  /// string will also override the value of the `navigator.userAgent` property
  /// that's returned to any scripts that are running within the inspected page.
  external String? userAgent;

  /// If specified, the script will be injected into every frame of the
  /// inspected page immediately upon load, before any of the frame's scripts.
  /// The script will not be injected after subsequent reloads-for example, if
  /// the user presses Ctrl+R.
  external String? injectedScript;
}
