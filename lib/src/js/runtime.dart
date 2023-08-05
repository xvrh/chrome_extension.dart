// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'tabs.dart';

export 'chrome.dart';

extension JSChromeJSRuntimeExtension on JSChrome {
  @JS('runtime')
  external JSRuntime? get runtimeNullable;

  /// Use the `chrome.runtime` API to retrieve the background page, return
  /// details about the manifest, and listen for and respond to events in the
  /// app or extension lifecycle. You can also use this API to convert the
  /// relative path of URLs to fully-qualified URLs.
  JSRuntime get runtime {
    var runtimeNullable = this.runtimeNullable;
    if (runtimeNullable == null) {
      throw ApiNotAvailableException('chrome.runtime');
    }
    return runtimeNullable;
  }
}

@JS()
@staticInterop
class JSRuntime {}

extension JSRuntimeExtension on JSRuntime {
  /// Retrieves the JavaScript 'window' object for the background page running
  /// inside the current extension/app. If the background page is an event page,
  /// the system will ensure it is loaded before calling the callback. If there
  /// is no background page, an error is set.
  external JSPromise getBackgroundPage();

  /// Open your Extension's options page, if possible.
  ///
  /// The precise behavior may depend on your manifest's
  /// `[options_ui](optionsV2)` or `[options_page](options)` key, or what Chrome
  /// happens to support at the time. For example, the page may be opened in a
  /// new tab, within chrome://extensions, within an App, or it may just focus
  /// an open options page. It will never cause the caller page to reload.
  ///
  /// If your Extension does not declare an options page, or Chrome failed to
  /// create one for some other reason, the callback will set [lastError].
  external JSPromise openOptionsPage();

  /// Returns details about the app or extension from the manifest. The object
  /// returned is a serialization of the full [manifest file](manifest.html).
  external JSAny getManifest();

  /// Converts a relative path within an app/extension install directory to a
  /// fully-qualified URL.
  external String getURL(

      /// A path to a resource within an app/extension expressed relative to its
      /// install directory.
      String path);

  /// Sets the URL to be visited upon uninstallation. This may be used to clean
  /// up server-side data, do analytics, and implement surveys. Maximum 255
  /// characters.
  external JSPromise setUninstallURL(

      /// URL to be opened after the extension is uninstalled. This URL must have
      /// an http: or https: scheme. Set an empty string to not open a new tab
      /// upon uninstallation.
      String url);

  /// Reloads the app or extension. This method is not supported in kiosk mode.
  /// For kiosk mode, use chrome.runtime.restart() method.
  external void reload();

  /// Requests an immediate update check be done for this app/extension.
  /// **Important**: Most extensions/apps should **not** use this method, since
  /// Chrome already does automatic checks every few hours, and you can listen
  /// for the [runtime.onUpdateAvailable] event without needing to call
  /// requestUpdateCheck.
  ///
  /// This method is only appropriate to call in very limited circumstances,
  /// such as if your extension/app talks to a backend service, and the backend
  /// service has determined that the client extension/app version is very far
  /// out of date and you'd like to prompt a user to update. Most other uses of
  /// requestUpdateCheck, such as calling it unconditionally based on a
  /// repeating timer, probably only serve to waste client, network, and server
  /// resources.
  ///
  /// Note: When called with a callback, instead of returning an object this
  /// function will return the two properties as separate arguments passed to
  /// the callback.
  external JSPromise requestUpdateCheck();

  /// Restart the ChromeOS device when the app runs in kiosk mode. Otherwise,
  /// it's no-op.
  external void restart();

  /// Restart the ChromeOS device when the app runs in kiosk mode after the
  /// given seconds. If called again before the time ends, the reboot will be
  /// delayed. If called with a value of -1, the reboot will be cancelled. It's
  /// a no-op in non-kiosk mode. It's only allowed to be called repeatedly by
  /// the first extension to invoke this API.
  external JSPromise restartAfterDelay(

      /// Time to wait in seconds before rebooting the device, or -1 to cancel a
      /// scheduled reboot.
      int seconds);

  /// Attempts to connect listeners within an extension/app (such as the
  /// background page), or other extensions/apps. This is useful for content
  /// scripts connecting to their extension processes, inter-app/extension
  /// communication, and [web messaging](manifest/externally_connectable.html).
  /// Note that this does not connect to any listeners in a content script.
  /// Extensions may connect to content scripts embedded in tabs via
  /// [tabs.connect].
  external Port connect(
    /// The ID of the extension or app to connect to. If omitted, a connection
    /// will be attempted with your own extension. Required if sending messages
    /// from a web page for [web
    /// messaging](manifest/externally_connectable.html).
    String? extensionId,
    ConnectInfo? connectInfo,
  );

  /// Connects to a native application in the host machine. See [Native
  /// Messaging](nativeMessaging) for more information.
  external Port connectNative(

      /// The name of the registered application to connect to.
      String application);

  /// Sends a single message to event listeners within your extension/app or a
  /// different extension/app. Similar to [runtime.connect] but only sends a
  /// single message, with an optional response. If sending to your extension,
  /// the [runtime.onMessage] event will be fired in every frame of your
  /// extension (except for the sender's frame), or [runtime.onMessageExternal],
  /// if a different extension. Note that extensions cannot send messages to
  /// content scripts using this method. To send messages to content scripts,
  /// use [tabs.sendMessage].
  external JSPromise sendMessage(
    /// The ID of the extension/app to send the message to. If omitted, the
    /// message will be sent to your own extension/app. Required if sending
    /// messages from a web page for [web
    /// messaging](manifest/externally_connectable.html).
    String? extensionId,

    /// The message to send. This message should be a JSON-ifiable object.
    JSAny message,
    SendMessageOptions? options,
  );

  /// Send a single message to a native application.
  external JSPromise sendNativeMessage(
    /// The name of the native messaging host.
    String application,

    /// The message that will be passed to the native messaging host.
    JSAny message,
  );

  /// Returns information about the current platform.
  external JSPromise getPlatformInfo();

  /// Returns a DirectoryEntry for the package directory.
  external void getPackageDirectoryEntry(JSFunction callback);

  /// Fetches information about active contexts associated with this extension
  external JSPromise getContexts(

      /// A filter to find matching contexts. A context matches if it matches all
      /// specified fields in the filter. Any unspecified field in the filter
      /// matches all contexts.
      ContextFilter filter);

  /// Fired when a profile that has this extension installed first starts up.
  /// This event is not fired when an incognito profile is started, even if this
  /// extension is operating in 'split' incognito mode.
  external Event get onStartup;

  /// Fired when the extension is first installed, when the extension is updated
  /// to a new version, and when Chrome is updated to a new version.
  external Event get onInstalled;

  /// Sent to the event page just before it is unloaded. This gives the
  /// extension opportunity to do some clean up. Note that since the page is
  /// unloading, any asynchronous operations started while handling this event
  /// are not guaranteed to complete. If more activity for the event page occurs
  /// before it gets unloaded the onSuspendCanceled event will be sent and the
  /// page won't be unloaded.
  external Event get onSuspend;

  /// Sent after onSuspend to indicate that the app won't be unloaded after all.
  external Event get onSuspendCanceled;

  /// Fired when an update is available, but isn't installed immediately because
  /// the app is currently running. If you do nothing, the update will be
  /// installed the next time the background page gets unloaded, if you want it
  /// to be installed sooner you can explicitly call chrome.runtime.reload(). If
  /// your extension is using a persistent background page, the background page
  /// of course never gets unloaded, so unless you call chrome.runtime.reload()
  /// manually in response to this event the update will not get installed until
  /// the next time Chrome itself restarts. If no handlers are listening for
  /// this event, and your extension has a persistent background page, it
  /// behaves as if chrome.runtime.reload() is called in response to this event.
  external Event get onUpdateAvailable;

  /// Fired when a Chrome update is available, but isn't installed immediately
  /// because a browser restart is required.
  external Event get onBrowserUpdateAvailable;

  /// Fired when a connection is made from either an extension process or a
  /// content script (by [runtime.connect]).
  external Event get onConnect;

  /// Fired when a connection is made from another extension (by
  /// [runtime.connect]).
  external Event get onConnectExternal;

  /// Fired when a connection is made from a native application. Currently only
  /// supported on Chrome OS.
  external Event get onConnectNative;

  /// Fired when a message is sent from either an extension process (by
  /// [runtime.sendMessage]) or a content script (by [tabs.sendMessage]).
  external Event get onMessage;

  /// Fired when a message is sent from another extension/app (by
  /// [runtime.sendMessage]). Cannot be used in a content script.
  external Event get onMessageExternal;

  /// Fired when an app or the device that it runs on needs to be restarted. The
  /// app should close all its windows at its earliest convenient time to let
  /// the restart to happen. If the app does nothing, a restart will be enforced
  /// after a 24-hour grace period has passed. Currently, this event is only
  /// fired for Chrome OS kiosk apps.
  external Event get onRestartRequired;

  /// This will be defined during an API method callback if there was an error
  external RuntimeLastError? get lastError;

  /// The ID of the extension/app.
  external String get id;
}

/// The operating system Chrome is running on.
typedef PlatformOs = String;

/// The machine's processor architecture.
typedef PlatformArch = String;

/// The native client architecture. This may be different from arch on some
/// platforms.
typedef PlatformNaclArch = String;

/// Result of the update check.
typedef RequestUpdateCheckStatus = String;

/// The reason that this event is being dispatched.
typedef OnInstalledReason = String;

/// The reason that the event is being dispatched. 'app_update' is used when the
/// restart is needed because the application is updated to a newer version.
/// 'os_update' is used when the restart is needed because the browser/OS is
/// updated to a newer version. 'periodic' is used when the system runs for more
/// than the permitted uptime set in the enterprise policy.
typedef OnRestartRequiredReason = String;

typedef ContextType = String;

@JS()
@staticInterop
@anonymous
class Port {
  external factory Port({
    /// The name of the port, as specified in the call to [runtime.connect].
    String name,

    /// Immediately disconnect the port. Calling `disconnect()` on an
    /// already-disconnected port has no effect. When a port is disconnected, no
    /// new events will be dispatched to this port.
    Function disconnect,

    /// Send a message to the other end of the port. If the port is disconnected,
    /// an error is thrown.
    Function postMessage,

    /// This property will **only** be present on ports passed to
    /// $(ref:runtime.onConnect onConnect) / $(ref:runtime.onConnectExternal
    /// onConnectExternal) / $(ref:runtime.onConnectExternal onConnectNative)
    /// listeners.
    MessageSender? sender,
  });
}

extension PortExtension on Port {
  /// The name of the port, as specified in the call to [runtime.connect].
  external String name;

  /// Immediately disconnect the port. Calling `disconnect()` on an
  /// already-disconnected port has no effect. When a port is disconnected, no
  /// new events will be dispatched to this port.
  external Function disconnect;

  /// Send a message to the other end of the port. If the port is disconnected,
  /// an error is thrown.
  external Function postMessage;

  /// This property will **only** be present on ports passed to
  /// $(ref:runtime.onConnect onConnect) / $(ref:runtime.onConnectExternal
  /// onConnectExternal) / $(ref:runtime.onConnectExternal onConnectNative)
  /// listeners.
  external MessageSender? sender;

  /// Fired when the port is disconnected from the other end(s).
  /// [runtime.lastError] may be set if the port was disconnected by an error.
  /// If the port is closed via $(ref:Port.disconnect disconnect), then this
  /// event is _only_ fired on the other end. This event is fired at most once
  /// (see also [Port lifetime](messaging#port-lifetime)).
  external Event get onDisconnect;

  /// This event is fired when $(ref:Port.postMessage postMessage) is called by
  /// the other end of the port.
  external Event get onMessage;
}

@JS()
@staticInterop
@anonymous
class MessageSender {
  external factory MessageSender({
    /// The [tabs.Tab] which opened the connection, if any. This property will
    /// *only* be present when the connection was opened from a tab (including
    /// content scripts), and *only* if the receiver is an extension, not an app.
    Tab? tab,

    /// The [frame](webNavigation#frame_ids) that opened the connection. 0 for
    /// top-level frames, positive for child frames. This will only be set when
    /// `tab` is set.
    int? frameId,

    /// The guest process id of the requesting webview, if available. Only
    /// available for component extensions.
    int? guestProcessId,

    /// The guest render frame routing id of the requesting webview, if available.
    /// Only available for component extensions.
    int? guestRenderFrameRoutingId,

    /// The ID of the extension or app that opened the connection, if any.
    String? id,

    /// The URL of the page or frame that opened the connection. If the sender is
    /// in an iframe, it will be iframe's URL not the URL of the page which hosts
    /// it.
    String? url,

    /// The name of the native application that opened the connection, if any.
    String? nativeApplication,

    /// The TLS channel ID of the page or frame that opened the connection, if
    /// requested by the extension or app, and if available.
    String? tlsChannelId,

    /// The origin of the page or frame that opened the connection. It can vary
    /// from the url property (e.g., about:blank) or can be opaque (e.g.,
    /// sandboxed iframes). This is useful for identifying if the origin can be
    /// trusted if we can't immediately tell from the URL.
    String? origin,

    /// A UUID of the document that opened the connection.
    String? documentId,

    /// The lifecycle the document that opened the connection is in at the time
    /// the port was created. Note that the lifecycle state of the document may
    /// have changed since port creation.
    String? documentLifecycle,
  });
}

extension MessageSenderExtension on MessageSender {
  /// The [tabs.Tab] which opened the connection, if any. This property will
  /// *only* be present when the connection was opened from a tab (including
  /// content scripts), and *only* if the receiver is an extension, not an app.
  external Tab? tab;

  /// The [frame](webNavigation#frame_ids) that opened the connection. 0 for
  /// top-level frames, positive for child frames. This will only be set when
  /// `tab` is set.
  external int? frameId;

  /// The guest process id of the requesting webview, if available. Only
  /// available for component extensions.
  external int? guestProcessId;

  /// The guest render frame routing id of the requesting webview, if available.
  /// Only available for component extensions.
  external int? guestRenderFrameRoutingId;

  /// The ID of the extension or app that opened the connection, if any.
  external String? id;

  /// The URL of the page or frame that opened the connection. If the sender is
  /// in an iframe, it will be iframe's URL not the URL of the page which hosts
  /// it.
  external String? url;

  /// The name of the native application that opened the connection, if any.
  external String? nativeApplication;

  /// The TLS channel ID of the page or frame that opened the connection, if
  /// requested by the extension or app, and if available.
  external String? tlsChannelId;

  /// The origin of the page or frame that opened the connection. It can vary
  /// from the url property (e.g., about:blank) or can be opaque (e.g.,
  /// sandboxed iframes). This is useful for identifying if the origin can be
  /// trusted if we can't immediately tell from the URL.
  external String? origin;

  /// A UUID of the document that opened the connection.
  external String? documentId;

  /// The lifecycle the document that opened the connection is in at the time
  /// the port was created. Note that the lifecycle state of the document may
  /// have changed since port creation.
  external String? documentLifecycle;
}

@JS()
@staticInterop
@anonymous
class PlatformInfo {
  external factory PlatformInfo({
    /// The operating system Chrome is running on.
    PlatformOs os,

    /// The machine's processor architecture.
    PlatformArch arch,

    /// The native client architecture. This may be different from arch on some
    /// platforms.
    PlatformNaclArch nacl_arch,
  });
}

extension PlatformInfoExtension on PlatformInfo {
  /// The operating system Chrome is running on.
  external PlatformOs os;

  /// The machine's processor architecture.
  external PlatformArch arch;

  /// The native client architecture. This may be different from arch on some
  /// platforms.
  external PlatformNaclArch nacl_arch;
}

@JS()
@staticInterop
@anonymous
class ExtensionContext {
  external factory ExtensionContext({
    /// The type of context this corresponds to.
    ContextType contextType,

    /// A unique identifier for this context
    String contextId,

    /// The ID of the tab for this context, or -1 if this context is not hosted in
    /// a tab.
    int tabId,

    /// The ID of the window for this context, or -1 if this context is not hosted
    /// in a window.
    int windowId,

    /// A UUID for the document associated with this context, or undefined if this
    /// context is hosted not in a document.
    String? documentId,

    /// The ID of the frame for this context, or -1 if this context is not hosted
    /// in a frame.
    int frameId,

    /// The URL of the document associated with this context, or undefined if the
    /// context is not hosted in a document.
    String? documentUrl,

    /// The origin of the document associated with this context, or undefined if
    /// the context is not hosted in a document.
    String? documentOrigin,

    /// Whether the context is associated with an incognito profile.
    bool incognito,
  });
}

extension ExtensionContextExtension on ExtensionContext {
  /// The type of context this corresponds to.
  external ContextType contextType;

  /// A unique identifier for this context
  external String contextId;

  /// The ID of the tab for this context, or -1 if this context is not hosted in
  /// a tab.
  external int tabId;

  /// The ID of the window for this context, or -1 if this context is not hosted
  /// in a window.
  external int windowId;

  /// A UUID for the document associated with this context, or undefined if this
  /// context is hosted not in a document.
  external String? documentId;

  /// The ID of the frame for this context, or -1 if this context is not hosted
  /// in a frame.
  external int frameId;

  /// The URL of the document associated with this context, or undefined if the
  /// context is not hosted in a document.
  external String? documentUrl;

  /// The origin of the document associated with this context, or undefined if
  /// the context is not hosted in a document.
  external String? documentOrigin;

  /// Whether the context is associated with an incognito profile.
  external bool incognito;
}

@JS()
@staticInterop
@anonymous
class ContextFilter {
  external factory ContextFilter({
    JSArray? contextTypes,
    JSArray? contextIds,
    JSArray? tabIds,
    JSArray? windowIds,
    JSArray? documentIds,
    JSArray? frameIds,
    JSArray? documentUrls,
    JSArray? documentOrigins,
    bool? incognito,
  });
}

extension ContextFilterExtension on ContextFilter {
  external JSArray? contextTypes;

  external JSArray? contextIds;

  external JSArray? tabIds;

  external JSArray? windowIds;

  external JSArray? documentIds;

  external JSArray? frameIds;

  external JSArray? documentUrls;

  external JSArray? documentOrigins;

  external bool? incognito;
}

@JS()
@staticInterop
@anonymous
class OnInstalledDetails {
  external factory OnInstalledDetails({
    /// The reason that this event is being dispatched.
    OnInstalledReason reason,

    /// Indicates the previous version of the extension, which has just been
    /// updated. This is present only if 'reason' is 'update'.
    String? previousVersion,

    /// Indicates the ID of the imported shared module extension which updated.
    /// This is present only if 'reason' is 'shared_module_update'.
    String? id,
  });
}

extension OnInstalledDetailsExtension on OnInstalledDetails {
  /// The reason that this event is being dispatched.
  external OnInstalledReason reason;

  /// Indicates the previous version of the extension, which has just been
  /// updated. This is present only if 'reason' is 'update'.
  external String? previousVersion;

  /// Indicates the ID of the imported shared module extension which updated.
  /// This is present only if 'reason' is 'shared_module_update'.
  external String? id;
}

@JS()
@staticInterop
@anonymous
class OnUpdateAvailableDetails {
  external factory OnUpdateAvailableDetails(
      {
      /// The version number of the available update.
      String version});
}

extension OnUpdateAvailableDetailsExtension on OnUpdateAvailableDetails {
  /// The version number of the available update.
  external String version;
}

@JS()
@staticInterop
@anonymous
class RequestUpdateCheckCallbackResult {
  external factory RequestUpdateCheckCallbackResult({
    /// Result of the update check.
    RequestUpdateCheckStatus status,

    /// If an update is available, this contains the version of the available
    /// update.
    String? version,
  });
}

extension RequestUpdateCheckCallbackResultExtension
    on RequestUpdateCheckCallbackResult {
  /// Result of the update check.
  external RequestUpdateCheckStatus status;

  /// If an update is available, this contains the version of the available
  /// update.
  external String? version;
}

@JS()
@staticInterop
@anonymous
class ConnectInfo {
  external factory ConnectInfo({
    /// Will be passed into onConnect for processes that are listening for the
    /// connection event.
    String? name,

    /// Whether the TLS channel ID will be passed into onConnectExternal for
    /// processes that are listening for the connection event.
    bool? includeTlsChannelId,
  });
}

extension ConnectInfoExtension on ConnectInfo {
  /// Will be passed into onConnect for processes that are listening for the
  /// connection event.
  external String? name;

  /// Whether the TLS channel ID will be passed into onConnectExternal for
  /// processes that are listening for the connection event.
  external bool? includeTlsChannelId;
}

@JS()
@staticInterop
@anonymous
class SendMessageOptions {
  external factory SendMessageOptions(
      {
      /// Whether the TLS channel ID will be passed into onMessageExternal for
      /// processes that are listening for the connection event.
      bool? includeTlsChannelId});
}

extension SendMessageOptionsExtension on SendMessageOptions {
  /// Whether the TLS channel ID will be passed into onMessageExternal for
  /// processes that are listening for the connection event.
  external bool? includeTlsChannelId;
}

@JS()
@staticInterop
@anonymous
class RuntimeLastError {
  external factory RuntimeLastError(
      {
      /// Details about the error which occurred.
      String? message});
}

extension RuntimeLastErrorExtension on RuntimeLastError {
  /// Details about the error which occurred.
  external String? message;
}
