// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'src/internal_helpers.dart';
import 'src/js/system_network.dart' as $js;
import 'system.dart';

export 'src/chrome.dart' show chrome, EventStream;
export 'system.dart' show ChromeSystem, ChromeSystemExtension;

final _systemNetwork = ChromeSystemNetwork._();

extension ChromeSystemNetworkExtension on ChromeSystem {
  /// Use the `system.network` API to query network interfaces.
  ChromeSystemNetwork get network => _systemNetwork;
}

class ChromeSystemNetwork {
  ChromeSystemNetwork._();

  bool get isAvailable =>
      $js.chrome.systemNullable?.networkNullable != null && alwaysTrue;

  /// Retrieves information about local adapters on this system.
  ///
  /// |callback| : Called when local adapter information is available.
  Future<List<NetworkInterface>> getNetworkInterfaces() async {
    var $res = await $js.chrome.system.network.getNetworkInterfaces().toDart;

    // Handle the response properly regardless of its type
    final dartRes = $res.dartify();
    final dartified = dartRes is List ? dartRes : [];

    // Convert each element to a NetworkInterface using Map data
    return dartified.map<NetworkInterface>((e) {
      if (e is Map) {
        // Create NetworkInterface from Map data
        return NetworkInterface(
          name: e['name'] as String? ?? '',
          address: e['address'] as String? ?? '',
          prefixLength: (e['prefixLength'] as num?)?.toInt() ?? 0,
        );
      } else {
        // Fallback for unexpected types
        return NetworkInterface(name: '', address: '', prefixLength: 0);
      }
    }).toList();
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
