// ignore_for_file: unnecessary_parenthesis

library;

import 'src/internal_helpers.dart';
import 'src/js/idle.dart' as $js;

export 'src/chrome.dart' show chrome;

final _idle = ChromeIdle._();

extension ChromeIdleExtension on Chrome {
  /// Use the `chrome.idle` API to detect when the machine's idle state changes.
  ChromeIdle get idle => _idle;
}

class ChromeIdle {
  ChromeIdle._();

  bool get isAvailable => $js.chrome.idleNullable != null && alwaysTrue;

  /// Returns "locked" if the system is locked, "idle" if the user has not
  /// generated any input for a specified number of seconds, or "active"
  /// otherwise.
  /// [detectionIntervalInSeconds] The system is considered idle if
  /// detectionIntervalInSeconds seconds have elapsed since the last user
  /// input detected.
  Future<IdleState> queryState(int detectionIntervalInSeconds) {
    var $completer = Completer<IdleState>();
    $js.chrome.idle.queryState(
      detectionIntervalInSeconds,
      ($js.IdleState newState) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(IdleState.fromJS(newState));
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Sets the interval, in seconds, used to determine when the system is in an
  /// idle state for onStateChanged events. The default interval is 60 seconds.
  /// [intervalInSeconds] Threshold, in seconds, used to determine when the
  /// system is in an idle state.
  void setDetectionInterval(int intervalInSeconds) {
    $js.chrome.idle.setDetectionInterval(intervalInSeconds);
  }

  /// Gets the time, in seconds, it takes until the screen is locked
  /// automatically while idle. Returns a zero duration if the screen is never
  /// locked automatically. Currently supported on Chrome OS only.
  Future<int> getAutoLockDelay() {
    var $completer = Completer<int>();
    $js.chrome.idle.getAutoLockDelay((int delay) {
      if (checkRuntimeLastError($completer)) {
        $completer.complete(delay);
      }
    }.toJS);
    return $completer.future;
  }

  /// Fired when the system changes to an active, idle or locked state. The
  /// event fires with "locked" if the screen is locked or the screensaver
  /// activates, "idle" if the system is unlocked and the user has not generated
  /// any input for a specified number of seconds, and "active" when the user
  /// generates input on an idle system.
  EventStream<IdleState> get onStateChanged =>
      $js.chrome.idle.onStateChanged.asStream(($c) => ($js.IdleState newState) {
            return $c(IdleState.fromJS(newState));
          });
}

enum IdleState {
  active('active'),
  idle('idle'),
  locked('locked');

  const IdleState(this.value);

  final String value;

  String get toJS => value;
  static IdleState fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}
