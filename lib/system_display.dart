// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/system_display.dart' as $js;
import 'system.dart';

export 'src/chrome.dart' show chrome;
export 'system.dart' show ChromeSystem, ChromeSystemExtension;

final _systemDisplay = ChromeSystemDisplay._();

extension ChromeSystemDisplayExtension on ChromeSystem {
  /// Use the `system.display` API to query display metadata.
  ChromeSystemDisplay get display => _systemDisplay;
}

class ChromeSystemDisplay {
  ChromeSystemDisplay._();

  bool get isAvailable =>
      $js.chrome.systemNullable?.displayNullable != null && alwaysTrue;

  /// Requests the information for all attached display devices.
  /// |flags|: Options affecting how the information is returned.
  /// |callback|: The callback to invoke with the results.
  Future<List<DisplayUnitInfo>> getInfo(GetInfoFlags? flags) async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.system.display.getInfo(flags?.toJS));
    return $res.toDart
        .cast<$js.DisplayUnitInfo>()
        .map((e) => DisplayUnitInfo.fromJS(e))
        .toList();
  }

  /// Requests the layout info for all displays.
  /// NOTE: This is only available to Chrome OS Kiosk apps and Web UI.
  /// |callback|: The callback to invoke with the results.
  Future<List<DisplayLayout>> getDisplayLayout() async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.system.display.getDisplayLayout());
    return $res.toDart
        .cast<$js.DisplayLayout>()
        .map((e) => DisplayLayout.fromJS(e))
        .toList();
  }

  /// Updates the properties for the display specified by |id|, according to
  /// the information provided in |info|. On failure, [runtime.lastError]
  /// will be set.
  /// NOTE: This is only available to Chrome OS Kiosk apps and Web UI.
  /// |id|: The display's unique identifier.
  /// |info|: The information about display properties that should be changed.
  ///     A property will be changed only if a new value for it is specified in
  ///     |info|.
  /// |callback|: Empty function called when the function finishes. To find out
  ///     whether the function succeeded, [runtime.lastError] should be
  ///     queried.
  Future<void> setDisplayProperties(
    String id,
    DisplayProperties info,
  ) async {
    await promiseToFuture<void>($js.chrome.system.display.setDisplayProperties(
      id,
      info.toJS,
    ));
  }

  /// Set the layout for all displays. Any display not included will use the
  /// default layout. If a layout would overlap or be otherwise invalid it
  /// will be adjusted to a valid layout. After layout is resolved, an
  /// onDisplayChanged event will be triggered.
  /// NOTE: This is only available to Chrome OS Kiosk apps and Web UI.
  /// |layouts|: The layout information, required for all displays except
  ///     the primary display.
  /// |callback|: Empty function called when the function finishes. To find out
  ///     whether the function succeeded, [runtime.lastError] should be
  ///     queried.
  Future<void> setDisplayLayout(List<DisplayLayout> layouts) async {
    await promiseToFuture<void>($js.chrome.system.display
        .setDisplayLayout(layouts.toJSArray((e) => e.toJS)));
  }

  /// Enables/disables the unified desktop feature. If enabled while mirroring
  /// is active, the desktop mode will not change until mirroring is turned
  /// off. Otherwise, the desktop mode will switch to unified immediately.
  /// NOTE: This is only available to Chrome OS Kiosk apps and Web UI.
  /// |enabled|: True if unified desktop should be enabled.
  void enableUnifiedDesktop(bool enabled) {
    $js.chrome.system.display.enableUnifiedDesktop(enabled);
  }

  /// Starts overscan calibration for a display. This will show an overlay
  /// on the screen indicating the current overscan insets. If overscan
  /// calibration for display |id| is in progress this will reset calibration.
  /// |id|: The display's unique identifier.
  void overscanCalibrationStart(String id) {
    $js.chrome.system.display.overscanCalibrationStart(id);
  }

  /// Adjusts the current overscan insets for a display. Typically this should
  /// either move the display along an axis (e.g. left+right have the same
  /// value) or scale it along an axis (e.g. top+bottom have opposite values).
  /// Each Adjust call is cumulative with previous calls since Start.
  /// |id|: The display's unique identifier.
  /// |delta|: The amount to change the overscan insets.
  void overscanCalibrationAdjust(
    String id,
    Insets delta,
  ) {
    $js.chrome.system.display.overscanCalibrationAdjust(
      id,
      delta.toJS,
    );
  }

  /// Resets the overscan insets for a display to the last saved value (i.e
  /// before Start was called).
  /// |id|: The display's unique identifier.
  void overscanCalibrationReset(String id) {
    $js.chrome.system.display.overscanCalibrationReset(id);
  }

  /// Complete overscan adjustments for a display  by saving the current values
  /// and hiding the overlay.
  /// |id|: The display's unique identifier.
  void overscanCalibrationComplete(String id) {
    $js.chrome.system.display.overscanCalibrationComplete(id);
  }

  /// Displays the native touch calibration UX for the display with |id| as
  /// display id. This will show an overlay on the screen with required
  /// instructions on how to proceed. The callback will be invoked in case of
  /// successful calibration only. If the calibration fails, this will throw an
  /// error.
  /// |id|: The display's unique identifier.
  /// |callback|: Optional callback to inform the caller that the touch
  ///      calibration has ended. The argument of the callback informs if the
  ///      calibration was a success or not.
  Future<bool> showNativeTouchCalibration(String id) async {
    var $res = await promiseToFuture<bool>(
        $js.chrome.system.display.showNativeTouchCalibration(id));
    return $res;
  }

  /// Starts custom touch calibration for a display. This should be called when
  /// using a custom UX for collecting calibration data. If another touch
  /// calibration is already in progress this will throw an error.
  /// |id|: The display's unique identifier.
  void startCustomTouchCalibration(String id) {
    $js.chrome.system.display.startCustomTouchCalibration(id);
  }

  /// Sets the touch calibration pairs for a display. These |pairs| would be
  /// used to calibrate the touch screen for display with |id| called in
  /// startCustomTouchCalibration(). Always call |startCustomTouchCalibration|
  /// before calling this method. If another touch calibration is already in
  /// progress this will throw an error.
  /// |pairs|: The pairs of point used to calibrate the display.
  /// |bounds|: Bounds of the display when the touch calibration was performed.
  ///     |bounds.left| and |bounds.top| values are ignored.
  void completeCustomTouchCalibration(
    TouchCalibrationPairQuad pairs,
    Bounds bounds,
  ) {
    $js.chrome.system.display.completeCustomTouchCalibration(
      pairs.toJS,
      bounds.toJS,
    );
  }

  /// Resets the touch calibration for the display and brings it back to its
  /// default state by clearing any touch calibration data associated with the
  /// display.
  /// |id|: The display's unique identifier.
  void clearTouchCalibration(String id) {
    $js.chrome.system.display.clearTouchCalibration(id);
  }

  /// Sets the display mode to the specified mirror mode. Each call resets the
  /// state from previous calls. Calling setDisplayProperties() will fail for
  /// the mirroring destination displays.
  /// NOTE: This is only available to Chrome OS Kiosk apps and Web UI.
  /// |info|: The information of the mirror mode that should be applied to the
  ///     display mode.
  /// |callback|: Empty function called when the function finishes. To find out
  ///     whether the function succeeded, [runtime.lastError] should be
  ///     queried.
  Future<void> setMirrorMode(MirrorModeInfo info) async {
    await promiseToFuture<void>(
        $js.chrome.system.display.setMirrorMode(info.toJS));
  }

  /// Fired when anything changes to the display configuration.
  EventStream<void> get onDisplayChanged =>
      $js.chrome.system.display.onDisplayChanged.asStream(($c) => () {
            return $c(null);
          });
}

/// Layout position, i.e. edge of parent that the display is attached to.
enum LayoutPosition {
  top('top'),
  right('right'),
  bottom('bottom'),
  left('left');

  const LayoutPosition(this.value);

  final String value;

  String get toJS => value;
  static LayoutPosition fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Mirror mode, i.e. different ways of how a display is mirrored to other
/// displays.
enum MirrorMode {
  /// Use the default mode (extended or unified desktop).
  off('off'),

  /// The default source display will be mirrored to all other displays.
  normal('normal'),

  /// The specified source display will be mirrored to the provided
  /// destination displays. All other connected displays will be extended.
  mixed('mixed');

  const MirrorMode(this.value);

  final String value;

  String get toJS => value;
  static MirrorMode fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class Bounds {
  Bounds.fromJS(this._wrapped);

  Bounds({
    /// The x-coordinate of the upper-left corner.
    required int left,

    /// The y-coordinate of the upper-left corner.
    required int top,

    /// The width of the display in pixels.
    required int width,

    /// The height of the display in pixels.
    required int height,
  }) : _wrapped = $js.Bounds(
          left: left,
          top: top,
          width: width,
          height: height,
        );

  final $js.Bounds _wrapped;

  $js.Bounds get toJS => _wrapped;

  /// The x-coordinate of the upper-left corner.
  int get left => _wrapped.left;
  set left(int v) {
    _wrapped.left = v;
  }

  /// The y-coordinate of the upper-left corner.
  int get top => _wrapped.top;
  set top(int v) {
    _wrapped.top = v;
  }

  /// The width of the display in pixels.
  int get width => _wrapped.width;
  set width(int v) {
    _wrapped.width = v;
  }

  /// The height of the display in pixels.
  int get height => _wrapped.height;
  set height(int v) {
    _wrapped.height = v;
  }
}

class Insets {
  Insets.fromJS(this._wrapped);

  Insets({
    /// The x-axis distance from the left bound.
    required int left,

    /// The y-axis distance from the top bound.
    required int top,

    /// The x-axis distance from the right bound.
    required int right,

    /// The y-axis distance from the bottom bound.
    required int bottom,
  }) : _wrapped = $js.Insets(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
        );

  final $js.Insets _wrapped;

  $js.Insets get toJS => _wrapped;

  /// The x-axis distance from the left bound.
  int get left => _wrapped.left;
  set left(int v) {
    _wrapped.left = v;
  }

  /// The y-axis distance from the top bound.
  int get top => _wrapped.top;
  set top(int v) {
    _wrapped.top = v;
  }

  /// The x-axis distance from the right bound.
  int get right => _wrapped.right;
  set right(int v) {
    _wrapped.right = v;
  }

  /// The y-axis distance from the bottom bound.
  int get bottom => _wrapped.bottom;
  set bottom(int v) {
    _wrapped.bottom = v;
  }
}

class Point {
  Point.fromJS(this._wrapped);

  Point({
    /// The x-coordinate of the point.
    required int x,

    /// The y-coordinate of the point.
    required int y,
  }) : _wrapped = $js.Point(
          x: x,
          y: y,
        );

  final $js.Point _wrapped;

  $js.Point get toJS => _wrapped;

  /// The x-coordinate of the point.
  int get x => _wrapped.x;
  set x(int v) {
    _wrapped.x = v;
  }

  /// The y-coordinate of the point.
  int get y => _wrapped.y;
  set y(int v) {
    _wrapped.y = v;
  }
}

class TouchCalibrationPair {
  TouchCalibrationPair.fromJS(this._wrapped);

  TouchCalibrationPair({
    /// The coordinates of the display point.
    required Point displayPoint,

    /// The coordinates of the touch point corresponding to the display point.
    required Point touchPoint,
  }) : _wrapped = $js.TouchCalibrationPair(
          displayPoint: displayPoint.toJS,
          touchPoint: touchPoint.toJS,
        );

  final $js.TouchCalibrationPair _wrapped;

  $js.TouchCalibrationPair get toJS => _wrapped;

  /// The coordinates of the display point.
  Point get displayPoint => Point.fromJS(_wrapped.displayPoint);
  set displayPoint(Point v) {
    _wrapped.displayPoint = v.toJS;
  }

  /// The coordinates of the touch point corresponding to the display point.
  Point get touchPoint => Point.fromJS(_wrapped.touchPoint);
  set touchPoint(Point v) {
    _wrapped.touchPoint = v.toJS;
  }
}

class TouchCalibrationPairQuad {
  TouchCalibrationPairQuad.fromJS(this._wrapped);

  TouchCalibrationPairQuad({
    /// First pair of touch and display point required for touch calibration.
    required TouchCalibrationPair pair1,

    /// Second pair of touch and display point required for touch calibration.
    required TouchCalibrationPair pair2,

    /// Third pair of touch and display point required for touch calibration.
    required TouchCalibrationPair pair3,

    /// Fourth pair of touch and display point required for touch calibration.
    required TouchCalibrationPair pair4,
  }) : _wrapped = $js.TouchCalibrationPairQuad(
          pair1: pair1.toJS,
          pair2: pair2.toJS,
          pair3: pair3.toJS,
          pair4: pair4.toJS,
        );

  final $js.TouchCalibrationPairQuad _wrapped;

  $js.TouchCalibrationPairQuad get toJS => _wrapped;

  /// First pair of touch and display point required for touch calibration.
  TouchCalibrationPair get pair1 => TouchCalibrationPair.fromJS(_wrapped.pair1);
  set pair1(TouchCalibrationPair v) {
    _wrapped.pair1 = v.toJS;
  }

  /// Second pair of touch and display point required for touch calibration.
  TouchCalibrationPair get pair2 => TouchCalibrationPair.fromJS(_wrapped.pair2);
  set pair2(TouchCalibrationPair v) {
    _wrapped.pair2 = v.toJS;
  }

  /// Third pair of touch and display point required for touch calibration.
  TouchCalibrationPair get pair3 => TouchCalibrationPair.fromJS(_wrapped.pair3);
  set pair3(TouchCalibrationPair v) {
    _wrapped.pair3 = v.toJS;
  }

  /// Fourth pair of touch and display point required for touch calibration.
  TouchCalibrationPair get pair4 => TouchCalibrationPair.fromJS(_wrapped.pair4);
  set pair4(TouchCalibrationPair v) {
    _wrapped.pair4 = v.toJS;
  }
}

class DisplayMode {
  DisplayMode.fromJS(this._wrapped);

  DisplayMode({
    /// The display mode width in device independent (user visible) pixels.
    required int width,

    /// The display mode height in device independent (user visible) pixels.
    required int height,

    /// The display mode width in native pixels.
    required int widthInNativePixels,

    /// The display mode height in native pixels.
    required int heightInNativePixels,

    /// The display mode UI scale factor.
    double? uiScale,

    /// The display mode device scale factor.
    required double deviceScaleFactor,

    /// The display mode refresh rate in hertz.
    required double refreshRate,

    /// True if the mode is the display's native mode.
    required bool isNative,

    /// True if the display mode is currently selected.
    required bool isSelected,

    /// True if this mode is interlaced, false if not provided.
    bool? isInterlaced,
  }) : _wrapped = $js.DisplayMode(
          width: width,
          height: height,
          widthInNativePixels: widthInNativePixels,
          heightInNativePixels: heightInNativePixels,
          uiScale: uiScale,
          deviceScaleFactor: deviceScaleFactor,
          refreshRate: refreshRate,
          isNative: isNative,
          isSelected: isSelected,
          isInterlaced: isInterlaced,
        );

  final $js.DisplayMode _wrapped;

  $js.DisplayMode get toJS => _wrapped;

  /// The display mode width in device independent (user visible) pixels.
  int get width => _wrapped.width;
  set width(int v) {
    _wrapped.width = v;
  }

  /// The display mode height in device independent (user visible) pixels.
  int get height => _wrapped.height;
  set height(int v) {
    _wrapped.height = v;
  }

  /// The display mode width in native pixels.
  int get widthInNativePixels => _wrapped.widthInNativePixels;
  set widthInNativePixels(int v) {
    _wrapped.widthInNativePixels = v;
  }

  /// The display mode height in native pixels.
  int get heightInNativePixels => _wrapped.heightInNativePixels;
  set heightInNativePixels(int v) {
    _wrapped.heightInNativePixels = v;
  }

  /// The display mode UI scale factor.
  double? get uiScale => _wrapped.uiScale;
  set uiScale(double? v) {
    _wrapped.uiScale = v;
  }

  /// The display mode device scale factor.
  double get deviceScaleFactor => _wrapped.deviceScaleFactor;
  set deviceScaleFactor(double v) {
    _wrapped.deviceScaleFactor = v;
  }

  /// The display mode refresh rate in hertz.
  double get refreshRate => _wrapped.refreshRate;
  set refreshRate(double v) {
    _wrapped.refreshRate = v;
  }

  /// True if the mode is the display's native mode.
  bool get isNative => _wrapped.isNative;
  set isNative(bool v) {
    _wrapped.isNative = v;
  }

  /// True if the display mode is currently selected.
  bool get isSelected => _wrapped.isSelected;
  set isSelected(bool v) {
    _wrapped.isSelected = v;
  }

  /// True if this mode is interlaced, false if not provided.
  bool? get isInterlaced => _wrapped.isInterlaced;
  set isInterlaced(bool? v) {
    _wrapped.isInterlaced = v;
  }
}

class DisplayLayout {
  DisplayLayout.fromJS(this._wrapped);

  DisplayLayout({
    /// The unique identifier of the display.
    required String id,

    /// The unique identifier of the parent display. Empty if this is the root.
    required String parentId,

    /// The layout position of this display relative to the parent. This will
    /// be ignored for the root.
    required LayoutPosition position,

    /// The offset of the display along the connected edge. 0 indicates that
    /// the topmost or leftmost corners are aligned.
    required int offset,
  }) : _wrapped = $js.DisplayLayout(
          id: id,
          parentId: parentId,
          position: position.toJS,
          offset: offset,
        );

  final $js.DisplayLayout _wrapped;

  $js.DisplayLayout get toJS => _wrapped;

  /// The unique identifier of the display.
  String get id => _wrapped.id;
  set id(String v) {
    _wrapped.id = v;
  }

  /// The unique identifier of the parent display. Empty if this is the root.
  String get parentId => _wrapped.parentId;
  set parentId(String v) {
    _wrapped.parentId = v;
  }

  /// The layout position of this display relative to the parent. This will
  /// be ignored for the root.
  LayoutPosition get position => LayoutPosition.fromJS(_wrapped.position);
  set position(LayoutPosition v) {
    _wrapped.position = v.toJS;
  }

  /// The offset of the display along the connected edge. 0 indicates that
  /// the topmost or leftmost corners are aligned.
  int get offset => _wrapped.offset;
  set offset(int v) {
    _wrapped.offset = v;
  }
}

class Edid {
  Edid.fromJS(this._wrapped);

  Edid({
    /// 3 character manufacturer code. See Sec. 3.4.1 page 21. Required in v1.4.
    required String manufacturerId,

    /// 2 byte manufacturer-assigned code, Sec. 3.4.2 page 21. Required in v1.4.
    required String productId,

    /// Year of manufacturer, Sec. 3.4.4 page 22. Required in v1.4.
    required int yearOfManufacture,
  }) : _wrapped = $js.Edid(
          manufacturerId: manufacturerId,
          productId: productId,
          yearOfManufacture: yearOfManufacture,
        );

  final $js.Edid _wrapped;

  $js.Edid get toJS => _wrapped;

  /// 3 character manufacturer code. See Sec. 3.4.1 page 21. Required in v1.4.
  String get manufacturerId => _wrapped.manufacturerId;
  set manufacturerId(String v) {
    _wrapped.manufacturerId = v;
  }

  /// 2 byte manufacturer-assigned code, Sec. 3.4.2 page 21. Required in v1.4.
  String get productId => _wrapped.productId;
  set productId(String v) {
    _wrapped.productId = v;
  }

  /// Year of manufacturer, Sec. 3.4.4 page 22. Required in v1.4.
  int get yearOfManufacture => _wrapped.yearOfManufacture;
  set yearOfManufacture(int v) {
    _wrapped.yearOfManufacture = v;
  }
}

class DisplayUnitInfo {
  DisplayUnitInfo.fromJS(this._wrapped);

  DisplayUnitInfo({
    /// The unique identifier of the display.
    required String id,

    /// The user-friendly name (e.g. "HP LCD monitor").
    required String name,

    /// NOTE: This is only available to Chrome OS Kiosk apps and Web UI.
    Edid? edid,

    /// Chrome OS only. Identifier of the display that is being mirrored if
    /// mirroring is enabled, otherwise empty. This will be set for all displays
    /// (including the display being mirrored).
    required String mirroringSourceId,

    /// Chrome OS only. Identifiers of the displays to which the source display
    /// is being mirrored. Empty if no displays are being mirrored. This will be
    /// set to the same value for all displays. This must not include
    /// |mirroringSourceId|.
    required List<String> mirroringDestinationIds,

    /// True if this is the primary display.
    required bool isPrimary,

    /// True if this is an internal display.
    required bool isInternal,

    /// True if this display is enabled.
    required bool isEnabled,

    /// True for all displays when in unified desktop mode. See documentation
    /// for [enableUnifiedDesktop].
    required bool isUnified,

    /// True when the auto-rotation is allowed. It happens when the device is in
    /// a tablet physical state or kSupportsClamshellAutoRotation is set.
    /// Provided for ChromeOS Settings UI only. TODO(stevenjb): Remove when
    /// Settings switches to a mojo API.
    bool? isAutoRotationAllowed,

    /// The number of pixels per inch along the x-axis.
    required double dpiX,

    /// The number of pixels per inch along the y-axis.
    required double dpiY,

    /// The display's clockwise rotation in degrees relative to the vertical
    /// position.
    /// Currently exposed only on ChromeOS. Will be set to 0 on other platforms.
    /// A value of -1 will be interpreted as auto-rotate when the device is in
    /// a physical tablet state.
    required int rotation,

    /// The display's logical bounds.
    required Bounds bounds,

    /// The display's insets within its screen's bounds.
    /// Currently exposed only on ChromeOS. Will be set to empty insets on
    /// other platforms.
    required Insets overscan,

    /// The usable work area of the display within the display bounds. The work
    /// area excludes areas of the display reserved for OS, for example taskbar
    /// and launcher.
    required Bounds workArea,

    /// The list of available display modes. The current mode will have
    /// isSelected=true. Only available on Chrome OS. Will be set to an empty
    /// array on other platforms.
    required List<DisplayMode> modes,

    /// True if this display has a touch input device associated with it.
    required bool hasTouchSupport,

    /// True if this display has an accelerometer associated with it.
    /// Provided for ChromeOS Settings UI only. TODO(stevenjb): Remove when
    /// Settings switches to a mojo API. NOTE: The name of this may change.
    required bool hasAccelerometerSupport,

    /// A list of zoom factor values that can be set for the display.
    required List<double> availableDisplayZoomFactors,

    /// The ratio between the display's current and default zoom.
    /// For example, value 1 is equivalent to 100% zoom, and value 1.5 is
    /// equivalent to 150% zoom.
    required double displayZoomFactor,
  }) : _wrapped = $js.DisplayUnitInfo(
          id: id,
          name: name,
          edid: edid?.toJS,
          mirroringSourceId: mirroringSourceId,
          mirroringDestinationIds: mirroringDestinationIds.toJSArray((e) => e),
          isPrimary: isPrimary,
          isInternal: isInternal,
          isEnabled: isEnabled,
          isUnified: isUnified,
          isAutoRotationAllowed: isAutoRotationAllowed,
          dpiX: dpiX,
          dpiY: dpiY,
          rotation: rotation,
          bounds: bounds.toJS,
          overscan: overscan.toJS,
          workArea: workArea.toJS,
          modes: modes.toJSArray((e) => e.toJS),
          hasTouchSupport: hasTouchSupport,
          hasAccelerometerSupport: hasAccelerometerSupport,
          availableDisplayZoomFactors:
              availableDisplayZoomFactors.toJSArray((e) => e),
          displayZoomFactor: displayZoomFactor,
        );

  final $js.DisplayUnitInfo _wrapped;

  $js.DisplayUnitInfo get toJS => _wrapped;

  /// The unique identifier of the display.
  String get id => _wrapped.id;
  set id(String v) {
    _wrapped.id = v;
  }

  /// The user-friendly name (e.g. "HP LCD monitor").
  String get name => _wrapped.name;
  set name(String v) {
    _wrapped.name = v;
  }

  /// NOTE: This is only available to Chrome OS Kiosk apps and Web UI.
  Edid? get edid => _wrapped.edid?.let(Edid.fromJS);
  set edid(Edid? v) {
    _wrapped.edid = v?.toJS;
  }

  /// Chrome OS only. Identifier of the display that is being mirrored if
  /// mirroring is enabled, otherwise empty. This will be set for all displays
  /// (including the display being mirrored).
  String get mirroringSourceId => _wrapped.mirroringSourceId;
  set mirroringSourceId(String v) {
    _wrapped.mirroringSourceId = v;
  }

  /// Chrome OS only. Identifiers of the displays to which the source display
  /// is being mirrored. Empty if no displays are being mirrored. This will be
  /// set to the same value for all displays. This must not include
  /// |mirroringSourceId|.
  List<String> get mirroringDestinationIds =>
      _wrapped.mirroringDestinationIds.toDart
          .cast<String>()
          .map((e) => e)
          .toList();
  set mirroringDestinationIds(List<String> v) {
    _wrapped.mirroringDestinationIds = v.toJSArray((e) => e);
  }

  /// True if this is the primary display.
  bool get isPrimary => _wrapped.isPrimary;
  set isPrimary(bool v) {
    _wrapped.isPrimary = v;
  }

  /// True if this is an internal display.
  bool get isInternal => _wrapped.isInternal;
  set isInternal(bool v) {
    _wrapped.isInternal = v;
  }

  /// True if this display is enabled.
  bool get isEnabled => _wrapped.isEnabled;
  set isEnabled(bool v) {
    _wrapped.isEnabled = v;
  }

  /// True for all displays when in unified desktop mode. See documentation
  /// for [enableUnifiedDesktop].
  bool get isUnified => _wrapped.isUnified;
  set isUnified(bool v) {
    _wrapped.isUnified = v;
  }

  /// True when the auto-rotation is allowed. It happens when the device is in
  /// a tablet physical state or kSupportsClamshellAutoRotation is set.
  /// Provided for ChromeOS Settings UI only. TODO(stevenjb): Remove when
  /// Settings switches to a mojo API.
  bool? get isAutoRotationAllowed => _wrapped.isAutoRotationAllowed;
  set isAutoRotationAllowed(bool? v) {
    _wrapped.isAutoRotationAllowed = v;
  }

  /// The number of pixels per inch along the x-axis.
  double get dpiX => _wrapped.dpiX;
  set dpiX(double v) {
    _wrapped.dpiX = v;
  }

  /// The number of pixels per inch along the y-axis.
  double get dpiY => _wrapped.dpiY;
  set dpiY(double v) {
    _wrapped.dpiY = v;
  }

  /// The display's clockwise rotation in degrees relative to the vertical
  /// position.
  /// Currently exposed only on ChromeOS. Will be set to 0 on other platforms.
  /// A value of -1 will be interpreted as auto-rotate when the device is in
  /// a physical tablet state.
  int get rotation => _wrapped.rotation;
  set rotation(int v) {
    _wrapped.rotation = v;
  }

  /// The display's logical bounds.
  Bounds get bounds => Bounds.fromJS(_wrapped.bounds);
  set bounds(Bounds v) {
    _wrapped.bounds = v.toJS;
  }

  /// The display's insets within its screen's bounds.
  /// Currently exposed only on ChromeOS. Will be set to empty insets on
  /// other platforms.
  Insets get overscan => Insets.fromJS(_wrapped.overscan);
  set overscan(Insets v) {
    _wrapped.overscan = v.toJS;
  }

  /// The usable work area of the display within the display bounds. The work
  /// area excludes areas of the display reserved for OS, for example taskbar
  /// and launcher.
  Bounds get workArea => Bounds.fromJS(_wrapped.workArea);
  set workArea(Bounds v) {
    _wrapped.workArea = v.toJS;
  }

  /// The list of available display modes. The current mode will have
  /// isSelected=true. Only available on Chrome OS. Will be set to an empty
  /// array on other platforms.
  List<DisplayMode> get modes => _wrapped.modes.toDart
      .cast<$js.DisplayMode>()
      .map((e) => DisplayMode.fromJS(e))
      .toList();
  set modes(List<DisplayMode> v) {
    _wrapped.modes = v.toJSArray((e) => e.toJS);
  }

  /// True if this display has a touch input device associated with it.
  bool get hasTouchSupport => _wrapped.hasTouchSupport;
  set hasTouchSupport(bool v) {
    _wrapped.hasTouchSupport = v;
  }

  /// True if this display has an accelerometer associated with it.
  /// Provided for ChromeOS Settings UI only. TODO(stevenjb): Remove when
  /// Settings switches to a mojo API. NOTE: The name of this may change.
  bool get hasAccelerometerSupport => _wrapped.hasAccelerometerSupport;
  set hasAccelerometerSupport(bool v) {
    _wrapped.hasAccelerometerSupport = v;
  }

  /// A list of zoom factor values that can be set for the display.
  List<double> get availableDisplayZoomFactors =>
      _wrapped.availableDisplayZoomFactors.toDart
          .cast<double>()
          .map((e) => e)
          .toList();
  set availableDisplayZoomFactors(List<double> v) {
    _wrapped.availableDisplayZoomFactors = v.toJSArray((e) => e);
  }

  /// The ratio between the display's current and default zoom.
  /// For example, value 1 is equivalent to 100% zoom, and value 1.5 is
  /// equivalent to 150% zoom.
  double get displayZoomFactor => _wrapped.displayZoomFactor;
  set displayZoomFactor(double v) {
    _wrapped.displayZoomFactor = v;
  }
}

class DisplayProperties {
  DisplayProperties.fromJS(this._wrapped);

  DisplayProperties({
    /// Chrome OS only. If set to true, changes the display mode to unified
    /// desktop (see [enableUnifiedDesktop] for details). If set to false,
    /// unified desktop mode will be disabled. This is only valid for the
    /// primary display. If provided, mirroringSourceId must not be provided and
    /// other properties will be ignored. This is has no effect if not provided.
    bool? isUnified,

    /// Chrome OS only. If set and not empty, enables mirroring for this display
    /// only. Otherwise disables mirroring for all displays. This value should
    /// indicate the id of the source display to mirror, which must not be the
    /// same as the id passed to setDisplayProperties. If set, no other property
    /// may be set.
    String? mirroringSourceId,

    /// If set to true, makes the display primary. No-op if set to false.
    /// Note: If set, the display is considered primary for all other properties
    /// (i.e. [isUnified] may be set and bounds origin may not).
    bool? isPrimary,

    /// If set, sets the display's overscan insets to the provided values. Note
    /// that overscan values may not be negative or larger than a half of the
    /// screen's size. Overscan cannot be changed on the internal monitor.
    Insets? overscan,

    /// If set, updates the display's rotation.
    /// Legal values are [0, 90, 180, 270]. The rotation is set clockwise,
    /// relative to the display's vertical position.
    int? rotation,

    /// If set, updates the display's logical bounds origin along the x-axis.
    /// Applied together with [boundsOriginY]. Defaults to the current value
    /// if not set and [boundsOriginY] is set. Note that when updating the
    /// display origin, some constraints will be applied, so the final bounds
    /// origin may be different than the one set. The final bounds can be
    /// retrieved using [getInfo]. The bounds origin cannot be changed on
    /// the primary display.
    int? boundsOriginx,

    /// If set, updates the display's logical bounds origin along the y-axis.
    /// See documentation for [boundsOriginX] parameter.
    int? boundsOriginy,

    /// If set, updates the display mode to the mode matching this value.
    /// If other parameters are invalid, this will not be applied. If the
    /// display mode is invalid, it will not be applied and an error will be
    /// set, but other properties will still be applied.
    DisplayMode? displayMode,

    /// If set, updates the zoom associated with the display. This zoom performs
    /// re-layout and repaint thus resulting in a better quality zoom than just
    /// performing a pixel by pixel stretch enlargement.
    double? displayZoomFactor,
  }) : _wrapped = $js.DisplayProperties(
          isUnified: isUnified,
          mirroringSourceId: mirroringSourceId,
          isPrimary: isPrimary,
          overscan: overscan?.toJS,
          rotation: rotation,
          boundsOriginX: boundsOriginx,
          boundsOriginY: boundsOriginy,
          displayMode: displayMode?.toJS,
          displayZoomFactor: displayZoomFactor,
        );

  final $js.DisplayProperties _wrapped;

  $js.DisplayProperties get toJS => _wrapped;

  /// Chrome OS only. If set to true, changes the display mode to unified
  /// desktop (see [enableUnifiedDesktop] for details). If set to false,
  /// unified desktop mode will be disabled. This is only valid for the
  /// primary display. If provided, mirroringSourceId must not be provided and
  /// other properties will be ignored. This is has no effect if not provided.
  bool? get isUnified => _wrapped.isUnified;
  set isUnified(bool? v) {
    _wrapped.isUnified = v;
  }

  /// Chrome OS only. If set and not empty, enables mirroring for this display
  /// only. Otherwise disables mirroring for all displays. This value should
  /// indicate the id of the source display to mirror, which must not be the
  /// same as the id passed to setDisplayProperties. If set, no other property
  /// may be set.
  String? get mirroringSourceId => _wrapped.mirroringSourceId;
  set mirroringSourceId(String? v) {
    _wrapped.mirroringSourceId = v;
  }

  /// If set to true, makes the display primary. No-op if set to false.
  /// Note: If set, the display is considered primary for all other properties
  /// (i.e. [isUnified] may be set and bounds origin may not).
  bool? get isPrimary => _wrapped.isPrimary;
  set isPrimary(bool? v) {
    _wrapped.isPrimary = v;
  }

  /// If set, sets the display's overscan insets to the provided values. Note
  /// that overscan values may not be negative or larger than a half of the
  /// screen's size. Overscan cannot be changed on the internal monitor.
  Insets? get overscan => _wrapped.overscan?.let(Insets.fromJS);
  set overscan(Insets? v) {
    _wrapped.overscan = v?.toJS;
  }

  /// If set, updates the display's rotation.
  /// Legal values are [0, 90, 180, 270]. The rotation is set clockwise,
  /// relative to the display's vertical position.
  int? get rotation => _wrapped.rotation;
  set rotation(int? v) {
    _wrapped.rotation = v;
  }

  /// If set, updates the display's logical bounds origin along the x-axis.
  /// Applied together with [boundsOriginY]. Defaults to the current value
  /// if not set and [boundsOriginY] is set. Note that when updating the
  /// display origin, some constraints will be applied, so the final bounds
  /// origin may be different than the one set. The final bounds can be
  /// retrieved using [getInfo]. The bounds origin cannot be changed on
  /// the primary display.
  int? get boundsOriginx => _wrapped.boundsOriginX;
  set boundsOriginx(int? v) {
    _wrapped.boundsOriginX = v;
  }

  /// If set, updates the display's logical bounds origin along the y-axis.
  /// See documentation for [boundsOriginX] parameter.
  int? get boundsOriginy => _wrapped.boundsOriginY;
  set boundsOriginy(int? v) {
    _wrapped.boundsOriginY = v;
  }

  /// If set, updates the display mode to the mode matching this value.
  /// If other parameters are invalid, this will not be applied. If the
  /// display mode is invalid, it will not be applied and an error will be
  /// set, but other properties will still be applied.
  DisplayMode? get displayMode => _wrapped.displayMode?.let(DisplayMode.fromJS);
  set displayMode(DisplayMode? v) {
    _wrapped.displayMode = v?.toJS;
  }

  /// If set, updates the zoom associated with the display. This zoom performs
  /// re-layout and repaint thus resulting in a better quality zoom than just
  /// performing a pixel by pixel stretch enlargement.
  double? get displayZoomFactor => _wrapped.displayZoomFactor;
  set displayZoomFactor(double? v) {
    _wrapped.displayZoomFactor = v;
  }
}

class GetInfoFlags {
  GetInfoFlags.fromJS(this._wrapped);

  GetInfoFlags(
      {
      /// If set to true, only a single [DisplayUnitInfo] will be returned
      /// by [getInfo] when in unified desktop mode (see
      /// [enableUnifiedDesktop]). Defaults to false.
      bool? singleUnified})
      : _wrapped = $js.GetInfoFlags(singleUnified: singleUnified);

  final $js.GetInfoFlags _wrapped;

  $js.GetInfoFlags get toJS => _wrapped;

  /// If set to true, only a single [DisplayUnitInfo] will be returned
  /// by [getInfo] when in unified desktop mode (see
  /// [enableUnifiedDesktop]). Defaults to false.
  bool? get singleUnified => _wrapped.singleUnified;
  set singleUnified(bool? v) {
    _wrapped.singleUnified = v;
  }
}

class MirrorModeInfo {
  MirrorModeInfo.fromJS(this._wrapped);

  MirrorModeInfo({
    /// The mirror mode that should be set.
    required MirrorMode mode,

    /// The id of the mirroring source display. This is only valid for 'mixed'.
    String? mirroringSourceId,

    /// The ids of the mirroring destination displays. This is only valid for
    /// 'mixed'.
    List<String>? mirroringDestinationIds,
  }) : _wrapped = $js.MirrorModeInfo(
          mode: mode.toJS,
          mirroringSourceId: mirroringSourceId,
          mirroringDestinationIds: mirroringDestinationIds?.toJSArray((e) => e),
        );

  final $js.MirrorModeInfo _wrapped;

  $js.MirrorModeInfo get toJS => _wrapped;

  /// The mirror mode that should be set.
  MirrorMode get mode => MirrorMode.fromJS(_wrapped.mode);
  set mode(MirrorMode v) {
    _wrapped.mode = v.toJS;
  }

  /// The id of the mirroring source display. This is only valid for 'mixed'.
  String? get mirroringSourceId => _wrapped.mirroringSourceId;
  set mirroringSourceId(String? v) {
    _wrapped.mirroringSourceId = v;
  }

  /// The ids of the mirroring destination displays. This is only valid for
  /// 'mixed'.
  List<String>? get mirroringDestinationIds =>
      _wrapped.mirroringDestinationIds?.toDart
          .cast<String>()
          .map((e) => e)
          .toList();
  set mirroringDestinationIds(List<String>? v) {
    _wrapped.mirroringDestinationIds = v?.toJSArray((e) => e);
  }
}
