// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/types.dart' as $js;

export 'src/chrome.dart' show chrome;

final _types = ChromeTypes._();

extension ChromeTypesExtension on Chrome {
  /// The `chrome.types` API contains type declarations for Chrome.
  ChromeTypes get types => _types;
}

class ChromeTypes {
  ChromeTypes._();

  bool get isAvailable => $js.chrome.typesNullable != null && alwaysTrue;
}

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
enum ChromeSettingScope {
  regular('regular'),
  regularOnly('regular_only'),
  incognitoPersistent('incognito_persistent'),
  incognitoSessionOnly('incognito_session_only');

  const ChromeSettingScope(this.value);

  final String value;

  String get toJS => value;
  static ChromeSettingScope fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// One of<ul><li>[not_controllable]: cannot be controlled by any
/// extension</li><li>[controlled_by_other_extensions]: controlled by extensions
/// with higher precedence</li><li>[controllable_by_this_extension]: can be
/// controlled by this extension</li><li>[controlled_by_this_extension]:
/// controlled by this extension</li></ul>
enum LevelOfControl {
  notControllable('not_controllable'),
  controlledByOtherExtensions('controlled_by_other_extensions'),
  controllableByThisExtension('controllable_by_this_extension'),
  controlledByThisExtension('controlled_by_this_extension');

  const LevelOfControl(this.value);

  final String value;

  String get toJS => value;
  static LevelOfControl fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class ChromeSetting {
  ChromeSetting.fromJS(this._wrapped);

  ChromeSetting() : _wrapped = $js.ChromeSetting();

  final $js.ChromeSetting _wrapped;

  $js.ChromeSetting get toJS => _wrapped;

  /// Gets the value of a setting.
  /// [details] Which setting to consider.
  Future<GetCallbackDetails> get(GetDetails details) async {
    var $res = await promiseToFuture<$js.GetCallbackDetails>(
        _wrapped.get(details.toJS));
    return GetCallbackDetails.fromJS($res);
  }

  /// Sets the value of a setting.
  /// [details] Which setting to change.
  /// [returns] Called at the completion of the set operation.
  Future<void> set(SetDetails details) async {
    await promiseToFuture<void>(_wrapped.set(details.toJS));
  }

  /// Clears the setting, restoring any default value.
  /// [details] Which setting to clear.
  /// [returns] Called at the completion of the clear operation.
  Future<void> clear(ClearDetails details) async {
    await promiseToFuture<void>(_wrapped.clear(details.toJS));
  }

  /// Fired after the setting changes.
  EventStream<OnChangeDetails> get onChange =>
      _wrapped.onChange.asStream(($c) => ($js.OnChangeDetails details) {
            return $c(OnChangeDetails.fromJS(details));
          });
}

class GetCallbackDetails {
  GetCallbackDetails.fromJS(this._wrapped);

  GetCallbackDetails({
    /// The value of the setting.
    required Object value,

    /// The level of control of the setting.
    required LevelOfControl levelOfControl,

    /// Whether the effective value is specific to the incognito
    /// session.<br/>This property will _only_ be present if the [incognito]
    /// property in the [details] parameter of `get()` was true.
    bool? incognitoSpecific,
  }) : _wrapped = $js.GetCallbackDetails(
          value: value.jsify()!,
          levelOfControl: levelOfControl.toJS,
          incognitoSpecific: incognitoSpecific,
        );

  final $js.GetCallbackDetails _wrapped;

  $js.GetCallbackDetails get toJS => _wrapped;

  /// The value of the setting.
  Object get value => _wrapped.value.dartify()!;
  set value(Object v) {
    _wrapped.value = v.jsify()!;
  }

  /// The level of control of the setting.
  LevelOfControl get levelOfControl =>
      LevelOfControl.fromJS(_wrapped.levelOfControl);
  set levelOfControl(LevelOfControl v) {
    _wrapped.levelOfControl = v.toJS;
  }

  /// Whether the effective value is specific to the incognito session.<br/>This
  /// property will _only_ be present if the [incognito] property in the
  /// [details] parameter of `get()` was true.
  bool? get incognitoSpecific => _wrapped.incognitoSpecific;
  set incognitoSpecific(bool? v) {
    _wrapped.incognitoSpecific = v;
  }
}

class GetDetails {
  GetDetails.fromJS(this._wrapped);

  GetDetails(
      {
      /// Whether to return the value that applies to the incognito session
      /// (default false).
      bool? incognito})
      : _wrapped = $js.GetDetails(incognito: incognito);

  final $js.GetDetails _wrapped;

  $js.GetDetails get toJS => _wrapped;

  /// Whether to return the value that applies to the incognito session (default
  /// false).
  bool? get incognito => _wrapped.incognito;
  set incognito(bool? v) {
    _wrapped.incognito = v;
  }
}

class SetDetails {
  SetDetails.fromJS(this._wrapped);

  SetDetails({
    /// The value of the setting. <br/>Note that every setting has a specific
    /// value type, which is described together with the setting. An extension
    /// should _not_ set a value of a different type.
    required Object value,

    /// Where to set the setting (default: regular).
    ChromeSettingScope? scope,
  }) : _wrapped = $js.SetDetails(
          value: value.jsify()!,
          scope: scope?.toJS,
        );

  final $js.SetDetails _wrapped;

  $js.SetDetails get toJS => _wrapped;

  /// The value of the setting. <br/>Note that every setting has a specific
  /// value type, which is described together with the setting. An extension
  /// should _not_ set a value of a different type.
  Object get value => _wrapped.value.dartify()!;
  set value(Object v) {
    _wrapped.value = v.jsify()!;
  }

  /// Where to set the setting (default: regular).
  ChromeSettingScope? get scope =>
      _wrapped.scope?.let(ChromeSettingScope.fromJS);
  set scope(ChromeSettingScope? v) {
    _wrapped.scope = v?.toJS;
  }
}

class ClearDetails {
  ClearDetails.fromJS(this._wrapped);

  ClearDetails(
      {
      /// Where to clear the setting (default: regular).
      ChromeSettingScope? scope})
      : _wrapped = $js.ClearDetails(scope: scope?.toJS);

  final $js.ClearDetails _wrapped;

  $js.ClearDetails get toJS => _wrapped;

  /// Where to clear the setting (default: regular).
  ChromeSettingScope? get scope =>
      _wrapped.scope?.let(ChromeSettingScope.fromJS);
  set scope(ChromeSettingScope? v) {
    _wrapped.scope = v?.toJS;
  }
}

class OnChangeDetails {
  OnChangeDetails.fromJS(this._wrapped);

  OnChangeDetails({
    /// The value of the setting after the change.
    required Object value,

    /// The level of control of the setting.
    required LevelOfControl levelOfControl,

    /// Whether the value that has changed is specific to the incognito
    /// session.<br/>This property will _only_ be present if the user has
    /// enabled the extension in incognito mode.
    bool? incognitoSpecific,
  }) : _wrapped = $js.OnChangeDetails(
          value: value.jsify()!,
          levelOfControl: levelOfControl.toJS,
          incognitoSpecific: incognitoSpecific,
        );

  final $js.OnChangeDetails _wrapped;

  $js.OnChangeDetails get toJS => _wrapped;

  /// The value of the setting after the change.
  Object get value => _wrapped.value.dartify()!;
  set value(Object v) {
    _wrapped.value = v.jsify()!;
  }

  /// The level of control of the setting.
  LevelOfControl get levelOfControl =>
      LevelOfControl.fromJS(_wrapped.levelOfControl);
  set levelOfControl(LevelOfControl v) {
    _wrapped.levelOfControl = v.toJS;
  }

  /// Whether the value that has changed is specific to the incognito
  /// session.<br/>This property will _only_ be present if the user has enabled
  /// the extension in incognito mode.
  bool? get incognitoSpecific => _wrapped.incognitoSpecific;
  set incognitoSpecific(bool? v) {
    _wrapped.incognitoSpecific = v;
  }
}
