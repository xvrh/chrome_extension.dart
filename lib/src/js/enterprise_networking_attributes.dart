// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'enterprise.dart';

export 'chrome.dart';
export 'enterprise.dart';

extension JSChromeJSEnterpriseNetworkingAttributesExtension
    on JSChromeEnterprise {
  @JS('networkingAttributes')
  external JSEnterpriseNetworkingAttributes? get networkingAttributesNullable;

  /// Use the `chrome.enterprise.networkingAttributes` API to read
  /// information about your current network.
  /// Note: This API is only available to extensions force-installed by
  /// enterprise
  /// policy.
  JSEnterpriseNetworkingAttributes get networkingAttributes {
    var networkingAttributesNullable = this.networkingAttributesNullable;
    if (networkingAttributesNullable == null) {
      throw ApiNotAvailableException('chrome.enterprise.networkingAttributes');
    }
    return networkingAttributesNullable;
  }
}

extension type JSEnterpriseNetworkingAttributes._(JSObject _) {
  /// Retrieves the network details of the device's default network.
  /// If the user is not affiliated or the device is not connected to a
  /// network, [runtime.lastError] will be set with a failure reason.
  /// |callback| : Called with the device's default network's
  /// [NetworkDetails].
  external JSPromise getNetworkDetails();
}
extension type NetworkDetails._(JSObject _) implements JSObject {
  external factory NetworkDetails({
    /// The device's MAC address.
    String macAddress,

    /// The device's local IPv4 address (undefined if not configured).
    String? ipv4,

    /// The device's local IPv6 address (undefined if not configured).
    String? ipv6,
  });

  /// The device's MAC address.
  external String macAddress;

  /// The device's local IPv4 address (undefined if not configured).
  external String? ipv4;

  /// The device's local IPv6 address (undefined if not configured).
  external String? ipv6;
}
