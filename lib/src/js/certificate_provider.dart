// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSCertificateProviderExtension on JSChrome {
  @JS('certificateProvider')
  external JSCertificateProvider? get certificateProviderNullable;

  /// Use this API to expose certificates to the platform which can use these
  /// certificates for TLS authentications.
  JSCertificateProvider get certificateProvider {
    var certificateProviderNullable = this.certificateProviderNullable;
    if (certificateProviderNullable == null) {
      throw ApiNotAvailableException('chrome.certificateProvider');
    }
    return certificateProviderNullable;
  }
}

@JS()
@staticInterop
class JSCertificateProvider {}

extension JSCertificateProviderExtension on JSCertificateProvider {
  /// Requests the PIN from the user. Only one ongoing request at a time is
  /// allowed. The requests issued while another flow is ongoing are rejected.
  /// It's the extension's responsibility to try again later if another flow is
  /// in progress.
  /// |details|: Contains the details about the requested dialog.
  /// |callback|: Is called when the dialog is resolved with the user input, or
  /// when the dialog request finishes unsuccessfully (e.g. the dialog was
  /// canceled by the user or was not allowed to be shown).
  external JSPromise requestPin(RequestPinDetails details);

  /// Stops the pin request started by the [requestPin] function.
  /// |details|: Contains the details about the reason for stopping the
  /// request flow.
  /// |callback|: To be used by Chrome to send to the extension the status from
  /// their request to close PIN dialog for user.
  external JSPromise stopPinRequest(StopPinRequestDetails details);

  /// Sets a list of certificates to use in the browser.
  /// The extension should call this function after initialization and on
  /// every change in the set of currently available certificates. The
  /// extension should also call this function in response to
  /// [onCertificatesUpdateRequested] every time this event is
  /// received.
  /// |details|: The certificates to set. Invalid certificates will be ignored.
  /// |callback|: Called upon completion.
  external JSPromise setCertificates(SetCertificatesDetails details);

  /// Should be called as a response to [onSignatureRequested].
  /// The extension must eventually call this function for every
  /// [onSignatureRequested] event; the API implementation will stop
  /// waiting for this call after some time and respond with a timeout
  /// error when this function is called.
  external JSPromise reportSignature(ReportSignatureDetails details);

  /// This event fires if the certificates set via [setCertificates]
  /// are insufficient or the browser requests updated information. The
  /// extension must call [setCertificates] with the updated list of
  /// certificates and the received `certificatesRequestId`.
  external Event get onCertificatesUpdateRequested;

  /// This event fires every time the browser needs to sign a message using a
  /// certificate provided by this extension via [setCertificates].
  /// The extension must sign the input data from `request` using
  /// the appropriate algorithm and private key and return it by calling
  /// [reportSignature] with the received `signRequestId`.
  external Event get onSignatureRequested;

  /// This event fires every time the browser requests the current list of
  /// certificates provided by this extension. The extension must call
  /// `reportCallback` exactly once with the current list of
  /// certificates.
  external Event get onCertificatesRequested;

  /// This event fires every time the browser needs to sign a message using
  /// a certificate provided by this extension in reply to an
  /// [onCertificatesRequested] event.
  /// The extension must sign the data in `request` using the
  /// appropriate algorithm and private key and return it by calling
  /// `reportCallback`. `reportCallback` must be called
  /// exactly once.
  /// |request|: Contains the details about the sign request.
  external Event get onSignDigestRequested;
}

/// Types of supported cryptographic signature algorithms.
typedef Algorithm = String;

/// Types of errors that the extension can report.
typedef Error = String;

/// Deprecated. Replaced by [Algorithm].
typedef Hash = String;

/// The type of code being requested by the extension with requestPin function.
typedef PinRequestType = String;

/// The types of errors that can be presented to the user through the
/// requestPin function.
typedef PinRequestErrorType = String;

/// The callback provided by the extension that Chrome uses to report back
/// rejected certificates. See `CertificatesCallback`.
typedef ResultCallback = JSFunction;

/// Call this exactly once with the list of certificates that this extension is
/// providing. The list must only contain certificates for which the extension
/// can sign data using the associated private key. If the list contains
/// invalid certificates, these will be ignored. All valid certificates are
/// still registered for the extension. Chrome will call back with the list of
/// rejected certificates, which might be empty.
typedef CertificatesCallback = JSFunction;

/// If no error occurred, this function must be called with the signature of
/// the digest using the private key of the requested certificate.
/// For an RSA key, the signature must be a PKCS#1 signature. The extension
/// is responsible for prepending the DigestInfo prefix and adding PKCS#1
/// padding. If an error occurred, this callback should be called without
/// signature.
typedef SignCallback = JSFunction;

@JS()
@staticInterop
@anonymous
class ClientCertificateInfo {
  external factory ClientCertificateInfo({
    /// The array must contain the DER encoding of the X.509 client certificate
    /// as its first element.
    /// This must include exactly one certificate.
    JSArray certificateChain,

    /// All algorithms supported for this certificate. The extension will only be
    /// asked for signatures using one of these algorithms.
    JSArray supportedAlgorithms,
  });
}

extension ClientCertificateInfoExtension on ClientCertificateInfo {
  /// The array must contain the DER encoding of the X.509 client certificate
  /// as its first element.
  /// This must include exactly one certificate.
  external JSArray certificateChain;

  /// All algorithms supported for this certificate. The extension will only be
  /// asked for signatures using one of these algorithms.
  external JSArray supportedAlgorithms;
}

@JS()
@staticInterop
@anonymous
class SetCertificatesDetails {
  external factory SetCertificatesDetails({
    /// When called in response to [onCertificatesUpdateRequested], should
    /// contain the received `certificatesRequestId` value. Otherwise,
    /// should be unset.
    int? certificatesRequestId,

    /// Error that occurred while extracting the certificates, if any. This error
    /// will be surfaced to the user when appropriate.
    Error? error,

    /// List of currently available client certificates.
    JSArray clientCertificates,
  });
}

extension SetCertificatesDetailsExtension on SetCertificatesDetails {
  /// When called in response to [onCertificatesUpdateRequested], should
  /// contain the received `certificatesRequestId` value. Otherwise,
  /// should be unset.
  external int? certificatesRequestId;

  /// Error that occurred while extracting the certificates, if any. This error
  /// will be surfaced to the user when appropriate.
  external Error? error;

  /// List of currently available client certificates.
  external JSArray clientCertificates;
}

@JS()
@staticInterop
@anonymous
class CertificatesUpdateRequest {
  external factory CertificatesUpdateRequest(
      {
      /// Request identifier to be passed to [setCertificates].
      int certificatesRequestId});
}

extension CertificatesUpdateRequestExtension on CertificatesUpdateRequest {
  /// Request identifier to be passed to [setCertificates].
  external int certificatesRequestId;
}

@JS()
@staticInterop
@anonymous
class SignatureRequest {
  external factory SignatureRequest({
    /// Request identifier to be passed to [reportSignature].
    int signRequestId,

    /// Data to be signed. Note that the data is not hashed.
    JSArrayBuffer input,

    /// Signature algorithm to be used.
    Algorithm algorithm,

    /// The DER encoding of a X.509 certificate. The extension must sign
    /// `input` using the associated private key.
    JSArrayBuffer certificate,
  });
}

extension SignatureRequestExtension on SignatureRequest {
  /// Request identifier to be passed to [reportSignature].
  external int signRequestId;

  /// Data to be signed. Note that the data is not hashed.
  external JSArrayBuffer input;

  /// Signature algorithm to be used.
  external Algorithm algorithm;

  /// The DER encoding of a X.509 certificate. The extension must sign
  /// `input` using the associated private key.
  external JSArrayBuffer certificate;
}

@JS()
@staticInterop
@anonymous
class ReportSignatureDetails {
  external factory ReportSignatureDetails({
    /// Request identifier that was received via the [onSignatureRequested]
    /// event.
    int signRequestId,

    /// Error that occurred while generating the signature, if any.
    Error? error,

    /// The signature, if successfully generated.
    JSArrayBuffer? signature,
  });
}

extension ReportSignatureDetailsExtension on ReportSignatureDetails {
  /// Request identifier that was received via the [onSignatureRequested]
  /// event.
  external int signRequestId;

  /// Error that occurred while generating the signature, if any.
  external Error? error;

  /// The signature, if successfully generated.
  external JSArrayBuffer? signature;
}

@JS()
@staticInterop
@anonymous
class CertificateInfo {
  external factory CertificateInfo({
    /// Must be the DER encoding of a X.509 certificate. Currently, only
    /// certificates of RSA keys are supported.
    JSArrayBuffer certificate,

    /// Must be set to all hashes supported for this certificate. This extension
    /// will only be asked for signatures of digests calculated with one of these
    /// hash algorithms. This should be in order of decreasing hash preference.
    JSArray supportedHashes,
  });
}

extension CertificateInfoExtension on CertificateInfo {
  /// Must be the DER encoding of a X.509 certificate. Currently, only
  /// certificates of RSA keys are supported.
  external JSArrayBuffer certificate;

  /// Must be set to all hashes supported for this certificate. This extension
  /// will only be asked for signatures of digests calculated with one of these
  /// hash algorithms. This should be in order of decreasing hash preference.
  external JSArray supportedHashes;
}

@JS()
@staticInterop
@anonymous
class SignRequest {
  external factory SignRequest({
    /// The unique ID to be used by the extension should it need to call a method
    /// that requires it, e.g. requestPin.
    int signRequestId,

    /// The digest that must be signed.
    JSArrayBuffer digest,

    /// Refers to the hash algorithm that was used to create `digest`.
    Hash hash,

    /// The DER encoding of a X.509 certificate. The extension must sign
    /// `digest` using the associated private key.
    JSArrayBuffer certificate,
  });
}

extension SignRequestExtension on SignRequest {
  /// The unique ID to be used by the extension should it need to call a method
  /// that requires it, e.g. requestPin.
  external int signRequestId;

  /// The digest that must be signed.
  external JSArrayBuffer digest;

  /// Refers to the hash algorithm that was used to create `digest`.
  external Hash hash;

  /// The DER encoding of a X.509 certificate. The extension must sign
  /// `digest` using the associated private key.
  external JSArrayBuffer certificate;
}

@JS()
@staticInterop
@anonymous
class RequestPinDetails {
  external factory RequestPinDetails({
    /// The ID given by Chrome in SignRequest.
    int signRequestId,

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
  });
}

extension RequestPinDetailsExtension on RequestPinDetails {
  /// The ID given by Chrome in SignRequest.
  external int signRequestId;

  /// The type of code requested. Default is PIN.
  external PinRequestType? requestType;

  /// The error template displayed to the user. This should be set if the
  /// previous request failed, to notify the user of the failure reason.
  external PinRequestErrorType? errorType;

  /// The number of attempts left. This is provided so that any UI can present
  /// this information to the user. Chrome is not expected to enforce this,
  /// instead stopPinRequest should be called by the extension with
  /// errorType = MAX_ATTEMPTS_EXCEEDED when the number of pin requests is
  /// exceeded.
  external int? attemptsLeft;
}

@JS()
@staticInterop
@anonymous
class StopPinRequestDetails {
  external factory StopPinRequestDetails({
    /// The ID given by Chrome in SignRequest.
    int signRequestId,

    /// The error template. If present it is displayed to user. Intended to
    /// contain the reason for stopping the flow if it was caused by an error,
    /// e.g. MAX_ATTEMPTS_EXCEEDED.
    PinRequestErrorType? errorType,
  });
}

extension StopPinRequestDetailsExtension on StopPinRequestDetails {
  /// The ID given by Chrome in SignRequest.
  external int signRequestId;

  /// The error template. If present it is displayed to user. Intended to
  /// contain the reason for stopping the flow if it was caused by an error,
  /// e.g. MAX_ATTEMPTS_EXCEEDED.
  external PinRequestErrorType? errorType;
}

@JS()
@staticInterop
@anonymous
class PinResponseDetails {
  external factory PinResponseDetails(
      {
      /// The code provided by the user. Empty if user closed the dialog or some
      /// other error occurred.
      String? userInput});
}

extension PinResponseDetailsExtension on PinResponseDetails {
  /// The code provided by the user. Empty if user closed the dialog or some
  /// other error occurred.
  external String? userInput;
}
