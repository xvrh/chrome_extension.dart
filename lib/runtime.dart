// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/runtime.dart' as $js;
import 'tabs.dart';

export 'src/chrome.dart' show chrome;

final _runtime = ChromeRuntime._();

extension ChromeRuntimeExtension on Chrome {
  /// Use the `chrome.runtime` API to retrieve the background page, return
  /// details about the manifest, and listen for and respond to events in the
  /// app or extension lifecycle. You can also use this API to convert the
  /// relative path of URLs to fully-qualified URLs.
  ChromeRuntime get runtime => _runtime;
}

class ChromeRuntime {
  ChromeRuntime._();

  bool get isAvailable => $js.chrome.runtimeNullable != null && alwaysTrue;

  /// Retrieves the JavaScript 'window' object for the background page running
  /// inside the current extension/app. If the background page is an event page,
  /// the system will ensure it is loaded before calling the callback. If there
  /// is no background page, an error is set.
  Future<JSObject?> getBackgroundPage() async {
    var $res = await promiseToFuture<JSObject?>(
        $js.chrome.runtime.getBackgroundPage());
    return $res;
  }

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
  Future<void> openOptionsPage() async {
    await promiseToFuture<void>($js.chrome.runtime.openOptionsPage());
  }

  /// Returns details about the app or extension from the manifest. The object
  /// returned is a serialization of the full [manifest file](manifest.html).
  /// [returns] The manifest details.
  Map getManifest() {
    return $js.chrome.runtime.getManifest().toDartMap();
  }

  /// Converts a relative path within an app/extension install directory to a
  /// fully-qualified URL.
  /// [path] A path to a resource within an app/extension expressed relative
  /// to its install directory.
  /// [returns] The fully-qualified URL to the resource.
  String getURL(String path) {
    return $js.chrome.runtime.getURL(path);
  }

  /// Sets the URL to be visited upon uninstallation. This may be used to clean
  /// up server-side data, do analytics, and implement surveys. Maximum 255
  /// characters.
  /// [url] URL to be opened after the extension is uninstalled. This URL must
  /// have an http: or https: scheme. Set an empty string to not open a new
  /// tab upon uninstallation.
  /// [returns] Called when the uninstall URL is set. If the given URL is
  /// invalid, [runtime.lastError] will be set.
  Future<void> setUninstallURL(String url) async {
    await promiseToFuture<void>($js.chrome.runtime.setUninstallURL(url));
  }

  /// Reloads the app or extension. This method is not supported in kiosk mode.
  /// For kiosk mode, use chrome.runtime.restart() method.
  void reload() {
    $js.chrome.runtime.reload();
  }

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
  Future<RequestUpdateCheckCallbackResult> requestUpdateCheck() async {
    var $res = await promiseToFuture<$js.RequestUpdateCheckCallbackResult>(
        $js.chrome.runtime.requestUpdateCheck());
    return RequestUpdateCheckCallbackResult.fromJS($res);
  }

  /// Restart the ChromeOS device when the app runs in kiosk mode. Otherwise,
  /// it's no-op.
  void restart() {
    $js.chrome.runtime.restart();
  }

  /// Restart the ChromeOS device when the app runs in kiosk mode after the
  /// given seconds. If called again before the time ends, the reboot will be
  /// delayed. If called with a value of -1, the reboot will be cancelled. It's
  /// a no-op in non-kiosk mode. It's only allowed to be called repeatedly by
  /// the first extension to invoke this API.
  /// [seconds] Time to wait in seconds before rebooting the device, or -1 to
  /// cancel a scheduled reboot.
  /// [returns] A callback to be invoked when a restart request was
  /// successfully rescheduled.
  Future<void> restartAfterDelay(int seconds) async {
    await promiseToFuture<void>($js.chrome.runtime.restartAfterDelay(seconds));
  }

  /// Attempts to connect listeners within an extension/app (such as the
  /// background page), or other extensions/apps. This is useful for content
  /// scripts connecting to their extension processes, inter-app/extension
  /// communication, and [web messaging](manifest/externally_connectable.html).
  /// Note that this does not connect to any listeners in a content script.
  /// Extensions may connect to content scripts embedded in tabs via
  /// [tabs.connect].
  /// [extensionId] The ID of the extension or app to connect to. If omitted,
  /// a connection will be attempted with your own extension. Required if
  /// sending messages from a web page for [web
  /// messaging](manifest/externally_connectable.html).
  /// [returns] Port through which messages can be sent and received. The
  /// port's $(ref:Port onDisconnect) event is fired if the extension/app does
  /// not exist.
  Port connect(
    String? extensionId,
    ConnectInfo? connectInfo,
  ) {
    return Port.fromJS($js.chrome.runtime.connect(
      extensionId,
      connectInfo?.toJS,
    ));
  }

  /// Connects to a native application in the host machine. See [Native
  /// Messaging](nativeMessaging) for more information.
  /// [application] The name of the registered application to connect to.
  /// [returns] Port through which messages can be sent and received with the
  /// application
  Port connectNative(String application) {
    return Port.fromJS($js.chrome.runtime.connectNative(application));
  }

  /// Sends a single message to event listeners within your extension/app or a
  /// different extension/app. Similar to [runtime.connect] but only sends a
  /// single message, with an optional response. If sending to your extension,
  /// the [runtime.onMessage] event will be fired in every frame of your
  /// extension (except for the sender's frame), or [runtime.onMessageExternal],
  /// if a different extension. Note that extensions cannot send messages to
  /// content scripts using this method. To send messages to content scripts,
  /// use [tabs.sendMessage].
  /// [extensionId] The ID of the extension/app to send the message to. If
  /// omitted, the message will be sent to your own extension/app. Required if
  /// sending messages from a web page for [web
  /// messaging](manifest/externally_connectable.html).
  /// [message] The message to send. This message should be a JSON-ifiable
  /// object.
  Future<Object> sendMessage(
    String? extensionId,
    Object message,
    SendMessageOptions? options,
  ) async {
    var $res = await promiseToFuture<JSAny>($js.chrome.runtime.sendMessage(
      extensionId,
      message.jsify()!,
      options?.toJS,
    ));
    return $res.dartify()!;
  }

  /// Send a single message to a native application.
  /// [application] The name of the native messaging host.
  /// [message] The message that will be passed to the native messaging host.
  Future<Map> sendNativeMessage(
    String application,
    Map message,
  ) async {
    var $res =
        await promiseToFuture<JSAny>($js.chrome.runtime.sendNativeMessage(
      application,
      message.jsify()!,
    ));
    return $res.toDartMap();
  }

  /// Returns information about the current platform.
  /// [returns] Called with results
  Future<PlatformInfo> getPlatformInfo() async {
    var $res = await promiseToFuture<$js.PlatformInfo>(
        $js.chrome.runtime.getPlatformInfo());
    return PlatformInfo.fromJS($res);
  }

  /// Returns a DirectoryEntry for the package directory.
  Future<JSObject> getPackageDirectoryEntry() {
    var $completer = Completer<JSObject>();
    $js.chrome.runtime.getPackageDirectoryEntry((JSObject directoryEntry) {
      if (checkRuntimeLastError($completer)) {
        $completer.complete(directoryEntry);
      }
    }.toJS);
    return $completer.future;
  }

  /// Fetches information about active contexts associated with this extension
  /// [filter] A filter to find matching contexts. A context matches if it
  /// matches all specified fields in the filter. Any unspecified field in the
  /// filter matches all contexts.
  /// [returns] Invoked with the matching contexts, if any.
  Future<List<ExtensionContext>> getContexts(ContextFilter filter) async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.runtime.getContexts(filter.toJS));
    return $res.toDart
        .cast<$js.ExtensionContext>()
        .map((e) => ExtensionContext.fromJS(e))
        .toList();
  }

  /// This will be defined during an API method callback if there was an error
  RuntimeLastError? get lastError =>
      $js.chrome.runtime.lastError?.let(RuntimeLastError.fromJS);

  /// The ID of the extension/app.
  String get id => $js.chrome.runtime.id;

  /// Fired when a profile that has this extension installed first starts up.
  /// This event is not fired when an incognito profile is started, even if this
  /// extension is operating in 'split' incognito mode.
  EventStream<void> get onStartup =>
      $js.chrome.runtime.onStartup.asStream(($c) => () {
            return $c(null);
          });

  /// Fired when the extension is first installed, when the extension is updated
  /// to a new version, and when Chrome is updated to a new version.
  EventStream<OnInstalledDetails> get onInstalled =>
      $js.chrome.runtime.onInstalled
          .asStream(($c) => ($js.OnInstalledDetails details) {
                return $c(OnInstalledDetails.fromJS(details));
              });

  /// Sent to the event page just before it is unloaded. This gives the
  /// extension opportunity to do some clean up. Note that since the page is
  /// unloading, any asynchronous operations started while handling this event
  /// are not guaranteed to complete. If more activity for the event page occurs
  /// before it gets unloaded the onSuspendCanceled event will be sent and the
  /// page won't be unloaded.
  EventStream<void> get onSuspend =>
      $js.chrome.runtime.onSuspend.asStream(($c) => () {
            return $c(null);
          });

  /// Sent after onSuspend to indicate that the app won't be unloaded after all.
  EventStream<void> get onSuspendCanceled =>
      $js.chrome.runtime.onSuspendCanceled.asStream(($c) => () {
            return $c(null);
          });

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
  EventStream<OnUpdateAvailableDetails> get onUpdateAvailable =>
      $js.chrome.runtime.onUpdateAvailable
          .asStream(($c) => ($js.OnUpdateAvailableDetails details) {
                return $c(OnUpdateAvailableDetails.fromJS(details));
              });

  /// Fired when a Chrome update is available, but isn't installed immediately
  /// because a browser restart is required.
  EventStream<void> get onBrowserUpdateAvailable =>
      $js.chrome.runtime.onBrowserUpdateAvailable.asStream(($c) => () {
            return $c(null);
          });

  /// Fired when a connection is made from either an extension process or a
  /// content script (by [runtime.connect]).
  EventStream<Port> get onConnect =>
      $js.chrome.runtime.onConnect.asStream(($c) => ($js.Port port) {
            return $c(Port.fromJS(port));
          });

  /// Fired when a connection is made from another extension (by
  /// [runtime.connect]).
  EventStream<Port> get onConnectExternal =>
      $js.chrome.runtime.onConnectExternal.asStream(($c) => ($js.Port port) {
            return $c(Port.fromJS(port));
          });

  /// Fired when a connection is made from a native application. Currently only
  /// supported on Chrome OS.
  EventStream<Port> get onConnectNative =>
      $js.chrome.runtime.onConnectNative.asStream(($c) => ($js.Port port) {
            return $c(Port.fromJS(port));
          });

  /// Fired when a message is sent from either an extension process (by
  /// [runtime.sendMessage]) or a content script (by [tabs.sendMessage]).
  EventStream<OnMessageEvent> get onMessage =>
      $js.chrome.runtime.onMessage.asStream(($c) => (
            JSAny? message,
            $js.MessageSender sender,
            Function sendResponse,
          ) {
            return $c(OnMessageEvent(
              message: message?.dartify(),
              sender: MessageSender.fromJS(sender),
              sendResponse: ([Object? p1, Object? p2]) {
                return (sendResponse as JSAny? Function(JSAny?, JSAny?))(
                        p1?.jsify(), p2?.jsify())
                    ?.dartify();
              },
            ));
          });

  /// Fired when a message is sent from another extension/app (by
  /// [runtime.sendMessage]). Cannot be used in a content script.
  EventStream<OnMessageExternalEvent> get onMessageExternal =>
      $js.chrome.runtime.onMessageExternal.asStream(($c) => (
            JSAny? message,
            $js.MessageSender sender,
            Function sendResponse,
          ) {
            return $c(OnMessageExternalEvent(
              message: message?.dartify(),
              sender: MessageSender.fromJS(sender),
              sendResponse: ([Object? p1, Object? p2]) {
                return (sendResponse as JSAny? Function(JSAny?, JSAny?))(
                        p1?.jsify(), p2?.jsify())
                    ?.dartify();
              },
            ));
          });

  /// Fired when an app or the device that it runs on needs to be restarted. The
  /// app should close all its windows at its earliest convenient time to let
  /// the restart to happen. If the app does nothing, a restart will be enforced
  /// after a 24-hour grace period has passed. Currently, this event is only
  /// fired for Chrome OS kiosk apps.
  EventStream<OnRestartRequiredReason> get onRestartRequired =>
      $js.chrome.runtime.onRestartRequired
          .asStream(($c) => ($js.OnRestartRequiredReason reason) {
                return $c(OnRestartRequiredReason.fromJS(reason));
              });
}

/// The operating system Chrome is running on.
enum PlatformOs {
  mac('mac'),
  win('win'),
  android('android'),
  cros('cros'),
  linux('linux'),
  openbsd('openbsd'),
  fuchsia('fuchsia');

  const PlatformOs(this.value);

  final String value;

  String get toJS => value;
  static PlatformOs fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The machine's processor architecture.
enum PlatformArch {
  arm('arm'),
  arm64('arm64'),
  x8632('x86-32'),
  x8664('x86-64'),
  mips('mips'),
  mips64('mips64');

  const PlatformArch(this.value);

  final String value;

  String get toJS => value;
  static PlatformArch fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The native client architecture. This may be different from arch on some
/// platforms.
enum PlatformNaclArch {
  arm('arm'),
  x8632('x86-32'),
  x8664('x86-64'),
  mips('mips'),
  mips64('mips64');

  const PlatformNaclArch(this.value);

  final String value;

  String get toJS => value;
  static PlatformNaclArch fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Result of the update check.
enum RequestUpdateCheckStatus {
  throttled('throttled'),
  noUpdate('no_update'),
  updateAvailable('update_available');

  const RequestUpdateCheckStatus(this.value);

  final String value;

  String get toJS => value;
  static RequestUpdateCheckStatus fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The reason that this event is being dispatched.
enum OnInstalledReason {
  install('install'),
  update('update'),
  chromeUpdate('chrome_update'),
  sharedModuleUpdate('shared_module_update');

  const OnInstalledReason(this.value);

  final String value;

  String get toJS => value;
  static OnInstalledReason fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The reason that the event is being dispatched. 'app_update' is used when the
/// restart is needed because the application is updated to a newer version.
/// 'os_update' is used when the restart is needed because the browser/OS is
/// updated to a newer version. 'periodic' is used when the system runs for more
/// than the permitted uptime set in the enterprise policy.
enum OnRestartRequiredReason {
  appUpdate('app_update'),
  osUpdate('os_update'),
  periodic('periodic');

  const OnRestartRequiredReason(this.value);

  final String value;

  String get toJS => value;
  static OnRestartRequiredReason fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum ContextType {
  tab('TAB'),
  popup('POPUP'),
  background('BACKGROUND'),
  offscreenDocument('OFFSCREEN_DOCUMENT');

  const ContextType(this.value);

  final String value;

  String get toJS => value;
  static ContextType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class Port {
  Port.fromJS(this._wrapped);

  Port({
    /// The name of the port, as specified in the call to [runtime.connect].
    required String name,

    /// Immediately disconnect the port. Calling `disconnect()` on an
    /// already-disconnected port has no effect. When a port is disconnected, no
    /// new events will be dispatched to this port.
    required Function disconnect,

    /// Send a message to the other end of the port. If the port is
    /// disconnected, an error is thrown.
    required Function postMessage,

    /// This property will **only** be present on ports passed to
    /// $(ref:runtime.onConnect onConnect) / $(ref:runtime.onConnectExternal
    /// onConnectExternal) / $(ref:runtime.onConnectExternal onConnectNative)
    /// listeners.
    MessageSender? sender,
  }) : _wrapped = $js.Port(
          name: name,
          disconnect: allowInterop(disconnect),
          postMessage: allowInterop(postMessage),
          sender: sender?.toJS,
        );

  final $js.Port _wrapped;

  $js.Port get toJS => _wrapped;

  /// The name of the port, as specified in the call to [runtime.connect].
  String get name => _wrapped.name;
  set name(String v) {
    _wrapped.name = v;
  }

  /// Immediately disconnect the port. Calling `disconnect()` on an
  /// already-disconnected port has no effect. When a port is disconnected, no
  /// new events will be dispatched to this port.
  Function get disconnect => ([Object? p1, Object? p2]) {
        return (_wrapped.disconnect as JSAny? Function(JSAny?, JSAny?))(
                p1?.jsify(), p2?.jsify())
            ?.dartify();
      };
  set disconnect(Function v) {
    _wrapped.disconnect = allowInterop(v);
  }

  /// Send a message to the other end of the port. If the port is disconnected,
  /// an error is thrown.
  Function get postMessage => ([Object? p1, Object? p2]) {
        return (_wrapped.postMessage as JSAny? Function(JSAny?, JSAny?))(
                p1?.jsify(), p2?.jsify())
            ?.dartify();
      };
  set postMessage(Function v) {
    _wrapped.postMessage = allowInterop(v);
  }

  /// This property will **only** be present on ports passed to
  /// $(ref:runtime.onConnect onConnect) / $(ref:runtime.onConnectExternal
  /// onConnectExternal) / $(ref:runtime.onConnectExternal onConnectNative)
  /// listeners.
  MessageSender? get sender => _wrapped.sender?.let(MessageSender.fromJS);
  set sender(MessageSender? v) {
    _wrapped.sender = v?.toJS;
  }

  /// Fired when the port is disconnected from the other end(s).
  /// [runtime.lastError] may be set if the port was disconnected by an error.
  /// If the port is closed via $(ref:Port.disconnect disconnect), then this
  /// event is _only_ fired on the other end. This event is fired at most once
  /// (see also [Port lifetime](messaging#port-lifetime)).
  EventStream<Port> get onDisconnect =>
      _wrapped.onDisconnect.asStream(($c) => ($js.Port port) {
            return $c(Port.fromJS(port));
          });

  /// This event is fired when $(ref:Port.postMessage postMessage) is called by
  /// the other end of the port.
  EventStream<PortOnMessageEvent> get onMessage =>
      _wrapped.onMessage.asStream(($c) => (
            JSAny message,
            $js.Port port,
          ) {
            return $c(PortOnMessageEvent(
              message: message.dartify()!,
              port: Port.fromJS(port),
            ));
          });
}

class MessageSender {
  MessageSender.fromJS(this._wrapped);

  MessageSender({
    /// The [tabs.Tab] which opened the connection, if any. This property will
    /// *only* be present when the connection was opened from a tab (including
    /// content scripts), and *only* if the receiver is an extension, not an
    /// app.
    Tab? tab,

    /// The [frame](webNavigation#frame_ids) that opened the connection. 0 for
    /// top-level frames, positive for child frames. This will only be set when
    /// `tab` is set.
    int? frameId,

    /// The guest process id of the requesting webview, if available. Only
    /// available for component extensions.
    int? guestProcessId,

    /// The guest render frame routing id of the requesting webview, if
    /// available. Only available for component extensions.
    int? guestRenderFrameRoutingId,

    /// The ID of the extension or app that opened the connection, if any.
    String? id,

    /// The URL of the page or frame that opened the connection. If the sender
    /// is in an iframe, it will be iframe's URL not the URL of the page which
    /// hosts it.
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
  }) : _wrapped = $js.MessageSender(
          tab: tab?.toJS,
          frameId: frameId,
          guestProcessId: guestProcessId,
          guestRenderFrameRoutingId: guestRenderFrameRoutingId,
          id: id,
          url: url,
          nativeApplication: nativeApplication,
          tlsChannelId: tlsChannelId,
          origin: origin,
          documentId: documentId,
          documentLifecycle: documentLifecycle,
        );

  final $js.MessageSender _wrapped;

  $js.MessageSender get toJS => _wrapped;

  /// The [tabs.Tab] which opened the connection, if any. This property will
  /// *only* be present when the connection was opened from a tab (including
  /// content scripts), and *only* if the receiver is an extension, not an app.
  Tab? get tab => _wrapped.tab?.let(Tab.fromJS);
  set tab(Tab? v) {
    _wrapped.tab = v?.toJS;
  }

  /// The [frame](webNavigation#frame_ids) that opened the connection. 0 for
  /// top-level frames, positive for child frames. This will only be set when
  /// `tab` is set.
  int? get frameId => _wrapped.frameId;
  set frameId(int? v) {
    _wrapped.frameId = v;
  }

  /// The guest process id of the requesting webview, if available. Only
  /// available for component extensions.
  int? get guestProcessId => _wrapped.guestProcessId;
  set guestProcessId(int? v) {
    _wrapped.guestProcessId = v;
  }

  /// The guest render frame routing id of the requesting webview, if available.
  /// Only available for component extensions.
  int? get guestRenderFrameRoutingId => _wrapped.guestRenderFrameRoutingId;
  set guestRenderFrameRoutingId(int? v) {
    _wrapped.guestRenderFrameRoutingId = v;
  }

  /// The ID of the extension or app that opened the connection, if any.
  String? get id => _wrapped.id;
  set id(String? v) {
    _wrapped.id = v;
  }

  /// The URL of the page or frame that opened the connection. If the sender is
  /// in an iframe, it will be iframe's URL not the URL of the page which hosts
  /// it.
  String? get url => _wrapped.url;
  set url(String? v) {
    _wrapped.url = v;
  }

  /// The name of the native application that opened the connection, if any.
  String? get nativeApplication => _wrapped.nativeApplication;
  set nativeApplication(String? v) {
    _wrapped.nativeApplication = v;
  }

  /// The TLS channel ID of the page or frame that opened the connection, if
  /// requested by the extension or app, and if available.
  String? get tlsChannelId => _wrapped.tlsChannelId;
  set tlsChannelId(String? v) {
    _wrapped.tlsChannelId = v;
  }

  /// The origin of the page or frame that opened the connection. It can vary
  /// from the url property (e.g., about:blank) or can be opaque (e.g.,
  /// sandboxed iframes). This is useful for identifying if the origin can be
  /// trusted if we can't immediately tell from the URL.
  String? get origin => _wrapped.origin;
  set origin(String? v) {
    _wrapped.origin = v;
  }

  /// A UUID of the document that opened the connection.
  String? get documentId => _wrapped.documentId;
  set documentId(String? v) {
    _wrapped.documentId = v;
  }

  /// The lifecycle the document that opened the connection is in at the time
  /// the port was created. Note that the lifecycle state of the document may
  /// have changed since port creation.
  String? get documentLifecycle => _wrapped.documentLifecycle;
  set documentLifecycle(String? v) {
    _wrapped.documentLifecycle = v;
  }
}

class PlatformInfo {
  PlatformInfo.fromJS(this._wrapped);

  PlatformInfo({
    /// The operating system Chrome is running on.
    required PlatformOs os,

    /// The machine's processor architecture.
    required PlatformArch arch,

    /// The native client architecture. This may be different from arch on some
    /// platforms.
    required PlatformNaclArch naclArch,
  }) : _wrapped = $js.PlatformInfo(
          os: os.toJS,
          arch: arch.toJS,
          nacl_arch: naclArch.toJS,
        );

  final $js.PlatformInfo _wrapped;

  $js.PlatformInfo get toJS => _wrapped;

  /// The operating system Chrome is running on.
  PlatformOs get os => PlatformOs.fromJS(_wrapped.os);
  set os(PlatformOs v) {
    _wrapped.os = v.toJS;
  }

  /// The machine's processor architecture.
  PlatformArch get arch => PlatformArch.fromJS(_wrapped.arch);
  set arch(PlatformArch v) {
    _wrapped.arch = v.toJS;
  }

  /// The native client architecture. This may be different from arch on some
  /// platforms.
  PlatformNaclArch get naclArch => PlatformNaclArch.fromJS(_wrapped.nacl_arch);
  set naclArch(PlatformNaclArch v) {
    _wrapped.nacl_arch = v.toJS;
  }
}

class ExtensionContext {
  ExtensionContext.fromJS(this._wrapped);

  ExtensionContext({
    /// The type of context this corresponds to.
    required ContextType contextType,

    /// A unique identifier for this context
    required String contextId,

    /// The ID of the tab for this context, or -1 if this context is not hosted
    /// in a tab.
    required int tabId,

    /// The ID of the window for this context, or -1 if this context is not
    /// hosted in a window.
    required int windowId,

    /// A UUID for the document associated with this context, or undefined if
    /// this context is hosted not in a document.
    String? documentId,

    /// The ID of the frame for this context, or -1 if this context is not
    /// hosted in a frame.
    required int frameId,

    /// The URL of the document associated with this context, or undefined if
    /// the context is not hosted in a document.
    String? documentUrl,

    /// The origin of the document associated with this context, or undefined if
    /// the context is not hosted in a document.
    String? documentOrigin,

    /// Whether the context is associated with an incognito profile.
    required bool incognito,
  }) : _wrapped = $js.ExtensionContext(
          contextType: contextType.toJS,
          contextId: contextId,
          tabId: tabId,
          windowId: windowId,
          documentId: documentId,
          frameId: frameId,
          documentUrl: documentUrl,
          documentOrigin: documentOrigin,
          incognito: incognito,
        );

  final $js.ExtensionContext _wrapped;

  $js.ExtensionContext get toJS => _wrapped;

  /// The type of context this corresponds to.
  ContextType get contextType => ContextType.fromJS(_wrapped.contextType);
  set contextType(ContextType v) {
    _wrapped.contextType = v.toJS;
  }

  /// A unique identifier for this context
  String get contextId => _wrapped.contextId;
  set contextId(String v) {
    _wrapped.contextId = v;
  }

  /// The ID of the tab for this context, or -1 if this context is not hosted in
  /// a tab.
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }

  /// The ID of the window for this context, or -1 if this context is not hosted
  /// in a window.
  int get windowId => _wrapped.windowId;
  set windowId(int v) {
    _wrapped.windowId = v;
  }

  /// A UUID for the document associated with this context, or undefined if this
  /// context is hosted not in a document.
  String? get documentId => _wrapped.documentId;
  set documentId(String? v) {
    _wrapped.documentId = v;
  }

  /// The ID of the frame for this context, or -1 if this context is not hosted
  /// in a frame.
  int get frameId => _wrapped.frameId;
  set frameId(int v) {
    _wrapped.frameId = v;
  }

  /// The URL of the document associated with this context, or undefined if the
  /// context is not hosted in a document.
  String? get documentUrl => _wrapped.documentUrl;
  set documentUrl(String? v) {
    _wrapped.documentUrl = v;
  }

  /// The origin of the document associated with this context, or undefined if
  /// the context is not hosted in a document.
  String? get documentOrigin => _wrapped.documentOrigin;
  set documentOrigin(String? v) {
    _wrapped.documentOrigin = v;
  }

  /// Whether the context is associated with an incognito profile.
  bool get incognito => _wrapped.incognito;
  set incognito(bool v) {
    _wrapped.incognito = v;
  }
}

class ContextFilter {
  ContextFilter.fromJS(this._wrapped);

  ContextFilter({
    List<ContextType>? contextTypes,
    List<String>? contextIds,
    List<int>? tabIds,
    List<int>? windowIds,
    List<String>? documentIds,
    List<int>? frameIds,
    List<String>? documentUrls,
    List<String>? documentOrigins,
    bool? incognito,
  }) : _wrapped = $js.ContextFilter(
          contextTypes: contextTypes?.toJSArray((e) => e.toJS),
          contextIds: contextIds?.toJSArray((e) => e),
          tabIds: tabIds?.toJSArray((e) => e),
          windowIds: windowIds?.toJSArray((e) => e),
          documentIds: documentIds?.toJSArray((e) => e),
          frameIds: frameIds?.toJSArray((e) => e),
          documentUrls: documentUrls?.toJSArray((e) => e),
          documentOrigins: documentOrigins?.toJSArray((e) => e),
          incognito: incognito,
        );

  final $js.ContextFilter _wrapped;

  $js.ContextFilter get toJS => _wrapped;

  List<ContextType>? get contextTypes => _wrapped.contextTypes?.toDart
      .cast<$js.ContextType>()
      .map((e) => ContextType.fromJS(e))
      .toList();
  set contextTypes(List<ContextType>? v) {
    _wrapped.contextTypes = v?.toJSArray((e) => e.toJS);
  }

  List<String>? get contextIds =>
      _wrapped.contextIds?.toDart.cast<String>().map((e) => e).toList();
  set contextIds(List<String>? v) {
    _wrapped.contextIds = v?.toJSArray((e) => e);
  }

  List<int>? get tabIds =>
      _wrapped.tabIds?.toDart.cast<int>().map((e) => e).toList();
  set tabIds(List<int>? v) {
    _wrapped.tabIds = v?.toJSArray((e) => e);
  }

  List<int>? get windowIds =>
      _wrapped.windowIds?.toDart.cast<int>().map((e) => e).toList();
  set windowIds(List<int>? v) {
    _wrapped.windowIds = v?.toJSArray((e) => e);
  }

  List<String>? get documentIds =>
      _wrapped.documentIds?.toDart.cast<String>().map((e) => e).toList();
  set documentIds(List<String>? v) {
    _wrapped.documentIds = v?.toJSArray((e) => e);
  }

  List<int>? get frameIds =>
      _wrapped.frameIds?.toDart.cast<int>().map((e) => e).toList();
  set frameIds(List<int>? v) {
    _wrapped.frameIds = v?.toJSArray((e) => e);
  }

  List<String>? get documentUrls =>
      _wrapped.documentUrls?.toDart.cast<String>().map((e) => e).toList();
  set documentUrls(List<String>? v) {
    _wrapped.documentUrls = v?.toJSArray((e) => e);
  }

  List<String>? get documentOrigins =>
      _wrapped.documentOrigins?.toDart.cast<String>().map((e) => e).toList();
  set documentOrigins(List<String>? v) {
    _wrapped.documentOrigins = v?.toJSArray((e) => e);
  }

  bool? get incognito => _wrapped.incognito;
  set incognito(bool? v) {
    _wrapped.incognito = v;
  }
}

class OnInstalledDetails {
  OnInstalledDetails.fromJS(this._wrapped);

  OnInstalledDetails({
    /// The reason that this event is being dispatched.
    required OnInstalledReason reason,

    /// Indicates the previous version of the extension, which has just been
    /// updated. This is present only if 'reason' is 'update'.
    String? previousVersion,

    /// Indicates the ID of the imported shared module extension which updated.
    /// This is present only if 'reason' is 'shared_module_update'.
    String? id,
  }) : _wrapped = $js.OnInstalledDetails(
          reason: reason.toJS,
          previousVersion: previousVersion,
          id: id,
        );

  final $js.OnInstalledDetails _wrapped;

  $js.OnInstalledDetails get toJS => _wrapped;

  /// The reason that this event is being dispatched.
  OnInstalledReason get reason => OnInstalledReason.fromJS(_wrapped.reason);
  set reason(OnInstalledReason v) {
    _wrapped.reason = v.toJS;
  }

  /// Indicates the previous version of the extension, which has just been
  /// updated. This is present only if 'reason' is 'update'.
  String? get previousVersion => _wrapped.previousVersion;
  set previousVersion(String? v) {
    _wrapped.previousVersion = v;
  }

  /// Indicates the ID of the imported shared module extension which updated.
  /// This is present only if 'reason' is 'shared_module_update'.
  String? get id => _wrapped.id;
  set id(String? v) {
    _wrapped.id = v;
  }
}

class OnUpdateAvailableDetails {
  OnUpdateAvailableDetails.fromJS(this._wrapped);

  OnUpdateAvailableDetails(
      {
      /// The version number of the available update.
      required String version})
      : _wrapped = $js.OnUpdateAvailableDetails(version: version);

  final $js.OnUpdateAvailableDetails _wrapped;

  $js.OnUpdateAvailableDetails get toJS => _wrapped;

  /// The version number of the available update.
  String get version => _wrapped.version;
  set version(String v) {
    _wrapped.version = v;
  }
}

class RequestUpdateCheckCallbackResult {
  RequestUpdateCheckCallbackResult.fromJS(this._wrapped);

  RequestUpdateCheckCallbackResult({
    /// Result of the update check.
    required RequestUpdateCheckStatus status,

    /// If an update is available, this contains the version of the available
    /// update.
    String? version,
  }) : _wrapped = $js.RequestUpdateCheckCallbackResult(
          status: status.toJS,
          version: version,
        );

  final $js.RequestUpdateCheckCallbackResult _wrapped;

  $js.RequestUpdateCheckCallbackResult get toJS => _wrapped;

  /// Result of the update check.
  RequestUpdateCheckStatus get status =>
      RequestUpdateCheckStatus.fromJS(_wrapped.status);
  set status(RequestUpdateCheckStatus v) {
    _wrapped.status = v.toJS;
  }

  /// If an update is available, this contains the version of the available
  /// update.
  String? get version => _wrapped.version;
  set version(String? v) {
    _wrapped.version = v;
  }
}

class ConnectInfo {
  ConnectInfo.fromJS(this._wrapped);

  ConnectInfo({
    /// Will be passed into onConnect for processes that are listening for the
    /// connection event.
    String? name,

    /// Whether the TLS channel ID will be passed into onConnectExternal for
    /// processes that are listening for the connection event.
    bool? includeTlsChannelId,
  }) : _wrapped = $js.ConnectInfo(
          name: name,
          includeTlsChannelId: includeTlsChannelId,
        );

  final $js.ConnectInfo _wrapped;

  $js.ConnectInfo get toJS => _wrapped;

  /// Will be passed into onConnect for processes that are listening for the
  /// connection event.
  String? get name => _wrapped.name;
  set name(String? v) {
    _wrapped.name = v;
  }

  /// Whether the TLS channel ID will be passed into onConnectExternal for
  /// processes that are listening for the connection event.
  bool? get includeTlsChannelId => _wrapped.includeTlsChannelId;
  set includeTlsChannelId(bool? v) {
    _wrapped.includeTlsChannelId = v;
  }
}

class SendMessageOptions {
  SendMessageOptions.fromJS(this._wrapped);

  SendMessageOptions(
      {
      /// Whether the TLS channel ID will be passed into onMessageExternal for
      /// processes that are listening for the connection event.
      bool? includeTlsChannelId})
      : _wrapped =
            $js.SendMessageOptions(includeTlsChannelId: includeTlsChannelId);

  final $js.SendMessageOptions _wrapped;

  $js.SendMessageOptions get toJS => _wrapped;

  /// Whether the TLS channel ID will be passed into onMessageExternal for
  /// processes that are listening for the connection event.
  bool? get includeTlsChannelId => _wrapped.includeTlsChannelId;
  set includeTlsChannelId(bool? v) {
    _wrapped.includeTlsChannelId = v;
  }
}

class RuntimeLastError {
  RuntimeLastError.fromJS(this._wrapped);

  RuntimeLastError(
      {
      /// Details about the error which occurred.
      String? message})
      : _wrapped = $js.RuntimeLastError(message: message);

  final $js.RuntimeLastError _wrapped;

  $js.RuntimeLastError get toJS => _wrapped;

  /// Details about the error which occurred.
  String? get message => _wrapped.message;
  set message(String? v) {
    _wrapped.message = v;
  }
}

class OnMessageEvent {
  OnMessageEvent({
    required this.message,
    required this.sender,
    required this.sendResponse,
  });

  /// The message sent by the calling script.
  final Object? message;

  final MessageSender sender;

  /// Function to call (at most once) when you have a response. The argument
  /// should be any JSON-ifiable object. If you have more than one `onMessage`
  /// listener in the same document, then only one may send a response. This
  /// function becomes invalid when the event listener returns, *unless you
  /// return true* from the event listener to indicate you wish to send a
  /// response asynchronously (this will keep the message channel open to the
  /// other end until `sendResponse` is called).
  final Function sendResponse;
}

class OnMessageExternalEvent {
  OnMessageExternalEvent({
    required this.message,
    required this.sender,
    required this.sendResponse,
  });

  /// The message sent by the calling script.
  final Object? message;

  final MessageSender sender;

  /// Function to call (at most once) when you have a response. The argument
  /// should be any JSON-ifiable object. If you have more than one `onMessage`
  /// listener in the same document, then only one may send a response. This
  /// function becomes invalid when the event listener returns, *unless you
  /// return true* from the event listener to indicate you wish to send a
  /// response asynchronously (this will keep the message channel open to the
  /// other end until `sendResponse` is called).
  final Function sendResponse;
}

class PortOnMessageEvent {
  PortOnMessageEvent({
    required this.message,
    required this.port,
  });

  /// The message received on the port.
  final Object message;

  /// The port that received the message.
  final Port port;
}
