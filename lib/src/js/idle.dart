// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSIdleExtension on JSChrome {
  @JS('idle')
  external JSIdle? get idleNullable;

  /// Use the `chrome.idle` API to detect when the machine's idle state changes.
  JSIdle get idle {
    var idleNullable = this.idleNullable;
    if (idleNullable == null) {
      throw ApiNotAvailableException('chrome.idle');
    }
    return idleNullable;
  }
}

@JS()
@staticInterop
class JSIdle {}

extension JSIdleExtension on JSIdle {
  /// Returns "locked" if the system is locked, "idle" if the user has not
  /// generated any input for a specified number of seconds, or "active"
  /// otherwise.
  external void queryState(
    /// The system is considered idle if detectionIntervalInSeconds seconds have
    /// elapsed since the last user input detected.
    int detectionIntervalInSeconds,
    JSFunction callback,
  );

  /// Sets the interval, in seconds, used to determine when the system is in an
  /// idle state for onStateChanged events. The default interval is 60 seconds.
  external void setDetectionInterval(

      /// Threshold, in seconds, used to determine when the system is in an idle
      /// state.
      int intervalInSeconds);

  /// Gets the time, in seconds, it takes until the screen is locked
  /// automatically while idle. Returns a zero duration if the screen is never
  /// locked automatically. Currently supported on Chrome OS only.
  external void getAutoLockDelay(JSFunction callback);

  /// Fired when the system changes to an active, idle or locked state. The
  /// event fires with "locked" if the screen is locked or the screensaver
  /// activates, "idle" if the system is unlocked and the user has not generated
  /// any input for a specified number of seconds, and "active" when the user
  /// generates input on an idle system.
  external Event get onStateChanged;
}

typedef IdleState = String;
