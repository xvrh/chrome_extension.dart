## 0.6.0

- Regenerate the bindings from the Chrome 156 API schemas. Chromium moved many
  APIs to WebIDL, which the generator can now read.
- Add the `readingList` and `userScripts` APIs.
- New functions, events and properties across the APIs (for example `sidePanel`,
  `omnibox` actions, split view in `tabs`, `cookies.getPartitionKey`,
  `storage.getKeys`). Some types changed to follow Chrome:
  `pageCapture.saveAsMHTML` resolves with a `Blob`,
  `devtools.inspectedWindow.eval` resolves with a single response object and
  `privacy.relatedWebsiteSetsEnabled` was removed.
- Annotate deprecated functions and events with `@Deprecated`.
- Fix the value of `usb.Recipient.interface`.

## 0.5.0

- Support WebAssembly: the package can be compiled with `dart compile wasm` and
  `flutter build web --wasm`.
- Remove the usages of the deprecated `dart:js_util` library.
- `runtime.sendMessage` and `tabs.sendMessage` return `null` when the receiver
  doesn't send a response.
- Require Dart 3.6.

## 0.4.0

- Fix the package to work with Dart 3.5 & Flutter 3.24

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
