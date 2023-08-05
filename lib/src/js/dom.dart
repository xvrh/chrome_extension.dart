// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSDomExtension on JSChrome {
  @JS('dom')
  external JSDom? get domNullable;

  /// Use the `chrome.dom` API to access special DOM APIs for Extensions
  JSDom get dom {
    var domNullable = this.domNullable;
    if (domNullable == null) {
      throw ApiNotAvailableException('chrome.dom');
    }
    return domNullable;
  }
}

@JS()
@staticInterop
class JSDom {}

extension JSDomExtension on JSDom {
  /// Gets the open shadow root or the closed shadow root hosted by the
  /// specified element. If the element doesn't attach the shadow root, it will
  /// return null.
  external JSAny openOrClosedShadowRoot(JSObject element);
}
