# chrome_extension.dart

[![pub package](https://img.shields.io/pub/v/chrome_extension.svg)](https://pub.dev/packages/chrome_extension)
[![pub points](https://img.shields.io/pub/points/chrome_extension)](https://pub.dev/packages/chrome_extension/score)
[![Build Status](https://github.com/xvrh/chrome_extension.dart/actions/workflows/build.yaml/badge.svg?branch=main)](https://github.com/xvrh/chrome_extension.dart/actions/workflows/build.yaml)

A library for accessing the `chrome.*` [APIs](https://developer.chrome.com/docs/extensions/reference/) available in Chrome extensions.

It lets you build [Chrome extensions](https://developer.chrome.com/docs/extensions/) with [Dart](https://dart.dev) & [Flutter](https://flutter.dev) and use the native APIs through a high-level, type-safe interface.

The JS interop is built on top of `dart:js_interop`, so the library works when compiled to JavaScript and to WebAssembly (`dart compile wasm`, `flutter build web --wasm`).

<a href="https://www.buymeacoffee.com/xvrh" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="60" width="217"></a>

## Using the library

### Example

#### `chrome.tabs`
```dart
import 'example/chrome_tabs.dart';
```

#### `chrome.alarms`
```dart
import 'example/chrome_alarms.dart';
```

#### `chrome.power`
```dart
import 'example/chrome_power.dart';
```

#### `chrome.runtime`
```dart
import 'example/chrome_runtime.dart';
```

#### `chrome.storage`
```dart
import 'example/chrome_storage.dart';
```

### Available APIs

<!-- LIST APIS -->

## Documentation

* [Chrome Extensions API reference](https://developer.chrome.com/docs/extensions/reference/)
* See [example folder](https://github.com/xvrh/chrome_extension.dart/tree/main/extension_examples) for some examples of Flutter and Dart Chrome extensions

## Tips to build Chrome extensions with Flutter

Here are some personal tips to build Chrome extensions using the Flutter UI framework.

#### Develop the app using Flutter Desktop

In order to develop in a comfortable environment with hot-reload,
most of the app (the UI part) should be developed using Flutter desktop.

This requires an abstraction layer between the UI and the `chrome_extension` APIs.

In the Desktop entry point, a fake implementation of this abstraction layer is used, like this:

```dart
import 'example/desktop_entry_point.dart#example';
```

Launch this entry point in desktop with  
`flutter run -t lib/main_desktop.dart -d macos|windows|linux`

And the real entry point (the one used in the actual compiled extension) looks like:

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
import 'example/build_script.dart#example';
```

It builds the flutter app and compiles all the other Dart scripts
(for example: options.dart.js, popup.dart.js, background.dart.js)

With `--wasm`, the Flutter app is compiled to WebAssembly (with a fallback to JavaScript).
`web/index.html` needs to load it with `<script src="flutter_bootstrap.js" async></script>`,
loading `main.dart.js` directly always uses the JavaScript build.

Keep compiling the background service worker and the content scripts to JavaScript:
content scripts can't be ES modules, and a Wasm module is instantiated asynchronously while Chrome
only dispatches the event that woke up the service worker to the listeners registered synchronously.

#### Testing

Write tests for the extension using [`puppeteer-dart`](https://pub.dev/packages/puppeteer).

`browser.installExtension()` (or `puppeteer.launch(extensions: [...])`) installs the extension through the
DevTools protocol, so the tests can run in headless mode and with Google Chrome, which ignores the
`--load-extension` flag since version 137.

```dart
import 'example/test.dart';
```