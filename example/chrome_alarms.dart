import 'package:chrome_extension/alarms.dart';

void main() async {
  await chrome.alarms.create('MyAlarm', AlarmCreateInfo(delayInMinutes: 2));

  var alarm = await chrome.alarms.get('MyAlarm');
  print(alarm!.name);
}
