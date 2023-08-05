// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'runtime.dart';
import 'src/internal_helpers.dart';
import 'src/js/extension.dart' as $js;
import 'src/js/runtime.dart' as $js_runtime;

export 'src/chrome.dart' show chrome;

final _extension = ChromeExtension._();

extension ChromeExtensionExtension on Chrome {
  /// The `chrome.extension` API has utilities that can be used by any extension
  /// page. It includes support for exchanging messages between an extension and
  /// its content scripts or between extensions, as described in detail in
  /// [Message Passing](messaging).
  ChromeExtension get extension => _extension;
}

class ChromeExtension {
  ChromeExtension._();

  bool get isAvailable => $js.chrome.extensionNullable != null && alwaysTrue;

  /// Sends a single request to other listeners within the extension. Similar to
  /// [runtime.connect], but only sends a single request with an optional
  /// response. The [extension.onRequest] event is fired in each page of the
  /// extension.
  /// [extensionId] The extension ID of the extension you want to connect to.
  /// If omitted, default is your own extension.
  @Deprecated(r'Please use $(ref:runtime.sendMessage).')
  Future<Object> sendRequest(
    String? extensionId,
    Object request,
  ) async {
    var $res = await promiseToFuture<JSAny>($js.chrome.extension.sendRequest(
      extensionId,
      request.jsify()!,
    ));
    return $res.dartify()!;
  }

  /// Converts a relative path within an extension install directory to a
  /// fully-qualified URL.
  /// [path] A path to a resource within an extension expressed relative to
  /// its install directory.
  /// [returns] The fully-qualified URL to the resource.
  @Deprecated(r'Please use $(ref:runtime.getURL).')
  String getURL(String path) {
    return $js.chrome.extension.getURL(path);
  }

  /// Returns an array of the JavaScript 'window' objects for each of the pages
  /// running inside the current extension.
  /// [returns] Array of global objects
  List<JSObject> getViews(GetViewsFetchProperties? fetchProperties) {
    return $js.chrome.extension
        .getViews(fetchProperties?.toJS)
        .toDart
        .cast<JSObject>()
        .map((e) => e)
        .toList();
  }

  /// Returns the JavaScript 'window' object for the background page running
  /// inside the current extension. Returns null if the extension has no
  /// background page.
  JSObject? getBackgroundPage() {
    return $js.chrome.extension.getBackgroundPage();
  }

  /// Returns an array of the JavaScript 'window' objects for each of the tabs
  /// running inside the current extension. If `windowId` is specified, returns
  /// only the 'window' objects of tabs attached to the specified window.
  /// [returns] Array of global window objects
  @Deprecated(
      r'Please use $(ref:extension.getViews) <code>{type: "tab"}</code>.')
  List<JSObject> getExtensionTabs(int? windowId) {
    return $js.chrome.extension
        .getExtensionTabs(windowId)
        .toDart
        .cast<JSObject>()
        .map((e) => e)
        .toList();
  }

  /// Retrieves the state of the extension's access to Incognito-mode. This
  /// corresponds to the user-controlled per-extension 'Allowed in Incognito'
  /// setting accessible via the chrome://extensions page.
  Future<bool> isAllowedIncognitoAccess() async {
    var $res = await promiseToFuture<bool>(
        $js.chrome.extension.isAllowedIncognitoAccess());
    return $res;
  }

  /// Retrieves the state of the extension's access to the 'file://' scheme.
  /// This corresponds to the user-controlled per-extension 'Allow access to
  /// File URLs' setting accessible via the chrome://extensions page.
  Future<bool> isAllowedFileSchemeAccess() async {
    var $res = await promiseToFuture<bool>(
        $js.chrome.extension.isAllowedFileSchemeAccess());
    return $res;
  }

  /// Sets the value of the ap CGI parameter used in the extension's update URL.
  ///  This value is ignored for extensions that are hosted in the Chrome
  /// Extension Gallery.
  void setUpdateUrlData(String data) {
    $js.chrome.extension.setUpdateUrlData(data);
  }

  /// Set for the lifetime of a callback if an ansychronous extension api has
  /// resulted in an error. If no error has occured lastError will be
  /// [undefined].
  ExtensionLastError? get lastError =>
      $js.chrome.extension.lastError?.let(ExtensionLastError.fromJS);

  /// True for content scripts running inside incognito tabs, and for extension
  /// pages running inside an incognito process. The latter only applies to
  /// extensions with 'split' incognito_behavior.
  bool? get inIncognitoContext => $js.chrome.extension.inIncognitoContext;

  /// Fired when a request is sent from either an extension process or a content
  /// script.
  EventStream<OnRequestEvent> get onRequest =>
      $js.chrome.extension.onRequest.asStream(($c) => (
            JSAny? request,
            $js_runtime.MessageSender sender,
            Function sendResponse,
          ) {
            return $c(OnRequestEvent(
              request: request?.dartify(),
              sender: MessageSender.fromJS(sender),
              sendResponse: ([Object? p1, Object? p2]) {
                return (sendResponse as JSAny? Function(JSAny?, JSAny?))(
                        p1?.jsify(), p2?.jsify())
                    ?.dartify();
              },
            ));
          });

  /// Fired when a request is sent from another extension.
  EventStream<OnRequestExternalEvent> get onRequestExternal =>
      $js.chrome.extension.onRequestExternal.asStream(($c) => (
            JSAny? request,
            $js_runtime.MessageSender sender,
            Function sendResponse,
          ) {
            return $c(OnRequestExternalEvent(
              request: request?.dartify(),
              sender: MessageSender.fromJS(sender),
              sendResponse: ([Object? p1, Object? p2]) {
                return (sendResponse as JSAny? Function(JSAny?, JSAny?))(
                        p1?.jsify(), p2?.jsify())
                    ?.dartify();
              },
            ));
          });
}

/// The type of extension view.
enum ViewType {
  tab('tab'),
  popup('popup');

  const ViewType(this.value);

  final String value;

  String get toJS => value;
  static ViewType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class GetViewsFetchProperties {
  GetViewsFetchProperties.fromJS(this._wrapped);

  GetViewsFetchProperties({
    /// The type of view to get. If omitted, returns all views (including
    /// background pages and tabs).
    ViewType? type,

    /// The window to restrict the search to. If omitted, returns all views.
    int? windowId,

    /// Find a view according to a tab id. If this field is omitted, returns all
    /// views.
    int? tabId,
  }) : _wrapped = $js.GetViewsFetchProperties(
          type: type?.toJS,
          windowId: windowId,
          tabId: tabId,
        );

  final $js.GetViewsFetchProperties _wrapped;

  $js.GetViewsFetchProperties get toJS => _wrapped;

  /// The type of view to get. If omitted, returns all views (including
  /// background pages and tabs).
  ViewType? get type => _wrapped.type?.let(ViewType.fromJS);
  set type(ViewType? v) {
    _wrapped.type = v?.toJS;
  }

  /// The window to restrict the search to. If omitted, returns all views.
  int? get windowId => _wrapped.windowId;
  set windowId(int? v) {
    _wrapped.windowId = v;
  }

  /// Find a view according to a tab id. If this field is omitted, returns all
  /// views.
  int? get tabId => _wrapped.tabId;
  set tabId(int? v) {
    _wrapped.tabId = v;
  }
}

class ExtensionLastError {
  ExtensionLastError.fromJS(this._wrapped);

  ExtensionLastError(
      {
      /// Description of the error that has taken place.
      required String message})
      : _wrapped = $js.ExtensionLastError(message: message);

  final $js.ExtensionLastError _wrapped;

  $js.ExtensionLastError get toJS => _wrapped;

  /// Description of the error that has taken place.
  String get message => _wrapped.message;
  set message(String v) {
    _wrapped.message = v;
  }
}

class OnRequestEvent {
  OnRequestEvent({
    required this.request,
    required this.sender,
    required this.sendResponse,
  });

  /// The request sent by the calling script.
  final Object? request;

  final MessageSender sender;

  /// Function to call (at most once) when you have a response. The argument
  /// should be any JSON-ifiable object, or undefined if there is no response.
  /// If you have more than one `onRequest` listener in the same document, then
  /// only one may send a response.
  final Function sendResponse;
}

class OnRequestExternalEvent {
  OnRequestExternalEvent({
    required this.request,
    required this.sender,
    required this.sendResponse,
  });

  /// The request sent by the calling script.
  final Object? request;

  final MessageSender sender;

  /// Function to call when you have a response. The argument should be any
  /// JSON-ifiable object, or undefined if there is no response.
  final Function sendResponse;
}
