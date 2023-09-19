# chrome_extension.dart

[![pub package](https://img.shields.io/pub/v/chrome_extension.svg)](https://pub.dartlang.org/packages/chrome_extension)
[![Build Status](https://github.com/xvrh/chrome_extension.dart/workflows/Build/badge.svg)](https://github.com/xvrh/chrome_extension.dart)

A library for accessing the `chrome.*` [APIs](https://developer.chrome.com/docs/extensions/reference/) available in Chrome extensions.

This allows to build [Chrome extension](https://developer.chrome.com/docs/extensions/) with [Dart](https://dart.dev) & [Flutter](https://flutter.dev) and to interop with the native APIs easily with a high-level type-safe interface.

The JS interop is build on top of `dart:js_interop` (static interop) which make it ready for future WASM compilation.

## Using the library

### Example

```dart
import 'example/example.dart';
```

### Available APIs

<!-- LIST APIS -->

## Documentation

* [Chrome Extensions API reference](https://developer.chrome.com/docs/extensions/reference/)
* See [example folder](https://github.com/xvrh/chrome_extension/tree/main/extension_examples) for some examples of Flutter and Dart Chrome extensions

## Tips to build Chrome extensions with Flutter

#### Develop the app using Flutter Desktop

In order to develop in a comfortable environment with hot-reload and hot-restart working,
develop most of the app using Flutter desktop.

The app needs an abstraction layer between the UI and the `chrome_extension` APIs.

The desktop entry point injects a fake implementation of this abstraction layer to be runnable on Desktop.

```dart
import 'example/desktop_entry_point.dart#example';
```

Launch this entry point with  
`flutter run -t lib/main_desktop.dart -d macos|windows|linux`

Create the real entry point and compile it with a custom build script

```dart
import 'example/real_entry_point.dart#example';
```

#### Build script

`web/manifest.json`
```json
{
  "manifest_version": 3,
  "name": "my_extension",
  "permissions": [
    "activeTab"
  ],
  "options_page": "options.html",
  "background": {
    "service_worker": "background.dart.js"
  },
  "action": {
    "default_popup": "index.html",
    "default_icon": {
      "16": "icons-16.png"
    }
  },
  "content_security_policy": {
    "extension_pages": "script-src 'self' 'wasm-unsafe-eval'; object-src 'self';"
  }
}
```

```dart
import 'example/build_script.dart';
```

It builds the flutter app and compiles all the other Dart scripts
(for example: options.dart.js, popup.dart.js, background.dart.js)

#### Testing

Write tests for the extension using [`puppeteer-dart`](https://pub.dev/packages/puppeteer).

```dart
import 'example/test.dart';
```