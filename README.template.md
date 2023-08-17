# chrome_extension

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
* See [example folder](https://github.com/xvrh/chrome_extension/tree/main/extension_examples)