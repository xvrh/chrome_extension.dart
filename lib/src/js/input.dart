import 'dart:js_interop';
import 'chrome.dart';

extension JSChromeInputExtension on JSChrome {
  @JS('input')
  external JSChromeInput? get inputNullable;
  JSChromeInput get input {
    var inputNullable = this.inputNullable;
    if (inputNullable == null) {
      throw ApiNotAvailableException('chrome.input');
    }
    return inputNullable;
  }
}

@JS()
@staticInterop
class JSChromeInput {}
