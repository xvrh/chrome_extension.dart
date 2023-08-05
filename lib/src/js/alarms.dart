// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSAlarmsExtension on JSChrome {
  @JS('alarms')
  external JSAlarms? get alarmsNullable;

  /// Use the `chrome.alarms` API to schedule code to run
  /// periodically or at a specified time in the future.
  JSAlarms get alarms {
    var alarmsNullable = this.alarmsNullable;
    if (alarmsNullable == null) {
      throw ApiNotAvailableException('chrome.alarms');
    }
    return alarmsNullable;
  }
}

@JS()
@staticInterop
class JSAlarms {}

extension JSAlarmsExtension on JSAlarms {
  /// Creates an alarm.  Near the time(s) specified by [alarmInfo],
  /// the `onAlarm` event is fired. If there is another alarm with
  /// the same name (or no name if none is specified), it will be cancelled and
  /// replaced by this alarm.
  ///
  /// In order to reduce the load on the user's machine, Chrome limits alarms
  /// to at most once every 1 minute but may delay them an arbitrary amount
  /// more.  That is, setting `delayInMinutes` or
  /// `periodInMinutes` to less than `1` will not be
  /// honored and will cause a warning.  `when` can be set to less
  /// than 1 minute after "now" without warning but won't actually cause the
  /// alarm to fire for at least 1 minute.
  ///
  /// To help you debug your app or extension, when you've loaded it unpacked,
  /// there's no limit to how often the alarm can fire.
  ///
  /// |name|: Optional name to identify this alarm. Defaults to the empty
  /// string.
  /// |alarmInfo|: Describes when the alarm should fire.  The initial time must
  /// be specified by either [when] or [delayInMinutes] (but
  /// not both).  If [periodInMinutes] is set, the alarm will repeat
  /// every [periodInMinutes] minutes after the initial event.  If
  /// neither [when] or [delayInMinutes] is set for a
  /// repeating alarm, [periodInMinutes] is used as the default for
  /// [delayInMinutes].
  /// |callback|: Invoked when the alarm has been created.
  external JSPromise create(
    String? name,
    AlarmCreateInfo alarmInfo,
  );

  /// Retrieves details about the specified alarm.
  /// |name|: The name of the alarm to get. Defaults to the empty string.
  external JSPromise get(String? name);

  /// Gets an array of all the alarms.
  external JSPromise getAll();

  /// Clears the alarm with the given name.
  /// |name|: The name of the alarm to clear. Defaults to the empty string.
  external JSPromise clear(String? name);

  /// Clears all alarms.
  external JSPromise clearAll();

  /// Fired when an alarm has elapsed. Useful for event pages.
  /// |alarm|: The alarm that has elapsed.
  external Event get onAlarm;
}

@JS()
@staticInterop
@anonymous
class Alarm {
  external factory Alarm({
    /// Name of this alarm.
    String name,

    /// Time at which this alarm was scheduled to fire, in milliseconds past the
    /// epoch (e.g. `Date.now() + n`).  For performance reasons, the
    /// alarm may have been delayed an arbitrary amount beyond this.
    double scheduledTime,

    /// If not null, the alarm is a repeating alarm and will fire again in
    /// [periodInMinutes] minutes.
    double? periodInMinutes,
  });
}

extension AlarmExtension on Alarm {
  /// Name of this alarm.
  external String name;

  /// Time at which this alarm was scheduled to fire, in milliseconds past the
  /// epoch (e.g. `Date.now() + n`).  For performance reasons, the
  /// alarm may have been delayed an arbitrary amount beyond this.
  external double scheduledTime;

  /// If not null, the alarm is a repeating alarm and will fire again in
  /// [periodInMinutes] minutes.
  external double? periodInMinutes;
}

@JS()
@staticInterop
@anonymous
class AlarmCreateInfo {
  external factory AlarmCreateInfo({
    /// Time at which the alarm should fire, in milliseconds past the epoch
    /// (e.g. `Date.now() + n`).
    double? when,

    /// Length of time in minutes after which the `onAlarm` event
    /// should fire.
    ///
    /// <!-- TODO: need minimum=0 -->
    double? delayInMinutes,

    /// If set, the onAlarm event should fire every [periodInMinutes]
    /// minutes after the initial event specified by [when] or
    /// [delayInMinutes].  If not set, the alarm will only fire once.
    ///
    /// <!-- TODO: need minimum=0 -->
    double? periodInMinutes,
  });
}

extension AlarmCreateInfoExtension on AlarmCreateInfo {
  /// Time at which the alarm should fire, in milliseconds past the epoch
  /// (e.g. `Date.now() + n`).
  external double? when;

  /// Length of time in minutes after which the `onAlarm` event
  /// should fire.
  ///
  /// <!-- TODO: need minimum=0 -->
  external double? delayInMinutes;

  /// If set, the onAlarm event should fire every [periodInMinutes]
  /// minutes after the initial event specified by [when] or
  /// [delayInMinutes].  If not set, the alarm will only fire once.
  ///
  /// <!-- TODO: need minimum=0 -->
  external double? periodInMinutes;
}
