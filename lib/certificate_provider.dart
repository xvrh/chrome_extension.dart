// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'dart:typed_data';
import 'src/internal_helpers.dart';
import 'src/js/certificate_provider.dart' as $js;

export 'src/chrome.dart' show chrome;

final _certificateProvider = ChromeCertificateProvider._();

extension ChromeCertificateProviderExtension on Chrome {
  /// Use this API to expose certificates to the platform which can use these
  /// certificates for TLS authentications.
  ChromeCertificateProvider get certificateProvider => _certificateProvider;
}

class ChromeCertificateProvider {
  ChromeCertificateProvider._();

  bool get isAvailable =>
      $js.chrome.certificateProviderNullable != null && alwaysTrue;

  /// Requests the PIN from the user. Only one ongoing request at a time is
  /// allowed. The requests issued while another flow is ongoing are rejected.
  /// It's the extension's responsibility to try again later if another flow is
  /// in progress.
  /// |details|: Contains the details about the requested dialog.
  /// |callback|: Is called when the dialog is resolved with the user input, or
  /// when the dialog request finishes unsuccessfully (e.g. the dialog was
  /// canceled by the user or was not allowed to be shown).
  Future<PinResponseDetails?> requestPin(RequestPinDetails details) async {
    var $res = await promiseToFuture<$js.PinResponseDetails?>(
        $js.chrome.certificateProvider.requestPin(details.toJS));
    return $res?.let(PinResponseDetails.fromJS);
  }

  /// Stops the pin request started by the [requestPin] function.
  /// |details|: Contains the details about the reason for stopping the
  /// request flow.
  /// |callback|: To be used by Chrome to send to the extension the status from
  /// their request to close PIN dialog for user.
  Future<void> stopPinRequest(StopPinRequestDetails details) async {
    await promiseToFuture<void>(
        $js.chrome.certificateProvider.stopPinRequest(details.toJS));
  }

  /// Sets a list of certificates to use in the browser.
  /// The extension should call this function after initialization and on
  /// every change in the set of currently available certificates. The
  /// extension should also call this function in response to
  /// [onCertificatesUpdateRequested] every time this event is
  /// received.
  /// |details|: The certificates to set. Invalid certificates will be ignored.
  /// |callback|: Called upon completion.
  Future<void> setCertificates(SetCertificatesDetails details) async {
    await promiseToFuture<void>(
        $js.chrome.certificateProvider.setCertificates(details.toJS));
  }

  /// Should be called as a response to [onSignatureRequested].
  /// The extension must eventually call this function for every
  /// [onSignatureRequested] event; the API implementation will stop
  /// waiting for this call after some time and respond with a timeout
  /// error when this function is called.
  Future<void> reportSignature(ReportSignatureDetails details) async {
    await promiseToFuture<void>(
        $js.chrome.certificateProvider.reportSignature(details.toJS));
  }

  /// This event fires if the certificates set via [setCertificates]
  /// are insufficient or the browser requests updated information. The
  /// extension must call [setCertificates] with the updated list of
  /// certificates and the received `certificatesRequestId`.
  EventStream<CertificatesUpdateRequest> get onCertificatesUpdateRequested =>
      $js.chrome.certificateProvider.onCertificatesUpdateRequested
          .asStream(($c) => ($js.CertificatesUpdateRequest request) {
                return $c(CertificatesUpdateRequest.fromJS(request));
              });

  /// This event fires every time the browser needs to sign a message using a
  /// certificate provided by this extension via [setCertificates].
  /// The extension must sign the input data from `request` using
  /// the appropriate algorithm and private key and return it by calling
  /// [reportSignature] with the received `signRequestId`.
  EventStream<SignatureRequest> get onSignatureRequested =>
      $js.chrome.certificateProvider.onSignatureRequested
          .asStream(($c) => ($js.SignatureRequest request) {
                return $c(SignatureRequest.fromJS(request));
              });

  /// This event fires every time the browser requests the current list of
  /// certificates provided by this extension. The extension must call
  /// `reportCallback` exactly once with the current list of
  /// certificates.
  EventStream<
          void Function(
            List<CertificateInfo>,
            void Function(List<ByteBuffer>),
          )>
      get onCertificatesRequested =>
          $js.chrome.certificateProvider.onCertificatesRequested
              .asStream(($c) => ($js.CertificatesCallback reportCallback) {
                    return $c((List<CertificateInfo> certificates,
                        void Function(List<ByteBuffer>) callback) {
                      //ignore: avoid_dynamic_calls
                      (reportCallback as Function)(
                          certificates.toJSArray((e) => e.toJS),
                          (JSArray rejectedCertificates) {
                        callback(rejectedCertificates.toDart
                            .cast<JSArrayBuffer>()
                            .map((e) => e.toDart)
                            .toList());
                      });
                    });
                  });

  /// This event fires every time the browser needs to sign a message using
  /// a certificate provided by this extension in reply to an
  /// [onCertificatesRequested] event.
  /// The extension must sign the data in `request` using the
  /// appropriate algorithm and private key and return it by calling
  /// `reportCallback`. `reportCallback` must be called
  /// exactly once.
  /// |request|: Contains the details about the sign request.
  EventStream<OnSignDigestRequestedEvent> get onSignDigestRequested =>
      $js.chrome.certificateProvider.onSignDigestRequested.asStream(($c) => (
            $js.SignRequest request,
            $js.SignCallback reportCallback,
          ) {
            return $c(OnSignDigestRequestedEvent(
              request: SignRequest.fromJS(request),
              reportCallback: (ByteBuffer? signature) {
                //ignore: avoid_dynamic_calls
                (reportCallback as Function)(signature?.toJS);
              },
            ));
          });
}

/// Types of supported cryptographic signature algorithms.
enum Algorithm {
  /// RSASSA PKCS#1 v1.5 signature algorithm with the MD5-SHA-1 hashing. The
  /// extension must not prepend a DigestInfo prefix but only add PKCS#1
  /// padding. This algorithm is deprecated and will never be requested by
  /// Chrome as of version 109.
  rsassaPkcs1V15Md5Sha1('RSASSA_PKCS1_v1_5_MD5_SHA1'),

  /// RSASSA PKCS#1 v1.5 signature algorithm with the SHA-1 hash function.
  rsassaPkcs1V15Sha1('RSASSA_PKCS1_v1_5_SHA1'),

  /// RSASSA PKCS#1 v1.5 signature algorithm with the SHA-256 hashing function.
  rsassaPkcs1V15Sha256('RSASSA_PKCS1_v1_5_SHA256'),

  /// RSASSA PKCS#1 v1.5 signature algorithm with the SHA-384 hashing function.
  rsassaPkcs1V15Sha384('RSASSA_PKCS1_v1_5_SHA384'),

  /// RSASSA PKCS#1 v1.5 signature algorithm with the SHA-512 hashing function.
  rsassaPkcs1V15Sha512('RSASSA_PKCS1_v1_5_SHA512'),

  /// Since Chrome 89. RSASSA PSS signature algorithm with the SHA-256 hashing
  /// function, MGF1 mask generation function and the salt of the same size as
  /// the hash.
  rsassaPssSha256('RSASSA_PSS_SHA256'),

  /// Since Chrome 89. RSASSA PSS signature algorithm with the SHA-384 hashing
  /// function, MGF1 mask generation function and the salt of the same size as
  /// the hash.
  rsassaPssSha384('RSASSA_PSS_SHA384'),

  /// Since Chrome 89. RSASSA PSS signature algorithm with the SHA-512 hashing
  /// function, MGF1 mask generation function and the salt of the same size as
  /// the hash.
  rsassaPssSha512('RSASSA_PSS_SHA512');

  const Algorithm(this.value);

  final String value;

  String get toJS => value;
  static Algorithm fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Types of errors that the extension can report.
enum Error {
  /// General error that cannot be represented by other more specific error
  /// codes.
  generalError('GENERAL_ERROR');

  const Error(this.value);

  final String value;

  String get toJS => value;
  static Error fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Deprecated. Replaced by [Algorithm].
enum Hash {
  md5Sha1('MD5_SHA1'),
  sha1('SHA1'),
  sha256('SHA256'),
  sha384('SHA384'),
  sha512('SHA512');

  const Hash(this.value);

  final String value;

  String get toJS => value;
  static Hash fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The type of code being requested by the extension with requestPin function.
enum PinRequestType {
  pin('PIN'),
  puk('PUK');

  const PinRequestType(this.value);

  final String value;

  String get toJS => value;
  static PinRequestType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The types of errors that can be presented to the user through the
/// requestPin function.
enum PinRequestErrorType {
  invalidPin('INVALID_PIN'),
  invalidPuk('INVALID_PUK'),
  maxAttemptsExceeded('MAX_ATTEMPTS_EXCEEDED'),
  unknownError('UNKNOWN_ERROR');

  const PinRequestErrorType(this.value);

  final String value;

  String get toJS => value;
  static PinRequestErrorType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The callback provided by the extension that Chrome uses to report back
/// rejected certificates. See `CertificatesCallback`.
typedef ResultCallback = void Function(List<ByteBuffer>);

/// Call this exactly once with the list of certificates that this extension is
/// providing. The list must only contain certificates for which the extension
/// can sign data using the associated private key. If the list contains
/// invalid certificates, these will be ignored. All valid certificates are
/// still registered for the extension. Chrome will call back with the list of
/// rejected certificates, which might be empty.
typedef CertificatesCallback = void Function(
  List<CertificateInfo>,
  void Function(List<ByteBuffer>),
);

/// If no error occurred, this function must be called with the signature of
/// the digest using the private key of the requested certificate.
/// For an RSA key, the signature must be a PKCS#1 signature. The extension
/// is responsible for prepending the DigestInfo prefix and adding PKCS#1
/// padding. If an error occurred, this callback should be called without
/// signature.
typedef SignCallback = void Function(ByteBuffer?);

class ClientCertificateInfo {
  ClientCertificateInfo.fromJS(this._wrapped);

  ClientCertificateInfo({
    /// The array must contain the DER encoding of the X.509 client certificate
    /// as its first element.
    /// This must include exactly one certificate.
    required List<ByteBuffer> certificateChain,

    /// All algorithms supported for this certificate. The extension will only
    /// be
    /// asked for signatures using one of these algorithms.
    required List<Algorithm> supportedAlgorithms,
  }) : _wrapped = $js.ClientCertificateInfo(
          certificateChain: certificateChain.toJSArray((e) => e.toJS),
          supportedAlgorithms: supportedAlgorithms.toJSArray((e) => e.toJS),
        );

  final $js.ClientCertificateInfo _wrapped;

  $js.ClientCertificateInfo get toJS => _wrapped;

  /// The array must contain the DER encoding of the X.509 client certificate
  /// as its first element.
  /// This must include exactly one certificate.
  List<ByteBuffer> get certificateChain => _wrapped.certificateChain.toDart
      .cast<JSArrayBuffer>()
      .map((e) => e.toDart)
      .toList();
  set certificateChain(List<ByteBuffer> v) {
    _wrapped.certificateChain = v.toJSArray((e) => e.toJS);
  }

  /// All algorithms supported for this certificate. The extension will only be
  /// asked for signatures using one of these algorithms.
  List<Algorithm> get supportedAlgorithms => _wrapped.supportedAlgorithms.toDart
      .cast<$js.Algorithm>()
      .map((e) => Algorithm.fromJS(e))
      .toList();
  set supportedAlgorithms(List<Algorithm> v) {
    _wrapped.supportedAlgorithms = v.toJSArray((e) => e.toJS);
  }
}

class SetCertificatesDetails {
  SetCertificatesDetails.fromJS(this._wrapped);

  SetCertificatesDetails({
    /// When called in response to [onCertificatesUpdateRequested], should
    /// contain the received `certificatesRequestId` value. Otherwise,
    /// should be unset.
    int? certificatesRequestId,

    /// Error that occurred while extracting the certificates, if any. This
    /// error
    /// will be surfaced to the user when appropriate.
    Error? error,

    /// List of currently available client certificates.
    required List<ClientCertificateInfo> clientCertificates,
  }) : _wrapped = $js.SetCertificatesDetails(
          certificatesRequestId: certificatesRequestId,
          error: error?.toJS,
          clientCertificates: clientCertificates.toJSArray((e) => e.toJS),
        );

  final $js.SetCertificatesDetails _wrapped;

  $js.SetCertificatesDetails get toJS => _wrapped;

  /// When called in response to [onCertificatesUpdateRequested], should
  /// contain the received `certificatesRequestId` value. Otherwise,
  /// should be unset.
  int? get certificatesRequestId => _wrapped.certificatesRequestId;
  set certificatesRequestId(int? v) {
    _wrapped.certificatesRequestId = v;
  }

  /// Error that occurred while extracting the certificates, if any. This error
  /// will be surfaced to the user when appropriate.
  Error? get error => _wrapped.error?.let(Error.fromJS);
  set error(Error? v) {
    _wrapped.error = v?.toJS;
  }

  /// List of currently available client certificates.
  List<ClientCertificateInfo> get clientCertificates =>
      _wrapped.clientCertificates.toDart
          .cast<$js.ClientCertificateInfo>()
          .map((e) => ClientCertificateInfo.fromJS(e))
          .toList();
  set clientCertificates(List<ClientCertificateInfo> v) {
    _wrapped.clientCertificates = v.toJSArray((e) => e.toJS);
  }
}

class CertificatesUpdateRequest {
  CertificatesUpdateRequest.fromJS(this._wrapped);

  CertificatesUpdateRequest(
      {
      /// Request identifier to be passed to [setCertificates].
      required int certificatesRequestId})
      : _wrapped = $js.CertificatesUpdateRequest(
            certificatesRequestId: certificatesRequestId);

  final $js.CertificatesUpdateRequest _wrapped;

  $js.CertificatesUpdateRequest get toJS => _wrapped;

  /// Request identifier to be passed to [setCertificates].
  int get certificatesRequestId => _wrapped.certificatesRequestId;
  set certificatesRequestId(int v) {
    _wrapped.certificatesRequestId = v;
  }
}

class SignatureRequest {
  SignatureRequest.fromJS(this._wrapped);

  SignatureRequest({
    /// Request identifier to be passed to [reportSignature].
    required int signRequestId,

    /// Data to be signed. Note that the data is not hashed.
    required ByteBuffer input,

    /// Signature algorithm to be used.
    required Algorithm algorithm,

    /// The DER encoding of a X.509 certificate. The extension must sign
    /// `input` using the associated private key.
    required ByteBuffer certificate,
  }) : _wrapped = $js.SignatureRequest(
          signRequestId: signRequestId,
          input: input.toJS,
          algorithm: algorithm.toJS,
          certificate: certificate.toJS,
        );

  final $js.SignatureRequest _wrapped;

  $js.SignatureRequest get toJS => _wrapped;

  /// Request identifier to be passed to [reportSignature].
  int get signRequestId => _wrapped.signRequestId;
  set signRequestId(int v) {
    _wrapped.signRequestId = v;
  }

  /// Data to be signed. Note that the data is not hashed.
  ByteBuffer get input => _wrapped.input.toDart;
  set input(ByteBuffer v) {
    _wrapped.input = v.toJS;
  }

  /// Signature algorithm to be used.
  Algorithm get algorithm => Algorithm.fromJS(_wrapped.algorithm);
  set algorithm(Algorithm v) {
    _wrapped.algorithm = v.toJS;
  }

  /// The DER encoding of a X.509 certificate. The extension must sign
  /// `input` using the associated private key.
  ByteBuffer get certificate => _wrapped.certificate.toDart;
  set certificate(ByteBuffer v) {
    _wrapped.certificate = v.toJS;
  }
}

class ReportSignatureDetails {
  ReportSignatureDetails.fromJS(this._wrapped);

  ReportSignatureDetails({
    /// Request identifier that was received via the [onSignatureRequested]
    /// event.
    required int signRequestId,

    /// Error that occurred while generating the signature, if any.
    Error? error,

    /// The signature, if successfully generated.
    ByteBuffer? signature,
  }) : _wrapped = $js.ReportSignatureDetails(
          signRequestId: signRequestId,
          error: error?.toJS,
          signature: signature?.toJS,
        );

  final $js.ReportSignatureDetails _wrapped;

  $js.ReportSignatureDetails get toJS => _wrapped;

  /// Request identifier that was received via the [onSignatureRequested]
  /// event.
  int get signRequestId => _wrapped.signRequestId;
  set signRequestId(int v) {
    _wrapped.signRequestId = v;
  }

  /// Error that occurred while generating the signature, if any.
  Error? get error => _wrapped.error?.let(Error.fromJS);
  set error(Error? v) {
    _wrapped.error = v?.toJS;
  }

  /// The signature, if successfully generated.
  ByteBuffer? get signature => _wrapped.signature?.toDart;
  set signature(ByteBuffer? v) {
    _wrapped.signature = v?.toJS;
  }
}

class CertificateInfo {
  CertificateInfo.fromJS(this._wrapped);

  CertificateInfo({
    /// Must be the DER encoding of a X.509 certificate. Currently, only
    /// certificates of RSA keys are supported.
    required ByteBuffer certificate,

    /// Must be set to all hashes supported for this certificate. This extension
    /// will only be asked for signatures of digests calculated with one of
    /// these
    /// hash algorithms. This should be in order of decreasing hash preference.
    required List<Hash> supportedHashes,
  }) : _wrapped = $js.CertificateInfo(
          certificate: certificate.toJS,
          supportedHashes: supportedHashes.toJSArray((e) => e.toJS),
        );

  final $js.CertificateInfo _wrapped;

  $js.CertificateInfo get toJS => _wrapped;

  /// Must be the DER encoding of a X.509 certificate. Currently, only
  /// certificates of RSA keys are supported.
  ByteBuffer get certificate => _wrapped.certificate.toDart;
  set certificate(ByteBuffer v) {
    _wrapped.certificate = v.toJS;
  }

  /// Must be set to all hashes supported for this certificate. This extension
  /// will only be asked for signatures of digests calculated with one of these
  /// hash algorithms. This should be in order of decreasing hash preference.
  List<Hash> get supportedHashes => _wrapped.supportedHashes.toDart
      .cast<$js.Hash>()
      .map((e) => Hash.fromJS(e))
      .toList();
  set supportedHashes(List<Hash> v) {
    _wrapped.supportedHashes = v.toJSArray((e) => e.toJS);
  }
}

class SignRequest {
  SignRequest.fromJS(this._wrapped);

  SignRequest({
    /// The unique ID to be used by the extension should it need to call a
    /// method
    /// that requires it, e.g. requestPin.
    required int signRequestId,

    /// The digest that must be signed.
    required ByteBuffer digest,

    /// Refers to the hash algorithm that was used to create `digest`.
    required Hash hash,

    /// The DER encoding of a X.509 certificate. The extension must sign
    /// `digest` using the associated private key.
    required ByteBuffer certificate,
  }) : _wrapped = $js.SignRequest(
          signRequestId: signRequestId,
          digest: digest.toJS,
          hash: hash.toJS,
          certificate: certificate.toJS,
        );

  final $js.SignRequest _wrapped;

  $js.SignRequest get toJS => _wrapped;

  /// The unique ID to be used by the extension should it need to call a method
  /// that requires it, e.g. requestPin.
  int get signRequestId => _wrapped.signRequestId;
  set signRequestId(int v) {
    _wrapped.signRequestId = v;
  }

  /// The digest that must be signed.
  ByteBuffer get digest => _wrapped.digest.toDart;
  set digest(ByteBuffer v) {
    _wrapped.digest = v.toJS;
  }

  /// Refers to the hash algorithm that was used to create `digest`.
  Hash get hash => Hash.fromJS(_wrapped.hash);
  set hash(Hash v) {
    _wrapped.hash = v.toJS;
  }

  /// The DER encoding of a X.509 certificate. The extension must sign
  /// `digest` using the associated private key.
  ByteBuffer get certificate => _wrapped.certificate.toDart;
  set certificate(ByteBuffer v) {
    _wrapped.certificate = v.toJS;
  }
}

class RequestPinDetails {
  RequestPinDetails.fromJS(this._wrapped);

  RequestPinDetails({
    /// The ID given by Chrome in SignRequest.
    required int signRequestId,

    /// The type of code requested. Default is PIN.
    PinRequestType? requestType,

    /// The error template displayed to the user. This should be set if the
    /// previous request failed, to notify the user of the failure reason.
    PinRequestErrorType? errorType,

    /// The number of attempts left. This is provided so that any UI can present
    /// this information to the user. Chrome is not expected to enforce this,
    /// instead stopPinRequest should be called by the extension with
    /// errorType = MAX_ATTEMPTS_EXCEEDED when the number of pin requests is
    /// exceeded.
    int? attemptsLeft,
  }) : _wrapped = $js.RequestPinDetails(
          signRequestId: signRequestId,
          requestType: requestType?.toJS,
          errorType: errorType?.toJS,
          attemptsLeft: attemptsLeft,
        );

  final $js.RequestPinDetails _wrapped;

  $js.RequestPinDetails get toJS => _wrapped;

  /// The ID given by Chrome in SignRequest.
  int get signRequestId => _wrapped.signRequestId;
  set signRequestId(int v) {
    _wrapped.signRequestId = v;
  }

  /// The type of code requested. Default is PIN.
  PinRequestType? get requestType =>
      _wrapped.requestType?.let(PinRequestType.fromJS);
  set requestType(PinRequestType? v) {
    _wrapped.requestType = v?.toJS;
  }

  /// The error template displayed to the user. This should be set if the
  /// previous request failed, to notify the user of the failure reason.
  PinRequestErrorType? get errorType =>
      _wrapped.errorType?.let(PinRequestErrorType.fromJS);
  set errorType(PinRequestErrorType? v) {
    _wrapped.errorType = v?.toJS;
  }

  /// The number of attempts left. This is provided so that any UI can present
  /// this information to the user. Chrome is not expected to enforce this,
  /// instead stopPinRequest should be called by the extension with
  /// errorType = MAX_ATTEMPTS_EXCEEDED when the number of pin requests is
  /// exceeded.
  int? get attemptsLeft => _wrapped.attemptsLeft;
  set attemptsLeft(int? v) {
    _wrapped.attemptsLeft = v;
  }
}

class StopPinRequestDetails {
  StopPinRequestDetails.fromJS(this._wrapped);

  StopPinRequestDetails({
    /// The ID given by Chrome in SignRequest.
    required int signRequestId,

    /// The error template. If present it is displayed to user. Intended to
    /// contain the reason for stopping the flow if it was caused by an error,
    /// e.g. MAX_ATTEMPTS_EXCEEDED.
    PinRequestErrorType? errorType,
  }) : _wrapped = $js.StopPinRequestDetails(
          signRequestId: signRequestId,
          errorType: errorType?.toJS,
        );

  final $js.StopPinRequestDetails _wrapped;

  $js.StopPinRequestDetails get toJS => _wrapped;

  /// The ID given by Chrome in SignRequest.
  int get signRequestId => _wrapped.signRequestId;
  set signRequestId(int v) {
    _wrapped.signRequestId = v;
  }

  /// The error template. If present it is displayed to user. Intended to
  /// contain the reason for stopping the flow if it was caused by an error,
  /// e.g. MAX_ATTEMPTS_EXCEEDED.
  PinRequestErrorType? get errorType =>
      _wrapped.errorType?.let(PinRequestErrorType.fromJS);
  set errorType(PinRequestErrorType? v) {
    _wrapped.errorType = v?.toJS;
  }
}

class PinResponseDetails {
  PinResponseDetails.fromJS(this._wrapped);

  PinResponseDetails(
      {
      /// The code provided by the user. Empty if user closed the dialog or some
      /// other error occurred.
      String? userInput})
      : _wrapped = $js.PinResponseDetails(userInput: userInput);

  final $js.PinResponseDetails _wrapped;

  $js.PinResponseDetails get toJS => _wrapped;

  /// The code provided by the user. Empty if user closed the dialog or some
  /// other error occurred.
  String? get userInput => _wrapped.userInput;
  set userInput(String? v) {
    _wrapped.userInput = v;
  }
}

class OnSignDigestRequestedEvent {
  OnSignDigestRequestedEvent({
    required this.request,
    required this.reportCallback,
  });

  final SignRequest request;

  final void Function(ByteBuffer?) reportCallback;
}
