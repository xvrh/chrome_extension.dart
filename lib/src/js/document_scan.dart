// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSDocumentScanExtension on JSChrome {
  @JS('documentScan')
  external JSDocumentScan? get documentScanNullable;

  /// Use the `chrome.documentScan` API to discover and retrieve
  /// images from attached paper document scanners.
  JSDocumentScan get documentScan {
    var documentScanNullable = this.documentScanNullable;
    if (documentScanNullable == null) {
      throw ApiNotAvailableException('chrome.documentScan');
    }
    return documentScanNullable;
  }
}

extension type JSDocumentScan._(JSObject _) {
  /// Performs a document scan.  On success, the PNG data will be
  /// sent to the callback.
  /// |options| : Object containing scan parameters.
  /// |callback| : Called with the result and data from the scan.
  external JSPromise scan(ScanOptions options);

  /// Gets the list of available scanners.  On success, the list will be
  /// sent to the callback.
  /// |filter| : `DeviceFilter` indicating which types of scanners
  /// should be returned.
  /// |callback| : Called with the result and list of scanners.
  external JSPromise getScannerList(DeviceFilter filter);

  /// Opens a scanner for exclusive access.  On success, the response containing
  /// a scanner handle and configuration will be sent to the callback.
  /// |scannerId| : Scanner id previously returned from `getScannerList`
  /// indicating which scanner should be opened.
  /// |callback| : Called with the result.
  external JSPromise openScanner(String scannerId);

  /// Gets the group names and member options from a scanner handle previously
  /// opened by `openScanner`.
  /// |scannerHandle| : Open scanner handle previously returned from
  /// `openScanner`.
  /// |callback| : Called with the result.
  external JSPromise getOptionGroups(String scannerHandle);

  /// Closes a previously opened scanner handle.  A response indicating the
  /// outcome will be sent to the callback.  Even if the response is not a
  /// success, the supplied handle will become invalid and should not be used
  /// for further operations.
  /// |scannerHandle| : Open scanner handle previously returned from
  /// `openScanner`.
  /// |callback| : Called with the result.
  external JSPromise closeScanner(String scannerHandle);

  /// Sends the list of new option values in `options` as a bundle
  /// to be set on `scannerHandle`.  Each option will be set by the
  /// backend the order specified.  Returns a backend response indicating the
  /// result of each option setting and a new set of final option values after
  /// all options have been updated.
  /// |scannerHandle| : Open scanner handle previously returned from
  /// `openScanner`.
  /// |options| : A list of `OptionSetting`s that will be applied to
  /// `scannerHandle`.
  /// |callback| : Called with the result.
  external JSPromise setOptions(
    String scannerHandle,
    JSArray options,
  );

  /// Starts a scan using a previously opened scanner handle.  A response
  /// indicating the outcome will be sent to the callback.  If successful, the
  /// response will include a job handle that can be used in subsequent calls
  /// to read scan data or cancel a scan.
  /// |scannerHandle| : Open scanner handle previously returned from
  /// `openScanner`.
  /// |options| : `StartScanOptions` indicating what options are to
  /// be used for the scan.  `StartScanOptions.format` must match
  /// one of the entries returned in the scanner's `ScannerInfo`.
  /// |callback| : Called with the result.
  external JSPromise startScan(
    String scannerHandle,
    StartScanOptions options,
  );

  /// Cancels a scan that was previously started using `startScan`.
  /// The response is sent to the callback.
  /// |job| : An active scan job previously returned from
  /// `startScan`.
  /// |callback| : Called with the result.
  external JSPromise cancelScan(String job);

  /// Reads the next chunk of available image data from an active job handle.
  /// A response indicating the outcome will be sent to the callback.
  ///
  /// It is valid for a response to have result
  /// `OperationResult.SUCCESS` with a zero-length
  /// `data` member.  This means the scanner is still working but
  /// does not yet have additional data ready.  The caller should wait a short
  /// time and try again.
  ///
  /// When the scan job completes, the response will have the result
  /// `OperationResult.EOF`.  This response may contain a final
  /// non-zero `data` member.
  /// |job| : Active job handle previously returned from
  /// `startScan`.
  /// |callback| : Called with the result.
  external JSPromise readScanData(String job);
}

/// OperationResult is an enum that indicates the result of each operation
/// performed by the backend.  It contains the same causes as SANE_Status plus
/// additional statuses that come from the IPC layers and image conversion
/// stages.
typedef OperationResult = String;

/// How the scanner is connected to the computer.
typedef ConnectionType = String;

/// The type of an option.  This is the same set of types as SANE_Value_Type.
typedef OptionType = String;

/// The unit of measurement for an option.  This is the same set of units as
/// SANE_Unit.
typedef OptionUnit = String;

/// The type of constraint represented by an OptionConstraint.
typedef ConstraintType = String;

/// How an option can be changed.
typedef Configurability = String;
extension type ScanOptions._(JSObject _) implements JSObject {
  external factory ScanOptions({
    /// The MIME types that are accepted by the caller.
    JSArray? mimeTypes,

    /// The number of scanned images allowed (defaults to 1).
    int? maxImages,
  });

  /// The MIME types that are accepted by the caller.
  external JSArray? mimeTypes;

  /// The number of scanned images allowed (defaults to 1).
  external int? maxImages;
}
extension type ScanResults._(JSObject _) implements JSObject {
  external factory ScanResults({
    /// The data image URLs in a form that can be passed as the "src" value to
    /// an image tag.
    JSArray dataUrls,

    /// The MIME type of `dataUrls`.
    String mimeType,
  });

  /// The data image URLs in a form that can be passed as the "src" value to
  /// an image tag.
  external JSArray dataUrls;

  /// The MIME type of `dataUrls`.
  external String mimeType;
}
extension type ScannerInfo._(JSObject _) implements JSObject {
  external factory ScannerInfo({
    /// For connecting with `openScanner`.
    String scannerId,

    /// Printable name for displaying in the UI.
    String name,

    /// Scanner manufacturer.
    String manufacturer,

    /// Scanner model if available, or a generic description.
    String model,

    /// For matching against other `ScannerInfo` entries that point
    /// to the same physical device.
    String deviceUuid,

    /// How the scanner is connected to the computer.
    ConnectionType connectionType,

    /// If true, the scanner connection's transport cannot be intercepted by a
    /// passive listener, such as TLS or USB.
    bool secure,

    /// MIME types that can be requested for returned scans.
    JSArray imageFormats,
  });

  /// For connecting with `openScanner`.
  external String scannerId;

  /// Printable name for displaying in the UI.
  external String name;

  /// Scanner manufacturer.
  external String manufacturer;

  /// Scanner model if available, or a generic description.
  external String model;

  /// For matching against other `ScannerInfo` entries that point
  /// to the same physical device.
  external String deviceUuid;

  /// How the scanner is connected to the computer.
  external ConnectionType connectionType;

  /// If true, the scanner connection's transport cannot be intercepted by a
  /// passive listener, such as TLS or USB.
  external bool secure;

  /// MIME types that can be requested for returned scans.
  external JSArray imageFormats;
}
extension type OptionConstraint._(JSObject _) implements JSObject {
  external factory OptionConstraint({
    ConstraintType type,
    JSAny? min,
    JSAny? max,
    JSAny? quant,
    JSAny? list,
  });

  external ConstraintType type;

  external JSAny? min;

  external JSAny? max;

  external JSAny? quant;

  external JSAny? list;
}
extension type ScannerOption._(JSObject _) implements JSObject {
  external factory ScannerOption({
    /// Option name using lowercase a-z, numbers, and dashes.
    String name,

    /// Printable one-line title.
    String title,

    /// Longer description of the option.
    String description,

    /// The type that `value` will contain and that is needed for
    /// setting this option.
    OptionType type,

    /// Unit of measurement for this option.
    OptionUnit unit,

    /// Current value of the option if relevant. Note the type passed here must
    /// match the type specified in `type`.
    JSAny? value,

    /// Constraint on possible values.
    OptionConstraint? constraint,

    /// Can be detected from software.
    bool isDetectable,

    /// Whether/how the option can be changed.
    Configurability configurability,

    /// Can be automatically set by the backend.
    bool isAutoSettable,

    /// Emulated by the backend if true.
    bool isEmulated,

    /// Option is active and can be set/retrieved.  If false, the
    /// `value` field will not be set.
    bool isActive,

    /// UI should not display this option by default.
    bool isAdvanced,

    /// Option is used for internal configuration and should never be displayed
    /// in the UI.
    bool isInternal,
  });

  /// Option name using lowercase a-z, numbers, and dashes.
  external String name;

  /// Printable one-line title.
  external String title;

  /// Longer description of the option.
  external String description;

  /// The type that `value` will contain and that is needed for
  /// setting this option.
  external OptionType type;

  /// Unit of measurement for this option.
  external OptionUnit unit;

  /// Current value of the option if relevant. Note the type passed here must
  /// match the type specified in `type`.
  external JSAny? value;

  /// Constraint on possible values.
  external OptionConstraint? constraint;

  /// Can be detected from software.
  external bool isDetectable;

  /// Whether/how the option can be changed.
  external Configurability configurability;

  /// Can be automatically set by the backend.
  external bool isAutoSettable;

  /// Emulated by the backend if true.
  external bool isEmulated;

  /// Option is active and can be set/retrieved.  If false, the
  /// `value` field will not be set.
  external bool isActive;

  /// UI should not display this option by default.
  external bool isAdvanced;

  /// Option is used for internal configuration and should never be displayed
  /// in the UI.
  external bool isInternal;
}
extension type DeviceFilter._(JSObject _) implements JSObject {
  external factory DeviceFilter({
    /// Only return scanners that are directly attached to the computer.
    bool? local,

    /// Only return scanners that use a secure transport, such as USB or TLS.
    bool? secure,
  });

  /// Only return scanners that are directly attached to the computer.
  external bool? local;

  /// Only return scanners that use a secure transport, such as USB or TLS.
  external bool? secure;
}
extension type OptionGroup._(JSObject _) implements JSObject {
  external factory OptionGroup({
    /// Printable title, e.g. "Geometry options".
    String title,

    /// Names of contained options, in backend-provided order.
    JSArray members,
  });

  /// Printable title, e.g. "Geometry options".
  external String title;

  /// Names of contained options, in backend-provided order.
  external JSArray members;
}
extension type GetScannerListResponse._(JSObject _) implements JSObject {
  external factory GetScannerListResponse({
    /// The backend's enumeration result.  Note that partial results could be
    /// returned even if this indicates an error.
    OperationResult result,

    /// A possibly-empty list of scanners that match the provided
    /// `DeviceFilter`.
    JSArray scanners,
  });

  /// The backend's enumeration result.  Note that partial results could be
  /// returned even if this indicates an error.
  external OperationResult result;

  /// A possibly-empty list of scanners that match the provided
  /// `DeviceFilter`.
  external JSArray scanners;
}
extension type OpenScannerResponse._(JSObject _) implements JSObject {
  external factory OpenScannerResponse({
    /// Same scanner ID passed to `openScanner()`.
    String scannerId,

    /// Backend result of opening the scanner.
    OperationResult result,

    /// If `result` is `OperationResult.SUCCESS`, a handle
    /// to the scanner that can be used for further operations.
    String? scannerHandle,

    /// If `result` is `OperationResult.SUCCESS`, a
    /// key-value mapping from option names to `ScannerOption`.
    JSAny? options,
  });

  /// Same scanner ID passed to `openScanner()`.
  external String scannerId;

  /// Backend result of opening the scanner.
  external OperationResult result;

  /// If `result` is `OperationResult.SUCCESS`, a handle
  /// to the scanner that can be used for further operations.
  external String? scannerHandle;

  /// If `result` is `OperationResult.SUCCESS`, a
  /// key-value mapping from option names to `ScannerOption`.
  external JSAny? options;
}
extension type GetOptionGroupsResponse._(JSObject _) implements JSObject {
  external factory GetOptionGroupsResponse({
    /// Same scanner handle passed to `getOptionGroups()`.
    String scannerHandle,

    /// The backend's result of getting the option groups.
    OperationResult result,

    /// If `result` is `OperationResult.SUCCESS`, a list of
    /// option groups in the order supplied by the backend.
    JSArray? groups,
  });

  /// Same scanner handle passed to `getOptionGroups()`.
  external String scannerHandle;

  /// The backend's result of getting the option groups.
  external OperationResult result;

  /// If `result` is `OperationResult.SUCCESS`, a list of
  /// option groups in the order supplied by the backend.
  external JSArray? groups;
}
extension type CloseScannerResponse._(JSObject _) implements JSObject {
  external factory CloseScannerResponse({
    /// Same scanner handle passed to `closeScanner()`.
    String scannerHandle,

    /// Backend result of closing the scanner.  Even if this value is not
    /// `OperationResult.SUCCESS`, the handle will be invalid and
    /// should not be used for any further operations.
    OperationResult result,
  });

  /// Same scanner handle passed to `closeScanner()`.
  external String scannerHandle;

  /// Backend result of closing the scanner.  Even if this value is not
  /// `OperationResult.SUCCESS`, the handle will be invalid and
  /// should not be used for any further operations.
  external OperationResult result;
}
extension type OptionSetting._(JSObject _) implements JSObject {
  external factory OptionSetting({
    /// Name of the option to set.
    String name,

    /// Type of the option.  The requested type must match the real type of the
    /// underlying option.
    OptionType type,

    /// Value to set.  Leave unset to request automatic setting for options that
    /// have `autoSettable` enabled.  The type supplied for
    /// `value` must match `type`.
    JSAny? value,
  });

  /// Name of the option to set.
  external String name;

  /// Type of the option.  The requested type must match the real type of the
  /// underlying option.
  external OptionType type;

  /// Value to set.  Leave unset to request automatic setting for options that
  /// have `autoSettable` enabled.  The type supplied for
  /// `value` must match `type`.
  external JSAny? value;
}
extension type SetOptionResult._(JSObject _) implements JSObject {
  external factory SetOptionResult({
    /// Name of the option that was set.
    String name,

    /// Backend result of setting the option.
    OperationResult result,
  });

  /// Name of the option that was set.
  external String name;

  /// Backend result of setting the option.
  external OperationResult result;
}
extension type SetOptionsResponse._(JSObject _) implements JSObject {
  external factory SetOptionsResponse({
    /// The same scanner handle passed to `setOptions()`.
    String scannerHandle,

    /// One result per passed-in `OptionSetting`.
    JSArray results,

    /// Updated key-value mapping from option names to
    /// `ScannerOption` containing the new configuration after
    /// attempting to set all supplied options.  This has the same structure as
    /// the `options` field in `OpenScannerResponse`.
    ///
    /// This field will be set even if some options were not set successfully,
    /// but will be unset if retrieving the updated configuration fails (e.g.,
    /// if the scanner is disconnected in the middle).
    JSAny? options,
  });

  /// The same scanner handle passed to `setOptions()`.
  external String scannerHandle;

  /// One result per passed-in `OptionSetting`.
  external JSArray results;

  /// Updated key-value mapping from option names to
  /// `ScannerOption` containing the new configuration after
  /// attempting to set all supplied options.  This has the same structure as
  /// the `options` field in `OpenScannerResponse`.
  ///
  /// This field will be set even if some options were not set successfully,
  /// but will be unset if retrieving the updated configuration fails (e.g.,
  /// if the scanner is disconnected in the middle).
  external JSAny? options;
}
extension type StartScanOptions._(JSObject _) implements JSObject {
  external factory StartScanOptions(
      {
      /// MIME type to return scanned data in.
      String format});

  /// MIME type to return scanned data in.
  external String format;
}
extension type StartScanResponse._(JSObject _) implements JSObject {
  external factory StartScanResponse({
    /// The same scanner handle that was passed to `startScan()`.
    String scannerHandle,

    /// The backend's start scan result.
    OperationResult result,

    /// If `result` is `OperationResult.SUCCESS`, a handle
    /// that can be used to read scan data or cancel the job.
    String? job,
  });

  /// The same scanner handle that was passed to `startScan()`.
  external String scannerHandle;

  /// The backend's start scan result.
  external OperationResult result;

  /// If `result` is `OperationResult.SUCCESS`, a handle
  /// that can be used to read scan data or cancel the job.
  external String? job;
}
extension type CancelScanResponse._(JSObject _) implements JSObject {
  external factory CancelScanResponse({
    /// The same job handle that was passed to `cancelScan()`.
    String job,

    /// The backend's cancel scan result.
    OperationResult result,
  });

  /// The same job handle that was passed to `cancelScan()`.
  external String job;

  /// The backend's cancel scan result.
  external OperationResult result;
}
extension type ReadScanDataResponse._(JSObject _) implements JSObject {
  external factory ReadScanDataResponse({
    /// Same job handle passed to `readScanData()`.
    String job,

    /// The backend result of reading data.  If this is
    /// `OperationResult.SUCCESS`, `data` will contain the
    /// next (possibly zero-length) chunk of image data that was ready for
    /// reading.  If this is `OperationResult.EOF`, `data`
    /// will contain the final chunk of image data.
    OperationResult result,

    /// If result is `OperationResult.SUCCESS`, the next chunk of
    /// scanned image data.
    JSArrayBuffer? data,

    /// If result is `OperationResult.SUCCESS`, an estimate of how
    /// much of the total scan data has been delivered so far, in the range
    /// 0-100.
    int? estimatedCompletion,
  });

  /// Same job handle passed to `readScanData()`.
  external String job;

  /// The backend result of reading data.  If this is
  /// `OperationResult.SUCCESS`, `data` will contain the
  /// next (possibly zero-length) chunk of image data that was ready for
  /// reading.  If this is `OperationResult.EOF`, `data`
  /// will contain the final chunk of image data.
  external OperationResult result;

  /// If result is `OperationResult.SUCCESS`, the next chunk of
  /// scanned image data.
  external JSArrayBuffer? data;

  /// If result is `OperationResult.SUCCESS`, an estimate of how
  /// much of the total scan data has been delivered so far, in the range
  /// 0-100.
  external int? estimatedCompletion;
}
