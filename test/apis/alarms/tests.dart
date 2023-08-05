import 'package:checks/checks.dart';
import 'package:chrome_apis/alarms.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('create alarm', () async {
    await chrome.alarms.create(
        'AlarmName',
        AlarmCreateInfo(
          delayInMinutes: 1,
        ));
    await chrome.alarms.create(
        'AlarmName2',
        AlarmCreateInfo(
          delayInMinutes: 10,
        ));
    var all = await chrome.alarms.getAll();
    check(all).length.equals(2);
    check(all.first.name).equals('AlarmName');
    check(all.last.name).equals('AlarmName2');
    check(all.first.periodInMinutes).isNull();
    check(all.first.scheduledTime).isCloseTo(
        DateTime.now().add(Duration(minutes: 1)).millisecondsSinceEpoch, 1000);

    var byName = await chrome.alarms.get('AlarmName');
    check(byName!.name).equals('AlarmName');

    var cleared = await chrome.alarms.clearAll();
    check(cleared).isTrue();
  });

  test('Clear alarm', () async {
    await chrome.alarms.create(
        'MyAlarm',
        AlarmCreateInfo(
          delayInMinutes: 1,
        ));

    var found = await chrome.alarms.get('MyAlarm');
    check(found).isNotNull();

    var cleared = await chrome.alarms.clear('MyAlarm');
    check(cleared).isTrue();

    found = await chrome.alarms.get('MyAlarm');
    check(found).isNull();
  });

  test('Clear not existing alarm', () async {
    var cleared = await chrome.alarms.clear('Not exist');
    check(cleared).isFalse();
  });

  test('ClearAll empty', () async {
    await chrome.alarms.clearAll();
    var cleared = await chrome.alarms.clearAll();
    check(cleared).isTrue();
  });
}
