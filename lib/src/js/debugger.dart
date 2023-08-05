// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSDebuggerExtension on JSChrome {
  @JS('debugger')
  external JSDebugger? get debuggerNullable;

  /// The `chrome.debugger` API serves as an alternate transport for Chrome's
  /// [remote debugging
  /// protocol](https://developer.chrome.com/devtools/docs/debugger-protocol).
  /// Use `chrome.debugger` to attach to one or more tabs to instrument network
  /// interaction, debug JavaScript, mutate the DOM and CSS, etc. Use the
  /// Debuggee `tabId` to target tabs with sendCommand and route events by
  /// `tabId` from onEvent callbacks.
  JSDebugger get debugger {
    var debuggerNullable = this.debuggerNullable;
    if (debuggerNullable == null) {
      throw ApiNotAvailableException('chrome.debugger');
    }
    return debuggerNullable;
  }
}

@JS()
@staticInterop
class JSDebugger {}

extension JSDebuggerExtension on JSDebugger {
  /// Attaches debugger to the given target.
  external JSPromise attach(
    /// Debugging target to which you want to attach.
    Debuggee target,

    /// Required debugging protocol version ("0.1"). One can only attach to the
    /// debuggee with matching major version and greater or equal minor version.
    /// List of the protocol versions can be obtained
    /// [here](https://developer.chrome.com/devtools/docs/debugger-protocol).
    String requiredVersion,
  );

  /// Detaches debugger from the given target.
  external JSPromise detach(

      /// Debugging target from which you want to detach.
      Debuggee target);

  /// Sends given command to the debugging target.
  external JSPromise sendCommand(
    /// Debugging target to which you want to send the command.
    Debuggee target,

    /// Method name. Should be one of the methods defined by the [remote
    /// debugging
    /// protocol](https://developer.chrome.com/devtools/docs/debugger-protocol).
    String method,

    /// JSON object with request parameters. This object must conform to the
    /// remote debugging params scheme for given method.
    JSAny? commandParams,
  );

  /// Returns the list of available debug targets.
  external JSPromise getTargets();

  /// Fired whenever debugging target issues instrumentation event.
  external Event get onEvent;

  /// Fired when browser terminates debugging session for the tab. This happens
  /// when either the tab is being closed or Chrome DevTools is being invoked
  /// for the attached tab.
  external Event get onDetach;
}

/// Target type.
typedef TargetInfoType = String;

/// Connection termination reason.
typedef DetachReason = String;

@JS()
@staticInterop
@anonymous
class Debuggee {
  external factory Debuggee({
    /// The id of the tab which you intend to debug.
    int? tabId,

    /// The id of the extension which you intend to debug. Attaching to an
    /// extension background page is only possible when the
    /// `--silent-debugger-extension-api` command-line switch is used.
    String? extensionId,

    /// The opaque id of the debug target.
    String? targetId,
  });
}

extension DebuggeeExtension on Debuggee {
  /// The id of the tab which you intend to debug.
  external int? tabId;

  /// The id of the extension which you intend to debug. Attaching to an
  /// extension background page is only possible when the
  /// `--silent-debugger-extension-api` command-line switch is used.
  external String? extensionId;

  /// The opaque id of the debug target.
  external String? targetId;
}

@JS()
@staticInterop
@anonymous
class TargetInfo {
  external factory TargetInfo({
    /// Target type.
    TargetInfoType type,

    /// Target id.
    String id,

    /// The tab id, defined if type == 'page'.
    int? tabId,

    /// The extension id, defined if type = 'background_page'.
    String? extensionId,

    /// True if debugger is already attached.
    bool attached,

    /// Target page title.
    String title,

    /// Target URL.
    String url,

    /// Target favicon URL.
    String? faviconUrl,
  });
}

extension TargetInfoExtension on TargetInfo {
  /// Target type.
  external TargetInfoType type;

  /// Target id.
  external String id;

  /// The tab id, defined if type == 'page'.
  external int? tabId;

  /// The extension id, defined if type = 'background_page'.
  external String? extensionId;

  /// True if debugger is already attached.
  external bool attached;

  /// Target page title.
  external String title;

  /// Target URL.
  external String url;

  /// Target favicon URL.
  external String? faviconUrl;
}
