// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'enterprise.dart';

export 'chrome.dart';
export 'enterprise.dart';

extension JSChromeJSEnterpriseHardwarePlatformExtension on JSChromeEnterprise {
  @JS('hardwarePlatform')
  external JSEnterpriseHardwarePlatform? get hardwarePlatformNullable;

  /// Use the `chrome.enterprise.hardwarePlatform` API to get the
  /// manufacturer and model of the hardware platform where the browser runs.
  /// Note: This API is only available to extensions installed by enterprise
  /// policy.
  JSEnterpriseHardwarePlatform get hardwarePlatform {
    var hardwarePlatformNullable = this.hardwarePlatformNullable;
    if (hardwarePlatformNullable == null) {
      throw ApiNotAvailableException('chrome.enterprise.hardwarePlatform');
    }
    return hardwarePlatformNullable;
  }
}

@JS()
@staticInterop
class JSEnterpriseHardwarePlatform {}

extension JSEnterpriseHardwarePlatformExtension
    on JSEnterpriseHardwarePlatform {
  /// Obtains the manufacturer and model for the hardware platform and, if
  /// the extension is authorized, returns it via |callback|.
  /// |callback|: Called with the hardware platform info.
  external JSPromise getHardwarePlatformInfo();
}

@JS()
@staticInterop
@anonymous
class HardwarePlatformInfo {
  external factory HardwarePlatformInfo({
    String model,
    String manufacturer,
  });
}

extension HardwarePlatformInfoExtension on HardwarePlatformInfo {
  external String model;

  external String manufacturer;
}
