// ignore_for_file: unnecessary_parenthesis

library;

import 'src/internal_helpers.dart';
import 'src/js/proxy.dart' as $js;
import 'types.dart';

export 'src/chrome.dart' show chrome;

final _proxy = ChromeProxy._();

extension ChromeProxyExtension on Chrome {
  /// Use the `chrome.proxy` API to manage Chrome's proxy settings. This API
  /// relies on the [ChromeSetting prototype of the type
  /// API](types#ChromeSetting) for getting and setting the proxy configuration.
  ChromeProxy get proxy => _proxy;
}

class ChromeProxy {
  ChromeProxy._();

  bool get isAvailable => $js.chrome.proxyNullable != null && alwaysTrue;

  /// Proxy settings to be used. The value of this setting is a ProxyConfig
  /// object.
  ChromeSetting get settings => ChromeSetting.fromJS($js.chrome.proxy.settings);

  /// Notifies about proxy errors.
  EventStream<OnProxyErrorDetails> get onProxyError =>
      $js.chrome.proxy.onProxyError
          .asStream(($c) => ($js.OnProxyErrorDetails details) {
                return $c(OnProxyErrorDetails.fromJS(details));
              });
}

enum Scheme {
  http('http'),
  https('https'),
  quic('quic'),
  socks4('socks4'),
  socks5('socks5');

  const Scheme(this.value);

  final String value;

  String get toJS => value;
  static Scheme fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum Mode {
  direct('direct'),
  autoDetect('auto_detect'),
  pacScript('pac_script'),
  fixedServers('fixed_servers'),
  system('system');

  const Mode(this.value);

  final String value;

  String get toJS => value;
  static Mode fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class ProxyServer {
  ProxyServer.fromJS(this._wrapped);

  ProxyServer({
    /// The scheme (protocol) of the proxy server itself. Defaults to 'http'.
    Scheme? scheme,

    /// The hostname or IP address of the proxy server. Hostnames must be in
    /// ASCII (in Punycode format). IDNA is not supported, yet.
    required String host,

    /// The port of the proxy server. Defaults to a port that depends on the
    /// scheme.
    int? port,
  }) : _wrapped = $js.ProxyServer(
          scheme: scheme?.toJS,
          host: host,
          port: port,
        );

  final $js.ProxyServer _wrapped;

  $js.ProxyServer get toJS => _wrapped;

  /// The scheme (protocol) of the proxy server itself. Defaults to 'http'.
  Scheme? get scheme => _wrapped.scheme?.let(Scheme.fromJS);
  set scheme(Scheme? v) {
    _wrapped.scheme = v?.toJS;
  }

  /// The hostname or IP address of the proxy server. Hostnames must be in ASCII
  /// (in Punycode format). IDNA is not supported, yet.
  String get host => _wrapped.host;
  set host(String v) {
    _wrapped.host = v;
  }

  /// The port of the proxy server. Defaults to a port that depends on the
  /// scheme.
  int? get port => _wrapped.port;
  set port(int? v) {
    _wrapped.port = v;
  }
}

class ProxyRules {
  ProxyRules.fromJS(this._wrapped);

  ProxyRules({
    /// The proxy server to be used for all per-URL requests (that is http,
    /// https, and ftp).
    ProxyServer? singleProxy,

    /// The proxy server to be used for HTTP requests.
    ProxyServer? proxyForHttp,

    /// The proxy server to be used for HTTPS requests.
    ProxyServer? proxyForHttps,

    /// The proxy server to be used for FTP requests.
    ProxyServer? proxyForFtp,

    /// The proxy server to be used for everthing else or if any of the specific
    /// proxyFor... is not specified.
    ProxyServer? fallbackProxy,

    /// List of servers to connect to without a proxy server.
    List<String>? bypassList,
  }) : _wrapped = $js.ProxyRules(
          singleProxy: singleProxy?.toJS,
          proxyForHttp: proxyForHttp?.toJS,
          proxyForHttps: proxyForHttps?.toJS,
          proxyForFtp: proxyForFtp?.toJS,
          fallbackProxy: fallbackProxy?.toJS,
          bypassList: bypassList?.toJSArray((e) => e),
        );

  final $js.ProxyRules _wrapped;

  $js.ProxyRules get toJS => _wrapped;

  /// The proxy server to be used for all per-URL requests (that is http, https,
  /// and ftp).
  ProxyServer? get singleProxy => _wrapped.singleProxy?.let(ProxyServer.fromJS);
  set singleProxy(ProxyServer? v) {
    _wrapped.singleProxy = v?.toJS;
  }

  /// The proxy server to be used for HTTP requests.
  ProxyServer? get proxyForHttp =>
      _wrapped.proxyForHttp?.let(ProxyServer.fromJS);
  set proxyForHttp(ProxyServer? v) {
    _wrapped.proxyForHttp = v?.toJS;
  }

  /// The proxy server to be used for HTTPS requests.
  ProxyServer? get proxyForHttps =>
      _wrapped.proxyForHttps?.let(ProxyServer.fromJS);
  set proxyForHttps(ProxyServer? v) {
    _wrapped.proxyForHttps = v?.toJS;
  }

  /// The proxy server to be used for FTP requests.
  ProxyServer? get proxyForFtp => _wrapped.proxyForFtp?.let(ProxyServer.fromJS);
  set proxyForFtp(ProxyServer? v) {
    _wrapped.proxyForFtp = v?.toJS;
  }

  /// The proxy server to be used for everthing else or if any of the specific
  /// proxyFor... is not specified.
  ProxyServer? get fallbackProxy =>
      _wrapped.fallbackProxy?.let(ProxyServer.fromJS);
  set fallbackProxy(ProxyServer? v) {
    _wrapped.fallbackProxy = v?.toJS;
  }

  /// List of servers to connect to without a proxy server.
  List<String>? get bypassList =>
      _wrapped.bypassList?.toDart.cast<String>().map((e) => e).toList();
  set bypassList(List<String>? v) {
    _wrapped.bypassList = v?.toJSArray((e) => e);
  }
}

class PacScript {
  PacScript.fromJS(this._wrapped);

  PacScript({
    /// URL of the PAC file to be used.
    String? url,

    /// A PAC script.
    String? data,

    /// If true, an invalid PAC script will prevent the network stack from
    /// falling back to direct connections. Defaults to false.
    bool? mandatory,
  }) : _wrapped = $js.PacScript(
          url: url,
          data: data,
          mandatory: mandatory,
        );

  final $js.PacScript _wrapped;

  $js.PacScript get toJS => _wrapped;

  /// URL of the PAC file to be used.
  String? get url => _wrapped.url;
  set url(String? v) {
    _wrapped.url = v;
  }

  /// A PAC script.
  String? get data => _wrapped.data;
  set data(String? v) {
    _wrapped.data = v;
  }

  /// If true, an invalid PAC script will prevent the network stack from falling
  /// back to direct connections. Defaults to false.
  bool? get mandatory => _wrapped.mandatory;
  set mandatory(bool? v) {
    _wrapped.mandatory = v;
  }
}

class ProxyConfig {
  ProxyConfig.fromJS(this._wrapped);

  ProxyConfig({
    /// The proxy rules describing this configuration. Use this for
    /// 'fixed_servers' mode.
    ProxyRules? rules,

    /// The proxy auto-config (PAC) script for this configuration. Use this for
    /// 'pac_script' mode.
    PacScript? pacScript,

    /// 'direct' = Never use a proxy
    /// 'auto_detect' = Auto detect proxy settings
    /// 'pac_script' = Use specified PAC script
    /// 'fixed_servers' = Manually specify proxy servers
    /// 'system' = Use system proxy settings
    required Mode mode,
  }) : _wrapped = $js.ProxyConfig(
          rules: rules?.toJS,
          pacScript: pacScript?.toJS,
          mode: mode.toJS,
        );

  final $js.ProxyConfig _wrapped;

  $js.ProxyConfig get toJS => _wrapped;

  /// The proxy rules describing this configuration. Use this for
  /// 'fixed_servers' mode.
  ProxyRules? get rules => _wrapped.rules?.let(ProxyRules.fromJS);
  set rules(ProxyRules? v) {
    _wrapped.rules = v?.toJS;
  }

  /// The proxy auto-config (PAC) script for this configuration. Use this for
  /// 'pac_script' mode.
  PacScript? get pacScript => _wrapped.pacScript?.let(PacScript.fromJS);
  set pacScript(PacScript? v) {
    _wrapped.pacScript = v?.toJS;
  }

  /// 'direct' = Never use a proxy
  /// 'auto_detect' = Auto detect proxy settings
  /// 'pac_script' = Use specified PAC script
  /// 'fixed_servers' = Manually specify proxy servers
  /// 'system' = Use system proxy settings
  Mode get mode => Mode.fromJS(_wrapped.mode);
  set mode(Mode v) {
    _wrapped.mode = v.toJS;
  }
}

class OnProxyErrorDetails {
  OnProxyErrorDetails.fromJS(this._wrapped);

  OnProxyErrorDetails({
    /// If true, the error was fatal and the network transaction was aborted.
    /// Otherwise, a direct connection is used instead.
    required bool fatal,

    /// The error description.
    required String error,

    /// Additional details about the error such as a JavaScript runtime error.
    required String details,
  }) : _wrapped = $js.OnProxyErrorDetails(
          fatal: fatal,
          error: error,
          details: details,
        );

  final $js.OnProxyErrorDetails _wrapped;

  $js.OnProxyErrorDetails get toJS => _wrapped;

  /// If true, the error was fatal and the network transaction was aborted.
  /// Otherwise, a direct connection is used instead.
  bool get fatal => _wrapped.fatal;
  set fatal(bool v) {
    _wrapped.fatal = v;
  }

  /// The error description.
  String get error => _wrapped.error;
  set error(String v) {
    _wrapped.error = v;
  }

  /// Additional details about the error such as a JavaScript runtime error.
  String get details => _wrapped.details;
  set details(String v) {
    _wrapped.details = v;
  }
}
