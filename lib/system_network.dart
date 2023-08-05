// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/system_network.dart' as $js;
import 'system.dart';

export 'src/chrome.dart' show chrome;
export 'system.dart' show ChromeSystem, ChromeSystemExtension;

final _systemNetwork = ChromeSystemNetwork._();

extension ChromeSystemNetworkExtension on ChromeSystem {
  /// Use the `chrome.system.network` API.
  ChromeSystemNetwork get network => _systemNetwork;
}

class ChromeSystemNetwork {
  ChromeSystemNetwork._();

  bool get isAvailable =>
      $js.chrome.systemNullable?.networkNullable != null && alwaysTrue;

  /// Retrieves information about local adapters on this system.
  /// |callback| : Called when local adapter information is available.
  Future<List<NetworkInterface>> getNetworkInterfaces() async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.system.network.getNetworkInterfaces());
    return $res.toDart
        .cast<$js.NetworkInterface>()
        .map((e) => NetworkInterface.fromJS(e))
        .toList();
  }
}

class NetworkInterface {
  NetworkInterface.fromJS(this._wrapped);

  NetworkInterface({
    /// The underlying name of the adapter. On *nix, this will typically be
    /// "eth0", "wlan0", etc.
    required String name,

    /// The available IPv4/6 address.
    required String address,

    /// The prefix length
    required int prefixLength,
  }) : _wrapped = $js.NetworkInterface(
          name: name,
          address: address,
          prefixLength: prefixLength,
        );

  final $js.NetworkInterface _wrapped;

  $js.NetworkInterface get toJS => _wrapped;

  /// The underlying name of the adapter. On *nix, this will typically be
  /// "eth0", "wlan0", etc.
  String get name => _wrapped.name;
  set name(String v) {
    _wrapped.name = v;
  }

  /// The available IPv4/6 address.
  String get address => _wrapped.address;
  set address(String v) {
    _wrapped.address = v;
  }

  /// The prefix length
  int get prefixLength => _wrapped.prefixLength;
  set prefixLength(int v) {
    _wrapped.prefixLength = v;
  }
}
