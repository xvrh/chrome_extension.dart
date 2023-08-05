import 'dart:js_interop';
import 'chrome.dart';

extension JSChromeSystemExtension on JSChrome {
  @JS('system')
  external JSChromeSystem? get systemNullable;
  JSChromeSystem get system {
    var systemNullable = this.systemNullable;
    if (systemNullable == null) {
      throw ApiNotAvailableException('chrome.system');
    }
    return systemNullable;
  }
}

@JS()
@staticInterop
class JSChromeSystem {}
