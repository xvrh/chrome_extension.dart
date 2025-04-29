// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'dart:typed_data';
import 'src/internal_helpers.dart';
import 'src/js/document_scan.dart' as $js;

export 'src/chrome.dart' show chrome, EventStream;

final _documentScan = ChromeDocumentScan._();

extension ChromeDocumentScanExtension on Chrome {
  /// Use the `chrome.documentScan` API to discover and retrieve
  /// images from attached paper document scanners.
  ChromeDocumentScan get documentScan => _documentScan;
}

class ChromeDocumentScan {
  ChromeDocumentScan._();

  bool get isAvailable => $js.chrome.documentScanNullable != null && alwaysTrue;

  /// Performs a document scan.  On success, the PNG data will be
  /// sent to the callback.
  /// |options| : Object containing scan parameters.
  /// |callback| : Called with the result and data from the scan.
  Future<ScanResults> scan(ScanOptions options) async {
    var $res = await $js.chrome.documentScan.scan(options.toJS).toDart;
    return ScanResults.fromJS($res! as $js.ScanResults);
  }

  /// Gets the list of available scanners.  On success, the list will be
  /// sent to the callback.
  /// |filter| : `DeviceFilter` indicating which types of scanners
  /// should be returned.
  /// |callback| : Called with the result and list of scanners.
  Future<GetScannerListResponse> getScannerList(DeviceFilter filter) async {
    var $res = await $js.chrome.documentScan.getScannerList(filter.toJS).toDart;
    return GetScannerListResponse.fromJS($res! as $js.GetScannerListResponse);
  }

  /// Opens a scanner for exclusive access.  On success, the response containing
  /// a scanner handle and configuration will be sent to the callback.
  /// |scannerId| : Scanner id previously returned from `getScannerList`
  /// indicating which scanner should be opened.
  /// |callback| : Called with the result.
  Future<OpenScannerResponse> openScanner(String scannerId) async {
    var $res = await $js.chrome.documentScan.openScanner(scannerId).toDart;
    return OpenScannerResponse.fromJS($res! as $js.OpenScannerResponse);
  }

  /// Gets the group names and member options from a scanner handle previously
  /// opened by `openScanner`.
  /// |scannerHandle| : Open scanner handle previously returned from
  /// `openScanner`.
  /// |callback| : Called with the result.
  Future<GetOptionGroupsResponse> getOptionGroups(String scannerHandle) async {
    var $res =
        await $js.chrome.documentScan.getOptionGroups(scannerHandle).toDart;
    return GetOptionGroupsResponse.fromJS($res! as $js.GetOptionGroupsResponse);
  }

  /// Closes a previously opened scanner handle.  A response indicating the
  /// outcome will be sent to the callback.  Even if the response is not a
  /// success, the supplied handle will become invalid and should not be used
  /// for further operations.
  /// |scannerHandle| : Open scanner handle previously returned from
  /// `openScanner`.
  /// |callback| : Called with the result.
  Future<CloseScannerResponse> closeScanner(String scannerHandle) async {
    var $res = await $js.chrome.documentScan.closeScanner(scannerHandle).toDart;
    return CloseScannerResponse.fromJS($res! as $js.CloseScannerResponse);
  }

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
  Future<SetOptionsResponse> setOptions(
    String scannerHandle,
    List<OptionSetting> options,
  ) async {
    var $res =
        await $js.chrome.documentScan
            .setOptions(scannerHandle, options.toJSArray((e) => e.toJS))
            .toDart;
    return SetOptionsResponse.fromJS($res! as $js.SetOptionsResponse);
  }

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
  Future<StartScanResponse> startScan(
    String scannerHandle,
    StartScanOptions options,
  ) async {
    var $res =
        await $js.chrome.documentScan
            .startScan(scannerHandle, options.toJS)
            .toDart;
    return StartScanResponse.fromJS($res! as $js.StartScanResponse);
  }

  /// Cancels a scan that was previously started using `startScan`.
  /// The response is sent to the callback.
  /// |job| : An active scan job previously returned from
  /// `startScan`.
  /// |callback| : Called with the result.
  Future<CancelScanResponse> cancelScan(String job) async {
    var $res = await $js.chrome.documentScan.cancelScan(job).toDart;
    return CancelScanResponse.fromJS($res! as $js.CancelScanResponse);
  }

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
  Future<ReadScanDataResponse> readScanData(String job) async {
    var $res = await $js.chrome.documentScan.readScanData(job).toDart;
    return ReadScanDataResponse.fromJS($res! as $js.ReadScanDataResponse);
  }
}

/// OperationResult is an enum that indicates the result of each operation
/// performed by the backend.  It contains the same causes as SANE_Status plus
/// additional statuses that come from the IPC layers and image conversion
/// stages.
enum OperationResult {
  /// An unknown or generic failure occurred.
  unknown('UNKNOWN'),

  /// Operation succeeded.
  success('SUCCESS'),

  /// The operation is not supported.
  unsupported('UNSUPPORTED'),

  /// The operation was cancelled.
  cancelled('CANCELLED'),

  /// The device is busy.
  deviceBusy('DEVICE_BUSY'),

  /// Data or argument is invalid.
  invalid('INVALID'),

  /// Value is the wrong type for the underlying option.
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

  /// Not enough memory was available to complete the operation.
  noMemory('NO_MEMORY'),

  /// The device was not reachable.
  unreachable('UNREACHABLE'),

  /// The device was disconnected.
  missing('MISSING'),

  /// An internal error occurred.
  internalError('INTERNAL_ERROR');

  const OperationResult(this.value);

  final String value;

  JSString get toJS => value.toJS;
  static OperationResult fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

/// How the scanner is connected to the computer.
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

/// The type of an option.  This is the same set of types as SANE_Value_Type.
enum OptionType {
  /// Unknown option type.  `value` will be unset.
  unknown('UNKNOWN'),

  /// true/false only.  `value` will be a boolean.
  bool('BOOL'),

  /// Signed 32-bit integer.  `value` will be long or long[],
  /// depending on whether the option takes more than one value.
  int('INT'),

  /// Double in the range -32768-32767.9999 with a resolution of 1/65535.
  /// `value` will be double or double[] depending on whether the
  /// option takes more than one value.
  fixed('FIXED'),

  /// A sequence of any bytes except NUL ('\0').  `value` will be a
  /// DOMString.
  string('STRING'),

  /// Hardware button or toggle.  No value.
  button('BUTTON'),

  /// Grouping option.  No value.  This is included for compatibility, but
  /// will not normally be returned in `ScannerOption` values.  Use
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

/// The unit of measurement for an option.  This is the same set of units as
/// SANE_Unit.
enum OptionUnit {
  /// Value is a unitless number, e.g. threshold.
  unitless('UNITLESS'),

  /// Value is a number of pixels, e.g., scan dimensions.
  pixel('PIXEL'),

  /// Value is the number of bits, e.g., color depth.
  bit('BIT'),

  /// Value is measured in millimeters, e.g., scan dimensions.
  mm('MM'),

  /// Value is measured in dots per inch, e.g., resolution.
  dpi('DPI'),

  /// Value is a percent, e.g., brightness.
  percent('PERCENT'),

  /// Value is measured in microseconds, e.g., exposure time.
  microsecond('MICROSECOND');

  const OptionUnit(this.value);

  final String value;

  JSString get toJS => value.toJS;
  static OptionUnit fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

/// The type of constraint represented by an OptionConstraint.
enum ConstraintType {
  /// Constraint represents a range of `OptionType.INT` values.
  /// `min`, `max`, and `quant` will be
  /// `long`, and `list` will be unset.
  intRange('INT_RANGE'),

  /// Constraint represents a range of `OptionType.FIXED` values.
  /// `min`, `max`, and `quant` will be
  /// `double`, and `list` will be unset.
  fixedRange('FIXED_RANGE'),

  /// Constraint represents a specific list of `OptionType.INT`
  /// values.  `list` will contain `long` values, and
  /// the other fields will be unset.
  intList('INT_LIST'),

  /// Constraint represents a specific list of `OptionType.FIXED`
  /// values.  `list` will contain `double` values, and
  /// the other fields will be unset.
  fixedList('FIXED_LIST'),

  /// Constraint represents a specific list of `OptionType.STRING`
  /// values.  `list` will contain `DOMString` values,
  /// and the other fields will be unset.
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
  /// Option is read-only and cannot be changed.
  notConfigurable('NOT_CONFIGURABLE'),

  /// Option can be set in software.
  softwareConfigurable('SOFTWARE_CONFIGURABLE'),

  /// Option can be set by the user toggling/pushing a hardware button.
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

    /// The number of scanned images allowed (defaults to 1).
    int? maxImages,
  }) : _wrapped = $js.ScanOptions(
         mimeTypes: mimeTypes?.toJSArray((e) => e),
         maxImages: maxImages,
       );

  final $js.ScanOptions _wrapped;

  $js.ScanOptions get toJS => _wrapped;

  /// The MIME types that are accepted by the caller.
  List<String>? get mimeTypes =>
      _wrapped.mimeTypes?.toDart.cast<String>().map((e) => e).toList();

  set mimeTypes(List<String>? v) {
    _wrapped.mimeTypes = v?.toJSArray((e) => e);
  }

  /// The number of scanned images allowed (defaults to 1).
  int? get maxImages => _wrapped.maxImages;

  set maxImages(int? v) {
    _wrapped.maxImages = v;
  }
}

class ScanResults {
  ScanResults.fromJS(this._wrapped);

  ScanResults({
    /// The data image URLs in a form that can be passed as the "src" value to
    /// an image tag.
    required List<String> dataUrls,

    /// The MIME type of `dataUrls`.
    required String mimeType,
  }) : _wrapped = $js.ScanResults(
         dataUrls: dataUrls.toJSArray((e) => e),
         mimeType: mimeType,
       );

  final $js.ScanResults _wrapped;

  $js.ScanResults get toJS => _wrapped;

  /// The data image URLs in a form that can be passed as the "src" value to
  /// an image tag.
  List<String> get dataUrls =>
      _wrapped.dataUrls.toDart.cast<String>().map((e) => e).toList();

  set dataUrls(List<String> v) {
    _wrapped.dataUrls = v.toJSArray((e) => e);
  }

  /// The MIME type of `dataUrls`.
  String get mimeType => _wrapped.mimeType;

  set mimeType(String v) {
    _wrapped.mimeType = v;
  }
}

class ScannerInfo {
  ScannerInfo.fromJS(this._wrapped);

  ScannerInfo({
    /// For connecting with `openScanner`.
    required String scannerId,

    /// Printable name for displaying in the UI.
    required String name,

    /// Scanner manufacturer.
    required String manufacturer,

    /// Scanner model if available, or a generic description.
    required String model,

    /// For matching against other `ScannerInfo` entries that point
    /// to the same physical device.
    required String deviceUuid,

    /// How the scanner is connected to the computer.
    required ConnectionType connectionType,

    /// If true, the scanner connection's transport cannot be intercepted by a
    /// passive listener, such as TLS or USB.
    required bool secure,

    /// MIME types that can be requested for returned scans.
    required List<String> imageFormats,
  }) : _wrapped = $js.ScannerInfo(
         scannerId: scannerId,
         name: name,
         manufacturer: manufacturer,
         model: model,
         deviceUuid: deviceUuid,
         connectionType: connectionType.toJS,
         secure: secure,
         imageFormats: imageFormats.toJSArray((e) => e),
       );

  final $js.ScannerInfo _wrapped;

  $js.ScannerInfo get toJS => _wrapped;

  /// For connecting with `openScanner`.
  String get scannerId => _wrapped.scannerId;

  set scannerId(String v) {
    _wrapped.scannerId = v;
  }

  /// Printable name for displaying in the UI.
  String get name => _wrapped.name;

  set name(String v) {
    _wrapped.name = v;
  }

  /// Scanner manufacturer.
  String get manufacturer => _wrapped.manufacturer;

  set manufacturer(String v) {
    _wrapped.manufacturer = v;
  }

  /// Scanner model if available, or a generic description.
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

  /// How the scanner is connected to the computer.
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

  /// MIME types that can be requested for returned scans.
  List<String> get imageFormats =>
      _wrapped.imageFormats.toDart.cast<String>().map((e) => e).toList();

  set imageFormats(List<String> v) {
    _wrapped.imageFormats = v.toJSArray((e) => e);
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
           int() => min.jsify()!,
           double() => min.jsify()!,
           null => null,
           _ =>
             throw UnsupportedError(
               'Received type: ${min.runtimeType}. Supported types are: int, double',
             ),
         },
         max: switch (max) {
           int() => max.jsify()!,
           double() => max.jsify()!,
           null => null,
           _ =>
             throw UnsupportedError(
               'Received type: ${max.runtimeType}. Supported types are: int, double',
             ),
         },
         quant: switch (quant) {
           int() => quant.jsify()!,
           double() => quant.jsify()!,
           null => null,
           _ =>
             throw UnsupportedError(
               'Received type: ${quant.runtimeType}. Supported types are: int, double',
             ),
         },
         list: switch (list) {
           List<double>() => list.toJSArray((e) => e),
           List<int>() => list.toJSArray((e) => e),
           List() => list.toJSArrayString(),
           null => null,
           _ =>
             throw UnsupportedError(
               'Received type: ${list.runtimeType}. Supported types are: List<double>, List<int>, List<String>',
             ),
         },
       );

  final $js.OptionConstraint _wrapped;

  $js.OptionConstraint get toJS => _wrapped;

  ConstraintType get type => ConstraintType.fromJS(_wrapped.type);

  set type(ConstraintType v) {
    _wrapped.type = v.toJS;
  }

  Object? get min => _wrapped.min?.when(isInt: (v) => v, isDouble: (v) => v);

  set min(Object? v) {
    _wrapped.min = switch (v) {
      int() => v.jsify()!,
      double() => v.jsify()!,
      null => null,
      _ =>
        throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: int, double',
        ),
    };
  }

  Object? get max => _wrapped.max?.when(isInt: (v) => v, isDouble: (v) => v);

  set max(Object? v) {
    _wrapped.max = switch (v) {
      int() => v.jsify()!,
      double() => v.jsify()!,
      null => null,
      _ =>
        throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: int, double',
        ),
    };
  }

  Object? get quant =>
      _wrapped.quant?.when(isInt: (v) => v, isDouble: (v) => v);

  set quant(Object? v) {
    _wrapped.quant = switch (v) {
      int() => v.jsify()!,
      double() => v.jsify()!,
      null => null,
      _ =>
        throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: int, double',
        ),
    };
  }

  Object? get list => _wrapped.list?.when(
    isArray: (v) => v.toDart.cast<double>().map((e) => e).toList(),
  );

  set list(Object? v) {
    _wrapped.list = switch (v) {
      List<double>() => v.toJSArray((e) => e),
      List<int>() => v.toJSArray((e) => e),
      List() => v.toJSArrayString(),
      null => null,
      _ =>
        throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: List<double>, List<int>, List<String>',
        ),
    };
  }
}

class ScannerOption {
  ScannerOption.fromJS(this._wrapped);

  ScannerOption({
    /// Option name using lowercase a-z, numbers, and dashes.
    required String name,

    /// Printable one-line title.
    required String title,

    /// Longer description of the option.
    required String description,

    /// The type that `value` will contain and that is needed for
    /// setting this option.
    required OptionType type,

    /// Unit of measurement for this option.
    required OptionUnit unit,

    /// Current value of the option if relevant. Note the type passed here must
    /// match the type specified in `type`.
    Object? value,

    /// Constraint on possible values.
    OptionConstraint? constraint,

    /// Can be detected from software.
    required bool isDetectable,

    /// Whether/how the option can be changed.
    required Configurability configurability,

    /// Can be automatically set by the backend.
    required bool isAutoSettable,

    /// Emulated by the backend if true.
    required bool isEmulated,

    /// Option is active and can be set/retrieved.  If false, the
    /// `value` field will not be set.
    required bool isActive,

    /// UI should not display this option by default.
    required bool isAdvanced,

    /// Option is used for internal configuration and should never be displayed
    /// in the UI.
    required bool isInternal,
  }) : _wrapped = $js.ScannerOption(
         name: name,
         title: title,
         description: description,
         type: type.toJS,
         unit: unit.toJS,
         value: switch (value) {
           bool() => value.jsify()!,
           double() => value.jsify()!,
           List<double>() => value.toJSArray((e) => e),
           int() => value.jsify()!,
           List<int>() => value.toJSArray((e) => e),
           String() => value.jsify()!,
           null => null,
           _ =>
             throw UnsupportedError(
               'Received type: ${value.runtimeType}. Supported types are: bool, double, List<double>, int, List<int>, String',
             ),
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

  /// Option name using lowercase a-z, numbers, and dashes.
  String get name => _wrapped.name;

  set name(String v) {
    _wrapped.name = v;
  }

  /// Printable one-line title.
  String get title => _wrapped.title;

  set title(String v) {
    _wrapped.title = v;
  }

  /// Longer description of the option.
  String get description => _wrapped.description;

  set description(String v) {
    _wrapped.description = v;
  }

  /// The type that `value` will contain and that is needed for
  /// setting this option.
  OptionType get type => OptionType.fromJS(_wrapped.type);

  set type(OptionType v) {
    _wrapped.type = v.toJS;
  }

  /// Unit of measurement for this option.
  OptionUnit get unit => OptionUnit.fromJS(_wrapped.unit);

  set unit(OptionUnit v) {
    _wrapped.unit = v.toJS;
  }

  /// Current value of the option if relevant. Note the type passed here must
  /// match the type specified in `type`.
  Object? get value => _wrapped.value?.when(
    isBool: (v) => v,
    isDouble: (v) => v,
    isArray: (v) => v.toDart.cast<double>().map((e) => e).toList(),
    isInt: (v) => v,
    isString: (v) => v,
  );

  set value(Object? v) {
    _wrapped.value = switch (v) {
      bool() => v.jsify()!,
      double() => v.jsify()!,
      List<double>() => v.toJSArray((e) => e),
      int() => v.jsify()!,
      List<int>() => v.toJSArray((e) => e),
      String() => v.jsify()!,
      null => null,
      _ =>
        throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: bool, double, List<double>, int, List<int>, String',
        ),
    };
  }

  /// Constraint on possible values.
  OptionConstraint? get constraint =>
      _wrapped.constraint?.let(OptionConstraint.fromJS);

  set constraint(OptionConstraint? v) {
    _wrapped.constraint = v?.toJS;
  }

  /// Can be detected from software.
  bool get isDetectable => _wrapped.isDetectable;

  set isDetectable(bool v) {
    _wrapped.isDetectable = v;
  }

  /// Whether/how the option can be changed.
  Configurability get configurability =>
      Configurability.fromJS(_wrapped.configurability);

  set configurability(Configurability v) {
    _wrapped.configurability = v.toJS;
  }

  /// Can be automatically set by the backend.
  bool get isAutoSettable => _wrapped.isAutoSettable;

  set isAutoSettable(bool v) {
    _wrapped.isAutoSettable = v;
  }

  /// Emulated by the backend if true.
  bool get isEmulated => _wrapped.isEmulated;

  set isEmulated(bool v) {
    _wrapped.isEmulated = v;
  }

  /// Option is active and can be set/retrieved.  If false, the
  /// `value` field will not be set.
  bool get isActive => _wrapped.isActive;

  set isActive(bool v) {
    _wrapped.isActive = v;
  }

  /// UI should not display this option by default.
  bool get isAdvanced => _wrapped.isAdvanced;

  set isAdvanced(bool v) {
    _wrapped.isAdvanced = v;
  }

  /// Option is used for internal configuration and should never be displayed
  /// in the UI.
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
  }) : _wrapped = $js.DeviceFilter(local: local, secure: secure);

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
    /// Printable title, e.g. "Geometry options".
    required String title,

    /// Names of contained options, in backend-provided order.
    required List<String> members,
  }) : _wrapped = $js.OptionGroup(
         title: title,
         members: members.toJSArray((e) => e),
       );

  final $js.OptionGroup _wrapped;

  $js.OptionGroup get toJS => _wrapped;

  /// Printable title, e.g. "Geometry options".
  String get title => _wrapped.title;

  set title(String v) {
    _wrapped.title = v;
  }

  /// Names of contained options, in backend-provided order.
  List<String> get members =>
      _wrapped.members.toDart.cast<String>().map((e) => e).toList();

  set members(List<String> v) {
    _wrapped.members = v.toJSArray((e) => e);
  }
}

class GetScannerListResponse {
  GetScannerListResponse.fromJS(this._wrapped);

  GetScannerListResponse({
    /// The backend's enumeration result.  Note that partial results could be
    /// returned even if this indicates an error.
    required OperationResult result,

    /// A possibly-empty list of scanners that match the provided
    /// `DeviceFilter`.
    required List<ScannerInfo> scanners,
  }) : _wrapped = $js.GetScannerListResponse(
         result: result.toJS,
         scanners: scanners.toJSArray((e) => e.toJS),
       );

  final $js.GetScannerListResponse _wrapped;

  $js.GetScannerListResponse get toJS => _wrapped;

  /// The backend's enumeration result.  Note that partial results could be
  /// returned even if this indicates an error.
  OperationResult get result => OperationResult.fromJS(_wrapped.result);

  set result(OperationResult v) {
    _wrapped.result = v.toJS;
  }

  /// A possibly-empty list of scanners that match the provided
  /// `DeviceFilter`.
  List<ScannerInfo> get scanners =>
      _wrapped.scanners.toDart
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
    /// Same scanner ID passed to `openScanner()`.
    required String scannerId,

    /// Backend result of opening the scanner.
    required OperationResult result,

    /// If `result` is `OperationResult.SUCCESS`, a handle
    /// to the scanner that can be used for further operations.
    String? scannerHandle,

    /// If `result` is `OperationResult.SUCCESS`, a
    /// key-value mapping from option names to `ScannerOption`.
    Map? options,
  }) : _wrapped = $js.OpenScannerResponse(
         scannerId: scannerId,
         result: result.toJS,
         scannerHandle: scannerHandle,
         options: options?.jsify(),
       );

  final $js.OpenScannerResponse _wrapped;

  $js.OpenScannerResponse get toJS => _wrapped;

  /// Same scanner ID passed to `openScanner()`.
  String get scannerId => _wrapped.scannerId;

  set scannerId(String v) {
    _wrapped.scannerId = v;
  }

  /// Backend result of opening the scanner.
  OperationResult get result => OperationResult.fromJS(_wrapped.result);

  set result(OperationResult v) {
    _wrapped.result = v.toJS;
  }

  /// If `result` is `OperationResult.SUCCESS`, a handle
  /// to the scanner that can be used for further operations.
  String? get scannerHandle => _wrapped.scannerHandle;

  set scannerHandle(String? v) {
    _wrapped.scannerHandle = v;
  }

  /// If `result` is `OperationResult.SUCCESS`, a
  /// key-value mapping from option names to `ScannerOption`.
  Map? get options => _wrapped.options?.toDartMap();

  set options(Map? v) {
    _wrapped.options = v?.jsify();
  }
}

class GetOptionGroupsResponse {
  GetOptionGroupsResponse.fromJS(this._wrapped);

  GetOptionGroupsResponse({
    /// Same scanner handle passed to `getOptionGroups()`.
    required String scannerHandle,

    /// The backend's result of getting the option groups.
    required OperationResult result,

    /// If `result` is `OperationResult.SUCCESS`, a list of
    /// option groups in the order supplied by the backend.
    List<OptionGroup>? groups,
  }) : _wrapped = $js.GetOptionGroupsResponse(
         scannerHandle: scannerHandle,
         result: result.toJS,
         groups: groups?.toJSArray((e) => e.toJS),
       );

  final $js.GetOptionGroupsResponse _wrapped;

  $js.GetOptionGroupsResponse get toJS => _wrapped;

  /// Same scanner handle passed to `getOptionGroups()`.
  String get scannerHandle => _wrapped.scannerHandle;

  set scannerHandle(String v) {
    _wrapped.scannerHandle = v;
  }

  /// The backend's result of getting the option groups.
  OperationResult get result => OperationResult.fromJS(_wrapped.result);

  set result(OperationResult v) {
    _wrapped.result = v.toJS;
  }

  /// If `result` is `OperationResult.SUCCESS`, a list of
  /// option groups in the order supplied by the backend.
  List<OptionGroup>? get groups =>
      _wrapped.groups?.toDart
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
    /// Same scanner handle passed to `closeScanner()`.
    required String scannerHandle,

    /// Backend result of closing the scanner.  Even if this value is not
    /// `OperationResult.SUCCESS`, the handle will be invalid and
    /// should not be used for any further operations.
    required OperationResult result,
  }) : _wrapped = $js.CloseScannerResponse(
         scannerHandle: scannerHandle,
         result: result.toJS,
       );

  final $js.CloseScannerResponse _wrapped;

  $js.CloseScannerResponse get toJS => _wrapped;

  /// Same scanner handle passed to `closeScanner()`.
  String get scannerHandle => _wrapped.scannerHandle;

  set scannerHandle(String v) {
    _wrapped.scannerHandle = v;
  }

  /// Backend result of closing the scanner.  Even if this value is not
  /// `OperationResult.SUCCESS`, the handle will be invalid and
  /// should not be used for any further operations.
  OperationResult get result => OperationResult.fromJS(_wrapped.result);

  set result(OperationResult v) {
    _wrapped.result = v.toJS;
  }
}

class OptionSetting {
  OptionSetting.fromJS(this._wrapped);

  OptionSetting({
    /// Name of the option to set.
    required String name,

    /// Type of the option.  The requested type must match the real type of the
    /// underlying option.
    required OptionType type,

    /// Value to set.  Leave unset to request automatic setting for options that
    /// have `autoSettable` enabled.  The type supplied for
    /// `value` must match `type`.
    Object? value,
  }) : _wrapped = $js.OptionSetting(
         name: name,
         type: type.toJS,
         value: switch (value) {
           bool() => value.jsify()!,
           double() => value.jsify()!,
           List<double>() => value.toJSArray((e) => e),
           int() => value.jsify()!,
           List<int>() => value.toJSArray((e) => e),
           String() => value.jsify()!,
           null => null,
           _ =>
             throw UnsupportedError(
               'Received type: ${value.runtimeType}. Supported types are: bool, double, List<double>, int, List<int>, String',
             ),
         },
       );

  final $js.OptionSetting _wrapped;

  $js.OptionSetting get toJS => _wrapped;

  /// Name of the option to set.
  String get name => _wrapped.name;

  set name(String v) {
    _wrapped.name = v;
  }

  /// Type of the option.  The requested type must match the real type of the
  /// underlying option.
  OptionType get type => OptionType.fromJS(_wrapped.type);

  set type(OptionType v) {
    _wrapped.type = v.toJS;
  }

  /// Value to set.  Leave unset to request automatic setting for options that
  /// have `autoSettable` enabled.  The type supplied for
  /// `value` must match `type`.
  Object? get value => _wrapped.value?.when(
    isBool: (v) => v,
    isDouble: (v) => v,
    isArray: (v) => v.toDart.cast<double>().map((e) => e).toList(),
    isInt: (v) => v,
    isString: (v) => v,
  );

  set value(Object? v) {
    _wrapped.value = switch (v) {
      bool() => v.jsify()!,
      double() => v.jsify()!,
      List<double>() => v.toJSArray((e) => e),
      int() => v.jsify()!,
      List<int>() => v.toJSArray((e) => e),
      String() => v.jsify()!,
      null => null,
      _ =>
        throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: bool, double, List<double>, int, List<int>, String',
        ),
    };
  }
}

class SetOptionResult {
  SetOptionResult.fromJS(this._wrapped);

  SetOptionResult({
    /// Name of the option that was set.
    required String name,

    /// Backend result of setting the option.
    required OperationResult result,
  }) : _wrapped = $js.SetOptionResult(name: name, result: result.toJS);

  final $js.SetOptionResult _wrapped;

  $js.SetOptionResult get toJS => _wrapped;

  /// Name of the option that was set.
  String get name => _wrapped.name;

  set name(String v) {
    _wrapped.name = v;
  }

  /// Backend result of setting the option.
  OperationResult get result => OperationResult.fromJS(_wrapped.result);

  set result(OperationResult v) {
    _wrapped.result = v.toJS;
  }
}

class SetOptionsResponse {
  SetOptionsResponse.fromJS(this._wrapped);

  SetOptionsResponse({
    /// The same scanner handle passed to `setOptions()`.
    required String scannerHandle,

    /// One result per passed-in `OptionSetting`.
    required List<SetOptionResult> results,

    /// Updated key-value mapping from option names to
    /// `ScannerOption` containing the new configuration after
    /// attempting to set all supplied options.  This has the same structure as
    /// the `options` field in `OpenScannerResponse`.
    ///
    /// This field will be set even if some options were not set successfully,
    /// but will be unset if retrieving the updated configuration fails (e.g.,
    /// if the scanner is disconnected in the middle).
    Map? options,
  }) : _wrapped = $js.SetOptionsResponse(
         scannerHandle: scannerHandle,
         results: results.toJSArray((e) => e.toJS),
         options: options?.jsify(),
       );

  final $js.SetOptionsResponse _wrapped;

  $js.SetOptionsResponse get toJS => _wrapped;

  /// The same scanner handle passed to `setOptions()`.
  String get scannerHandle => _wrapped.scannerHandle;

  set scannerHandle(String v) {
    _wrapped.scannerHandle = v;
  }

  /// One result per passed-in `OptionSetting`.
  List<SetOptionResult> get results =>
      _wrapped.results.toDart
          .cast<$js.SetOptionResult>()
          .map((e) => SetOptionResult.fromJS(e))
          .toList();

  set results(List<SetOptionResult> v) {
    _wrapped.results = v.toJSArray((e) => e.toJS);
  }

  /// Updated key-value mapping from option names to
  /// `ScannerOption` containing the new configuration after
  /// attempting to set all supplied options.  This has the same structure as
  /// the `options` field in `OpenScannerResponse`.
  ///
  /// This field will be set even if some options were not set successfully,
  /// but will be unset if retrieving the updated configuration fails (e.g.,
  /// if the scanner is disconnected in the middle).
  Map? get options => _wrapped.options?.toDartMap();

  set options(Map? v) {
    _wrapped.options = v?.jsify();
  }
}

class StartScanOptions {
  StartScanOptions.fromJS(this._wrapped);

  StartScanOptions({
    /// MIME type to return scanned data in.
    required String format,
  }) : _wrapped = $js.StartScanOptions(format: format);

  final $js.StartScanOptions _wrapped;

  $js.StartScanOptions get toJS => _wrapped;

  /// MIME type to return scanned data in.
  String get format => _wrapped.format;

  set format(String v) {
    _wrapped.format = v;
  }
}

class StartScanResponse {
  StartScanResponse.fromJS(this._wrapped);

  StartScanResponse({
    /// The same scanner handle that was passed to `startScan()`.
    required String scannerHandle,

    /// The backend's start scan result.
    required OperationResult result,

    /// If `result` is `OperationResult.SUCCESS`, a handle
    /// that can be used to read scan data or cancel the job.
    String? job,
  }) : _wrapped = $js.StartScanResponse(
         scannerHandle: scannerHandle,
         result: result.toJS,
         job: job,
       );

  final $js.StartScanResponse _wrapped;

  $js.StartScanResponse get toJS => _wrapped;

  /// The same scanner handle that was passed to `startScan()`.
  String get scannerHandle => _wrapped.scannerHandle;

  set scannerHandle(String v) {
    _wrapped.scannerHandle = v;
  }

  /// The backend's start scan result.
  OperationResult get result => OperationResult.fromJS(_wrapped.result);

  set result(OperationResult v) {
    _wrapped.result = v.toJS;
  }

  /// If `result` is `OperationResult.SUCCESS`, a handle
  /// that can be used to read scan data or cancel the job.
  String? get job => _wrapped.job;

  set job(String? v) {
    _wrapped.job = v;
  }
}

class CancelScanResponse {
  CancelScanResponse.fromJS(this._wrapped);

  CancelScanResponse({
    /// The same job handle that was passed to `cancelScan()`.
    required String job,

    /// The backend's cancel scan result.
    required OperationResult result,
  }) : _wrapped = $js.CancelScanResponse(job: job, result: result.toJS);

  final $js.CancelScanResponse _wrapped;

  $js.CancelScanResponse get toJS => _wrapped;

  /// The same job handle that was passed to `cancelScan()`.
  String get job => _wrapped.job;

  set job(String v) {
    _wrapped.job = v;
  }

  /// The backend's cancel scan result.
  OperationResult get result => OperationResult.fromJS(_wrapped.result);

  set result(OperationResult v) {
    _wrapped.result = v.toJS;
  }
}

class ReadScanDataResponse {
  ReadScanDataResponse.fromJS(this._wrapped);

  ReadScanDataResponse({
    /// Same job handle passed to `readScanData()`.
    required String job,

    /// The backend result of reading data.  If this is
    /// `OperationResult.SUCCESS`, `data` will contain the
    /// next (possibly zero-length) chunk of image data that was ready for
    /// reading.  If this is `OperationResult.EOF`, `data`
    /// will contain the final chunk of image data.
    required OperationResult result,

    /// If result is `OperationResult.SUCCESS`, the next chunk of
    /// scanned image data.
    ByteBuffer? data,

    /// If result is `OperationResult.SUCCESS`, an estimate of how
    /// much of the total scan data has been delivered so far, in the range
    /// 0-100.
    int? estimatedCompletion,
  }) : _wrapped = $js.ReadScanDataResponse(
         job: job,
         result: result.toJS,
         data: data?.toJS,
         estimatedCompletion: estimatedCompletion,
       );

  final $js.ReadScanDataResponse _wrapped;

  $js.ReadScanDataResponse get toJS => _wrapped;

  /// Same job handle passed to `readScanData()`.
  String get job => _wrapped.job;

  set job(String v) {
    _wrapped.job = v;
  }

  /// The backend result of reading data.  If this is
  /// `OperationResult.SUCCESS`, `data` will contain the
  /// next (possibly zero-length) chunk of image data that was ready for
  /// reading.  If this is `OperationResult.EOF`, `data`
  /// will contain the final chunk of image data.
  OperationResult get result => OperationResult.fromJS(_wrapped.result);

  set result(OperationResult v) {
    _wrapped.result = v.toJS;
  }

  /// If result is `OperationResult.SUCCESS`, the next chunk of
  /// scanned image data.
  ByteBuffer? get data => _wrapped.data?.toDart;

  set data(ByteBuffer? v) {
    _wrapped.data = v?.toJS;
  }

  /// If result is `OperationResult.SUCCESS`, an estimate of how
  /// much of the total scan data has been delivered so far, in the range
  /// 0-100.
  int? get estimatedCompletion => _wrapped.estimatedCompletion;

  set estimatedCompletion(int? v) {
    _wrapped.estimatedCompletion = v;
  }
}
