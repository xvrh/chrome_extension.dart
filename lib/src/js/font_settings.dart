// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSFontSettingsExtension on JSChrome {
  @JS('fontSettings')
  external JSFontSettings? get fontSettingsNullable;

  /// Use the `chrome.fontSettings` API to manage Chrome's font settings.
  JSFontSettings get fontSettings {
    var fontSettingsNullable = this.fontSettingsNullable;
    if (fontSettingsNullable == null) {
      throw ApiNotAvailableException('chrome.fontSettings');
    }
    return fontSettingsNullable;
  }
}

@JS()
@staticInterop
class JSFontSettings {}

extension JSFontSettingsExtension on JSFontSettings {
  /// Clears the font set by this extension, if any.
  external JSPromise clearFont(ClearFontDetails details);

  /// Gets the font for a given script and generic font family.
  external JSPromise getFont(GetFontDetails details);

  /// Sets the font for a given script and generic font family.
  external JSPromise setFont(SetFontDetails details);

  /// Gets a list of fonts on the system.
  external JSPromise getFontList();

  /// Clears the default font size set by this extension, if any.
  external JSPromise clearDefaultFontSize(

      /// This parameter is currently unused.
      ClearDefaultFontSizeDetails? details);

  /// Gets the default font size.
  external JSPromise getDefaultFontSize(

      /// This parameter is currently unused.
      GetDefaultFontSizeDetails? details);

  /// Sets the default font size.
  external JSPromise setDefaultFontSize(SetDefaultFontSizeDetails details);

  /// Clears the default fixed font size set by this extension, if any.
  external JSPromise clearDefaultFixedFontSize(

      /// This parameter is currently unused.
      ClearDefaultFixedFontSizeDetails? details);

  /// Gets the default size for fixed width fonts.
  external JSPromise getDefaultFixedFontSize(

      /// This parameter is currently unused.
      GetDefaultFixedFontSizeDetails? details);

  /// Sets the default size for fixed width fonts.
  external JSPromise setDefaultFixedFontSize(
      SetDefaultFixedFontSizeDetails details);

  /// Clears the minimum font size set by this extension, if any.
  external JSPromise clearMinimumFontSize(

      /// This parameter is currently unused.
      ClearMinimumFontSizeDetails? details);

  /// Gets the minimum font size.
  external JSPromise getMinimumFontSize(

      /// This parameter is currently unused.
      GetMinimumFontSizeDetails? details);

  /// Sets the minimum font size.
  external JSPromise setMinimumFontSize(SetMinimumFontSizeDetails details);

  /// Fired when a font setting changes.
  external Event get onFontChanged;

  /// Fired when the default font size setting changes.
  external Event get onDefaultFontSizeChanged;

  /// Fired when the default fixed font size setting changes.
  external Event get onDefaultFixedFontSizeChanged;

  /// Fired when the minimum font size setting changes.
  external Event get onMinimumFontSizeChanged;
}

/// An ISO 15924 script code. The default, or global, script is represented by
/// script code "Zyyy".
typedef ScriptCode = String;

/// A CSS generic font family.
typedef GenericFamily = String;

/// One of
/// [not_controllable]: cannot be controlled by any extension
/// [controlled_by_other_extensions]: controlled by extensions with higher
/// precedence
/// [controllable_by_this_extension]: can be controlled by this extension
/// [controlled_by_this_extension]: controlled by this extension
typedef LevelOfControl = String;

@JS()
@staticInterop
@anonymous
class FontName {
  external factory FontName({
    /// The font ID.
    String fontId,

    /// The display name of the font.
    String displayName,
  });
}

extension FontNameExtension on FontName {
  /// The font ID.
  external String fontId;

  /// The display name of the font.
  external String displayName;
}

@JS()
@staticInterop
@anonymous
class OnFontChangedDetails {
  external factory OnFontChangedDetails({
    /// The font ID. See the description in `getFont`.
    String fontId,

    /// The script code for which the font setting has changed.
    ScriptCode? script,

    /// The generic font family for which the font setting has changed.
    GenericFamily genericFamily,

    /// The level of control this extension has over the setting.
    LevelOfControl levelOfControl,
  });
}

extension OnFontChangedDetailsExtension on OnFontChangedDetails {
  /// The font ID. See the description in `getFont`.
  external String fontId;

  /// The script code for which the font setting has changed.
  external ScriptCode? script;

  /// The generic font family for which the font setting has changed.
  external GenericFamily genericFamily;

  /// The level of control this extension has over the setting.
  external LevelOfControl levelOfControl;
}

@JS()
@staticInterop
@anonymous
class OnDefaultFontSizeChangedDetails {
  external factory OnDefaultFontSizeChangedDetails({
    /// The font size in pixels.
    int pixelSize,

    /// The level of control this extension has over the setting.
    LevelOfControl levelOfControl,
  });
}

extension OnDefaultFontSizeChangedDetailsExtension
    on OnDefaultFontSizeChangedDetails {
  /// The font size in pixels.
  external int pixelSize;

  /// The level of control this extension has over the setting.
  external LevelOfControl levelOfControl;
}

@JS()
@staticInterop
@anonymous
class OnDefaultFixedFontSizeChangedDetails {
  external factory OnDefaultFixedFontSizeChangedDetails({
    /// The font size in pixels.
    int pixelSize,

    /// The level of control this extension has over the setting.
    LevelOfControl levelOfControl,
  });
}

extension OnDefaultFixedFontSizeChangedDetailsExtension
    on OnDefaultFixedFontSizeChangedDetails {
  /// The font size in pixels.
  external int pixelSize;

  /// The level of control this extension has over the setting.
  external LevelOfControl levelOfControl;
}

@JS()
@staticInterop
@anonymous
class OnMinimumFontSizeChangedDetails {
  external factory OnMinimumFontSizeChangedDetails({
    /// The font size in pixels.
    int pixelSize,

    /// The level of control this extension has over the setting.
    LevelOfControl levelOfControl,
  });
}

extension OnMinimumFontSizeChangedDetailsExtension
    on OnMinimumFontSizeChangedDetails {
  /// The font size in pixels.
  external int pixelSize;

  /// The level of control this extension has over the setting.
  external LevelOfControl levelOfControl;
}

@JS()
@staticInterop
@anonymous
class ClearFontDetails {
  external factory ClearFontDetails({
    /// The script for which the font should be cleared. If omitted, the global
    /// script font setting is cleared.
    ScriptCode? script,

    /// The generic font family for which the font should be cleared.
    GenericFamily genericFamily,
  });
}

extension ClearFontDetailsExtension on ClearFontDetails {
  /// The script for which the font should be cleared. If omitted, the global
  /// script font setting is cleared.
  external ScriptCode? script;

  /// The generic font family for which the font should be cleared.
  external GenericFamily genericFamily;
}

@JS()
@staticInterop
@anonymous
class GetFontCallbackDetails {
  external factory GetFontCallbackDetails({
    /// The font ID. Rather than the literal font ID preference value, this may be
    /// the ID of the font that the system resolves the preference value to. So,
    /// [fontId] can differ from the font passed to `setFont`, if, for example,
    /// the font is not available on the system. The empty string signifies
    /// fallback to the global script font setting.
    String fontId,

    /// The level of control this extension has over the setting.
    LevelOfControl levelOfControl,
  });
}

extension GetFontCallbackDetailsExtension on GetFontCallbackDetails {
  /// The font ID. Rather than the literal font ID preference value, this may be
  /// the ID of the font that the system resolves the preference value to. So,
  /// [fontId] can differ from the font passed to `setFont`, if, for example,
  /// the font is not available on the system. The empty string signifies
  /// fallback to the global script font setting.
  external String fontId;

  /// The level of control this extension has over the setting.
  external LevelOfControl levelOfControl;
}

@JS()
@staticInterop
@anonymous
class GetFontDetails {
  external factory GetFontDetails({
    /// The script for which the font should be retrieved. If omitted, the font
    /// setting for the global script (script code "Zyyy") is retrieved.
    ScriptCode? script,

    /// The generic font family for which the font should be retrieved.
    GenericFamily genericFamily,
  });
}

extension GetFontDetailsExtension on GetFontDetails {
  /// The script for which the font should be retrieved. If omitted, the font
  /// setting for the global script (script code "Zyyy") is retrieved.
  external ScriptCode? script;

  /// The generic font family for which the font should be retrieved.
  external GenericFamily genericFamily;
}

@JS()
@staticInterop
@anonymous
class SetFontDetails {
  external factory SetFontDetails({
    /// The script code which the font should be set. If omitted, the font setting
    /// for the global script (script code "Zyyy") is set.
    ScriptCode? script,

    /// The generic font family for which the font should be set.
    GenericFamily genericFamily,

    /// The font ID. The empty string means to fallback to the global script font
    /// setting.
    String fontId,
  });
}

extension SetFontDetailsExtension on SetFontDetails {
  /// The script code which the font should be set. If omitted, the font setting
  /// for the global script (script code "Zyyy") is set.
  external ScriptCode? script;

  /// The generic font family for which the font should be set.
  external GenericFamily genericFamily;

  /// The font ID. The empty string means to fallback to the global script font
  /// setting.
  external String fontId;
}

@JS()
@staticInterop
@anonymous
class ClearDefaultFontSizeDetails {
  external factory ClearDefaultFontSizeDetails();
}

extension ClearDefaultFontSizeDetailsExtension on ClearDefaultFontSizeDetails {}

@JS()
@staticInterop
@anonymous
class GetDefaultFontSizeCallbackDetails {
  external factory GetDefaultFontSizeCallbackDetails({
    /// The font size in pixels.
    int pixelSize,

    /// The level of control this extension has over the setting.
    LevelOfControl levelOfControl,
  });
}

extension GetDefaultFontSizeCallbackDetailsExtension
    on GetDefaultFontSizeCallbackDetails {
  /// The font size in pixels.
  external int pixelSize;

  /// The level of control this extension has over the setting.
  external LevelOfControl levelOfControl;
}

@JS()
@staticInterop
@anonymous
class GetDefaultFontSizeDetails {
  external factory GetDefaultFontSizeDetails();
}

extension GetDefaultFontSizeDetailsExtension on GetDefaultFontSizeDetails {}

@JS()
@staticInterop
@anonymous
class SetDefaultFontSizeDetails {
  external factory SetDefaultFontSizeDetails(
      {
      /// The font size in pixels.
      int pixelSize});
}

extension SetDefaultFontSizeDetailsExtension on SetDefaultFontSizeDetails {
  /// The font size in pixels.
  external int pixelSize;
}

@JS()
@staticInterop
@anonymous
class ClearDefaultFixedFontSizeDetails {
  external factory ClearDefaultFixedFontSizeDetails();
}

extension ClearDefaultFixedFontSizeDetailsExtension
    on ClearDefaultFixedFontSizeDetails {}

@JS()
@staticInterop
@anonymous
class GetDefaultFixedFontSizeCallbackDetails {
  external factory GetDefaultFixedFontSizeCallbackDetails({
    /// The font size in pixels.
    int pixelSize,

    /// The level of control this extension has over the setting.
    LevelOfControl levelOfControl,
  });
}

extension GetDefaultFixedFontSizeCallbackDetailsExtension
    on GetDefaultFixedFontSizeCallbackDetails {
  /// The font size in pixels.
  external int pixelSize;

  /// The level of control this extension has over the setting.
  external LevelOfControl levelOfControl;
}

@JS()
@staticInterop
@anonymous
class GetDefaultFixedFontSizeDetails {
  external factory GetDefaultFixedFontSizeDetails();
}

extension GetDefaultFixedFontSizeDetailsExtension
    on GetDefaultFixedFontSizeDetails {}

@JS()
@staticInterop
@anonymous
class SetDefaultFixedFontSizeDetails {
  external factory SetDefaultFixedFontSizeDetails(
      {
      /// The font size in pixels.
      int pixelSize});
}

extension SetDefaultFixedFontSizeDetailsExtension
    on SetDefaultFixedFontSizeDetails {
  /// The font size in pixels.
  external int pixelSize;
}

@JS()
@staticInterop
@anonymous
class ClearMinimumFontSizeDetails {
  external factory ClearMinimumFontSizeDetails();
}

extension ClearMinimumFontSizeDetailsExtension on ClearMinimumFontSizeDetails {}

@JS()
@staticInterop
@anonymous
class GetMinimumFontSizeCallbackDetails {
  external factory GetMinimumFontSizeCallbackDetails({
    /// The font size in pixels.
    int pixelSize,

    /// The level of control this extension has over the setting.
    LevelOfControl levelOfControl,
  });
}

extension GetMinimumFontSizeCallbackDetailsExtension
    on GetMinimumFontSizeCallbackDetails {
  /// The font size in pixels.
  external int pixelSize;

  /// The level of control this extension has over the setting.
  external LevelOfControl levelOfControl;
}

@JS()
@staticInterop
@anonymous
class GetMinimumFontSizeDetails {
  external factory GetMinimumFontSizeDetails();
}

extension GetMinimumFontSizeDetailsExtension on GetMinimumFontSizeDetails {}

@JS()
@staticInterop
@anonymous
class SetMinimumFontSizeDetails {
  external factory SetMinimumFontSizeDetails(
      {
      /// The font size in pixels.
      int pixelSize});
}

extension SetMinimumFontSizeDetailsExtension on SetMinimumFontSizeDetails {
  /// The font size in pixels.
  external int pixelSize;
}
