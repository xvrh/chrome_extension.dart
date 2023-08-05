// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'enterprise.dart';
import 'src/internal_helpers.dart';
import 'src/js/enterprise_hardware_platform.dart' as $js;

export 'enterprise.dart' show ChromeEnterprise, ChromeEnterpriseExtension;
export 'src/chrome.dart' show chrome;

final _enterpriseHardwarePlatform = ChromeEnterpriseHardwarePlatform._();

extension ChromeEnterpriseHardwarePlatformExtension on ChromeEnterprise {
  /// Use the `chrome.enterprise.hardwarePlatform` API to get the
  /// manufacturer and model of the hardware platform where the browser runs.
  /// Note: This API is only available to extensions installed by enterprise
  /// policy.
  ChromeEnterpriseHardwarePlatform get hardwarePlatform =>
      _enterpriseHardwarePlatform;
}

class ChromeEnterpriseHardwarePlatform {
  ChromeEnterpriseHardwarePlatform._();

  bool get isAvailable =>
      $js.chrome.enterpriseNullable?.hardwarePlatformNullable != null &&
      alwaysTrue;

  /// Obtains the manufacturer and model for the hardware platform and, if
  /// the extension is authorized, returns it via |callback|.
  /// |callback|: Called with the hardware platform info.
  Future<HardwarePlatformInfo> getHardwarePlatformInfo() async {
    var $res = await promiseToFuture<$js.HardwarePlatformInfo>(
        $js.chrome.enterprise.hardwarePlatform.getHardwarePlatformInfo());
    return HardwarePlatformInfo.fromJS($res);
  }
}

class HardwarePlatformInfo {
  HardwarePlatformInfo.fromJS(this._wrapped);

  HardwarePlatformInfo({
    required String model,
    required String manufacturer,
  }) : _wrapped = $js.HardwarePlatformInfo(
          model: model,
          manufacturer: manufacturer,
        );

  final $js.HardwarePlatformInfo _wrapped;

  $js.HardwarePlatformInfo get toJS => _wrapped;

  String get model => _wrapped.model;
  set model(String v) {
    _wrapped.model = v;
  }

  String get manufacturer => _wrapped.manufacturer;
  set manufacturer(String v) {
    _wrapped.manufacturer = v;
  }
}
