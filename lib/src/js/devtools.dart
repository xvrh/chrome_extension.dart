import 'dart:js_interop';
import 'chrome.dart';

extension JSChromeDevtoolsExtension on JSChrome {
  @JS('devtools')
  external JSChromeDevtools? get devtoolsNullable;
  JSChromeDevtools get devtools {
    var devtoolsNullable = this.devtoolsNullable;
    if (devtoolsNullable == null) {
      throw ApiNotAvailableException('chrome.devtools');
    }
    return devtoolsNullable;
  }
}

@JS()
@staticInterop
class JSChromeDevtools {}
