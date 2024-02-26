// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

@JS()
library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSTypesExtension on JSChrome {
  @JS('types')
  external JSTypes? get typesNullable;

  /// The `chrome.types` API contains type declarations for Chrome.
  JSTypes get types {
    var typesNullable = this.typesNullable;
    if (typesNullable == null) {
      throw ApiNotAvailableException('chrome.types');
    }
    return typesNullable;
  }
}

extension type JSTypes._(JSObject _) {}

/// The scope of the ChromeSetting. One of<ul><li>[regular]: setting for the
/// regular profile (which is inherited by the incognito profile if not
/// overridden elsewhere),</li><li>[regular_only]: setting for the regular
/// profile only (not inherited by the incognito
/// profile),</li><li>[incognito_persistent]: setting for the incognito profile
/// that survives browser restarts (overrides regular
/// preferences),</li><li>[incognito_session_only]: setting for the incognito
/// profile that can only be set during an incognito session and is deleted when
/// the incognito session ends (overrides regular and incognito_persistent
/// preferences).</li></ul>
typedef ChromeSettingScope = String;

/// One of<ul><li>[not_controllable]: cannot be controlled by any
/// extension</li><li>[controlled_by_other_extensions]: controlled by extensions
/// with higher precedence</li><li>[controllable_by_this_extension]: can be
/// controlled by this extension</li><li>[controlled_by_this_extension]:
/// controlled by this extension</li></ul>
typedef LevelOfControl = String;
extension type ChromeSetting._(JSObject _) implements JSObject {
  external factory ChromeSetting();

  /// Gets the value of a setting.
  external JSPromise get(

      /// Which setting to consider.
      GetDetails details);

  /// Sets the value of a setting.
  external JSPromise set(

      /// Which setting to change.
      SetDetails details);

  /// Clears the setting, restoring any default value.
  external JSPromise clear(

      /// Which setting to clear.
      ClearDetails details);

  /// Fired after the setting changes.
  external Event get onChange;
}
extension type GetCallbackDetails._(JSObject _) implements JSObject {
  external factory GetCallbackDetails({
    /// The value of the setting.
    JSAny value,

    /// The level of control of the setting.
    LevelOfControl levelOfControl,

    /// Whether the effective value is specific to the incognito session.<br/>This
    /// property will _only_ be present if the [incognito] property in the
    /// [details] parameter of `get()` was true.
    bool? incognitoSpecific,
  });

  /// The value of the setting.
  external JSAny value;

  /// The level of control of the setting.
  external LevelOfControl levelOfControl;

  /// Whether the effective value is specific to the incognito session.<br/>This
  /// property will _only_ be present if the [incognito] property in the
  /// [details] parameter of `get()` was true.
  external bool? incognitoSpecific;
}
extension type GetDetails._(JSObject _) implements JSObject {
  external factory GetDetails(
      {
      /// Whether to return the value that applies to the incognito session (default
      /// false).
      bool? incognito});

  /// Whether to return the value that applies to the incognito session (default
  /// false).
  external bool? incognito;
}
extension type SetDetails._(JSObject _) implements JSObject {
  external factory SetDetails({
    /// The value of the setting. <br/>Note that every setting has a specific
    /// value type, which is described together with the setting. An extension
    /// should _not_ set a value of a different type.
    JSAny value,

    /// Where to set the setting (default: regular).
    ChromeSettingScope? scope,
  });

  /// The value of the setting. <br/>Note that every setting has a specific
  /// value type, which is described together with the setting. An extension
  /// should _not_ set a value of a different type.
  external JSAny value;

  /// Where to set the setting (default: regular).
  external ChromeSettingScope? scope;
}
extension type ClearDetails._(JSObject _) implements JSObject {
  external factory ClearDetails(
      {
      /// Where to clear the setting (default: regular).
      ChromeSettingScope? scope});

  /// Where to clear the setting (default: regular).
  external ChromeSettingScope? scope;
}
extension type OnChangeDetails._(JSObject _) implements JSObject {
  external factory OnChangeDetails({
    /// The value of the setting after the change.
    JSAny value,

    /// The level of control of the setting.
    LevelOfControl levelOfControl,

    /// Whether the value that has changed is specific to the incognito
    /// session.<br/>This property will _only_ be present if the user has enabled
    /// the extension in incognito mode.
    bool? incognitoSpecific,
  });

  /// The value of the setting after the change.
  external JSAny value;

  /// The level of control of the setting.
  external LevelOfControl levelOfControl;

  /// Whether the value that has changed is specific to the incognito
  /// session.<br/>This property will _only_ be present if the user has enabled
  /// the extension in incognito mode.
  external bool? incognitoSpecific;
}
