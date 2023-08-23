## 0.1.1

- Update the readme.

## 0.1.0

- Initial implementation of the binding for the chrome.* APIs
Each API is in its own dart file and can be used like:

```dart
import 'package:chrome_extension/alarms.dart';

void main() async {
  await chrome.alarms.create('MyAlarm', AlarmCreateInfo(delayInMinutes: 2));
}
```
