// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'system.dart';

export 'chrome.dart';
export 'system.dart';

extension JSChromeJSSystemNetworkExtension on JSChromeSystem {
  @JS('network')
  external JSSystemNetwork? get networkNullable;

  /// Use the `chrome.system.network` API.
  JSSystemNetwork get network {
    var networkNullable = this.networkNullable;
    if (networkNullable == null) {
      throw ApiNotAvailableException('chrome.system.network');
    }
    return networkNullable;
  }
}

@JS()
@staticInterop
class JSSystemNetwork {}

extension JSSystemNetworkExtension on JSSystemNetwork {
  /// Retrieves information about local adapters on this system.
  /// |callback| : Called when local adapter information is available.
  external JSPromise getNetworkInterfaces();
}

@JS()
@staticInterop
@anonymous
class NetworkInterface {
  external factory NetworkInterface({
    /// The underlying name of the adapter. On *nix, this will typically be
    /// "eth0", "wlan0", etc.
    String name,

    /// The available IPv4/6 address.
    String address,

    /// The prefix length
    int prefixLength,
  });
}

extension NetworkInterfaceExtension on NetworkInterface {
  /// The underlying name of the adapter. On *nix, this will typically be
  /// "eth0", "wlan0", etc.
  external String name;

  /// The available IPv4/6 address.
  external String address;

  /// The prefix length
  external int prefixLength;
}
