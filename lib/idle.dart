// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'src/internal_helpers.dart';
import 'src/js/idle.dart' as $js;

export 'src/chrome.dart' show chrome, EventStream;

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
  Future<IdleState> queryState(int detectionIntervalInSeconds) async {
    var $res =
        await $js.chrome.idle.queryState(detectionIntervalInSeconds).toDart;
    return IdleState.fromJS($res! as $js.IdleState);
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
  Future<int> getAutoLockDelay() async {
    var $res = await $js.chrome.idle.getAutoLockDelay().toDart;
    return $res.dartify() as int? ?? 0;
  }

  /// Fired when the system changes to an active, idle or locked state. The
  /// event fires with "locked" if the screen is locked or the screensaver
  /// activates, "idle" if the system is unlocked and the user has not generated
  /// any input for a specified number of seconds, and "active" when the user
  /// generates input on an idle system.
  EventStream<IdleState> get onStateChanged =>
      $js.chrome.idle.onStateChanged.asStream(
        ($c) =>
            ($js.IdleState newState) {
              return $c(IdleState.fromJS(newState));
            }.toJS,
      );
}

enum IdleState {
  active('active'),
  idle('idle'),
  locked('locked');

  const IdleState(this.value);

  final String value;

  JSString get toJS => value.toJS;
  static IdleState fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}
