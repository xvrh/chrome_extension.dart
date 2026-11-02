// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import
// ignore_for_file: unintended_html_in_doc_comment

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSDocumentScanExtension on JSChrome {
  @JS('documentScan')
  external JSDocumentScan? get documentScanNullable;

  /// Use the `chrome.documentScan` API to discover and retrieve
  /// images from attached document scanners.
  JSDocumentScan get documentScan {
    var documentScanNullable = this.documentScanNullable;
    if (documentScanNullable == null) {
      throw ApiNotAvailableException('chrome.documentScan');
    }
    return documentScanNullable;
  }
}

extension type JSDocumentScan._(JSObject _) {
  /// Performs a document scan and returns a Promise that resolves
  /// with a [ScanResults] object. If a callback is passed to
  /// this function, the returned data is passed to it instead.
  /// |options| : An object containing scan parameters.
  /// |Returns| : Returns a Promise which resolves with the scan results.
  external JSPromise<ScanResults> scan(ScanOptions options);

  /// Gets the list of available scanners and returns a Promise that
  /// resolves with a [GetScannerListResponse] object. If a callback
  /// is passed to this function, returned data is passed to it instead.
  /// |filter| : A [DeviceFilter] indicating which types of scanners
  /// should be returned.
  /// |Returns| : Returns a Promise which resolves with the result and list of
  /// scanners.
  external JSPromise<GetScannerListResponse> getScannerList(
      DeviceFilter filter);

  /// Opens a scanner for exclusive access and returns a Promise that
  /// resolves with an [OpenScannerResponse] object. If a callback
  /// is passed to this function, returned data is passed to it instead.
  /// |scannerId| : The ID of a scanner to be opened. This value is one
  /// returned from a previous call to [getScannerList].
  /// |Returns| : Returns a Promise which resolves with the result.
  external JSPromise<OpenScannerResponse> openScanner(String scannerId);

  /// Gets the group names and member options from a scanner previously
  /// opened by [openScanner]. This method returns a Promise that
  /// resolves with a [GetOptionGroupsResponse] object. If a callback
  /// is passed to this function, returned data is passed to it instead.
  /// |scannerHandle| : The handle of an open scanner returned from a call
  /// to [openScanner].
  /// |Returns| : Returns a Promise which resolves with the result.
  external JSPromise<GetOptionGroupsResponse> getOptionGroups(
      String scannerHandle);

  /// Closes the scanner with the passed in handle and returns a Promise
  /// that resolves with a [CloseScannerResponse] object. If a callback
  /// is used, the object is passed to it instead. Even if the response is
  /// not a success, the supplied handle becomes invalid and should not be
  /// used for further operations.
  /// |scannerHandle| : Specifies the handle of an open scanner that was
  /// previously returned from a call to [openScanner].
  /// |Returns| : Returns a Promise which resolves with the result.
  external JSPromise<CloseScannerResponse> closeScanner(String scannerHandle);

  /// Sets options on the specified scanner and returns a Promise that
  /// resolves with a [SetOptionsResponse] object containing the
  /// result of trying to set every value in the order of the passed-in
  /// [OptionSetting] object. If a callback is used, the object is
  /// passed to it instead.
  /// |scannerHandle| : The handle of the scanner to set options on. This
  /// should be a value previously returned from a call to [openScanner].
  /// |options| : A list of `OptionSetting` objects to be applied to
  /// the scanner.
  /// |Returns| : Returns a Promise which resolves with the result.
  external JSPromise<SetOptionsResponse> setOptions(
    String scannerHandle,
    JSArray options,
  );

  /// Starts a scan on the specified scanner and returns a Promise that
  /// resolves with a [StartScanResponse]. If a callback is used,
  /// the object is passed to it instead. If the call was successful, the
  /// response includes a job handle that can be used in subsequent calls
  /// to read scan data or cancel a scan.
  /// |scannerHandle| : The handle of an open scanner. This should be a value
  /// previously returned from a call to [openScanner].
  /// |options| : A [StartScanOptions] object indicating the options to
  /// be used for the scan. The `StartScanOptions.format` property
  /// must match one of the entries returned in the scanner's
  /// `ScannerInfo`.
  /// |Returns| : Returns a Promise which resolves with the result.
  external JSPromise<StartScanResponse> startScan(
    String scannerHandle,
    StartScanOptions options,
  );

  /// Cancels a started scan and returns a Promise that resolves with a
  /// [CancelScanResponse] object. If a callback is used, the object
  /// is passed to it instead.
  /// |job| : The handle of an active scan job previously returned from a
  /// call to [startScan].
  /// |Returns| : Returns a Promise which resolves with the result.
  external JSPromise<CancelScanResponse> cancelScan(String job);

  /// Reads the next chunk of available image data from an active job handle,
  /// and returns a Promise that resolves with a [ReadScanDataResponse]
  /// object. If a callback is used, the object is passed to it instead.
  ///
  /// <aside class="note">**Note:**It is valid for a response result to be
  /// `SUCCESS` with a zero-length `data`
  /// member. This means the scanner is still working but does not yet have
  /// additional data ready. The caller should wait a short time and try again.
  ///
  /// When the scan job completes, the response will have the result value of
  /// `EOF`. This response may contain a final
  /// non-zero `data` member.</aside>
  ///
  /// |job| : Active job handle previously returned from
  /// [startScan].
  /// |Returns| : Returns a Promise which resolves with the result.
  external JSPromise<ReadScanDataResponse> readScanData(String job);
}

/// An enum that indicates the result of each operation.
typedef OperationResult = JSString;

/// Indicates how the scanner is connected to the computer.
typedef ConnectionType = JSString;

/// The data type of an option.
typedef OptionType = JSString;

/// Indicates the data type for [ScannerOption.unit].
typedef OptionUnit = JSString;

/// The data type of constraint represented by an [OptionConstraint].
typedef ConstraintType = JSString;

/// How an option can be changed.
typedef Configurability = JSString;
extension type ScanOptions._(JSObject _) implements JSObject {
  external factory ScanOptions({
    /// The MIME types that are accepted by the caller.
    JSArray? mimeTypes,

    /// The number of scanned images allowed. The default is 1.
    int? maxImages,
  });

  /// The MIME types that are accepted by the caller.
  external JSArray? mimeTypes;

  /// The number of scanned images allowed. The default is 1.
  external int? maxImages;
}
extension type ScanResults._(JSObject _) implements JSObject {
  external factory ScanResults({
    /// An array of data image URLs in a form that can be passed as the "src"
    /// value to an image tag.
    JSArray dataUrls,

    /// The MIME type of the `dataUrls`.
    String mimeType,
  });

  /// An array of data image URLs in a form that can be passed as the "src"
  /// value to an image tag.
  external JSArray dataUrls;

  /// The MIME type of the `dataUrls`.
  external String mimeType;
}
extension type ScannerInfo._(JSObject _) implements JSObject {
  external factory ScannerInfo({
    /// The ID of a specific scanner.
    String scannerId,

    /// A human-readable name for the scanner to display in the UI.
    String name,

    /// The scanner manufacturer.
    String manufacturer,

    /// The scanner model if it is available, or a generic description.
    String model,

    /// For matching against other `ScannerInfo` entries that point
    /// to the same physical device.
    String deviceUuid,

    /// Indicates how the scanner is connected to the computer.
    ConnectionType connectionType,

    /// If true, the scanner connection's transport cannot be intercepted by a
    /// passive listener, such as TLS or USB.
    bool secure,

    /// An array of MIME types that can be requested for returned scans.
    JSArray imageFormats,

    /// A human-readable description of the protocol or driver used to
    /// access the scanner, such as Mopria, WSD, or epsonds. This is primarily
    /// useful for allowing a user to choose between protocols if a device
    /// supports multiple protocols.
    String protocolType,
  });

  /// The ID of a specific scanner.
  external String scannerId;

  /// A human-readable name for the scanner to display in the UI.
  external String name;

  /// The scanner manufacturer.
  external String manufacturer;

  /// The scanner model if it is available, or a generic description.
  external String model;

  /// For matching against other `ScannerInfo` entries that point
  /// to the same physical device.
  external String deviceUuid;

  /// Indicates how the scanner is connected to the computer.
  external ConnectionType connectionType;

  /// If true, the scanner connection's transport cannot be intercepted by a
  /// passive listener, such as TLS or USB.
  external bool secure;

  /// An array of MIME types that can be requested for returned scans.
  external JSArray imageFormats;

  /// A human-readable description of the protocol or driver used to
  /// access the scanner, such as Mopria, WSD, or epsonds. This is primarily
  /// useful for allowing a user to choose between protocols if a device
  /// supports multiple protocols.
  external String protocolType;
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
    /// The option name using lowercase ASCII letters, numbers, and dashes.
    /// Diacritics are not allowed.
    String name,

    /// A printable one-line title.
    String title,

    /// A longer description of the option.
    String description,

    /// The data type contained in the `value` property, which
    /// is needed for setting this option.
    OptionType type,

    /// The unit of measurement for this option.
    OptionUnit unit,

    /// The current value of the option, if relevant. Note that the data
    /// type of this property must match the data type specified in
    /// `type`.
    JSAny? value,

    /// Defines [OptionConstraint] on the current scanner option.
    OptionConstraint? constraint,

    /// Indicates that this option can be detected from software.
    bool isDetectable,

    /// Indicates whether and how the option can be changed.
    Configurability configurability,

    /// Can be automatically set by the scanner driver.
    bool isAutoSettable,

    /// Emulated by the scanner driver if true.
    bool isEmulated,

    /// Indicates the option is active and can be set or retrieved. If false,
    /// the `value` property will not be set.
    bool isActive,

    /// Indicates that the UI should not display this option by default.
    bool isAdvanced,

    /// Indicates that the option is used for internal configuration and
    /// should never be displayed in the UI.
    bool isInternal,
  });

  /// The option name using lowercase ASCII letters, numbers, and dashes.
  /// Diacritics are not allowed.
  external String name;

  /// A printable one-line title.
  external String title;

  /// A longer description of the option.
  external String description;

  /// The data type contained in the `value` property, which
  /// is needed for setting this option.
  external OptionType type;

  /// The unit of measurement for this option.
  external OptionUnit unit;

  /// The current value of the option, if relevant. Note that the data
  /// type of this property must match the data type specified in
  /// `type`.
  external JSAny? value;

  /// Defines [OptionConstraint] on the current scanner option.
  external OptionConstraint? constraint;

  /// Indicates that this option can be detected from software.
  external bool isDetectable;

  /// Indicates whether and how the option can be changed.
  external Configurability configurability;

  /// Can be automatically set by the scanner driver.
  external bool isAutoSettable;

  /// Emulated by the scanner driver if true.
  external bool isEmulated;

  /// Indicates the option is active and can be set or retrieved. If false,
  /// the `value` property will not be set.
  external bool isActive;

  /// Indicates that the UI should not display this option by default.
  external bool isAdvanced;

  /// Indicates that the option is used for internal configuration and
  /// should never be displayed in the UI.
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
    /// Provides a printable title, for example "Geometry options".
    String title,

    /// An array of option names in driver-provided order.
    JSArray members,
  });

  /// Provides a printable title, for example "Geometry options".
  external String title;

  /// An array of option names in driver-provided order.
  external JSArray members;
}
extension type GetScannerListResponse._(JSObject _) implements JSObject {
  external factory GetScannerListResponse({
    /// The enumeration result. Note that partial results could be
    /// returned even if this indicates an error.
    OperationResult result,

    /// A possibly-empty list of scanners that match the provided
    /// [DeviceFilter].
    JSArray scanners,
  });

  /// The enumeration result. Note that partial results could be
  /// returned even if this indicates an error.
  external OperationResult result;

  /// A possibly-empty list of scanners that match the provided
  /// [DeviceFilter].
  external JSArray scanners;
}
extension type OpenScannerResponse._(JSObject _) implements JSObject {
  external factory OpenScannerResponse({
    /// The scanner ID passed to `openScanner()`.
    String scannerId,

    /// The result of opening the scanner. If the value of this is
    /// `SUCCESS`, the `scannerHandle` and
    /// `options` properties will be populated.
    OperationResult result,

    /// If `result` is `SUCCESS`, a
    /// handle to the scanner that can be used for further operations.
    String? scannerHandle,

    /// If `result` is `SUCCESS`,
    /// provides a key-value mapping where the key is a device-specific
    /// option and the value is an instance of [ScannerOption].
    JSAny? options,
  });

  /// The scanner ID passed to `openScanner()`.
  external String scannerId;

  /// The result of opening the scanner. If the value of this is
  /// `SUCCESS`, the `scannerHandle` and
  /// `options` properties will be populated.
  external OperationResult result;

  /// If `result` is `SUCCESS`, a
  /// handle to the scanner that can be used for further operations.
  external String? scannerHandle;

  /// If `result` is `SUCCESS`,
  /// provides a key-value mapping where the key is a device-specific
  /// option and the value is an instance of [ScannerOption].
  external JSAny? options;
}
extension type GetOptionGroupsResponse._(JSObject _) implements JSObject {
  external factory GetOptionGroupsResponse({
    /// The same scanner handle as was passed to [getOptionGroups].
    String scannerHandle,

    /// The result of getting the option groups. If the value of this is
    /// `SUCCESS`, the `groups` property will be
    /// populated.
    OperationResult result,

    /// If `result` is `SUCCESS`, provides a
    /// list of option groups in the order supplied by the scanner driver.
    JSArray? groups,
  });

  /// The same scanner handle as was passed to [getOptionGroups].
  external String scannerHandle;

  /// The result of getting the option groups. If the value of this is
  /// `SUCCESS`, the `groups` property will be
  /// populated.
  external OperationResult result;

  /// If `result` is `SUCCESS`, provides a
  /// list of option groups in the order supplied by the scanner driver.
  external JSArray? groups;
}
extension type CloseScannerResponse._(JSObject _) implements JSObject {
  external factory CloseScannerResponse({
    /// The same scanner handle as was passed to [closeScanner].
    String scannerHandle,

    /// The result of closing the scanner. Even if this value is not
    /// `SUCCESS`, the handle will be invalid and
    /// should not be used for any further operations.
    OperationResult result,
  });

  /// The same scanner handle as was passed to [closeScanner].
  external String scannerHandle;

  /// The result of closing the scanner. Even if this value is not
  /// `SUCCESS`, the handle will be invalid and
  /// should not be used for any further operations.
  external OperationResult result;
}
extension type OptionSetting._(JSObject _) implements JSObject {
  external factory OptionSetting({
    /// Indicates the name of the option to set.
    String name,

    /// Indicates the data type of the option. The requested data type must
    /// match the real data type of the underlying option.
    OptionType type,

    /// Indicates the value to set. Leave unset to request automatic setting for
    /// options that have `autoSettable` enabled. The data type
    /// supplied for `value` must match `type`.
    JSAny? value,
  });

  /// Indicates the name of the option to set.
  external String name;

  /// Indicates the data type of the option. The requested data type must
  /// match the real data type of the underlying option.
  external OptionType type;

  /// Indicates the value to set. Leave unset to request automatic setting for
  /// options that have `autoSettable` enabled. The data type
  /// supplied for `value` must match `type`.
  external JSAny? value;
}
extension type SetOptionResult._(JSObject _) implements JSObject {
  external factory SetOptionResult({
    /// Indicates the name of the option that was set.
    String name,

    /// Indicates the result of setting the option.
    OperationResult result,
  });

  /// Indicates the name of the option that was set.
  external String name;

  /// Indicates the result of setting the option.
  external OperationResult result;
}
extension type SetOptionsResponse._(JSObject _) implements JSObject {
  external factory SetOptionsResponse({
    /// Provides the scanner handle passed to `setOptions()`.
    String scannerHandle,

    /// An array of results, one each for every passed-in
    /// `OptionSetting`.
    JSArray results,

    /// An updated key-value mapping from option names to
    /// [ScannerOption] values containing the new configuration after
    /// attempting to set all supplied options. This has the same structure as
    /// the `options` property in [OpenScannerResponse].
    ///
    /// This property will be set even if some options were not set successfully,
    /// but will be unset if retrieving the updated configuration fails (for
    /// example, if the scanner is disconnected in the middle of scanning).
    JSAny? options,
  });

  /// Provides the scanner handle passed to `setOptions()`.
  external String scannerHandle;

  /// An array of results, one each for every passed-in
  /// `OptionSetting`.
  external JSArray results;

  /// An updated key-value mapping from option names to
  /// [ScannerOption] values containing the new configuration after
  /// attempting to set all supplied options. This has the same structure as
  /// the `options` property in [OpenScannerResponse].
  ///
  /// This property will be set even if some options were not set successfully,
  /// but will be unset if retrieving the updated configuration fails (for
  /// example, if the scanner is disconnected in the middle of scanning).
  external JSAny? options;
}
extension type StartScanOptions._(JSObject _) implements JSObject {
  external factory StartScanOptions({
    /// Specifies the MIME type to return scanned data in.
    String format,

    /// If a non-zero value is specified, limits the maximum scanned bytes
    /// returned in a single [readScanData] response to that value.  The
    /// smallest allowed value is 32768 (32 KB).  If this property is not
    /// specified, the size of a returned chunk may be as large as the entire
    /// scanned image.
    int? maxReadSize,
  });

  /// Specifies the MIME type to return scanned data in.
  external String format;

  /// If a non-zero value is specified, limits the maximum scanned bytes
  /// returned in a single [readScanData] response to that value.  The
  /// smallest allowed value is 32768 (32 KB).  If this property is not
  /// specified, the size of a returned chunk may be as large as the entire
  /// scanned image.
  external int? maxReadSize;
}
extension type StartScanResponse._(JSObject _) implements JSObject {
  external factory StartScanResponse({
    /// Provides the same scanner handle that was passed to
    /// `startScan()`.
    String scannerHandle,

    /// The result of starting a scan. If the value of this is
    /// `SUCCESS`, the `job` property will be populated.
    OperationResult result,

    /// If `result` is `SUCCESS`, provides a
    /// handle that can be used to read scan data or cancel the job.
    String? job,
  });

  /// Provides the same scanner handle that was passed to
  /// `startScan()`.
  external String scannerHandle;

  /// The result of starting a scan. If the value of this is
  /// `SUCCESS`, the `job` property will be populated.
  external OperationResult result;

  /// If `result` is `SUCCESS`, provides a
  /// handle that can be used to read scan data or cancel the job.
  external String? job;
}
extension type CancelScanResponse._(JSObject _) implements JSObject {
  external factory CancelScanResponse({
    /// Provides the same job handle that was passed to
    /// `cancelScan()`.
    String job,

    /// The backend's cancel scan result. If the result is
    /// `OperationResult.SUCCESS` or
    /// `OperationResult.CANCELLED`, the scan has been cancelled and
    /// the scanner is ready to start a new scan.  If the result is
    /// `OperationResult.DEVICE_BUSY `, the scanner is still
    /// processing the requested cancellation; the caller should wait a short
    /// time and try the request again. Other result values indicate a permanent
    /// error that should not be retried.
    OperationResult result,
  });

  /// Provides the same job handle that was passed to
  /// `cancelScan()`.
  external String job;

  /// The backend's cancel scan result. If the result is
  /// `OperationResult.SUCCESS` or
  /// `OperationResult.CANCELLED`, the scan has been cancelled and
  /// the scanner is ready to start a new scan.  If the result is
  /// `OperationResult.DEVICE_BUSY `, the scanner is still
  /// processing the requested cancellation; the caller should wait a short
  /// time and try the request again. Other result values indicate a permanent
  /// error that should not be retried.
  external OperationResult result;
}
extension type ReadScanDataResponse._(JSObject _) implements JSObject {
  external factory ReadScanDataResponse({
    /// Provides the job handle passed to `readScanData()`.
    String job,

    /// The result of reading data. If its value is
    /// `SUCCESS`, then `data` contains the
    /// _next_ (possibly zero-length) chunk of image data that is ready
    /// for reading. If its value is `EOF`, the `data`
    /// contains the _last_ chunk of image data.
    OperationResult result,

    /// If `result` is `SUCCESS`, contains
    /// the _next_ chunk of scanned image data. If `result` is
    /// `EOF`, contains the _last_ chunk of
    /// scanned image data.
    JSArrayBuffer? data,

    /// If `result` is `SUCCESS`, an estimate of
    /// how much of the total scan data has been delivered so far, in the range
    /// 0 to 100.
    int? estimatedCompletion,
  });

  /// Provides the job handle passed to `readScanData()`.
  external String job;

  /// The result of reading data. If its value is
  /// `SUCCESS`, then `data` contains the
  /// _next_ (possibly zero-length) chunk of image data that is ready
  /// for reading. If its value is `EOF`, the `data`
  /// contains the _last_ chunk of image data.
  external OperationResult result;

  /// If `result` is `SUCCESS`, contains
  /// the _next_ chunk of scanned image data. If `result` is
  /// `EOF`, contains the _last_ chunk of
  /// scanned image data.
  external JSArrayBuffer? data;

  /// If `result` is `SUCCESS`, an estimate of
  /// how much of the total scan data has been delivered so far, in the range
  /// 0 to 100.
  external int? estimatedCompletion;
}
