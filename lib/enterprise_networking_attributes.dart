// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'enterprise.dart';
import 'src/internal_helpers.dart';
import 'src/js/enterprise_networking_attributes.dart' as $js;

export 'enterprise.dart' show ChromeEnterprise, ChromeEnterpriseExtension;
export 'src/chrome.dart' show chrome;

final _enterpriseNetworkingAttributes =
    ChromeEnterpriseNetworkingAttributes._();

extension ChromeEnterpriseNetworkingAttributesExtension on ChromeEnterprise {
  /// Use the `chrome.enterprise.networkingAttributes` API to read
  /// information about your current network.
  /// Note: This API is only available to extensions force-installed by
  /// enterprise
  /// policy.
  ChromeEnterpriseNetworkingAttributes get networkingAttributes =>
      _enterpriseNetworkingAttributes;
}

class ChromeEnterpriseNetworkingAttributes {
  ChromeEnterpriseNetworkingAttributes._();

  bool get isAvailable =>
      $js.chrome.enterpriseNullable?.networkingAttributesNullable != null &&
      alwaysTrue;

  /// Retrieves the network details of the device's default network.
  /// If the user is not affiliated or the device is not connected to a
  /// network, [runtime.lastError] will be set with a failure reason.
  /// |callback| : Called with the device's default network's
  /// [NetworkDetails].
  Future<NetworkDetails> getNetworkDetails() async {
    var $res = await promiseToFuture<$js.NetworkDetails>(
        $js.chrome.enterprise.networkingAttributes.getNetworkDetails());
    return NetworkDetails.fromJS($res);
  }
}

class NetworkDetails {
  NetworkDetails.fromJS(this._wrapped);

  NetworkDetails({
    /// The device's MAC address.
    required String macAddress,

    /// The device's local IPv4 address (undefined if not configured).
    String? ipv4,

    /// The device's local IPv6 address (undefined if not configured).
    String? ipv6,
  }) : _wrapped = $js.NetworkDetails(
          macAddress: macAddress,
          ipv4: ipv4,
          ipv6: ipv6,
        );

  final $js.NetworkDetails _wrapped;

  $js.NetworkDetails get toJS => _wrapped;

  /// The device's MAC address.
  String get macAddress => _wrapped.macAddress;
  set macAddress(String v) {
    _wrapped.macAddress = v;
  }

  /// The device's local IPv4 address (undefined if not configured).
  String? get ipv4 => _wrapped.ipv4;
  set ipv4(String? v) {
    _wrapped.ipv4 = v;
  }

  /// The device's local IPv6 address (undefined if not configured).
  String? get ipv6 => _wrapped.ipv6;
  set ipv6(String? v) {
    _wrapped.ipv6 = v;
  }
}
