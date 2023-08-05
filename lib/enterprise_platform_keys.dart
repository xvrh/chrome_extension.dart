// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:typed_data';
import 'enterprise.dart';
import 'src/internal_helpers.dart';
import 'src/js/enterprise_platform_keys.dart' as $js;

export 'enterprise.dart' show ChromeEnterprise, ChromeEnterpriseExtension;
export 'src/chrome.dart' show chrome;

final _enterprisePlatformKeys = ChromeEnterprisePlatformKeys._();

extension ChromeEnterprisePlatformKeysExtension on ChromeEnterprise {
  /// Use the `chrome.enterprise.platformKeys` API to generate keys and
  /// install certificates for these keys. The certificates will be managed by
  /// the
  /// platform and can be used for TLS authentication, network access or by
  /// other
  /// extension through $(ref:platformKeys chrome.platformKeys).
  ChromeEnterprisePlatformKeys get platformKeys => _enterprisePlatformKeys;
}

class ChromeEnterprisePlatformKeys {
  ChromeEnterprisePlatformKeys._();

  bool get isAvailable =>
      $js.chrome.enterpriseNullable?.platformKeysNullable != null && alwaysTrue;

  /// Returns the available Tokens. In a regular user's session the list will
  /// always contain the user's token with `id` `"user"`.
  /// If a system-wide TPM token is available, the returned list will also
  /// contain the system-wide token with `id` `"system"`.
  /// The system-wide token will be the same for all sessions on this device
  /// (device in the sense of e.g. a Chromebook).
  Future<List<Token>> getTokens() {
    var $completer = Completer<List<Token>>();
    $js.chrome.enterprise.platformKeys.getTokens((JSArray tokens) {
      if (checkRuntimeLastError($completer)) {
        $completer.complete(tokens.toDart
            .cast<$js.Token>()
            .map((e) => Token.fromJS(e))
            .toList());
      }
    }.toJS);
    return $completer.future;
  }

  /// Returns the list of all client certificates available from the given
  /// token. Can be used to check for the existence and expiration of client
  /// certificates that are usable for a certain authentication.
  /// |tokenId|: The id of a Token returned by `getTokens`.
  /// |callback|: Called back with the list of the available certificates.
  Future<List<ByteBuffer>> getCertificates(String tokenId) {
    var $completer = Completer<List<ByteBuffer>>();
    $js.chrome.enterprise.platformKeys.getCertificates(
      tokenId,
      (JSArray certificates) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(certificates.toDart
              .cast<JSArrayBuffer>()
              .map((e) => e.toDart)
              .toList());
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Imports `certificate` to the given token if the certified key
  /// is already stored in this token.
  /// After a successful certification request, this function should be used to
  /// store the obtained certificate and to make it available to the operating
  /// system and browser for authentication.
  /// |tokenId|: The id of a Token returned by `getTokens`.
  /// |certificate|: The DER encoding of a X.509 certificate.
  /// |callback|: Called back when this operation is finished.
  Future<void> importCertificate(
    String tokenId,
    ByteBuffer certificate,
  ) {
    var $completer = Completer<void>();
    $js.chrome.enterprise.platformKeys.importCertificate(
      tokenId,
      certificate.toJS,
      () {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(null);
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Removes `certificate` from the given token if present.
  /// Should be used to remove obsolete certificates so that they are not
  /// considered during authentication and do not clutter the certificate
  /// choice. Should be used to free storage in the certificate store.
  /// |tokenId|: The id of a Token returned by `getTokens`.
  /// |certificate|: The DER encoding of a X.509 certificate.
  /// |callback|: Called back when this operation is finished.
  Future<void> removeCertificate(
    String tokenId,
    ByteBuffer certificate,
  ) {
    var $completer = Completer<void>();
    $js.chrome.enterprise.platformKeys.removeCertificate(
      tokenId,
      certificate.toJS,
      () {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(null);
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Similar to `challengeMachineKey` and
  /// `challengeUserKey`, but allows specifying the algorithm of a
  /// registered key. Challenges a hardware-backed Enterprise Machine Key and
  /// emits the response as part of a remote attestation protocol. Only useful
  /// on Chrome OS and in conjunction with the Verified Access Web API which
  /// both issues challenges and verifies responses.
  ///
  /// A successful verification by the Verified Access Web API is a strong
  /// signal that the current device is a legitimate Chrome OS device, the
  /// current device is managed by the domain specified during verification,
  /// the current signed-in user is managed by the domain specified during
  /// verification, and the current device state complies with enterprise
  /// device policy. For example, a policy may specify that the device must not
  /// be in developer mode.  Any device identity emitted by the verification is
  /// tightly bound to the hardware of the current device. If
  /// `"user"` Scope is specified, the identity is also tighly bound
  /// to the current signed-in user.
  ///
  /// This function is highly restricted and will fail if the current device is
  /// not managed, the current user is not managed, or if this operation has
  /// not explicitly been enabled for the caller by enterprise device policy.
  /// The challenged key does not reside in the `"system"` or
  /// `"user"` token and is not accessible by any other API.
  /// |options|: Object containing the fields defined in
  ///            [ChallengeKeyOptions].
  /// |callback|: Called back with the challenge response.
  Future<ByteBuffer> challengeKey(ChallengeKeyOptions options) {
    var $completer = Completer<ByteBuffer>();
    $js.chrome.enterprise.platformKeys.challengeKey(
      options.toJS,
      (JSArrayBuffer response) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(response.toDart);
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Challenges a hardware-backed Enterprise Machine Key and emits the
  /// response as part of a remote attestation protocol. Only useful on Chrome
  /// OS and in conjunction with the Verified Access Web API which both issues
  /// challenges and verifies responses. A successful verification by the
  /// Verified Access Web API is a strong signal of all of the following:
  /// * The current device is a legitimate Chrome OS device.
  /// * The current device is managed by the domain specified during
  ///   verification.
  /// * The current signed-in user is managed by the domain specified during
  ///   verification.
  /// * The current device state complies with enterprise device policy. For
  ///   example, a policy may specify that the device must not be in developer
  ///   mode.
  /// * Any device identity emitted by the verification is tightly bound to the
  ///   hardware of the current device.
  /// This function is highly restricted and will fail if the current device
  /// is not managed, the current user is not managed, or if this operation
  /// has not explicitly been enabled for the caller by enterprise device
  /// policy. The Enterprise Machine Key does not reside in the
  /// `"system"` token and is not accessible by any other API.
  /// |challenge|: A challenge as emitted by the Verified Access Web API.
  /// |registerKey|: If set, the current Enterprise Machine Key is registered
  ///                with the `"system"` token and relinquishes the
  ///                Enterprise Machine Key role. The key can then be
  ///                associated with a certificate and used like any other
  ///                signing key. This key is 2048-bit RSA. Subsequent calls
  ///                to this function will then generate a new Enterprise
  ///                Machine Key.
  /// |callback|: Called back with the challenge response.
  @Deprecated(r'Use $(ref:challengeKey) instead.')
  Future<ByteBuffer> challengeMachineKey(
    ByteBuffer challenge,
    bool? registerKey,
  ) {
    var $completer = Completer<ByteBuffer>();
    $js.chrome.enterprise.platformKeys.challengeMachineKey(
      challenge.toJS,
      registerKey,
      (JSArrayBuffer response) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(response.toDart);
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Challenges a hardware-backed Enterprise User Key and emits the response
  /// as part of a remote attestation protocol. Only useful on Chrome OS and in
  /// conjunction with the Verified Access Web API which both issues challenges
  /// and verifies responses. A successful verification by the Verified Access
  /// Web API is a strong signal of all of the following:
  /// * The current device is a legitimate Chrome OS device.
  /// * The current device is managed by the domain specified during
  ///   verification.
  /// * The current signed-in user is managed by the domain specified during
  ///   verification.
  /// * The current device state complies with enterprise user policy. For
  ///   example, a policy may specify that the device must not be in developer
  ///   mode.
  /// * The public key emitted by the verification is tightly bound to the
  ///   hardware of the current device and to the current signed-in user.
  /// This function is highly restricted and will fail if the current device is
  /// not managed, the current user is not managed, or if this operation has
  /// not explicitly been enabled for the caller by enterprise user policy.
  /// The Enterprise User Key does not reside in the `"user"` token
  /// and is not accessible by any other API.
  /// |challenge|: A challenge as emitted by the Verified Access Web API.
  /// |registerKey|: If set, the current Enterprise User Key is registered with
  ///                the `"user"` token and relinquishes the
  ///                Enterprise User Key role. The key can then be associated
  ///                with a certificate and used like any other signing key.
  ///                This key is 2048-bit RSA. Subsequent calls to this
  ///                function will then generate a new Enterprise User Key.
  /// |callback|: Called back with the challenge response.
  @Deprecated(r'Use $(ref:challengeKey) instead.')
  Future<ByteBuffer> challengeUserKey(
    ByteBuffer challenge,
    bool registerKey,
  ) {
    var $completer = Completer<ByteBuffer>();
    $js.chrome.enterprise.platformKeys.challengeUserKey(
      challenge.toJS,
      registerKey,
      (JSArrayBuffer response) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(response.toDart);
        }
      }.toJS,
    );
    return $completer.future;
  }
}

/// Whether to use the Enterprise User Key or the Enterprise Machine Key.
enum Scope {
  user('USER'),
  machine('MACHINE');

  const Scope(this.value);

  final String value;

  String get toJS => value;
  static Scope fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Type of key to generate.
enum Algorithm {
  rsa('RSA'),
  ecdsa('ECDSA');

  const Algorithm(this.value);

  final String value;

  String get toJS => value;
  static Algorithm fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class Token {
  Token.fromJS(this._wrapped);

  Token({
    /// Uniquely identifies this `Token`.
    /// Static IDs are `"user"` and `"system"`,
    /// referring to the platform's user-specific and the system-wide hardware
    /// token, respectively. Any other tokens (with other identifiers) might be
    /// returned by [enterprise.platformKeys.getTokens].
    required String id,

    /// Implements the WebCrypto's
    /// [SubtleCrypto](http://www.w3.org/TR/WebCryptoAPI/#subtlecrypto-interface)
    /// interface. The cryptographic operations, including key generation, are
    /// hardware-backed.
    /// Only non-extractable RSASSA-PKCS1-V1_5 keys with
    /// `modulusLength` up to 2048 and ECDSA with
    /// `namedCurve` P-256 can be generated. Each key can be
    /// used for signing data at most once.
    /// Keys generated on a specific `Token` cannot be used with
    /// any other Tokens, nor can they be used with
    /// `window.crypto.subtle`. Equally, `Key` objects
    /// created with `window.crypto.subtle` cannot be used with this
    /// interface.
    required JSObject subtleCrypto,

    /// Implements the WebCrypto's
    /// [SubtleCrypto](http://www.w3.org/TR/WebCryptoAPI/#subtlecrypto-interface)
    /// interface. The cryptographic operations, including key generation, are
    /// software-backed. Protection of the keys, and thus implementation of the
    /// non-extractable property, is done in software, so the keys are less
    /// protected than hardware-backed keys.
    /// Only non-extractable RSASSA-PKCS1-V1_5 keys with
    /// `modulusLength` up to 2048 can be generated. Each key can be
    /// used for signing data at most once.
    /// Keys generated on a specific `Token` cannot be used with
    /// any other Tokens, nor can they be used with
    /// `window.crypto.subtle`. Equally, `Key` objects
    /// created with `window.crypto.subtle` cannot be used with this
    /// interface.
    required JSObject softwareBackedSubtleCrypto,
  }) : _wrapped = $js.Token(
          id: id,
          subtleCrypto: subtleCrypto,
          softwareBackedSubtleCrypto: softwareBackedSubtleCrypto,
        );

  final $js.Token _wrapped;

  $js.Token get toJS => _wrapped;

  /// Uniquely identifies this `Token`.
  /// Static IDs are `"user"` and `"system"`,
  /// referring to the platform's user-specific and the system-wide hardware
  /// token, respectively. Any other tokens (with other identifiers) might be
  /// returned by [enterprise.platformKeys.getTokens].
  String get id => _wrapped.id;
  set id(String v) {
    _wrapped.id = v;
  }

  /// Implements the WebCrypto's
  /// [SubtleCrypto](http://www.w3.org/TR/WebCryptoAPI/#subtlecrypto-interface)
  /// interface. The cryptographic operations, including key generation, are
  /// hardware-backed.
  /// Only non-extractable RSASSA-PKCS1-V1_5 keys with
  /// `modulusLength` up to 2048 and ECDSA with
  /// `namedCurve` P-256 can be generated. Each key can be
  /// used for signing data at most once.
  /// Keys generated on a specific `Token` cannot be used with
  /// any other Tokens, nor can they be used with
  /// `window.crypto.subtle`. Equally, `Key` objects
  /// created with `window.crypto.subtle` cannot be used with this
  /// interface.
  JSObject get subtleCrypto => _wrapped.subtleCrypto;
  set subtleCrypto(JSObject v) {
    _wrapped.subtleCrypto = v;
  }

  /// Implements the WebCrypto's
  /// [SubtleCrypto](http://www.w3.org/TR/WebCryptoAPI/#subtlecrypto-interface)
  /// interface. The cryptographic operations, including key generation, are
  /// software-backed. Protection of the keys, and thus implementation of the
  /// non-extractable property, is done in software, so the keys are less
  /// protected than hardware-backed keys.
  /// Only non-extractable RSASSA-PKCS1-V1_5 keys with
  /// `modulusLength` up to 2048 can be generated. Each key can be
  /// used for signing data at most once.
  /// Keys generated on a specific `Token` cannot be used with
  /// any other Tokens, nor can they be used with
  /// `window.crypto.subtle`. Equally, `Key` objects
  /// created with `window.crypto.subtle` cannot be used with this
  /// interface.
  JSObject get softwareBackedSubtleCrypto =>
      _wrapped.softwareBackedSubtleCrypto;
  set softwareBackedSubtleCrypto(JSObject v) {
    _wrapped.softwareBackedSubtleCrypto = v;
  }
}

class RegisterKeyOptions {
  RegisterKeyOptions.fromJS(this._wrapped);

  RegisterKeyOptions(
      {
      /// Which algorithm the registered key should use.
      required Algorithm algorithm})
      : _wrapped = $js.RegisterKeyOptions(algorithm: algorithm.toJS);

  final $js.RegisterKeyOptions _wrapped;

  $js.RegisterKeyOptions get toJS => _wrapped;

  /// Which algorithm the registered key should use.
  Algorithm get algorithm => Algorithm.fromJS(_wrapped.algorithm);
  set algorithm(Algorithm v) {
    _wrapped.algorithm = v.toJS;
  }
}

class ChallengeKeyOptions {
  ChallengeKeyOptions.fromJS(this._wrapped);

  ChallengeKeyOptions({
    /// A challenge as emitted by the Verified Access Web API.
    required ByteBuffer challenge,

    /// If present, registers the challenged key with the specified
    /// `scope`'s token.  The key can then be associated with a
    /// certificate and used like any other signing key.  Subsequent calls to
    /// this function will then generate a new Enterprise Key in the specified
    /// `scope`.
    RegisterKeyOptions? registerKey,

    /// Which Enterprise Key to challenge.
    required Scope scope,
  }) : _wrapped = $js.ChallengeKeyOptions(
          challenge: challenge.toJS,
          registerKey: registerKey?.toJS,
          scope: scope.toJS,
        );

  final $js.ChallengeKeyOptions _wrapped;

  $js.ChallengeKeyOptions get toJS => _wrapped;

  /// A challenge as emitted by the Verified Access Web API.
  ByteBuffer get challenge => _wrapped.challenge.toDart;
  set challenge(ByteBuffer v) {
    _wrapped.challenge = v.toJS;
  }

  /// If present, registers the challenged key with the specified
  /// `scope`'s token.  The key can then be associated with a
  /// certificate and used like any other signing key.  Subsequent calls to
  /// this function will then generate a new Enterprise Key in the specified
  /// `scope`.
  RegisterKeyOptions? get registerKey =>
      _wrapped.registerKey?.let(RegisterKeyOptions.fromJS);
  set registerKey(RegisterKeyOptions? v) {
    _wrapped.registerKey = v?.toJS;
  }

  /// Which Enterprise Key to challenge.
  Scope get scope => Scope.fromJS(_wrapped.scope);
  set scope(Scope v) {
    _wrapped.scope = v.toJS;
  }
}
