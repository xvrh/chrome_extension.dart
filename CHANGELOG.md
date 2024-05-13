## 0.3.1

- Expose `EventStream` class.

## 0.3.0

- Regenerate the bindings based on Chrome v122
- Update JS binding for Dart 3.3
- Require Dart SDK >= 3.3

## 0.2.0

- Regenerate the bindings based on Chrome v116
- Update JS binding for Dart 3.2
- Require Dart SDK >= 3.2

## 0.1.2

- Update the readme to give some tips on how to build Chrome extensions with Flutter.

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
