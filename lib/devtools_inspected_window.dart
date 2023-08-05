// ignore_for_file: unnecessary_parenthesis

library;

import 'devtools.dart';
import 'src/internal_helpers.dart';
import 'src/js/devtools_inspected_window.dart' as $js;

export 'devtools.dart' show ChromeDevtools, ChromeDevtoolsExtension;
export 'src/chrome.dart' show chrome;

final _devtoolsInspectedWindow = ChromeDevtoolsInspectedWindow._();

extension ChromeDevtoolsInspectedWindowExtension on ChromeDevtools {
  /// Use the `chrome.devtools.inspectedWindow` API to interact with the
  /// inspected window: obtain the tab ID for the inspected page, evaluate the
  /// code in the context of the inspected window, reload the page, or obtain
  /// the list of resources within the page.
  ChromeDevtoolsInspectedWindow get inspectedWindow => _devtoolsInspectedWindow;
}

class ChromeDevtoolsInspectedWindow {
  ChromeDevtoolsInspectedWindow._();

  bool get isAvailable =>
      $js.chrome.devtoolsNullable?.inspectedWindowNullable != null &&
      alwaysTrue;

  /// Evaluates a JavaScript expression in the context of the main frame of the
  /// inspected page. The expression must evaluate to a JSON-compliant object,
  /// otherwise an exception is thrown. The eval function can report either a
  /// DevTools-side error or a JavaScript exception that occurs during
  /// evaluation. In either case, the `result` parameter of the callback is
  /// `undefined`. In the case of a DevTools-side error, the `isException`
  /// parameter is non-null and has `isError` set to true and `code` set to an
  /// error code. In the case of a JavaScript error, `isException` is set to
  /// true and `value` is set to the string value of thrown object.
  /// [expression] An expression to evaluate.
  /// [options] The options parameter can contain one or more options.
  /// [returns] A function called when evaluation completes.
  Future<EvalResult> eval(
    String expression,
    EvalOptions? options,
  ) {
    var $completer = Completer<EvalResult>();
    $js.chrome.devtools.inspectedWindow.eval(
      expression,
      options?.toJS,
      (
        JSAny result,
        $js.EvalExceptionInfo exceptionInfo,
      ) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(EvalResult(
            result: result.toDartMap(),
            exceptionInfo: EvalExceptionInfo.fromJS(exceptionInfo),
          ));
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Reloads the inspected page.
  void reload(ReloadOptions? reloadOptions) {
    $js.chrome.devtools.inspectedWindow.reload(reloadOptions?.toJS);
  }

  /// Retrieves the list of resources from the inspected page.
  /// [returns] A function that receives the list of resources when the
  /// request completes.
  Future<List<Resource>> getResources() {
    var $completer = Completer<List<Resource>>();
    $js.chrome.devtools.inspectedWindow.getResources((JSArray resources) {
      if (checkRuntimeLastError($completer)) {
        $completer.complete(resources.toDart
            .cast<$js.Resource>()
            .map((e) => Resource.fromJS(e))
            .toList());
      }
    }.toJS);
    return $completer.future;
  }

  /// The ID of the tab being inspected. This ID may be used with chrome.tabs.*
  /// API.
  int get tabId => $js.chrome.devtools.inspectedWindow.tabId;

  /// Fired when a new resource is added to the inspected page.
  EventStream<Resource> get onResourceAdded =>
      $js.chrome.devtools.inspectedWindow.onResourceAdded
          .asStream(($c) => ($js.Resource resource) {
                return $c(Resource.fromJS(resource));
              });

  /// Fired when a new revision of the resource is committed (e.g. user saves an
  /// edited version of the resource in the Developer Tools).
  EventStream<OnResourceContentCommittedEvent> get onResourceContentCommitted =>
      $js.chrome.devtools.inspectedWindow.onResourceContentCommitted
          .asStream(($c) => (
                $js.Resource resource,
                String content,
              ) {
                return $c(OnResourceContentCommittedEvent(
                  resource: Resource.fromJS(resource),
                  content: content,
                ));
              });
}

class Resource {
  Resource.fromJS(this._wrapped);

  Resource(
      {
      /// The URL of the resource.
      required String url})
      : _wrapped = $js.Resource(url: url);

  final $js.Resource _wrapped;

  $js.Resource get toJS => _wrapped;

  /// The URL of the resource.
  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// Gets the content of the resource.
  /// [returns] A function that receives resource content when the request
  /// completes.
  Future<GetContentResult> getContent() {
    var $completer = Completer<GetContentResult>();
    _wrapped.getContent((
      String content,
      String encoding,
    ) {
      if (checkRuntimeLastError($completer)) {
        $completer.complete(GetContentResult(
          content: content,
          encoding: encoding,
        ));
      }
    }.toJS);
    return $completer.future;
  }

  /// Sets the content of the resource.
  /// [content] New content of the resource. Only resources with the text type
  /// are currently supported.
  /// [commit] True if the user has finished editing the resource, and the new
  /// content of the resource should be persisted; false if this is a minor
  /// change sent in progress of the user editing the resource.
  /// [returns] A function called upon request completion.
  Future<Map?> setContent(
    String content,
    bool commit,
  ) {
    var $completer = Completer<Map?>();
    _wrapped.setContent(
      content,
      commit,
      (JSAny? error) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(error?.toDartMap());
        }
      }.toJS,
    );
    return $completer.future;
  }
}

class EvalExceptionInfo {
  EvalExceptionInfo.fromJS(this._wrapped);

  EvalExceptionInfo({
    /// Set if the error occurred on the DevTools side before the expression is
    /// evaluated.
    required bool isError,

    /// Set if the error occurred on the DevTools side before the expression is
    /// evaluated.
    required String code,

    /// Set if the error occurred on the DevTools side before the expression is
    /// evaluated.
    required String description,

    /// Set if the error occurred on the DevTools side before the expression is
    /// evaluated, contains the array of the values that may be substituted into
    /// the description string to provide more information about the cause of
    /// the error.
    required List<Object> details,

    /// Set if the evaluated code produces an unhandled exception.
    required bool isException,

    /// Set if the evaluated code produces an unhandled exception.
    required String value,
  }) : _wrapped = $js.EvalExceptionInfo(
          isError: isError,
          code: code,
          description: description,
          details: details.toJSArray((e) => e.jsify()!),
          isException: isException,
          value: value,
        );

  final $js.EvalExceptionInfo _wrapped;

  $js.EvalExceptionInfo get toJS => _wrapped;

  /// Set if the error occurred on the DevTools side before the expression is
  /// evaluated.
  bool get isError => _wrapped.isError;
  set isError(bool v) {
    _wrapped.isError = v;
  }

  /// Set if the error occurred on the DevTools side before the expression is
  /// evaluated.
  String get code => _wrapped.code;
  set code(String v) {
    _wrapped.code = v;
  }

  /// Set if the error occurred on the DevTools side before the expression is
  /// evaluated.
  String get description => _wrapped.description;
  set description(String v) {
    _wrapped.description = v;
  }

  /// Set if the error occurred on the DevTools side before the expression is
  /// evaluated, contains the array of the values that may be substituted into
  /// the description string to provide more information about the cause of the
  /// error.
  List<Object> get details =>
      _wrapped.details.toDart.cast<JSAny>().map((e) => e.dartify()!).toList();
  set details(List<Object> v) {
    _wrapped.details = v.toJSArray((e) => e.jsify()!);
  }

  /// Set if the evaluated code produces an unhandled exception.
  bool get isException => _wrapped.isException;
  set isException(bool v) {
    _wrapped.isException = v;
  }

  /// Set if the evaluated code produces an unhandled exception.
  String get value => _wrapped.value;
  set value(String v) {
    _wrapped.value = v;
  }
}

class EvalOptions {
  EvalOptions.fromJS(this._wrapped);

  EvalOptions({
    /// If specified, the expression is evaluated on the iframe whose URL
    /// matches the one specified. By default, the expression is evaluated in
    /// the top frame of the inspected page.
    String? frameUrl,

    /// Evaluate the expression in the context of the content script of the
    /// calling extension, provided that the content script is already injected
    /// into the inspected page. If not, the expression is not evaluated and the
    /// callback is invoked with the exception parameter set to an object that
    /// has the `isError` field set to true and the `code` field set to
    /// `E_NOTFOUND`.
    bool? useContentScriptContext,

    /// Evaluate the expression in the context of a content script of an
    /// extension that matches the specified origin. If given,
    /// scriptExecutionContext overrides the 'true' setting on
    /// useContentScriptContext.
    String? scriptExecutionContext,
  }) : _wrapped = $js.EvalOptions(
          frameURL: frameUrl,
          useContentScriptContext: useContentScriptContext,
          scriptExecutionContext: scriptExecutionContext,
        );

  final $js.EvalOptions _wrapped;

  $js.EvalOptions get toJS => _wrapped;

  /// If specified, the expression is evaluated on the iframe whose URL matches
  /// the one specified. By default, the expression is evaluated in the top
  /// frame of the inspected page.
  String? get frameUrl => _wrapped.frameURL;
  set frameUrl(String? v) {
    _wrapped.frameURL = v;
  }

  /// Evaluate the expression in the context of the content script of the
  /// calling extension, provided that the content script is already injected
  /// into the inspected page. If not, the expression is not evaluated and the
  /// callback is invoked with the exception parameter set to an object that has
  /// the `isError` field set to true and the `code` field set to `E_NOTFOUND`.
  bool? get useContentScriptContext => _wrapped.useContentScriptContext;
  set useContentScriptContext(bool? v) {
    _wrapped.useContentScriptContext = v;
  }

  /// Evaluate the expression in the context of a content script of an extension
  /// that matches the specified origin. If given, scriptExecutionContext
  /// overrides the 'true' setting on useContentScriptContext.
  String? get scriptExecutionContext => _wrapped.scriptExecutionContext;
  set scriptExecutionContext(String? v) {
    _wrapped.scriptExecutionContext = v;
  }
}

class ReloadOptions {
  ReloadOptions.fromJS(this._wrapped);

  ReloadOptions({
    /// When true, the loader will bypass the cache for all inspected page
    /// resources loaded before the `load` event is fired. The effect is similar
    /// to pressing Ctrl+Shift+R in the inspected window or within the Developer
    /// Tools window.
    bool? ignoreCache,

    /// If specified, the string will override the value of the `User-Agent`
    /// HTTP header that's sent while loading the resources of the inspected
    /// page. The string will also override the value of the
    /// `navigator.userAgent` property that's returned to any scripts that are
    /// running within the inspected page.
    String? userAgent,

    /// If specified, the script will be injected into every frame of the
    /// inspected page immediately upon load, before any of the frame's scripts.
    /// The script will not be injected after subsequent reloads-for example, if
    /// the user presses Ctrl+R.
    String? injectedScript,
  }) : _wrapped = $js.ReloadOptions(
          ignoreCache: ignoreCache,
          userAgent: userAgent,
          injectedScript: injectedScript,
        );

  final $js.ReloadOptions _wrapped;

  $js.ReloadOptions get toJS => _wrapped;

  /// When true, the loader will bypass the cache for all inspected page
  /// resources loaded before the `load` event is fired. The effect is similar
  /// to pressing Ctrl+Shift+R in the inspected window or within the Developer
  /// Tools window.
  bool? get ignoreCache => _wrapped.ignoreCache;
  set ignoreCache(bool? v) {
    _wrapped.ignoreCache = v;
  }

  /// If specified, the string will override the value of the `User-Agent` HTTP
  /// header that's sent while loading the resources of the inspected page. The
  /// string will also override the value of the `navigator.userAgent` property
  /// that's returned to any scripts that are running within the inspected page.
  String? get userAgent => _wrapped.userAgent;
  set userAgent(String? v) {
    _wrapped.userAgent = v;
  }

  /// If specified, the script will be injected into every frame of the
  /// inspected page immediately upon load, before any of the frame's scripts.
  /// The script will not be injected after subsequent reloads-for example, if
  /// the user presses Ctrl+R.
  String? get injectedScript => _wrapped.injectedScript;
  set injectedScript(String? v) {
    _wrapped.injectedScript = v;
  }
}

class OnResourceContentCommittedEvent {
  OnResourceContentCommittedEvent({
    required this.resource,
    required this.content,
  });

  final Resource resource;

  /// New content of the resource.
  final String content;
}

class EvalResult {
  EvalResult({
    required this.result,
    required this.exceptionInfo,
  });

  /// The result of evaluation.
  final Map result;

  /// An object providing details if an exception occurred while evaluating the
  /// expression.
  final EvalExceptionInfo exceptionInfo;
}

class GetContentResult {
  GetContentResult({
    required this.content,
    required this.encoding,
  });

  /// Content of the resource (potentially encoded).
  final String content;

  /// Empty if the content is not encoded, encoding name otherwise. Currently,
  /// only base64 is supported.
  final String encoding;
}
