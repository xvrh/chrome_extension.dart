// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'dart:typed_data';
import 'src/internal_helpers.dart';
import 'src/js/vpn_provider.dart' as $js;

export 'src/chrome.dart' show chrome;

final _vpnProvider = ChromeVpnProvider._();

extension ChromeVpnProviderExtension on Chrome {
  /// Use the `chrome.vpnProvider` API to implement a VPN
  /// client.
  ChromeVpnProvider get vpnProvider => _vpnProvider;
}

class ChromeVpnProvider {
  ChromeVpnProvider._();

  bool get isAvailable => $js.chrome.vpnProviderNullable != null && alwaysTrue;

  /// Creates a new VPN configuration that persists across multiple login
  /// sessions of the user.
  /// |name|: The name of the VPN configuration.
  /// |callback|: Called when the configuration is created or if there is an
  /// error.
  Future<String> createConfig(String name) async {
    var $res = await promiseToFuture<String>(
        $js.chrome.vpnProvider.createConfig(name));
    return $res;
  }

  /// Destroys a VPN configuration created by the extension.
  /// |id|: ID of the VPN configuration to destroy.
  /// |callback|: Called when the configuration is destroyed or if there is an
  /// error.
  Future<void> destroyConfig(String id) async {
    await promiseToFuture<void>($js.chrome.vpnProvider.destroyConfig(id));
  }

  /// Sets the parameters for the VPN session. This should be called
  /// immediately after `"connected"` is received from the platform.
  /// This will succeed only when the VPN session is owned by the extension.
  /// |parameters|: The parameters for the VPN session.
  /// |callback|: Called when the parameters are set or if there is an error.
  Future<void> setParameters(Parameters parameters) async {
    await promiseToFuture<void>(
        $js.chrome.vpnProvider.setParameters(parameters.toJS));
  }

  /// Sends an IP packet through the tunnel created for the VPN session.
  /// This will succeed only when the VPN session is owned by the extension.
  /// |data|: The IP packet to be sent to the platform.
  /// |callback|: Called when the packet is sent or if there is an error.
  Future<void> sendPacket(ByteBuffer data) async {
    await promiseToFuture<void>($js.chrome.vpnProvider.sendPacket(data.toJS));
  }

  /// Notifies the VPN session state to the platform.
  /// This will succeed only when the VPN session is owned by the extension.
  /// |state|: The VPN session state of the VPN client.
  /// |callback|: Called when the notification is complete or if there is an
  /// error.
  Future<void> notifyConnectionStateChanged(VpnConnectionState state) async {
    await promiseToFuture<void>(
        $js.chrome.vpnProvider.notifyConnectionStateChanged(state.toJS));
  }

  /// Triggered when a message is received from the platform for a
  /// VPN configuration owned by the extension.
  /// |id|: ID of the configuration the message is intended for.
  /// |message|: The message received from the platform.  Note that new
  /// message types may be added in future Chrome versions to support new
  /// features.
  /// |error|: Error message when there is an error.
  EventStream<OnPlatformMessageEvent> get onPlatformMessage =>
      $js.chrome.vpnProvider.onPlatformMessage.asStream(($c) => (
            String id,
            $js.PlatformMessage message,
            String error,
          ) {
            return $c(OnPlatformMessageEvent(
              id: id,
              message: PlatformMessage.fromJS(message),
              error: error,
            ));
          });

  /// Triggered when an IP packet is received via the tunnel for the VPN
  /// session owned by the extension.
  /// |data|: The IP packet received from the platform.
  EventStream<ByteBuffer> get onPacketReceived =>
      $js.chrome.vpnProvider.onPacketReceived
          .asStream(($c) => (JSArrayBuffer data) {
                return $c(data.toDart);
              });

  /// Triggered when a configuration created by the extension is removed by the
  /// platform.
  /// |id|: ID of the removed configuration.
  EventStream<String> get onConfigRemoved =>
      $js.chrome.vpnProvider.onConfigRemoved.asStream(($c) => (String id) {
            return $c(id);
          });

  /// Triggered when a configuration is created by the platform for the
  /// extension.
  /// |id|: ID of the configuration created.
  /// |name|: Name of the configuration created.
  /// |data|: Configuration data provided by the administrator.
  EventStream<OnConfigCreatedEvent> get onConfigCreated =>
      $js.chrome.vpnProvider.onConfigCreated.asStream(($c) => (
            String id,
            String name,
            JSAny data,
          ) {
            return $c(OnConfigCreatedEvent(
              id: id,
              name: name,
              data: data.toDartMap(),
            ));
          });

  /// Triggered when there is a UI event for the extension. UI events are
  /// signals from the platform that indicate to the app that a UI dialog
  /// needs to be shown to the user.
  /// |event|: The UI event that is triggered.
  /// |id|: ID of the configuration for which the UI event was triggered.
  EventStream<OnUIEventEvent> get onUIEvent =>
      $js.chrome.vpnProvider.onUIEvent.asStream(($c) => (
            $js.UIEvent event,
            String? id,
          ) {
            return $c(OnUIEventEvent(
              event: UIEvent.fromJS(event),
              id: id,
            ));
          });
}

/// The enum is used by the platform to notify the client of the VPN session
/// status.
enum PlatformMessage {
  /// VPN configuration connected.
  connected('connected'),

  /// VPN configuration disconnected.
  disconnected('disconnected'),

  /// An error occurred in VPN connection, for example a timeout. A description
  /// of the error is given as the <a href="#property-onPlatformMessage-error">
  /// error argument to onPlatformMessage</a>.
  error('error'),

  /// The default physical network connection is down.
  linkDown('linkDown'),

  /// The default physical network connection is back up.
  linkUp('linkUp'),

  /// The default physical network connection changed, e.g. wifi->mobile.
  linkChanged('linkChanged'),

  /// The OS is preparing to suspend, so the VPN should drop its connection.
  /// The extension is not guaranteed to receive this event prior to
  /// suspending.
  suspend('suspend'),

  /// The OS has resumed and the user has logged back in, so the VPN should
  /// try to reconnect.
  resume('resume');

  const PlatformMessage(this.value);

  final String value;

  String get toJS => value;
  static PlatformMessage fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The enum is used by the VPN client to inform the platform
/// of its current state. This helps provide meaningful messages
/// to the user.
enum VpnConnectionState {
  /// VPN connection was successful.
  connected('connected'),

  /// VPN connection failed.
  failure('failure');

  const VpnConnectionState(this.value);

  final String value;

  String get toJS => value;
  static VpnConnectionState fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The enum is used by the platform to indicate the event that triggered
/// `onUIEvent`.
enum UIEvent {
  /// Request the VPN client to show add configuration dialog to the user.
  showAddDialog('showAddDialog'),

  /// Request the VPN client to show configuration settings dialog to the user.
  showConfigureDialog('showConfigureDialog');

  const UIEvent(this.value);

  final String value;

  String get toJS => value;
  static UIEvent fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class Parameters {
  Parameters.fromJS(this._wrapped);

  Parameters({
    /// IP address for the VPN interface in CIDR notation.
    /// IPv4 is currently the only supported mode.
    required String address,

    /// Broadcast address for the VPN interface. (default: deduced
    /// from IP address and mask)
    String? broadcastAddress,

    /// MTU setting for the VPN interface. (default: 1500 bytes)
    String? mtu,

    /// Exclude network traffic to the list of IP blocks in CIDR notation from
    /// the tunnel. This can be used to bypass traffic to and from the VPN
    /// server.
    /// When many rules match a destination, the rule with the longest matching
    /// prefix wins.
    /// Entries that correspond to the same CIDR block are treated as
    /// duplicates.
    /// Such duplicates in the collated (exclusionList + inclusionList) list are
    /// eliminated and the exact duplicate entry that will be eliminated is
    /// undefined.
    required List<String> exclusionList,

    /// Include network traffic to the list of IP blocks in CIDR notation to the
    /// tunnel. This parameter can be used to set up a split tunnel. By default
    /// no traffic is directed to the tunnel. Adding the entry "0.0.0.0/0" to
    /// this list gets all the user traffic redirected to the tunnel.
    /// When many rules match a destination, the rule with the longest matching
    /// prefix wins.
    /// Entries that correspond to the same CIDR block are treated as
    /// duplicates.
    /// Such duplicates in the collated (exclusionList + inclusionList) list are
    /// eliminated and the exact duplicate entry that will be eliminated is
    /// undefined.
    required List<String> inclusionList,

    /// A list of search domains. (default: no search domain)
    List<String>? domainSearch,

    /// A list of IPs for the DNS servers.
    required List<String> dnsServers,

    /// Whether or not the VPN extension implements auto-reconnection.
    ///
    /// If true, the `linkDown`, `linkUp`,
    /// `linkChanged`, `suspend`, and `resume`
    /// platform messages will be used to signal the respective events.
    /// If false, the system will forcibly disconnect the VPN if the network
    /// topology changes, and the user will need to reconnect manually.
    /// (default: false)
    ///
    /// This property is new in Chrome 51; it will generate an exception in
    /// earlier versions. try/catch can be used to conditionally enable the
    /// feature based on browser support.
    String? reconnect,
  }) : _wrapped = $js.Parameters(
          address: address,
          broadcastAddress: broadcastAddress,
          mtu: mtu,
          exclusionList: exclusionList.toJSArray((e) => e),
          inclusionList: inclusionList.toJSArray((e) => e),
          domainSearch: domainSearch?.toJSArray((e) => e),
          dnsServers: dnsServers.toJSArray((e) => e),
          reconnect: reconnect,
        );

  final $js.Parameters _wrapped;

  $js.Parameters get toJS => _wrapped;

  /// IP address for the VPN interface in CIDR notation.
  /// IPv4 is currently the only supported mode.
  String get address => _wrapped.address;
  set address(String v) {
    _wrapped.address = v;
  }

  /// Broadcast address for the VPN interface. (default: deduced
  /// from IP address and mask)
  String? get broadcastAddress => _wrapped.broadcastAddress;
  set broadcastAddress(String? v) {
    _wrapped.broadcastAddress = v;
  }

  /// MTU setting for the VPN interface. (default: 1500 bytes)
  String? get mtu => _wrapped.mtu;
  set mtu(String? v) {
    _wrapped.mtu = v;
  }

  /// Exclude network traffic to the list of IP blocks in CIDR notation from
  /// the tunnel. This can be used to bypass traffic to and from the VPN
  /// server.
  /// When many rules match a destination, the rule with the longest matching
  /// prefix wins.
  /// Entries that correspond to the same CIDR block are treated as duplicates.
  /// Such duplicates in the collated (exclusionList + inclusionList) list are
  /// eliminated and the exact duplicate entry that will be eliminated is
  /// undefined.
  List<String> get exclusionList =>
      _wrapped.exclusionList.toDart.cast<String>().map((e) => e).toList();
  set exclusionList(List<String> v) {
    _wrapped.exclusionList = v.toJSArray((e) => e);
  }

  /// Include network traffic to the list of IP blocks in CIDR notation to the
  /// tunnel. This parameter can be used to set up a split tunnel. By default
  /// no traffic is directed to the tunnel. Adding the entry "0.0.0.0/0" to
  /// this list gets all the user traffic redirected to the tunnel.
  /// When many rules match a destination, the rule with the longest matching
  /// prefix wins.
  /// Entries that correspond to the same CIDR block are treated as duplicates.
  /// Such duplicates in the collated (exclusionList + inclusionList) list are
  /// eliminated and the exact duplicate entry that will be eliminated is
  /// undefined.
  List<String> get inclusionList =>
      _wrapped.inclusionList.toDart.cast<String>().map((e) => e).toList();
  set inclusionList(List<String> v) {
    _wrapped.inclusionList = v.toJSArray((e) => e);
  }

  /// A list of search domains. (default: no search domain)
  List<String>? get domainSearch =>
      _wrapped.domainSearch?.toDart.cast<String>().map((e) => e).toList();
  set domainSearch(List<String>? v) {
    _wrapped.domainSearch = v?.toJSArray((e) => e);
  }

  /// A list of IPs for the DNS servers.
  List<String> get dnsServers =>
      _wrapped.dnsServers.toDart.cast<String>().map((e) => e).toList();
  set dnsServers(List<String> v) {
    _wrapped.dnsServers = v.toJSArray((e) => e);
  }

  /// Whether or not the VPN extension implements auto-reconnection.
  ///
  /// If true, the `linkDown`, `linkUp`,
  /// `linkChanged`, `suspend`, and `resume`
  /// platform messages will be used to signal the respective events.
  /// If false, the system will forcibly disconnect the VPN if the network
  /// topology changes, and the user will need to reconnect manually.
  /// (default: false)
  ///
  /// This property is new in Chrome 51; it will generate an exception in
  /// earlier versions. try/catch can be used to conditionally enable the
  /// feature based on browser support.
  String? get reconnect => _wrapped.reconnect;
  set reconnect(String? v) {
    _wrapped.reconnect = v;
  }
}

class OnPlatformMessageEvent {
  OnPlatformMessageEvent({
    required this.id,
    required this.message,
    required this.error,
  });

  final String id;

  final PlatformMessage message;

  final String error;
}

class OnConfigCreatedEvent {
  OnConfigCreatedEvent({
    required this.id,
    required this.name,
    required this.data,
  });

  final String id;

  final String name;

  final Map data;
}

class OnUIEventEvent {
  OnUIEventEvent({
    required this.event,
    required this.id,
  });

  final UIEvent event;

  final String? id;
}
