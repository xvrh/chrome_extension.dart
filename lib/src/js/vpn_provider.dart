// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSVpnProviderExtension on JSChrome {
  @JS('vpnProvider')
  external JSVpnProvider? get vpnProviderNullable;

  /// Use the `chrome.vpnProvider` API to implement a VPN
  /// client.
  JSVpnProvider get vpnProvider {
    var vpnProviderNullable = this.vpnProviderNullable;
    if (vpnProviderNullable == null) {
      throw ApiNotAvailableException('chrome.vpnProvider');
    }
    return vpnProviderNullable;
  }
}

@JS()
@staticInterop
class JSVpnProvider {}

extension JSVpnProviderExtension on JSVpnProvider {
  /// Creates a new VPN configuration that persists across multiple login
  /// sessions of the user.
  /// |name|: The name of the VPN configuration.
  /// |callback|: Called when the configuration is created or if there is an
  /// error.
  external JSPromise createConfig(String name);

  /// Destroys a VPN configuration created by the extension.
  /// |id|: ID of the VPN configuration to destroy.
  /// |callback|: Called when the configuration is destroyed or if there is an
  /// error.
  external JSPromise destroyConfig(String id);

  /// Sets the parameters for the VPN session. This should be called
  /// immediately after `"connected"` is received from the platform.
  /// This will succeed only when the VPN session is owned by the extension.
  /// |parameters|: The parameters for the VPN session.
  /// |callback|: Called when the parameters are set or if there is an error.
  external JSPromise setParameters(Parameters parameters);

  /// Sends an IP packet through the tunnel created for the VPN session.
  /// This will succeed only when the VPN session is owned by the extension.
  /// |data|: The IP packet to be sent to the platform.
  /// |callback|: Called when the packet is sent or if there is an error.
  external JSPromise sendPacket(JSArrayBuffer data);

  /// Notifies the VPN session state to the platform.
  /// This will succeed only when the VPN session is owned by the extension.
  /// |state|: The VPN session state of the VPN client.
  /// |callback|: Called when the notification is complete or if there is an
  /// error.
  external JSPromise notifyConnectionStateChanged(VpnConnectionState state);

  /// Triggered when a message is received from the platform for a
  /// VPN configuration owned by the extension.
  /// |id|: ID of the configuration the message is intended for.
  /// |message|: The message received from the platform.  Note that new
  /// message types may be added in future Chrome versions to support new
  /// features.
  /// |error|: Error message when there is an error.
  external Event get onPlatformMessage;

  /// Triggered when an IP packet is received via the tunnel for the VPN
  /// session owned by the extension.
  /// |data|: The IP packet received from the platform.
  external Event get onPacketReceived;

  /// Triggered when a configuration created by the extension is removed by the
  /// platform.
  /// |id|: ID of the removed configuration.
  external Event get onConfigRemoved;

  /// Triggered when a configuration is created by the platform for the
  /// extension.
  /// |id|: ID of the configuration created.
  /// |name|: Name of the configuration created.
  /// |data|: Configuration data provided by the administrator.
  external Event get onConfigCreated;

  /// Triggered when there is a UI event for the extension. UI events are
  /// signals from the platform that indicate to the app that a UI dialog
  /// needs to be shown to the user.
  /// |event|: The UI event that is triggered.
  /// |id|: ID of the configuration for which the UI event was triggered.
  external Event get onUIEvent;
}

/// The enum is used by the platform to notify the client of the VPN session
/// status.
typedef PlatformMessage = String;

/// The enum is used by the VPN client to inform the platform
/// of its current state. This helps provide meaningful messages
/// to the user.
typedef VpnConnectionState = String;

/// The enum is used by the platform to indicate the event that triggered
/// `onUIEvent`.
typedef UIEvent = String;

@JS()
@staticInterop
@anonymous
class Parameters {
  external factory Parameters({
    /// IP address for the VPN interface in CIDR notation.
    /// IPv4 is currently the only supported mode.
    String address,

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
    /// Entries that correspond to the same CIDR block are treated as duplicates.
    /// Such duplicates in the collated (exclusionList + inclusionList) list are
    /// eliminated and the exact duplicate entry that will be eliminated is
    /// undefined.
    JSArray exclusionList,

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
    JSArray inclusionList,

    /// A list of search domains. (default: no search domain)
    JSArray? domainSearch,

    /// A list of IPs for the DNS servers.
    JSArray dnsServers,

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
  });
}

extension ParametersExtension on Parameters {
  /// IP address for the VPN interface in CIDR notation.
  /// IPv4 is currently the only supported mode.
  external String address;

  /// Broadcast address for the VPN interface. (default: deduced
  /// from IP address and mask)
  external String? broadcastAddress;

  /// MTU setting for the VPN interface. (default: 1500 bytes)
  external String? mtu;

  /// Exclude network traffic to the list of IP blocks in CIDR notation from
  /// the tunnel. This can be used to bypass traffic to and from the VPN
  /// server.
  /// When many rules match a destination, the rule with the longest matching
  /// prefix wins.
  /// Entries that correspond to the same CIDR block are treated as duplicates.
  /// Such duplicates in the collated (exclusionList + inclusionList) list are
  /// eliminated and the exact duplicate entry that will be eliminated is
  /// undefined.
  external JSArray exclusionList;

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
  external JSArray inclusionList;

  /// A list of search domains. (default: no search domain)
  external JSArray? domainSearch;

  /// A list of IPs for the DNS servers.
  external JSArray dnsServers;

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
  external String? reconnect;
}
