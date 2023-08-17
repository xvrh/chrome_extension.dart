import 'package:chrome_extension/alarms.dart';
import 'package:chrome_extension/power.dart';
import 'package:chrome_extension/storage.dart';

void main() async {
  // Use the chrome.power API
  chrome.power.requestKeepAwake(Level.display);

  // Use the chrome.storage API
  await chrome.storage.sync.set({'mykey': 'value'});
  var values = await chrome.storage.sync.get(null /* all */);
  print(values['mykey']);

  // Use the chrome.alarms API
  await chrome.alarms.create('MyAlarm', AlarmCreateInfo(delayInMinutes: 2));
}
