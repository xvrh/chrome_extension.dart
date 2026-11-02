// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'dart:typed_data';
import 'src/internal_helpers.dart';
import 'src/js/document_scan.dart' as $js;

export 'src/chrome.dart' show chrome, EventStream;

final _documentScan = ChromeDocumentScan._();

extension ChromeDocumentScanExtension on Chrome {
  /// Use the `chrome.documentScan` API to discover and retrieve
  /// images from attached document scanners.
  ChromeDocumentScan get documentScan => _documentScan;
}

class ChromeDocumentScan {
  ChromeDocumentScan._();

  bool get isAvailable => $js.chrome.documentScanNullable != null && alwaysTrue;

  /// Performs a document scan and returns a Promise that resolves
  /// with a [ScanResults] object. If a callback is passed to
  /// this function, the returned data is passed to it instead.
  /// |options| : An object containing scan parameters.
  /// |Returns| : Returns a Promise which resolves with the scan results.
  Future<ScanResults> scan(ScanOptions options) async {
    var $res = await $js.chrome.documentScan.scan(options.toJS).toDart;
    return ScanResults.fromJS($res);
  }

  /// Gets the list of available scanners and returns a Promise that
  /// resolves with a [GetScannerListResponse] object. If a callback
  /// is passed to this function, returned data is passed to it instead.
  /// |filter| : A [DeviceFilter] indicating which types of scanners
  /// should be returned.
  /// |Returns| : Returns a Promise which resolves with the result and list of
  /// scanners.
  Future<GetScannerListResponse> getScannerList(DeviceFilter filter) async {
    var $res = await $js.chrome.documentScan.getScannerList(filter.toJS).toDart;
    return GetScannerListResponse.fromJS($res);
  }

  /// Opens a scanner for exclusive access and returns a Promise that
  /// resolves with an [OpenScannerResponse] object. If a callback
  /// is passed to this function, returned data is passed to it instead.
  /// |scannerId| : The ID of a scanner to be opened. This value is one
  /// returned from a previous call to [getScannerList].
  /// |Returns| : Returns a Promise which resolves with the result.
  Future<OpenScannerResponse> openScanner(String scannerId) async {
    var $res = await $js.chrome.documentScan.openScanner(scannerId).toDart;
    return OpenScannerResponse.fromJS($res);
  }

  /// Gets the group names and member options from a scanner previously
  /// opened by [openScanner]. This method returns a Promise that
  /// resolves with a [GetOptionGroupsResponse] object. If a callback
  /// is passed to this function, returned data is passed to it instead.
  /// |scannerHandle| : The handle of an open scanner returned from a call
  /// to [openScanner].
  /// |Returns| : Returns a Promise which resolves with the result.
  Future<GetOptionGroupsResponse> getOptionGroups(String scannerHandle) async {
    var $res =
        await $js.chrome.documentScan.getOptionGroups(scannerHandle).toDart;
    return GetOptionGroupsResponse.fromJS($res);
  }

  /// Closes the scanner with the passed in handle and returns a Promise
  /// that resolves with a [CloseScannerResponse] object. If a callback
  /// is used, the object is passed to it instead. Even if the response is
  /// not a success, the supplied handle becomes invalid and should not be
  /// used for further operations.
  /// |scannerHandle| : Specifies the handle of an open scanner that was
  /// previously returned from a call to [openScanner].
  /// |Returns| : Returns a Promise which resolves with the result.
  Future<CloseScannerResponse> closeScanner(String scannerHandle) async {
    var $res = await $js.chrome.documentScan.closeScanner(scannerHandle).toDart;
    return CloseScannerResponse.fromJS($res);
  }

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
  Future<SetOptionsResponse> setOptions(
    String scannerHandle,
    List<OptionSetting> options,
  ) async {
    var $res = await $js.chrome.documentScan
        .setOptions(
          scannerHandle,
          options.toJSArray((e) => e.toJS),
        )
        .toDart;
    return SetOptionsResponse.fromJS($res);
  }

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
  Future<StartScanResponse> startScan(
    String scannerHandle,
    StartScanOptions options,
  ) async {
    var $res = await $js.chrome.documentScan
        .startScan(
          scannerHandle,
          options.toJS,
        )
        .toDart;
    return StartScanResponse.fromJS($res);
  }

  /// Cancels a started scan and returns a Promise that resolves with a
  /// [CancelScanResponse] object. If a callback is used, the object
  /// is passed to it instead.
  /// |job| : The handle of an active scan job previously returned from a
  /// call to [startScan].
  /// |Returns| : Returns a Promise which resolves with the result.
  Future<CancelScanResponse> cancelScan(String job) async {
    var $res = await $js.chrome.documentScan.cancelScan(job).toDart;
    return CancelScanResponse.fromJS($res);
  }

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
  Future<ReadScanDataResponse> readScanData(String job) async {
    var $res = await $js.chrome.documentScan.readScanData(job).toDart;
    return ReadScanDataResponse.fromJS($res);
  }
}

/// An enum that indicates the result of each operation.
enum OperationResult {
  /// An unknown or generic failure occurred.
  unknown('UNKNOWN'),

  /// The operation succeeded.
  success('SUCCESS'),

  /// The operation is not supported.
  unsupported('UNSUPPORTED'),

  /// The operation was cancelled.
  cancelled('CANCELLED'),

  /// The device is busy.
  deviceBusy('DEVICE_BUSY'),

  /// Either the data or an argument passed to the method is not valid.
  invalid('INVALID'),

  /// The supplied value is the wrong data type for the underlying option.
  wrongType('WRONG_TYPE'),

  /// No more data is available.
  eof('EOF'),

  /// The document feeder is jammed.
  adfJammed('ADF_JAMMED'),

  /// The document feeder is empty.
  adfEmpty('ADF_EMPTY'),

  /// The flatbed cover is open.
  coverOpen('COVER_OPEN'),

  /// An error occurred while communicating with the device.
  ioError('IO_ERROR'),

  /// The device requires authentication.
  accessDenied('ACCESS_DENIED'),

  /// Not enough memory is available on the Chromebook to complete the
  /// operation.
  noMemory('NO_MEMORY'),

  /// The device is not reachable.
  unreachable('UNREACHABLE'),

  /// The device is disconnected.
  missing('MISSING'),

  /// An error has occurred somewhere other than the calling application.
  internalError('INTERNAL_ERROR');

  const OperationResult(this.value);

  final String value;

  JSString get toJS => value.toJS;

  static OperationResult fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

/// Indicates how the scanner is connected to the computer.
enum ConnectionType {
  unspecified('UNSPECIFIED'),
  usb('USB'),
  network('NETWORK');

  const ConnectionType(this.value);

  final String value;

  JSString get toJS => value.toJS;

  static ConnectionType fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

/// The data type of an option.
enum OptionType {
  /// The option's data type is unknown. The `value` property
  /// will be unset.
  unknown('UNKNOWN'),

  /// The `value` property will be one of `true</code or
  /// `false`.
  bool('BOOL'),

  /// A signed 32-bit integer. The `value` property will be long or
  /// long[], depending on whether the option takes more than one value.
  int('INT'),

  /// A double in the range -32768-32767.9999 with a resolution of 1/65535.
  /// The `value` property will be double or double[] depending
  /// on whether the option takes more than one value. Double values that
  /// can't be exactly represented will be rounded to the available range
  /// and precision.
  fixed('FIXED'),

  /// A sequence of any bytes except NUL ('\0'). The `value`
  /// property will be a DOMString.
  string('STRING'),

  /// An option of this type has no value. Instead, setting an option of
  /// this type causes an option-specific side effect in the scanner
  /// driver. For example, a button-typed option could be used by a
  /// scanner driver to provide a means to select default values or to
  /// tell an automatic document feeder to advance to the next sheet of
  /// paper.
  button('BUTTON'),

  /// Grouping option. No value. This is included for compatibility, but
  /// will not normally be returned in `ScannerOption` values. Use
  /// `getOptionGroups()` to retrieve the list of groups with their
  /// member options.
  group('GROUP');

  const OptionType(this.value);

  final String value;

  JSString get toJS => value.toJS;

  static OptionType fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

/// Indicates the data type for [ScannerOption.unit].
enum OptionUnit {
  /// The value is a unitless number. For example, it can be a threshold.
  unitless('UNITLESS'),

  /// The value is a number of pixels, for example, scan dimensions.
  pixel('PIXEL'),

  /// The value is the number of bits, for example, color depth.
  bit('BIT'),

  /// The value is measured in millimeters, for example, scan dimensions.
  mm('MM'),

  /// The value is measured in dots per inch, for example, resolution.
  dpi('DPI'),

  /// The value is a percent, for example, brightness.
  percent('PERCENT'),

  /// The value is measured in microseconds, for example, exposure time.
  microsecond('MICROSECOND');

  const OptionUnit(this.value);

  final String value;

  JSString get toJS => value.toJS;

  static OptionUnit fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

/// The data type of constraint represented by an [OptionConstraint].
enum ConstraintType {
  /// The constraint on a range of `OptionType.INT` values.
  /// The `min`, `max`, and `quant` properties
  /// of `OptionConstraint` will be `long`, and its
  /// `list` propety will be unset.
  intRange('INT_RANGE'),

  /// The constraint on a range of `OptionType.FIXED` values.
  /// The `min`, `max`, and `quant` properties
  /// of `OptionConstraint` will be `double`, and its
  /// `list` property will be unset.
  fixedRange('FIXED_RANGE'),

  /// The constraint on a specific list of `OptionType.INT`
  /// values. The `OptionConstraint.list` property will contain
  /// `long` values, and the other properties will be unset.
  intList('INT_LIST'),

  /// The constraint on a specific list of `OptionType.FIXED`
  /// values. The `OptionConstraint.list` property will contain
  /// `double` values, and the other properties will be unset.
  fixedList('FIXED_LIST'),

  /// The constraint on a specific list of `OptionType.STRING`
  /// values. The `OptionConstraint.list` property will contain
  /// `DOMString` values, and the other properties will be unset.
  stringList('STRING_LIST');

  const ConstraintType(this.value);

  final String value;

  JSString get toJS => value.toJS;

  static ConstraintType fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

/// How an option can be changed.
enum Configurability {
  /// The option is read-only.
  notConfigurable('NOT_CONFIGURABLE'),

  /// The option can be set in software.
  softwareConfigurable('SOFTWARE_CONFIGURABLE'),

  /// The option can be set by the user toggling or pushing a button on
  /// the scanner.
  hardwareConfigurable('HARDWARE_CONFIGURABLE');

  const Configurability(this.value);

  final String value;

  JSString get toJS => value.toJS;

  static Configurability fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

class ScanOptions {
  ScanOptions.fromJS(this._wrapped);

  ScanOptions({
    /// The MIME types that are accepted by the caller.
    List<String>? mimeTypes,

    /// The number of scanned images allowed. The default is 1.
    int? maxImages,
  }) : _wrapped = $js.ScanOptions(
          mimeTypes: mimeTypes?.toJSArray((e) => e.toJS),
          maxImages: maxImages,
        );

  final $js.ScanOptions _wrapped;

  $js.ScanOptions get toJS => _wrapped;

  /// The MIME types that are accepted by the caller.
  List<String>? get mimeTypes =>
      _wrapped.mimeTypes?.toDart.cast<JSString>().map((e) => e.toDart).toList();

  set mimeTypes(List<String>? v) {
    _wrapped.mimeTypes = v?.toJSArray((e) => e.toJS);
  }

  /// The number of scanned images allowed. The default is 1.
  int? get maxImages => _wrapped.maxImages;

  set maxImages(int? v) {
    _wrapped.maxImages = v;
  }
}

class ScanResults {
  ScanResults.fromJS(this._wrapped);

  ScanResults({
    /// An array of data image URLs in a form that can be passed as the "src"
    /// value to an image tag.
    required List<String> dataUrls,

    /// The MIME type of the `dataUrls`.
    required String mimeType,
  }) : _wrapped = $js.ScanResults(
          dataUrls: dataUrls.toJSArray((e) => e.toJS),
          mimeType: mimeType,
        );

  final $js.ScanResults _wrapped;

  $js.ScanResults get toJS => _wrapped;

  /// An array of data image URLs in a form that can be passed as the "src"
  /// value to an image tag.
  List<String> get dataUrls =>
      _wrapped.dataUrls.toDart.cast<JSString>().map((e) => e.toDart).toList();

  set dataUrls(List<String> v) {
    _wrapped.dataUrls = v.toJSArray((e) => e.toJS);
  }

  /// The MIME type of the `dataUrls`.
  String get mimeType => _wrapped.mimeType;

  set mimeType(String v) {
    _wrapped.mimeType = v;
  }
}

class ScannerInfo {
  ScannerInfo.fromJS(this._wrapped);

  ScannerInfo({
    /// The ID of a specific scanner.
    required String scannerId,

    /// A human-readable name for the scanner to display in the UI.
    required String name,

    /// The scanner manufacturer.
    required String manufacturer,

    /// The scanner model if it is available, or a generic description.
    required String model,

    /// For matching against other `ScannerInfo` entries that point
    /// to the same physical device.
    required String deviceUuid,

    /// Indicates how the scanner is connected to the computer.
    required ConnectionType connectionType,

    /// If true, the scanner connection's transport cannot be intercepted by a
    /// passive listener, such as TLS or USB.
    required bool secure,

    /// An array of MIME types that can be requested for returned scans.
    required List<String> imageFormats,

    /// A human-readable description of the protocol or driver used to
    /// access the scanner, such as Mopria, WSD, or epsonds. This is primarily
    /// useful for allowing a user to choose between protocols if a device
    /// supports multiple protocols.
    required String protocolType,
  }) : _wrapped = $js.ScannerInfo(
          scannerId: scannerId,
          name: name,
          manufacturer: manufacturer,
          model: model,
          deviceUuid: deviceUuid,
          connectionType: connectionType.toJS,
          secure: secure,
          imageFormats: imageFormats.toJSArray((e) => e.toJS),
          protocolType: protocolType,
        );

  final $js.ScannerInfo _wrapped;

  $js.ScannerInfo get toJS => _wrapped;

  /// The ID of a specific scanner.
  String get scannerId => _wrapped.scannerId;

  set scannerId(String v) {
    _wrapped.scannerId = v;
  }

  /// A human-readable name for the scanner to display in the UI.
  String get name => _wrapped.name;

  set name(String v) {
    _wrapped.name = v;
  }

  /// The scanner manufacturer.
  String get manufacturer => _wrapped.manufacturer;

  set manufacturer(String v) {
    _wrapped.manufacturer = v;
  }

  /// The scanner model if it is available, or a generic description.
  String get model => _wrapped.model;

  set model(String v) {
    _wrapped.model = v;
  }

  /// For matching against other `ScannerInfo` entries that point
  /// to the same physical device.
  String get deviceUuid => _wrapped.deviceUuid;

  set deviceUuid(String v) {
    _wrapped.deviceUuid = v;
  }

  /// Indicates how the scanner is connected to the computer.
  ConnectionType get connectionType =>
      ConnectionType.fromJS(_wrapped.connectionType);

  set connectionType(ConnectionType v) {
    _wrapped.connectionType = v.toJS;
  }

  /// If true, the scanner connection's transport cannot be intercepted by a
  /// passive listener, such as TLS or USB.
  bool get secure => _wrapped.secure;

  set secure(bool v) {
    _wrapped.secure = v;
  }

  /// An array of MIME types that can be requested for returned scans.
  List<String> get imageFormats => _wrapped.imageFormats.toDart
      .cast<JSString>()
      .map((e) => e.toDart)
      .toList();

  set imageFormats(List<String> v) {
    _wrapped.imageFormats = v.toJSArray((e) => e.toJS);
  }

  /// A human-readable description of the protocol or driver used to
  /// access the scanner, such as Mopria, WSD, or epsonds. This is primarily
  /// useful for allowing a user to choose between protocols if a device
  /// supports multiple protocols.
  String get protocolType => _wrapped.protocolType;

  set protocolType(String v) {
    _wrapped.protocolType = v;
  }
}

class OptionConstraint {
  OptionConstraint.fromJS(this._wrapped);

  OptionConstraint({
    required ConstraintType type,
    Object? min,
    Object? max,
    Object? quant,
    Object? list,
  }) : _wrapped = $js.OptionConstraint(
          type: type.toJS,
          min: switch (min) {
            int() => min.toJS,
            double() => min.toJS,
            null => null,
            _ => throw UnsupportedError(
                'Received type: ${min.runtimeType}. Supported types are: int, double')
          },
          max: switch (max) {
            int() => max.toJS,
            double() => max.toJS,
            null => null,
            _ => throw UnsupportedError(
                'Received type: ${max.runtimeType}. Supported types are: int, double')
          },
          quant: switch (quant) {
            int() => quant.toJS,
            double() => quant.toJS,
            null => null,
            _ => throw UnsupportedError(
                'Received type: ${quant.runtimeType}. Supported types are: int, double')
          },
          list: switch (list) {
            List<double>() => list.toJSArray((e) => e.toJS),
            List<int>() => list.toJSArray((e) => e.toJS),
            List() => list.toJSArrayString(),
            null => null,
            _ => throw UnsupportedError(
                'Received type: ${list.runtimeType}. Supported types are: List<double>, List<int>, List<String>')
          },
        );

  final $js.OptionConstraint _wrapped;

  $js.OptionConstraint get toJS => _wrapped;

  ConstraintType get type => ConstraintType.fromJS(_wrapped.type);

  set type(ConstraintType v) {
    _wrapped.type = v.toJS;
  }

  Object? get min => _wrapped.min?.when(
        isInt: (v) => v,
        isDouble: (v) => v,
      );

  set min(Object? v) {
    _wrapped.min = switch (v) {
      int() => v.toJS,
      double() => v.toJS,
      null => null,
      _ => throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: int, double')
    };
  }

  Object? get max => _wrapped.max?.when(
        isInt: (v) => v,
        isDouble: (v) => v,
      );

  set max(Object? v) {
    _wrapped.max = switch (v) {
      int() => v.toJS,
      double() => v.toJS,
      null => null,
      _ => throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: int, double')
    };
  }

  Object? get quant => _wrapped.quant?.when(
        isInt: (v) => v,
        isDouble: (v) => v,
      );

  set quant(Object? v) {
    _wrapped.quant = switch (v) {
      int() => v.toJS,
      double() => v.toJS,
      null => null,
      _ => throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: int, double')
    };
  }

  Object? get list => _wrapped.list?.when(
        isArray: (v) =>
            v.toDart.cast<JSNumber>().map((e) => e.toDartDouble).toList(),
      );

  set list(Object? v) {
    _wrapped.list = switch (v) {
      List<double>() => v.toJSArray((e) => e.toJS),
      List<int>() => v.toJSArray((e) => e.toJS),
      List() => v.toJSArrayString(),
      null => null,
      _ => throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: List<double>, List<int>, List<String>')
    };
  }
}

class ScannerOption {
  ScannerOption.fromJS(this._wrapped);

  ScannerOption({
    /// The option name using lowercase ASCII letters, numbers, and dashes.
    /// Diacritics are not allowed.
    required String name,

    /// A printable one-line title.
    required String title,

    /// A longer description of the option.
    required String description,

    /// The data type contained in the `value` property, which
    /// is needed for setting this option.
    required OptionType type,

    /// The unit of measurement for this option.
    required OptionUnit unit,

    /// The current value of the option, if relevant. Note that the data
    /// type of this property must match the data type specified in
    /// `type`.
    Object? value,

    /// Defines [OptionConstraint] on the current scanner option.
    OptionConstraint? constraint,

    /// Indicates that this option can be detected from software.
    required bool isDetectable,

    /// Indicates whether and how the option can be changed.
    required Configurability configurability,

    /// Can be automatically set by the scanner driver.
    required bool isAutoSettable,

    /// Emulated by the scanner driver if true.
    required bool isEmulated,

    /// Indicates the option is active and can be set or retrieved. If false,
    /// the `value` property will not be set.
    required bool isActive,

    /// Indicates that the UI should not display this option by default.
    required bool isAdvanced,

    /// Indicates that the option is used for internal configuration and
    /// should never be displayed in the UI.
    required bool isInternal,
  }) : _wrapped = $js.ScannerOption(
          name: name,
          title: title,
          description: description,
          type: type.toJS,
          unit: unit.toJS,
          value: switch (value) {
            bool() => value.toJS,
            double() => value.toJS,
            List<double>() => value.toJSArray((e) => e.toJS),
            int() => value.toJS,
            List<int>() => value.toJSArray((e) => e.toJS),
            String() => value.toJS,
            null => null,
            _ => throw UnsupportedError(
                'Received type: ${value.runtimeType}. Supported types are: bool, double, List<double>, int, List<int>, String')
          },
          constraint: constraint?.toJS,
          isDetectable: isDetectable,
          configurability: configurability.toJS,
          isAutoSettable: isAutoSettable,
          isEmulated: isEmulated,
          isActive: isActive,
          isAdvanced: isAdvanced,
          isInternal: isInternal,
        );

  final $js.ScannerOption _wrapped;

  $js.ScannerOption get toJS => _wrapped;

  /// The option name using lowercase ASCII letters, numbers, and dashes.
  /// Diacritics are not allowed.
  String get name => _wrapped.name;

  set name(String v) {
    _wrapped.name = v;
  }

  /// A printable one-line title.
  String get title => _wrapped.title;

  set title(String v) {
    _wrapped.title = v;
  }

  /// A longer description of the option.
  String get description => _wrapped.description;

  set description(String v) {
    _wrapped.description = v;
  }

  /// The data type contained in the `value` property, which
  /// is needed for setting this option.
  OptionType get type => OptionType.fromJS(_wrapped.type);

  set type(OptionType v) {
    _wrapped.type = v.toJS;
  }

  /// The unit of measurement for this option.
  OptionUnit get unit => OptionUnit.fromJS(_wrapped.unit);

  set unit(OptionUnit v) {
    _wrapped.unit = v.toJS;
  }

  /// The current value of the option, if relevant. Note that the data
  /// type of this property must match the data type specified in
  /// `type`.
  Object? get value => _wrapped.value?.when(
        isBool: (v) => v,
        isDouble: (v) => v,
        isArray: (v) =>
            v.toDart.cast<JSNumber>().map((e) => e.toDartDouble).toList(),
        isInt: (v) => v,
        isString: (v) => v,
      );

  set value(Object? v) {
    _wrapped.value = switch (v) {
      bool() => v.toJS,
      double() => v.toJS,
      List<double>() => v.toJSArray((e) => e.toJS),
      int() => v.toJS,
      List<int>() => v.toJSArray((e) => e.toJS),
      String() => v.toJS,
      null => null,
      _ => throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: bool, double, List<double>, int, List<int>, String')
    };
  }

  /// Defines [OptionConstraint] on the current scanner option.
  OptionConstraint? get constraint =>
      _wrapped.constraint?.let(OptionConstraint.fromJS);

  set constraint(OptionConstraint? v) {
    _wrapped.constraint = v?.toJS;
  }

  /// Indicates that this option can be detected from software.
  bool get isDetectable => _wrapped.isDetectable;

  set isDetectable(bool v) {
    _wrapped.isDetectable = v;
  }

  /// Indicates whether and how the option can be changed.
  Configurability get configurability =>
      Configurability.fromJS(_wrapped.configurability);

  set configurability(Configurability v) {
    _wrapped.configurability = v.toJS;
  }

  /// Can be automatically set by the scanner driver.
  bool get isAutoSettable => _wrapped.isAutoSettable;

  set isAutoSettable(bool v) {
    _wrapped.isAutoSettable = v;
  }

  /// Emulated by the scanner driver if true.
  bool get isEmulated => _wrapped.isEmulated;

  set isEmulated(bool v) {
    _wrapped.isEmulated = v;
  }

  /// Indicates the option is active and can be set or retrieved. If false,
  /// the `value` property will not be set.
  bool get isActive => _wrapped.isActive;

  set isActive(bool v) {
    _wrapped.isActive = v;
  }

  /// Indicates that the UI should not display this option by default.
  bool get isAdvanced => _wrapped.isAdvanced;

  set isAdvanced(bool v) {
    _wrapped.isAdvanced = v;
  }

  /// Indicates that the option is used for internal configuration and
  /// should never be displayed in the UI.
  bool get isInternal => _wrapped.isInternal;

  set isInternal(bool v) {
    _wrapped.isInternal = v;
  }
}

class DeviceFilter {
  DeviceFilter.fromJS(this._wrapped);

  DeviceFilter({
    /// Only return scanners that are directly attached to the computer.
    bool? local,

    /// Only return scanners that use a secure transport, such as USB or TLS.
    bool? secure,
  }) : _wrapped = $js.DeviceFilter(
          local: local,
          secure: secure,
        );

  final $js.DeviceFilter _wrapped;

  $js.DeviceFilter get toJS => _wrapped;

  /// Only return scanners that are directly attached to the computer.
  bool? get local => _wrapped.local;

  set local(bool? v) {
    _wrapped.local = v;
  }

  /// Only return scanners that use a secure transport, such as USB or TLS.
  bool? get secure => _wrapped.secure;

  set secure(bool? v) {
    _wrapped.secure = v;
  }
}

class OptionGroup {
  OptionGroup.fromJS(this._wrapped);

  OptionGroup({
    /// Provides a printable title, for example "Geometry options".
    required String title,

    /// An array of option names in driver-provided order.
    required List<String> members,
  }) : _wrapped = $js.OptionGroup(
          title: title,
          members: members.toJSArray((e) => e.toJS),
        );

  final $js.OptionGroup _wrapped;

  $js.OptionGroup get toJS => _wrapped;

  /// Provides a printable title, for example "Geometry options".
  String get title => _wrapped.title;

  set title(String v) {
    _wrapped.title = v;
  }

  /// An array of option names in driver-provided order.
  List<String> get members =>
      _wrapped.members.toDart.cast<JSString>().map((e) => e.toDart).toList();

  set members(List<String> v) {
    _wrapped.members = v.toJSArray((e) => e.toJS);
  }
}

class GetScannerListResponse {
  GetScannerListResponse.fromJS(this._wrapped);

  GetScannerListResponse({
    /// The enumeration result. Note that partial results could be
    /// returned even if this indicates an error.
    required OperationResult result,

    /// A possibly-empty list of scanners that match the provided
    /// [DeviceFilter].
    required List<ScannerInfo> scanners,
  }) : _wrapped = $js.GetScannerListResponse(
          result: result.toJS,
          scanners: scanners.toJSArray((e) => e.toJS),
        );

  final $js.GetScannerListResponse _wrapped;

  $js.GetScannerListResponse get toJS => _wrapped;

  /// The enumeration result. Note that partial results could be
  /// returned even if this indicates an error.
  OperationResult get result => OperationResult.fromJS(_wrapped.result);

  set result(OperationResult v) {
    _wrapped.result = v.toJS;
  }

  /// A possibly-empty list of scanners that match the provided
  /// [DeviceFilter].
  List<ScannerInfo> get scanners => _wrapped.scanners.toDart
      .cast<$js.ScannerInfo>()
      .map((e) => ScannerInfo.fromJS(e))
      .toList();

  set scanners(List<ScannerInfo> v) {
    _wrapped.scanners = v.toJSArray((e) => e.toJS);
  }
}

class OpenScannerResponse {
  OpenScannerResponse.fromJS(this._wrapped);

  OpenScannerResponse({
    /// The scanner ID passed to `openScanner()`.
    required String scannerId,

    /// The result of opening the scanner. If the value of this is
    /// `SUCCESS`, the `scannerHandle` and
    /// `options` properties will be populated.
    required OperationResult result,

    /// If `result` is `SUCCESS`, a
    /// handle to the scanner that can be used for further operations.
    String? scannerHandle,

    /// If `result` is `SUCCESS`,
    /// provides a key-value mapping where the key is a device-specific
    /// option and the value is an instance of [ScannerOption].
    Map? options,
  }) : _wrapped = $js.OpenScannerResponse(
          scannerId: scannerId,
          result: result.toJS,
          scannerHandle: scannerHandle,
          options: options?.jsify(),
        );

  final $js.OpenScannerResponse _wrapped;

  $js.OpenScannerResponse get toJS => _wrapped;

  /// The scanner ID passed to `openScanner()`.
  String get scannerId => _wrapped.scannerId;

  set scannerId(String v) {
    _wrapped.scannerId = v;
  }

  /// The result of opening the scanner. If the value of this is
  /// `SUCCESS`, the `scannerHandle` and
  /// `options` properties will be populated.
  OperationResult get result => OperationResult.fromJS(_wrapped.result);

  set result(OperationResult v) {
    _wrapped.result = v.toJS;
  }

  /// If `result` is `SUCCESS`, a
  /// handle to the scanner that can be used for further operations.
  String? get scannerHandle => _wrapped.scannerHandle;

  set scannerHandle(String? v) {
    _wrapped.scannerHandle = v;
  }

  /// If `result` is `SUCCESS`,
  /// provides a key-value mapping where the key is a device-specific
  /// option and the value is an instance of [ScannerOption].
  Map? get options => _wrapped.options?.toDartMap();

  set options(Map? v) {
    _wrapped.options = v?.jsify();
  }
}

class GetOptionGroupsResponse {
  GetOptionGroupsResponse.fromJS(this._wrapped);

  GetOptionGroupsResponse({
    /// The same scanner handle as was passed to [getOptionGroups].
    required String scannerHandle,

    /// The result of getting the option groups. If the value of this is
    /// `SUCCESS`, the `groups` property will be
    /// populated.
    required OperationResult result,

    /// If `result` is `SUCCESS`, provides a
    /// list of option groups in the order supplied by the scanner driver.
    List<OptionGroup>? groups,
  }) : _wrapped = $js.GetOptionGroupsResponse(
          scannerHandle: scannerHandle,
          result: result.toJS,
          groups: groups?.toJSArray((e) => e.toJS),
        );

  final $js.GetOptionGroupsResponse _wrapped;

  $js.GetOptionGroupsResponse get toJS => _wrapped;

  /// The same scanner handle as was passed to [getOptionGroups].
  String get scannerHandle => _wrapped.scannerHandle;

  set scannerHandle(String v) {
    _wrapped.scannerHandle = v;
  }

  /// The result of getting the option groups. If the value of this is
  /// `SUCCESS`, the `groups` property will be
  /// populated.
  OperationResult get result => OperationResult.fromJS(_wrapped.result);

  set result(OperationResult v) {
    _wrapped.result = v.toJS;
  }

  /// If `result` is `SUCCESS`, provides a
  /// list of option groups in the order supplied by the scanner driver.
  List<OptionGroup>? get groups => _wrapped.groups?.toDart
      .cast<$js.OptionGroup>()
      .map((e) => OptionGroup.fromJS(e))
      .toList();

  set groups(List<OptionGroup>? v) {
    _wrapped.groups = v?.toJSArray((e) => e.toJS);
  }
}

class CloseScannerResponse {
  CloseScannerResponse.fromJS(this._wrapped);

  CloseScannerResponse({
    /// The same scanner handle as was passed to [closeScanner].
    required String scannerHandle,

    /// The result of closing the scanner. Even if this value is not
    /// `SUCCESS`, the handle will be invalid and
    /// should not be used for any further operations.
    required OperationResult result,
  }) : _wrapped = $js.CloseScannerResponse(
          scannerHandle: scannerHandle,
          result: result.toJS,
        );

  final $js.CloseScannerResponse _wrapped;

  $js.CloseScannerResponse get toJS => _wrapped;

  /// The same scanner handle as was passed to [closeScanner].
  String get scannerHandle => _wrapped.scannerHandle;

  set scannerHandle(String v) {
    _wrapped.scannerHandle = v;
  }

  /// The result of closing the scanner. Even if this value is not
  /// `SUCCESS`, the handle will be invalid and
  /// should not be used for any further operations.
  OperationResult get result => OperationResult.fromJS(_wrapped.result);

  set result(OperationResult v) {
    _wrapped.result = v.toJS;
  }
}

class OptionSetting {
  OptionSetting.fromJS(this._wrapped);

  OptionSetting({
    /// Indicates the name of the option to set.
    required String name,

    /// Indicates the data type of the option. The requested data type must
    /// match the real data type of the underlying option.
    required OptionType type,

    /// Indicates the value to set. Leave unset to request automatic setting for
    /// options that have `autoSettable` enabled. The data type
    /// supplied for `value` must match `type`.
    Object? value,
  }) : _wrapped = $js.OptionSetting(
          name: name,
          type: type.toJS,
          value: switch (value) {
            bool() => value.toJS,
            double() => value.toJS,
            List<double>() => value.toJSArray((e) => e.toJS),
            int() => value.toJS,
            List<int>() => value.toJSArray((e) => e.toJS),
            String() => value.toJS,
            null => null,
            _ => throw UnsupportedError(
                'Received type: ${value.runtimeType}. Supported types are: bool, double, List<double>, int, List<int>, String')
          },
        );

  final $js.OptionSetting _wrapped;

  $js.OptionSetting get toJS => _wrapped;

  /// Indicates the name of the option to set.
  String get name => _wrapped.name;

  set name(String v) {
    _wrapped.name = v;
  }

  /// Indicates the data type of the option. The requested data type must
  /// match the real data type of the underlying option.
  OptionType get type => OptionType.fromJS(_wrapped.type);

  set type(OptionType v) {
    _wrapped.type = v.toJS;
  }

  /// Indicates the value to set. Leave unset to request automatic setting for
  /// options that have `autoSettable` enabled. The data type
  /// supplied for `value` must match `type`.
  Object? get value => _wrapped.value?.when(
        isBool: (v) => v,
        isDouble: (v) => v,
        isArray: (v) =>
            v.toDart.cast<JSNumber>().map((e) => e.toDartDouble).toList(),
        isInt: (v) => v,
        isString: (v) => v,
      );

  set value(Object? v) {
    _wrapped.value = switch (v) {
      bool() => v.toJS,
      double() => v.toJS,
      List<double>() => v.toJSArray((e) => e.toJS),
      int() => v.toJS,
      List<int>() => v.toJSArray((e) => e.toJS),
      String() => v.toJS,
      null => null,
      _ => throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: bool, double, List<double>, int, List<int>, String')
    };
  }
}

class SetOptionResult {
  SetOptionResult.fromJS(this._wrapped);

  SetOptionResult({
    /// Indicates the name of the option that was set.
    required String name,

    /// Indicates the result of setting the option.
    required OperationResult result,
  }) : _wrapped = $js.SetOptionResult(
          name: name,
          result: result.toJS,
        );

  final $js.SetOptionResult _wrapped;

  $js.SetOptionResult get toJS => _wrapped;

  /// Indicates the name of the option that was set.
  String get name => _wrapped.name;

  set name(String v) {
    _wrapped.name = v;
  }

  /// Indicates the result of setting the option.
  OperationResult get result => OperationResult.fromJS(_wrapped.result);

  set result(OperationResult v) {
    _wrapped.result = v.toJS;
  }
}

class SetOptionsResponse {
  SetOptionsResponse.fromJS(this._wrapped);

  SetOptionsResponse({
    /// Provides the scanner handle passed to `setOptions()`.
    required String scannerHandle,

    /// An array of results, one each for every passed-in
    /// `OptionSetting`.
    required List<SetOptionResult> results,

    /// An updated key-value mapping from option names to
    /// [ScannerOption] values containing the new configuration after
    /// attempting to set all supplied options. This has the same structure as
    /// the `options` property in [OpenScannerResponse].
    ///
    /// This property will be set even if some options were not set
    /// successfully,
    /// but will be unset if retrieving the updated configuration fails (for
    /// example, if the scanner is disconnected in the middle of scanning).
    Map? options,
  }) : _wrapped = $js.SetOptionsResponse(
          scannerHandle: scannerHandle,
          results: results.toJSArray((e) => e.toJS),
          options: options?.jsify(),
        );

  final $js.SetOptionsResponse _wrapped;

  $js.SetOptionsResponse get toJS => _wrapped;

  /// Provides the scanner handle passed to `setOptions()`.
  String get scannerHandle => _wrapped.scannerHandle;

  set scannerHandle(String v) {
    _wrapped.scannerHandle = v;
  }

  /// An array of results, one each for every passed-in
  /// `OptionSetting`.
  List<SetOptionResult> get results => _wrapped.results.toDart
      .cast<$js.SetOptionResult>()
      .map((e) => SetOptionResult.fromJS(e))
      .toList();

  set results(List<SetOptionResult> v) {
    _wrapped.results = v.toJSArray((e) => e.toJS);
  }

  /// An updated key-value mapping from option names to
  /// [ScannerOption] values containing the new configuration after
  /// attempting to set all supplied options. This has the same structure as
  /// the `options` property in [OpenScannerResponse].
  ///
  /// This property will be set even if some options were not set successfully,
  /// but will be unset if retrieving the updated configuration fails (for
  /// example, if the scanner is disconnected in the middle of scanning).
  Map? get options => _wrapped.options?.toDartMap();

  set options(Map? v) {
    _wrapped.options = v?.jsify();
  }
}

class StartScanOptions {
  StartScanOptions.fromJS(this._wrapped);

  StartScanOptions({
    /// Specifies the MIME type to return scanned data in.
    required String format,

    /// If a non-zero value is specified, limits the maximum scanned bytes
    /// returned in a single [readScanData] response to that value.  The
    /// smallest allowed value is 32768 (32 KB).  If this property is not
    /// specified, the size of a returned chunk may be as large as the entire
    /// scanned image.
    int? maxReadSize,
  }) : _wrapped = $js.StartScanOptions(
          format: format,
          maxReadSize: maxReadSize,
        );

  final $js.StartScanOptions _wrapped;

  $js.StartScanOptions get toJS => _wrapped;

  /// Specifies the MIME type to return scanned data in.
  String get format => _wrapped.format;

  set format(String v) {
    _wrapped.format = v;
  }

  /// If a non-zero value is specified, limits the maximum scanned bytes
  /// returned in a single [readScanData] response to that value.  The
  /// smallest allowed value is 32768 (32 KB).  If this property is not
  /// specified, the size of a returned chunk may be as large as the entire
  /// scanned image.
  int? get maxReadSize => _wrapped.maxReadSize;

  set maxReadSize(int? v) {
    _wrapped.maxReadSize = v;
  }
}

class StartScanResponse {
  StartScanResponse.fromJS(this._wrapped);

  StartScanResponse({
    /// Provides the same scanner handle that was passed to
    /// `startScan()`.
    required String scannerHandle,

    /// The result of starting a scan. If the value of this is
    /// `SUCCESS`, the `job` property will be populated.
    required OperationResult result,

    /// If `result` is `SUCCESS`, provides a
    /// handle that can be used to read scan data or cancel the job.
    String? job,
  }) : _wrapped = $js.StartScanResponse(
          scannerHandle: scannerHandle,
          result: result.toJS,
          job: job,
        );

  final $js.StartScanResponse _wrapped;

  $js.StartScanResponse get toJS => _wrapped;

  /// Provides the same scanner handle that was passed to
  /// `startScan()`.
  String get scannerHandle => _wrapped.scannerHandle;

  set scannerHandle(String v) {
    _wrapped.scannerHandle = v;
  }

  /// The result of starting a scan. If the value of this is
  /// `SUCCESS`, the `job` property will be populated.
  OperationResult get result => OperationResult.fromJS(_wrapped.result);

  set result(OperationResult v) {
    _wrapped.result = v.toJS;
  }

  /// If `result` is `SUCCESS`, provides a
  /// handle that can be used to read scan data or cancel the job.
  String? get job => _wrapped.job;

  set job(String? v) {
    _wrapped.job = v;
  }
}

class CancelScanResponse {
  CancelScanResponse.fromJS(this._wrapped);

  CancelScanResponse({
    /// Provides the same job handle that was passed to
    /// `cancelScan()`.
    required String job,

    /// The backend's cancel scan result. If the result is
    /// `OperationResult.SUCCESS` or
    /// `OperationResult.CANCELLED`, the scan has been cancelled and
    /// the scanner is ready to start a new scan.  If the result is
    /// `OperationResult.DEVICE_BUSY `, the scanner is still
    /// processing the requested cancellation; the caller should wait a short
    /// time and try the request again. Other result values indicate a permanent
    /// error that should not be retried.
    required OperationResult result,
  }) : _wrapped = $js.CancelScanResponse(
          job: job,
          result: result.toJS,
        );

  final $js.CancelScanResponse _wrapped;

  $js.CancelScanResponse get toJS => _wrapped;

  /// Provides the same job handle that was passed to
  /// `cancelScan()`.
  String get job => _wrapped.job;

  set job(String v) {
    _wrapped.job = v;
  }

  /// The backend's cancel scan result. If the result is
  /// `OperationResult.SUCCESS` or
  /// `OperationResult.CANCELLED`, the scan has been cancelled and
  /// the scanner is ready to start a new scan.  If the result is
  /// `OperationResult.DEVICE_BUSY `, the scanner is still
  /// processing the requested cancellation; the caller should wait a short
  /// time and try the request again. Other result values indicate a permanent
  /// error that should not be retried.
  OperationResult get result => OperationResult.fromJS(_wrapped.result);

  set result(OperationResult v) {
    _wrapped.result = v.toJS;
  }
}

class ReadScanDataResponse {
  ReadScanDataResponse.fromJS(this._wrapped);

  ReadScanDataResponse({
    /// Provides the job handle passed to `readScanData()`.
    required String job,

    /// The result of reading data. If its value is
    /// `SUCCESS`, then `data` contains the
    /// _next_ (possibly zero-length) chunk of image data that is ready
    /// for reading. If its value is `EOF`, the `data`
    /// contains the _last_ chunk of image data.
    required OperationResult result,

    /// If `result` is `SUCCESS`, contains
    /// the _next_ chunk of scanned image data. If `result` is
    /// `EOF`, contains the _last_ chunk of
    /// scanned image data.
    ByteBuffer? data,

    /// If `result` is `SUCCESS`, an estimate of
    /// how much of the total scan data has been delivered so far, in the range
    /// 0 to 100.
    int? estimatedCompletion,
  }) : _wrapped = $js.ReadScanDataResponse(
          job: job,
          result: result.toJS,
          data: data?.toJS,
          estimatedCompletion: estimatedCompletion,
        );

  final $js.ReadScanDataResponse _wrapped;

  $js.ReadScanDataResponse get toJS => _wrapped;

  /// Provides the job handle passed to `readScanData()`.
  String get job => _wrapped.job;

  set job(String v) {
    _wrapped.job = v;
  }

  /// The result of reading data. If its value is
  /// `SUCCESS`, then `data` contains the
  /// _next_ (possibly zero-length) chunk of image data that is ready
  /// for reading. If its value is `EOF`, the `data`
  /// contains the _last_ chunk of image data.
  OperationResult get result => OperationResult.fromJS(_wrapped.result);

  set result(OperationResult v) {
    _wrapped.result = v.toJS;
  }

  /// If `result` is `SUCCESS`, contains
  /// the _next_ chunk of scanned image data. If `result` is
  /// `EOF`, contains the _last_ chunk of
  /// scanned image data.
  ByteBuffer? get data => _wrapped.data?.toDart;

  set data(ByteBuffer? v) {
    _wrapped.data = v?.toJS;
  }

  /// If `result` is `SUCCESS`, an estimate of
  /// how much of the total scan data has been delivered so far, in the range
  /// 0 to 100.
  int? get estimatedCompletion => _wrapped.estimatedCompletion;

  set estimatedCompletion(int? v) {
    _wrapped.estimatedCompletion = v;
  }
}
