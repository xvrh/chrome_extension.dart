import 'dart:js_interop';
import 'chrome.dart';

extension JSChromeEnterpriseExtension on JSChrome {
  @JS('enterprise')
  external JSChromeEnterprise? get enterpriseNullable;
  JSChromeEnterprise get enterprise {
    var enterpriseNullable = this.enterpriseNullable;
    if (enterpriseNullable == null) {
      throw ApiNotAvailableException('chrome.enterprise');
    }
    return enterpriseNullable;
  }
}

@JS()
@staticInterop
class JSChromeEnterprise {}
