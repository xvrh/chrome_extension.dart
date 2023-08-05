// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:typed_data';
import 'src/internal_helpers.dart';
import 'src/js/platform_keys.dart' as $js;

export 'src/chrome.dart' show chrome;

final _platformKeys = ChromePlatformKeys._();

extension ChromePlatformKeysExtension on Chrome {
  /// Use the `chrome.platformKeys` API to access client certificates
  /// managed by the platform. If the user or policy grants the permission, an
  /// extension can use such a certficate in its custom authentication protocol.
  /// E.g. this allows usage of platform managed certificates in third party
  /// VPNs
  /// (see $(ref:vpnProvider chrome.vpnProvider)).
  ChromePlatformKeys get platformKeys => _platformKeys;
}

class ChromePlatformKeys {
  ChromePlatformKeys._();

  bool get isAvailable => $js.chrome.platformKeysNullable != null && alwaysTrue;

  /// This method filters from a list of client certificates the ones that
  /// are known to the platform, match `request` and for which the
  /// extension has permission to access the certificate and its private key.
  /// If `interactive` is true, the user is presented a dialog where
  /// they can select from matching certificates and grant the extension access
  /// to the certificate.
  /// The selected/filtered client certificates will be passed to
  /// `callback`.
  Future<List<Match>> selectClientCertificates(SelectDetails details) {
    var $completer = Completer<List<Match>>();
    $js.chrome.platformKeys.selectClientCertificates(
      details.toJS,
      (JSArray matches) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(matches.toDart
              .cast<$js.Match>()
              .map((e) => Match.fromJS(e))
              .toList());
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Passes the key pair of `certificate` for usage with
  /// [platformKeys.subtleCrypto] to `callback`.
  /// |certificate|: The certificate of a [Match] returned by
  /// [selectClientCertificates].
  /// |parameters|: Determines signature/hash algorithm parameters additionally
  /// to the parameters fixed by the key itself. The same parameters are
  /// accepted as by WebCrypto's <a
  /// href="http://www.w3.org/TR/WebCryptoAPI/#SubtleCrypto-method-importKey">importKey</a>
  /// function, e.g. `RsaHashedImportParams` for a RSASSA-PKCS1-v1_5
  /// key and `EcKeyImportParams` for EC key.
  /// Additionally for RSASSA-PKCS1-v1_5 keys, hashing algorithm name parameter
  /// can be specified with one of the following values: "none", "SHA-1",
  /// "SHA-256", "SHA-384", or "SHA-512", e.g.
  /// `{"hash": { "name": "none" } }`. The sign function will then
  /// apply PKCS#1 v1.5 padding but not hash the given data.
  /// Currently, this method only supports the "RSASSA-PKCS1-v1_5" and
  /// "ECDSA" algorithms.
  Future<GetKeyPairResult> getKeyPair(
    ByteBuffer certificate,
    Map parameters,
  ) {
    var $completer = Completer<GetKeyPairResult>();
    $js.chrome.platformKeys.getKeyPair(
      certificate.toJS,
      parameters.jsify()!,
      (
        JSAny publicKey,
        JSAny? privateKey,
      ) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(GetKeyPairResult(
            publicKey: publicKey.toDartMap(),
            privateKey: privateKey?.toDartMap(),
          ));
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Passes the key pair identified by `publicKeySpkiDer` for
  /// usage with [platformKeys.subtleCrypto] to `callback`.
  /// |publicKeySpkiDer|: A DER-encoded X.509 SubjectPublicKeyInfo, obtained
  /// e.g. by calling WebCrypto's exportKey function with format="spki".
  /// |parameters|: Provides signature and hash algorithm parameters, in
  /// addition to those fixed by the key itself. The same parameters are
  /// accepted as by WebCrypto's <a
  /// href="http://www.w3.org/TR/WebCryptoAPI/#SubtleCrypto-method-importKey">importKey</a>
  /// function, e.g. `RsaHashedImportParams` for a RSASSA-PKCS1-v1_5
  /// key. For RSASSA-PKCS1-v1_5 keys, we need to also pass a "hash" parameter
  /// `{ "hash": { "name": string } }`. The "hash" parameter
  /// represents the name of the hashing algorithm to be used in the digest
  /// operation before a sign. It is possible to pass "none" as the hash name,
  /// in which case the sign function will apply PKCS#1 v1.5 padding and but
  /// not hash the given data.
  /// Currently, this method supports the "ECDSA" algorithm with
  /// named-curve P-256 and "RSASSA-PKCS1-v1_5" algorithm with one of the
  /// hashing algorithms "none", "SHA-1", "SHA-256", "SHA-384", and
  /// "SHA-512".
  Future<GetKeyPairBySpkiResult> getKeyPairBySpki(
    ByteBuffer publicKeySpkiDer,
    Map parameters,
  ) {
    var $completer = Completer<GetKeyPairBySpkiResult>();
    $js.chrome.platformKeys.getKeyPairBySpki(
      publicKeySpkiDer.toJS,
      parameters.jsify()!,
      (
        JSAny publicKey,
        JSAny? privateKey,
      ) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(GetKeyPairBySpkiResult(
            publicKey: publicKey.toDartMap(),
            privateKey: privateKey?.toDartMap(),
          ));
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// An implementation of WebCrypto's
  /// <a href="http://www.w3.org/TR/WebCryptoAPI/#subtlecrypto-interface">
  /// SubtleCrypto</a>
  /// that allows crypto operations on keys of client certificates that are
  /// available to this extension.
  Map subtleCrypto() {
    return $js.chrome.platformKeys.subtleCrypto().toDartMap();
  }

  /// Checks whether `details.serverCertificateChain` can be trusted
  /// for `details.hostname` according to the trust settings of the
  /// platform.
  /// Note: The actual behavior of the trust verification is not fully
  /// specified and might change in the future.
  /// The API implementation verifies certificate expiration, validates the
  /// certification path and checks trust by a known CA.
  /// The implementation is supposed to respect the EKU serverAuth and to
  /// support subject alternative names.
  Future<VerificationResult> verifyTLSServerCertificate(
      VerificationDetails details) {
    var $completer = Completer<VerificationResult>();
    $js.chrome.platformKeys.verifyTLSServerCertificate(
      details.toJS,
      ($js.VerificationResult result) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(VerificationResult.fromJS(result));
        }
      }.toJS,
    );
    return $completer.future;
  }
}

enum ClientCertificateType {
  rsaSign('rsaSign'),
  ecdsaSign('ecdsaSign');

  const ClientCertificateType(this.value);

  final String value;

  String get toJS => value;
  static ClientCertificateType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class Match {
  Match.fromJS(this._wrapped);

  Match({
    /// The DER encoding of a X.509 certificate.
    required ByteBuffer certificate,

    /// The
    /// <a href="http://www.w3.org/TR/WebCryptoAPI/#key-algorithm-dictionary">
    /// KeyAlgorithm</a> of the certified key. This contains algorithm
    /// parameters that are inherent to the key of the certificate (e.g. the key
    /// length). Other parameters like the hash function used by the sign
    /// function are not included.
    required Map keyAlgorithm,
  }) : _wrapped = $js.Match(
          certificate: certificate.toJS,
          keyAlgorithm: keyAlgorithm.jsify()!,
        );

  final $js.Match _wrapped;

  $js.Match get toJS => _wrapped;

  /// The DER encoding of a X.509 certificate.
  ByteBuffer get certificate => _wrapped.certificate.toDart;
  set certificate(ByteBuffer v) {
    _wrapped.certificate = v.toJS;
  }

  /// The
  /// <a href="http://www.w3.org/TR/WebCryptoAPI/#key-algorithm-dictionary">
  /// KeyAlgorithm</a> of the certified key. This contains algorithm
  /// parameters that are inherent to the key of the certificate (e.g. the key
  /// length). Other parameters like the hash function used by the sign
  /// function are not included.
  Map get keyAlgorithm => _wrapped.keyAlgorithm.toDartMap();
  set keyAlgorithm(Map v) {
    _wrapped.keyAlgorithm = v.jsify()!;
  }
}

class ClientCertificateRequest {
  ClientCertificateRequest.fromJS(this._wrapped);

  ClientCertificateRequest({
    /// This field is a list of the types of certificates requested, sorted in
    /// order of the server's preference. Only certificates of a type contained
    /// in this list will be retrieved. If `certificateTypes` is the
    /// empty list, however, certificates of any type will be returned.
    required List<ClientCertificateType> certificateTypes,

    /// List of distinguished names of certificate authorities allowed by the
    /// server. Each entry must be a DER-encoded X.509 DistinguishedName.
    required List<ByteBuffer> certificateAuthorities,
  }) : _wrapped = $js.ClientCertificateRequest(
          certificateTypes: certificateTypes.toJSArray((e) => e.toJS),
          certificateAuthorities:
              certificateAuthorities.toJSArray((e) => e.toJS),
        );

  final $js.ClientCertificateRequest _wrapped;

  $js.ClientCertificateRequest get toJS => _wrapped;

  /// This field is a list of the types of certificates requested, sorted in
  /// order of the server's preference. Only certificates of a type contained
  /// in this list will be retrieved. If `certificateTypes` is the
  /// empty list, however, certificates of any type will be returned.
  List<ClientCertificateType> get certificateTypes =>
      _wrapped.certificateTypes.toDart
          .cast<$js.ClientCertificateType>()
          .map((e) => ClientCertificateType.fromJS(e))
          .toList();
  set certificateTypes(List<ClientCertificateType> v) {
    _wrapped.certificateTypes = v.toJSArray((e) => e.toJS);
  }

  /// List of distinguished names of certificate authorities allowed by the
  /// server. Each entry must be a DER-encoded X.509 DistinguishedName.
  List<ByteBuffer> get certificateAuthorities =>
      _wrapped.certificateAuthorities.toDart
          .cast<JSArrayBuffer>()
          .map((e) => e.toDart)
          .toList();
  set certificateAuthorities(List<ByteBuffer> v) {
    _wrapped.certificateAuthorities = v.toJSArray((e) => e.toJS);
  }
}

class SelectDetails {
  SelectDetails.fromJS(this._wrapped);

  SelectDetails({
    /// Only certificates that match this request will be returned.
    required ClientCertificateRequest request,

    /// If given, the `selectClientCertificates` operates on this
    /// list. Otherwise, obtains the list of all certificates from the
    /// platform's
    /// certificate stores that are available to this extensions.
    /// Entries that the extension doesn't have permission for or which doesn't
    /// match the request, are removed.
    List<ByteBuffer>? clientCerts,

    /// If true, the filtered list is presented to the user to manually select a
    /// certificate and thereby granting the extension access to the
    /// certificate(s) and key(s). Only the selected certificate(s) will be
    /// returned. If is false, the list is reduced to all certificates that the
    /// extension has been granted access to (automatically or manually).
    required bool interactive,
  }) : _wrapped = $js.SelectDetails(
          request: request.toJS,
          clientCerts: clientCerts?.toJSArray((e) => e.toJS),
          interactive: interactive,
        );

  final $js.SelectDetails _wrapped;

  $js.SelectDetails get toJS => _wrapped;

  /// Only certificates that match this request will be returned.
  ClientCertificateRequest get request =>
      ClientCertificateRequest.fromJS(_wrapped.request);
  set request(ClientCertificateRequest v) {
    _wrapped.request = v.toJS;
  }

  /// If given, the `selectClientCertificates` operates on this
  /// list. Otherwise, obtains the list of all certificates from the platform's
  /// certificate stores that are available to this extensions.
  /// Entries that the extension doesn't have permission for or which doesn't
  /// match the request, are removed.
  List<ByteBuffer>? get clientCerts => _wrapped.clientCerts?.toDart
      .cast<JSArrayBuffer>()
      .map((e) => e.toDart)
      .toList();
  set clientCerts(List<ByteBuffer>? v) {
    _wrapped.clientCerts = v?.toJSArray((e) => e.toJS);
  }

  /// If true, the filtered list is presented to the user to manually select a
  /// certificate and thereby granting the extension access to the
  /// certificate(s) and key(s). Only the selected certificate(s) will be
  /// returned. If is false, the list is reduced to all certificates that the
  /// extension has been granted access to (automatically or manually).
  bool get interactive => _wrapped.interactive;
  set interactive(bool v) {
    _wrapped.interactive = v;
  }
}

class VerificationDetails {
  VerificationDetails.fromJS(this._wrapped);

  VerificationDetails({
    /// Each chain entry must be the DER encoding of a X.509 certificate, the
    /// first entry must be the server certificate and each entry must certify
    /// the entry preceding it.
    required List<ByteBuffer> serverCertificateChain,

    /// The hostname of the server to verify the certificate for, e.g. the
    /// server
    /// that presented the `serverCertificateChain`.
    required String hostname,
  }) : _wrapped = $js.VerificationDetails(
          serverCertificateChain:
              serverCertificateChain.toJSArray((e) => e.toJS),
          hostname: hostname,
        );

  final $js.VerificationDetails _wrapped;

  $js.VerificationDetails get toJS => _wrapped;

  /// Each chain entry must be the DER encoding of a X.509 certificate, the
  /// first entry must be the server certificate and each entry must certify
  /// the entry preceding it.
  List<ByteBuffer> get serverCertificateChain =>
      _wrapped.serverCertificateChain.toDart
          .cast<JSArrayBuffer>()
          .map((e) => e.toDart)
          .toList();
  set serverCertificateChain(List<ByteBuffer> v) {
    _wrapped.serverCertificateChain = v.toJSArray((e) => e.toJS);
  }

  /// The hostname of the server to verify the certificate for, e.g. the server
  /// that presented the `serverCertificateChain`.
  String get hostname => _wrapped.hostname;
  set hostname(String v) {
    _wrapped.hostname = v;
  }
}

class VerificationResult {
  VerificationResult.fromJS(this._wrapped);

  VerificationResult({
    /// The result of the trust verification: true if trust for the given
    /// verification details could be established and false if trust is rejected
    /// for any reason.
    required bool trusted,

    /// If the trust verification failed, this array contains the errors
    /// reported
    /// by the underlying network layer. Otherwise, this array is empty.
    ///
    /// *Note:* This list is meant for debugging only and may not
    /// contain all relevant errors. The errors returned may change in future
    /// revisions of this API, and are not guaranteed to be forwards or
    /// backwards
    /// compatible.
    required List<String> debugErrors,
  }) : _wrapped = $js.VerificationResult(
          trusted: trusted,
          debug_errors: debugErrors.toJSArray((e) => e),
        );

  final $js.VerificationResult _wrapped;

  $js.VerificationResult get toJS => _wrapped;

  /// The result of the trust verification: true if trust for the given
  /// verification details could be established and false if trust is rejected
  /// for any reason.
  bool get trusted => _wrapped.trusted;
  set trusted(bool v) {
    _wrapped.trusted = v;
  }

  /// If the trust verification failed, this array contains the errors reported
  /// by the underlying network layer. Otherwise, this array is empty.
  ///
  /// *Note:* This list is meant for debugging only and may not
  /// contain all relevant errors. The errors returned may change in future
  /// revisions of this API, and are not guaranteed to be forwards or backwards
  /// compatible.
  List<String> get debugErrors =>
      _wrapped.debug_errors.toDart.cast<String>().map((e) => e).toList();
  set debugErrors(List<String> v) {
    _wrapped.debug_errors = v.toJSArray((e) => e);
  }
}

class GetKeyPairResult {
  GetKeyPairResult({
    required this.publicKey,
    required this.privateKey,
  });

  final Map publicKey;

  final Map? privateKey;
}

class GetKeyPairBySpkiResult {
  GetKeyPairBySpkiResult({
    required this.publicKey,
    required this.privateKey,
  });

  final Map publicKey;

  final Map? privateKey;
}
