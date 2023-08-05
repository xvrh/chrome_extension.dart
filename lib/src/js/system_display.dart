// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'system.dart';

export 'chrome.dart';
export 'system.dart';

extension JSChromeJSSystemDisplayExtension on JSChromeSystem {
  @JS('display')
  external JSSystemDisplay? get displayNullable;

  /// Use the `system.display` API to query display metadata.
  JSSystemDisplay get display {
    var displayNullable = this.displayNullable;
    if (displayNullable == null) {
      throw ApiNotAvailableException('chrome.system.display');
    }
    return displayNullable;
  }
}

@JS()
@staticInterop
class JSSystemDisplay {}

extension JSSystemDisplayExtension on JSSystemDisplay {
  /// Requests the information for all attached display devices.
  /// |flags|: Options affecting how the information is returned.
  /// |callback|: The callback to invoke with the results.
  external JSPromise getInfo(GetInfoFlags? flags);

  /// Requests the layout info for all displays.
  /// NOTE: This is only available to Chrome OS Kiosk apps and Web UI.
  /// |callback|: The callback to invoke with the results.
  external JSPromise getDisplayLayout();

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
  external JSPromise setDisplayProperties(
    String id,
    DisplayProperties info,
  );

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
  external JSPromise setDisplayLayout(JSArray layouts);

  /// Enables/disables the unified desktop feature. If enabled while mirroring
  /// is active, the desktop mode will not change until mirroring is turned
  /// off. Otherwise, the desktop mode will switch to unified immediately.
  /// NOTE: This is only available to Chrome OS Kiosk apps and Web UI.
  /// |enabled|: True if unified desktop should be enabled.
  external void enableUnifiedDesktop(bool enabled);

  /// Starts overscan calibration for a display. This will show an overlay
  /// on the screen indicating the current overscan insets. If overscan
  /// calibration for display |id| is in progress this will reset calibration.
  /// |id|: The display's unique identifier.
  external void overscanCalibrationStart(String id);

  /// Adjusts the current overscan insets for a display. Typically this should
  /// either move the display along an axis (e.g. left+right have the same
  /// value) or scale it along an axis (e.g. top+bottom have opposite values).
  /// Each Adjust call is cumulative with previous calls since Start.
  /// |id|: The display's unique identifier.
  /// |delta|: The amount to change the overscan insets.
  external void overscanCalibrationAdjust(
    String id,
    Insets delta,
  );

  /// Resets the overscan insets for a display to the last saved value (i.e
  /// before Start was called).
  /// |id|: The display's unique identifier.
  external void overscanCalibrationReset(String id);

  /// Complete overscan adjustments for a display  by saving the current values
  /// and hiding the overlay.
  /// |id|: The display's unique identifier.
  external void overscanCalibrationComplete(String id);

  /// Displays the native touch calibration UX for the display with |id| as
  /// display id. This will show an overlay on the screen with required
  /// instructions on how to proceed. The callback will be invoked in case of
  /// successful calibration only. If the calibration fails, this will throw an
  /// error.
  /// |id|: The display's unique identifier.
  /// |callback|: Optional callback to inform the caller that the touch
  ///      calibration has ended. The argument of the callback informs if the
  ///      calibration was a success or not.
  external JSPromise showNativeTouchCalibration(String id);

  /// Starts custom touch calibration for a display. This should be called when
  /// using a custom UX for collecting calibration data. If another touch
  /// calibration is already in progress this will throw an error.
  /// |id|: The display's unique identifier.
  external void startCustomTouchCalibration(String id);

  /// Sets the touch calibration pairs for a display. These |pairs| would be
  /// used to calibrate the touch screen for display with |id| called in
  /// startCustomTouchCalibration(). Always call |startCustomTouchCalibration|
  /// before calling this method. If another touch calibration is already in
  /// progress this will throw an error.
  /// |pairs|: The pairs of point used to calibrate the display.
  /// |bounds|: Bounds of the display when the touch calibration was performed.
  ///     |bounds.left| and |bounds.top| values are ignored.
  external void completeCustomTouchCalibration(
    TouchCalibrationPairQuad pairs,
    Bounds bounds,
  );

  /// Resets the touch calibration for the display and brings it back to its
  /// default state by clearing any touch calibration data associated with the
  /// display.
  /// |id|: The display's unique identifier.
  external void clearTouchCalibration(String id);

  /// Sets the display mode to the specified mirror mode. Each call resets the
  /// state from previous calls. Calling setDisplayProperties() will fail for
  /// the mirroring destination displays.
  /// NOTE: This is only available to Chrome OS Kiosk apps and Web UI.
  /// |info|: The information of the mirror mode that should be applied to the
  ///     display mode.
  /// |callback|: Empty function called when the function finishes. To find out
  ///     whether the function succeeded, [runtime.lastError] should be
  ///     queried.
  external JSPromise setMirrorMode(MirrorModeInfo info);

  /// Fired when anything changes to the display configuration.
  external Event get onDisplayChanged;
}

/// Layout position, i.e. edge of parent that the display is attached to.
typedef LayoutPosition = String;

/// Mirror mode, i.e. different ways of how a display is mirrored to other
/// displays.
typedef MirrorMode = String;

@JS()
@staticInterop
@anonymous
class Bounds {
  external factory Bounds({
    /// The x-coordinate of the upper-left corner.
    int left,

    /// The y-coordinate of the upper-left corner.
    int top,

    /// The width of the display in pixels.
    int width,

    /// The height of the display in pixels.
    int height,
  });
}

extension BoundsExtension on Bounds {
  /// The x-coordinate of the upper-left corner.
  external int left;

  /// The y-coordinate of the upper-left corner.
  external int top;

  /// The width of the display in pixels.
  external int width;

  /// The height of the display in pixels.
  external int height;
}

@JS()
@staticInterop
@anonymous
class Insets {
  external factory Insets({
    /// The x-axis distance from the left bound.
    int left,

    /// The y-axis distance from the top bound.
    int top,

    /// The x-axis distance from the right bound.
    int right,

    /// The y-axis distance from the bottom bound.
    int bottom,
  });
}

extension InsetsExtension on Insets {
  /// The x-axis distance from the left bound.
  external int left;

  /// The y-axis distance from the top bound.
  external int top;

  /// The x-axis distance from the right bound.
  external int right;

  /// The y-axis distance from the bottom bound.
  external int bottom;
}

@JS()
@staticInterop
@anonymous
class Point {
  external factory Point({
    /// The x-coordinate of the point.
    int x,

    /// The y-coordinate of the point.
    int y,
  });
}

extension PointExtension on Point {
  /// The x-coordinate of the point.
  external int x;

  /// The y-coordinate of the point.
  external int y;
}

@JS()
@staticInterop
@anonymous
class TouchCalibrationPair {
  external factory TouchCalibrationPair({
    /// The coordinates of the display point.
    Point displayPoint,

    /// The coordinates of the touch point corresponding to the display point.
    Point touchPoint,
  });
}

extension TouchCalibrationPairExtension on TouchCalibrationPair {
  /// The coordinates of the display point.
  external Point displayPoint;

  /// The coordinates of the touch point corresponding to the display point.
  external Point touchPoint;
}

@JS()
@staticInterop
@anonymous
class TouchCalibrationPairQuad {
  external factory TouchCalibrationPairQuad({
    /// First pair of touch and display point required for touch calibration.
    TouchCalibrationPair pair1,

    /// Second pair of touch and display point required for touch calibration.
    TouchCalibrationPair pair2,

    /// Third pair of touch and display point required for touch calibration.
    TouchCalibrationPair pair3,

    /// Fourth pair of touch and display point required for touch calibration.
    TouchCalibrationPair pair4,
  });
}

extension TouchCalibrationPairQuadExtension on TouchCalibrationPairQuad {
  /// First pair of touch and display point required for touch calibration.
  external TouchCalibrationPair pair1;

  /// Second pair of touch and display point required for touch calibration.
  external TouchCalibrationPair pair2;

  /// Third pair of touch and display point required for touch calibration.
  external TouchCalibrationPair pair3;

  /// Fourth pair of touch and display point required for touch calibration.
  external TouchCalibrationPair pair4;
}

@JS()
@staticInterop
@anonymous
class DisplayMode {
  external factory DisplayMode({
    /// The display mode width in device independent (user visible) pixels.
    int width,

    /// The display mode height in device independent (user visible) pixels.
    int height,

    /// The display mode width in native pixels.
    int widthInNativePixels,

    /// The display mode height in native pixels.
    int heightInNativePixels,

    /// The display mode UI scale factor.
    double? uiScale,

    /// The display mode device scale factor.
    double deviceScaleFactor,

    /// The display mode refresh rate in hertz.
    double refreshRate,

    /// True if the mode is the display's native mode.
    bool isNative,

    /// True if the display mode is currently selected.
    bool isSelected,

    /// True if this mode is interlaced, false if not provided.
    bool? isInterlaced,
  });
}

extension DisplayModeExtension on DisplayMode {
  /// The display mode width in device independent (user visible) pixels.
  external int width;

  /// The display mode height in device independent (user visible) pixels.
  external int height;

  /// The display mode width in native pixels.
  external int widthInNativePixels;

  /// The display mode height in native pixels.
  external int heightInNativePixels;

  /// The display mode UI scale factor.
  external double? uiScale;

  /// The display mode device scale factor.
  external double deviceScaleFactor;

  /// The display mode refresh rate in hertz.
  external double refreshRate;

  /// True if the mode is the display's native mode.
  external bool isNative;

  /// True if the display mode is currently selected.
  external bool isSelected;

  /// True if this mode is interlaced, false if not provided.
  external bool? isInterlaced;
}

@JS()
@staticInterop
@anonymous
class DisplayLayout {
  external factory DisplayLayout({
    /// The unique identifier of the display.
    String id,

    /// The unique identifier of the parent display. Empty if this is the root.
    String parentId,

    /// The layout position of this display relative to the parent. This will
    /// be ignored for the root.
    LayoutPosition position,

    /// The offset of the display along the connected edge. 0 indicates that
    /// the topmost or leftmost corners are aligned.
    int offset,
  });
}

extension DisplayLayoutExtension on DisplayLayout {
  /// The unique identifier of the display.
  external String id;

  /// The unique identifier of the parent display. Empty if this is the root.
  external String parentId;

  /// The layout position of this display relative to the parent. This will
  /// be ignored for the root.
  external LayoutPosition position;

  /// The offset of the display along the connected edge. 0 indicates that
  /// the topmost or leftmost corners are aligned.
  external int offset;
}

@JS()
@staticInterop
@anonymous
class Edid {
  external factory Edid({
    /// 3 character manufacturer code. See Sec. 3.4.1 page 21. Required in v1.4.
    String manufacturerId,

    /// 2 byte manufacturer-assigned code, Sec. 3.4.2 page 21. Required in v1.4.
    String productId,

    /// Year of manufacturer, Sec. 3.4.4 page 22. Required in v1.4.
    int yearOfManufacture,
  });
}

extension EdidExtension on Edid {
  /// 3 character manufacturer code. See Sec. 3.4.1 page 21. Required in v1.4.
  external String manufacturerId;

  /// 2 byte manufacturer-assigned code, Sec. 3.4.2 page 21. Required in v1.4.
  external String productId;

  /// Year of manufacturer, Sec. 3.4.4 page 22. Required in v1.4.
  external int yearOfManufacture;
}

@JS()
@staticInterop
@anonymous
class DisplayUnitInfo {
  external factory DisplayUnitInfo({
    /// The unique identifier of the display.
    String id,

    /// The user-friendly name (e.g. "HP LCD monitor").
    String name,

    /// NOTE: This is only available to Chrome OS Kiosk apps and Web UI.
    Edid? edid,

    /// Chrome OS only. Identifier of the display that is being mirrored if
    /// mirroring is enabled, otherwise empty. This will be set for all displays
    /// (including the display being mirrored).
    String mirroringSourceId,

    /// Chrome OS only. Identifiers of the displays to which the source display
    /// is being mirrored. Empty if no displays are being mirrored. This will be
    /// set to the same value for all displays. This must not include
    /// |mirroringSourceId|.
    JSArray mirroringDestinationIds,

    /// True if this is the primary display.
    bool isPrimary,

    /// True if this is an internal display.
    bool isInternal,

    /// True if this display is enabled.
    bool isEnabled,

    /// True for all displays when in unified desktop mode. See documentation
    /// for [enableUnifiedDesktop].
    bool isUnified,

    /// True when the auto-rotation is allowed. It happens when the device is in
    /// a tablet physical state or kSupportsClamshellAutoRotation is set.
    /// Provided for ChromeOS Settings UI only. TODO(stevenjb): Remove when
    /// Settings switches to a mojo API.
    bool? isAutoRotationAllowed,

    /// The number of pixels per inch along the x-axis.
    double dpiX,

    /// The number of pixels per inch along the y-axis.
    double dpiY,

    /// The display's clockwise rotation in degrees relative to the vertical
    /// position.
    /// Currently exposed only on ChromeOS. Will be set to 0 on other platforms.
    /// A value of -1 will be interpreted as auto-rotate when the device is in
    /// a physical tablet state.
    int rotation,

    /// The display's logical bounds.
    Bounds bounds,

    /// The display's insets within its screen's bounds.
    /// Currently exposed only on ChromeOS. Will be set to empty insets on
    /// other platforms.
    Insets overscan,

    /// The usable work area of the display within the display bounds. The work
    /// area excludes areas of the display reserved for OS, for example taskbar
    /// and launcher.
    Bounds workArea,

    /// The list of available display modes. The current mode will have
    /// isSelected=true. Only available on Chrome OS. Will be set to an empty
    /// array on other platforms.
    JSArray modes,

    /// True if this display has a touch input device associated with it.
    bool hasTouchSupport,

    /// True if this display has an accelerometer associated with it.
    /// Provided for ChromeOS Settings UI only. TODO(stevenjb): Remove when
    /// Settings switches to a mojo API. NOTE: The name of this may change.
    bool hasAccelerometerSupport,

    /// A list of zoom factor values that can be set for the display.
    JSArray availableDisplayZoomFactors,

    /// The ratio between the display's current and default zoom.
    /// For example, value 1 is equivalent to 100% zoom, and value 1.5 is
    /// equivalent to 150% zoom.
    double displayZoomFactor,
  });
}

extension DisplayUnitInfoExtension on DisplayUnitInfo {
  /// The unique identifier of the display.
  external String id;

  /// The user-friendly name (e.g. "HP LCD monitor").
  external String name;

  /// NOTE: This is only available to Chrome OS Kiosk apps and Web UI.
  external Edid? edid;

  /// Chrome OS only. Identifier of the display that is being mirrored if
  /// mirroring is enabled, otherwise empty. This will be set for all displays
  /// (including the display being mirrored).
  external String mirroringSourceId;

  /// Chrome OS only. Identifiers of the displays to which the source display
  /// is being mirrored. Empty if no displays are being mirrored. This will be
  /// set to the same value for all displays. This must not include
  /// |mirroringSourceId|.
  external JSArray mirroringDestinationIds;

  /// True if this is the primary display.
  external bool isPrimary;

  /// True if this is an internal display.
  external bool isInternal;

  /// True if this display is enabled.
  external bool isEnabled;

  /// True for all displays when in unified desktop mode. See documentation
  /// for [enableUnifiedDesktop].
  external bool isUnified;

  /// True when the auto-rotation is allowed. It happens when the device is in
  /// a tablet physical state or kSupportsClamshellAutoRotation is set.
  /// Provided for ChromeOS Settings UI only. TODO(stevenjb): Remove when
  /// Settings switches to a mojo API.
  external bool? isAutoRotationAllowed;

  /// The number of pixels per inch along the x-axis.
  external double dpiX;

  /// The number of pixels per inch along the y-axis.
  external double dpiY;

  /// The display's clockwise rotation in degrees relative to the vertical
  /// position.
  /// Currently exposed only on ChromeOS. Will be set to 0 on other platforms.
  /// A value of -1 will be interpreted as auto-rotate when the device is in
  /// a physical tablet state.
  external int rotation;

  /// The display's logical bounds.
  external Bounds bounds;

  /// The display's insets within its screen's bounds.
  /// Currently exposed only on ChromeOS. Will be set to empty insets on
  /// other platforms.
  external Insets overscan;

  /// The usable work area of the display within the display bounds. The work
  /// area excludes areas of the display reserved for OS, for example taskbar
  /// and launcher.
  external Bounds workArea;

  /// The list of available display modes. The current mode will have
  /// isSelected=true. Only available on Chrome OS. Will be set to an empty
  /// array on other platforms.
  external JSArray modes;

  /// True if this display has a touch input device associated with it.
  external bool hasTouchSupport;

  /// True if this display has an accelerometer associated with it.
  /// Provided for ChromeOS Settings UI only. TODO(stevenjb): Remove when
  /// Settings switches to a mojo API. NOTE: The name of this may change.
  external bool hasAccelerometerSupport;

  /// A list of zoom factor values that can be set for the display.
  external JSArray availableDisplayZoomFactors;

  /// The ratio between the display's current and default zoom.
  /// For example, value 1 is equivalent to 100% zoom, and value 1.5 is
  /// equivalent to 150% zoom.
  external double displayZoomFactor;
}

@JS()
@staticInterop
@anonymous
class DisplayProperties {
  external factory DisplayProperties({
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
    int? boundsOriginX,

    /// If set, updates the display's logical bounds origin along the y-axis.
    /// See documentation for [boundsOriginX] parameter.
    int? boundsOriginY,

    /// If set, updates the display mode to the mode matching this value.
    /// If other parameters are invalid, this will not be applied. If the
    /// display mode is invalid, it will not be applied and an error will be
    /// set, but other properties will still be applied.
    DisplayMode? displayMode,

    /// If set, updates the zoom associated with the display. This zoom performs
    /// re-layout and repaint thus resulting in a better quality zoom than just
    /// performing a pixel by pixel stretch enlargement.
    double? displayZoomFactor,
  });
}

extension DisplayPropertiesExtension on DisplayProperties {
  /// Chrome OS only. If set to true, changes the display mode to unified
  /// desktop (see [enableUnifiedDesktop] for details). If set to false,
  /// unified desktop mode will be disabled. This is only valid for the
  /// primary display. If provided, mirroringSourceId must not be provided and
  /// other properties will be ignored. This is has no effect if not provided.
  external bool? isUnified;

  /// Chrome OS only. If set and not empty, enables mirroring for this display
  /// only. Otherwise disables mirroring for all displays. This value should
  /// indicate the id of the source display to mirror, which must not be the
  /// same as the id passed to setDisplayProperties. If set, no other property
  /// may be set.
  external String? mirroringSourceId;

  /// If set to true, makes the display primary. No-op if set to false.
  /// Note: If set, the display is considered primary for all other properties
  /// (i.e. [isUnified] may be set and bounds origin may not).
  external bool? isPrimary;

  /// If set, sets the display's overscan insets to the provided values. Note
  /// that overscan values may not be negative or larger than a half of the
  /// screen's size. Overscan cannot be changed on the internal monitor.
  external Insets? overscan;

  /// If set, updates the display's rotation.
  /// Legal values are [0, 90, 180, 270]. The rotation is set clockwise,
  /// relative to the display's vertical position.
  external int? rotation;

  /// If set, updates the display's logical bounds origin along the x-axis.
  /// Applied together with [boundsOriginY]. Defaults to the current value
  /// if not set and [boundsOriginY] is set. Note that when updating the
  /// display origin, some constraints will be applied, so the final bounds
  /// origin may be different than the one set. The final bounds can be
  /// retrieved using [getInfo]. The bounds origin cannot be changed on
  /// the primary display.
  external int? boundsOriginX;

  /// If set, updates the display's logical bounds origin along the y-axis.
  /// See documentation for [boundsOriginX] parameter.
  external int? boundsOriginY;

  /// If set, updates the display mode to the mode matching this value.
  /// If other parameters are invalid, this will not be applied. If the
  /// display mode is invalid, it will not be applied and an error will be
  /// set, but other properties will still be applied.
  external DisplayMode? displayMode;

  /// If set, updates the zoom associated with the display. This zoom performs
  /// re-layout and repaint thus resulting in a better quality zoom than just
  /// performing a pixel by pixel stretch enlargement.
  external double? displayZoomFactor;
}

@JS()
@staticInterop
@anonymous
class GetInfoFlags {
  external factory GetInfoFlags(
      {
      /// If set to true, only a single [DisplayUnitInfo] will be returned
      /// by [getInfo] when in unified desktop mode (see
      /// [enableUnifiedDesktop]). Defaults to false.
      bool? singleUnified});
}

extension GetInfoFlagsExtension on GetInfoFlags {
  /// If set to true, only a single [DisplayUnitInfo] will be returned
  /// by [getInfo] when in unified desktop mode (see
  /// [enableUnifiedDesktop]). Defaults to false.
  external bool? singleUnified;
}

@JS()
@staticInterop
@anonymous
class MirrorModeInfo {
  external factory MirrorModeInfo({
    /// The mirror mode that should be set.
    MirrorMode mode,

    /// The id of the mirroring source display. This is only valid for 'mixed'.
    String? mirroringSourceId,

    /// The ids of the mirroring destination displays. This is only valid for
    /// 'mixed'.
    JSArray? mirroringDestinationIds,
  });
}

extension MirrorModeInfoExtension on MirrorModeInfo {
  /// The mirror mode that should be set.
  external MirrorMode mode;

  /// The id of the mirroring source display. This is only valid for 'mixed'.
  external String? mirroringSourceId;

  /// The ids of the mirroring destination displays. This is only valid for
  /// 'mixed'.
  external JSArray? mirroringDestinationIds;
}
