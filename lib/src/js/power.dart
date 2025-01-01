// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import
// ignore_for_file: unintended_html_in_doc_comment

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSPowerExtension on JSChrome {
  @JS('power')
  external JSPower? get powerNullable;

  /// Use the `chrome.power` API to override the system's power
  /// management features.
  JSPower get power {
    var powerNullable = this.powerNullable;
    if (powerNullable == null) {
      throw ApiNotAvailableException('chrome.power');
    }
    return powerNullable;
  }
}

extension type JSPower._(JSObject _) {
  /// Requests that power management be temporarily disabled. |level|
  /// describes the degree to which power management should be disabled.
  /// If a request previously made by the same app is still active, it
  /// will be replaced by the new request.
  external void requestKeepAwake(Level level);

  /// Releases a request previously made via requestKeepAwake().
  external void releaseKeepAwake();

  /// Reports a user activity in order to awake the screen from a dimmed or
  /// turned off state or from a screensaver. Exits the screensaver if it is
  /// currently active.
  external JSPromise reportActivity();
}

typedef Level = JSString;
