// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/power.dart' as $js;

export 'src/chrome.dart' show chrome;

final _power = ChromePower._();

extension ChromePowerExtension on Chrome {
  /// Use the `chrome.power` API to override the system's power
  /// management features.
  ChromePower get power => _power;
}

class ChromePower {
  ChromePower._();

  bool get isAvailable => $js.chrome.powerNullable != null && alwaysTrue;

  /// Requests that power management be temporarily disabled. |level|
  /// describes the degree to which power management should be disabled.
  /// If a request previously made by the same app is still active, it
  /// will be replaced by the new request.
  void requestKeepAwake(Level level) {
    $js.chrome.power.requestKeepAwake(level.toJS);
  }

  /// Releases a request previously made via requestKeepAwake().
  void releaseKeepAwake() {
    $js.chrome.power.releaseKeepAwake();
  }

  /// Reports a user activity in order to awake the screen from a dimmed or
  /// turned off state or from a screensaver. Exits the screensaver if it is
  /// currently active.
  Future<void> reportActivity() async {
    await promiseToFuture<void>($js.chrome.power.reportActivity());
  }
}

enum Level {
  /// Prevent the system from sleeping in response to user inactivity.
  system('system'),

  /// Prevent the display from being turned off or dimmed or the system
  /// from sleeping in response to user inactivity.
  display('display');

  const Level(this.value);

  final String value;

  String get toJS => value;
  static Level fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}
