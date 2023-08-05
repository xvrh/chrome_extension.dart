// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/font_settings.dart' as $js;

export 'src/chrome.dart' show chrome;

final _fontSettings = ChromeFontSettings._();

extension ChromeFontSettingsExtension on Chrome {
  /// Use the `chrome.fontSettings` API to manage Chrome's font settings.
  ChromeFontSettings get fontSettings => _fontSettings;
}

class ChromeFontSettings {
  ChromeFontSettings._();

  bool get isAvailable => $js.chrome.fontSettingsNullable != null && alwaysTrue;

  /// Clears the font set by this extension, if any.
  Future<void> clearFont(ClearFontDetails details) async {
    await promiseToFuture<void>(
        $js.chrome.fontSettings.clearFont(details.toJS));
  }

  /// Gets the font for a given script and generic font family.
  Future<GetFontCallbackDetails> getFont(GetFontDetails details) async {
    var $res = await promiseToFuture<$js.GetFontCallbackDetails>(
        $js.chrome.fontSettings.getFont(details.toJS));
    return GetFontCallbackDetails.fromJS($res);
  }

  /// Sets the font for a given script and generic font family.
  Future<void> setFont(SetFontDetails details) async {
    await promiseToFuture<void>($js.chrome.fontSettings.setFont(details.toJS));
  }

  /// Gets a list of fonts on the system.
  Future<List<FontName>> getFontList() async {
    var $res =
        await promiseToFuture<JSArray>($js.chrome.fontSettings.getFontList());
    return $res.toDart
        .cast<$js.FontName>()
        .map((e) => FontName.fromJS(e))
        .toList();
  }

  /// Clears the default font size set by this extension, if any.
  /// [details] This parameter is currently unused.
  Future<void> clearDefaultFontSize(
      ClearDefaultFontSizeDetails? details) async {
    await promiseToFuture<void>(
        $js.chrome.fontSettings.clearDefaultFontSize(details?.toJS));
  }

  /// Gets the default font size.
  /// [details] This parameter is currently unused.
  Future<GetDefaultFontSizeCallbackDetails> getDefaultFontSize(
      GetDefaultFontSizeDetails? details) async {
    var $res = await promiseToFuture<$js.GetDefaultFontSizeCallbackDetails>(
        $js.chrome.fontSettings.getDefaultFontSize(details?.toJS));
    return GetDefaultFontSizeCallbackDetails.fromJS($res);
  }

  /// Sets the default font size.
  Future<void> setDefaultFontSize(SetDefaultFontSizeDetails details) async {
    await promiseToFuture<void>(
        $js.chrome.fontSettings.setDefaultFontSize(details.toJS));
  }

  /// Clears the default fixed font size set by this extension, if any.
  /// [details] This parameter is currently unused.
  Future<void> clearDefaultFixedFontSize(
      ClearDefaultFixedFontSizeDetails? details) async {
    await promiseToFuture<void>(
        $js.chrome.fontSettings.clearDefaultFixedFontSize(details?.toJS));
  }

  /// Gets the default size for fixed width fonts.
  /// [details] This parameter is currently unused.
  Future<GetDefaultFixedFontSizeCallbackDetails> getDefaultFixedFontSize(
      GetDefaultFixedFontSizeDetails? details) async {
    var $res =
        await promiseToFuture<$js.GetDefaultFixedFontSizeCallbackDetails>(
            $js.chrome.fontSettings.getDefaultFixedFontSize(details?.toJS));
    return GetDefaultFixedFontSizeCallbackDetails.fromJS($res);
  }

  /// Sets the default size for fixed width fonts.
  Future<void> setDefaultFixedFontSize(
      SetDefaultFixedFontSizeDetails details) async {
    await promiseToFuture<void>(
        $js.chrome.fontSettings.setDefaultFixedFontSize(details.toJS));
  }

  /// Clears the minimum font size set by this extension, if any.
  /// [details] This parameter is currently unused.
  Future<void> clearMinimumFontSize(
      ClearMinimumFontSizeDetails? details) async {
    await promiseToFuture<void>(
        $js.chrome.fontSettings.clearMinimumFontSize(details?.toJS));
  }

  /// Gets the minimum font size.
  /// [details] This parameter is currently unused.
  Future<GetMinimumFontSizeCallbackDetails> getMinimumFontSize(
      GetMinimumFontSizeDetails? details) async {
    var $res = await promiseToFuture<$js.GetMinimumFontSizeCallbackDetails>(
        $js.chrome.fontSettings.getMinimumFontSize(details?.toJS));
    return GetMinimumFontSizeCallbackDetails.fromJS($res);
  }

  /// Sets the minimum font size.
  Future<void> setMinimumFontSize(SetMinimumFontSizeDetails details) async {
    await promiseToFuture<void>(
        $js.chrome.fontSettings.setMinimumFontSize(details.toJS));
  }

  /// Fired when a font setting changes.
  EventStream<OnFontChangedDetails> get onFontChanged =>
      $js.chrome.fontSettings.onFontChanged
          .asStream(($c) => ($js.OnFontChangedDetails details) {
                return $c(OnFontChangedDetails.fromJS(details));
              });

  /// Fired when the default font size setting changes.
  EventStream<OnDefaultFontSizeChangedDetails> get onDefaultFontSizeChanged =>
      $js.chrome.fontSettings.onDefaultFontSizeChanged
          .asStream(($c) => ($js.OnDefaultFontSizeChangedDetails details) {
                return $c(OnDefaultFontSizeChangedDetails.fromJS(details));
              });

  /// Fired when the default fixed font size setting changes.
  EventStream<OnDefaultFixedFontSizeChangedDetails>
      get onDefaultFixedFontSizeChanged => $js
          .chrome.fontSettings.onDefaultFixedFontSizeChanged
          .asStream(($c) => ($js.OnDefaultFixedFontSizeChangedDetails details) {
                return $c(OnDefaultFixedFontSizeChangedDetails.fromJS(details));
              });

  /// Fired when the minimum font size setting changes.
  EventStream<OnMinimumFontSizeChangedDetails> get onMinimumFontSizeChanged =>
      $js.chrome.fontSettings.onMinimumFontSizeChanged
          .asStream(($c) => ($js.OnMinimumFontSizeChangedDetails details) {
                return $c(OnMinimumFontSizeChangedDetails.fromJS(details));
              });
}

/// An ISO 15924 script code. The default, or global, script is represented by
/// script code "Zyyy".
enum ScriptCode {
  afak('Afak'),
  arab('Arab'),
  armi('Armi'),
  armn('Armn'),
  avst('Avst'),
  bali('Bali'),
  bamu('Bamu'),
  bass('Bass'),
  batk('Batk'),
  beng('Beng'),
  blis('Blis'),
  bopo('Bopo'),
  brah('Brah'),
  brai('Brai'),
  bugi('Bugi'),
  buhd('Buhd'),
  cakm('Cakm'),
  cans('Cans'),
  cari('Cari'),
  cham('Cham'),
  cher('Cher'),
  cirt('Cirt'),
  copt('Copt'),
  cprt('Cprt'),
  cyrl('Cyrl'),
  cyrs('Cyrs'),
  deva('Deva'),
  dsrt('Dsrt'),
  dupl('Dupl'),
  egyd('Egyd'),
  egyh('Egyh'),
  egyp('Egyp'),
  elba('Elba'),
  ethi('Ethi'),
  geor('Geor'),
  geok('Geok'),
  glag('Glag'),
  goth('Goth'),
  gran('Gran'),
  grek('Grek'),
  gujr('Gujr'),
  guru('Guru'),
  hang('Hang'),
  hani('Hani'),
  hano('Hano'),
  hans('Hans'),
  hant('Hant'),
  hebr('Hebr'),
  hluw('Hluw'),
  hmng('Hmng'),
  hung('Hung'),
  inds('Inds'),
  ital('Ital'),
  java('Java'),
  jpan('Jpan'),
  jurc('Jurc'),
  kali('Kali'),
  khar('Khar'),
  khmr('Khmr'),
  khoj('Khoj'),
  knda('Knda'),
  kpel('Kpel'),
  kthi('Kthi'),
  lana('Lana'),
  laoo('Laoo'),
  latf('Latf'),
  latg('Latg'),
  latn('Latn'),
  lepc('Lepc'),
  limb('Limb'),
  lina('Lina'),
  linb('Linb'),
  lisu('Lisu'),
  loma('Loma'),
  lyci('Lyci'),
  lydi('Lydi'),
  mand('Mand'),
  mani('Mani'),
  maya('Maya'),
  mend('Mend'),
  merc('Merc'),
  mero('Mero'),
  mlym('Mlym'),
  moon('Moon'),
  mong('Mong'),
  mroo('Mroo'),
  mtei('Mtei'),
  mymr('Mymr'),
  narb('Narb'),
  nbat('Nbat'),
  nkgb('Nkgb'),
  nkoo('Nkoo'),
  nshu('Nshu'),
  ogam('Ogam'),
  olck('Olck'),
  orkh('Orkh'),
  orya('Orya'),
  osma('Osma'),
  palm('Palm'),
  perm('Perm'),
  phag('Phag'),
  phli('Phli'),
  phlp('Phlp'),
  phlv('Phlv'),
  phnx('Phnx'),
  plrd('Plrd'),
  prti('Prti'),
  rjng('Rjng'),
  roro('Roro'),
  runr('Runr'),
  samr('Samr'),
  sara('Sara'),
  sarb('Sarb'),
  saur('Saur'),
  sgnw('Sgnw'),
  shaw('Shaw'),
  shrd('Shrd'),
  sind('Sind'),
  sinh('Sinh'),
  sora('Sora'),
  sund('Sund'),
  sylo('Sylo'),
  syrc('Syrc'),
  syre('Syre'),
  syrj('Syrj'),
  syrn('Syrn'),
  tagb('Tagb'),
  takr('Takr'),
  tale('Tale'),
  talu('Talu'),
  taml('Taml'),
  tang('Tang'),
  tavt('Tavt'),
  telu('Telu'),
  teng('Teng'),
  tfng('Tfng'),
  tglg('Tglg'),
  thaa('Thaa'),
  thai('Thai'),
  tibt('Tibt'),
  tirh('Tirh'),
  ugar('Ugar'),
  vaii('Vaii'),
  visp('Visp'),
  wara('Wara'),
  wole('Wole'),
  xpeo('Xpeo'),
  xsux('Xsux'),
  yiii('Yiii'),
  zmth('Zmth'),
  zsym('Zsym'),
  zyyy('Zyyy');

  const ScriptCode(this.value);

  final String value;

  String get toJS => value;
  static ScriptCode fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// A CSS generic font family.
enum GenericFamily {
  standard('standard'),
  sansserif('sansserif'),
  serif('serif'),
  fixed('fixed'),
  cursive('cursive'),
  fantasy('fantasy'),
  math('math');

  const GenericFamily(this.value);

  final String value;

  String get toJS => value;
  static GenericFamily fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// One of
/// [not_controllable]: cannot be controlled by any extension
/// [controlled_by_other_extensions]: controlled by extensions with higher
/// precedence
/// [controllable_by_this_extension]: can be controlled by this extension
/// [controlled_by_this_extension]: controlled by this extension
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

class FontName {
  FontName.fromJS(this._wrapped);

  FontName({
    /// The font ID.
    required String fontId,

    /// The display name of the font.
    required String displayName,
  }) : _wrapped = $js.FontName(
          fontId: fontId,
          displayName: displayName,
        );

  final $js.FontName _wrapped;

  $js.FontName get toJS => _wrapped;

  /// The font ID.
  String get fontId => _wrapped.fontId;
  set fontId(String v) {
    _wrapped.fontId = v;
  }

  /// The display name of the font.
  String get displayName => _wrapped.displayName;
  set displayName(String v) {
    _wrapped.displayName = v;
  }
}

class OnFontChangedDetails {
  OnFontChangedDetails.fromJS(this._wrapped);

  OnFontChangedDetails({
    /// The font ID. See the description in `getFont`.
    required String fontId,

    /// The script code for which the font setting has changed.
    ScriptCode? script,

    /// The generic font family for which the font setting has changed.
    required GenericFamily genericFamily,

    /// The level of control this extension has over the setting.
    required LevelOfControl levelOfControl,
  }) : _wrapped = $js.OnFontChangedDetails(
          fontId: fontId,
          script: script?.toJS,
          genericFamily: genericFamily.toJS,
          levelOfControl: levelOfControl.toJS,
        );

  final $js.OnFontChangedDetails _wrapped;

  $js.OnFontChangedDetails get toJS => _wrapped;

  /// The font ID. See the description in `getFont`.
  String get fontId => _wrapped.fontId;
  set fontId(String v) {
    _wrapped.fontId = v;
  }

  /// The script code for which the font setting has changed.
  ScriptCode? get script => _wrapped.script?.let(ScriptCode.fromJS);
  set script(ScriptCode? v) {
    _wrapped.script = v?.toJS;
  }

  /// The generic font family for which the font setting has changed.
  GenericFamily get genericFamily =>
      GenericFamily.fromJS(_wrapped.genericFamily);
  set genericFamily(GenericFamily v) {
    _wrapped.genericFamily = v.toJS;
  }

  /// The level of control this extension has over the setting.
  LevelOfControl get levelOfControl =>
      LevelOfControl.fromJS(_wrapped.levelOfControl);
  set levelOfControl(LevelOfControl v) {
    _wrapped.levelOfControl = v.toJS;
  }
}

class OnDefaultFontSizeChangedDetails {
  OnDefaultFontSizeChangedDetails.fromJS(this._wrapped);

  OnDefaultFontSizeChangedDetails({
    /// The font size in pixels.
    required int pixelSize,

    /// The level of control this extension has over the setting.
    required LevelOfControl levelOfControl,
  }) : _wrapped = $js.OnDefaultFontSizeChangedDetails(
          pixelSize: pixelSize,
          levelOfControl: levelOfControl.toJS,
        );

  final $js.OnDefaultFontSizeChangedDetails _wrapped;

  $js.OnDefaultFontSizeChangedDetails get toJS => _wrapped;

  /// The font size in pixels.
  int get pixelSize => _wrapped.pixelSize;
  set pixelSize(int v) {
    _wrapped.pixelSize = v;
  }

  /// The level of control this extension has over the setting.
  LevelOfControl get levelOfControl =>
      LevelOfControl.fromJS(_wrapped.levelOfControl);
  set levelOfControl(LevelOfControl v) {
    _wrapped.levelOfControl = v.toJS;
  }
}

class OnDefaultFixedFontSizeChangedDetails {
  OnDefaultFixedFontSizeChangedDetails.fromJS(this._wrapped);

  OnDefaultFixedFontSizeChangedDetails({
    /// The font size in pixels.
    required int pixelSize,

    /// The level of control this extension has over the setting.
    required LevelOfControl levelOfControl,
  }) : _wrapped = $js.OnDefaultFixedFontSizeChangedDetails(
          pixelSize: pixelSize,
          levelOfControl: levelOfControl.toJS,
        );

  final $js.OnDefaultFixedFontSizeChangedDetails _wrapped;

  $js.OnDefaultFixedFontSizeChangedDetails get toJS => _wrapped;

  /// The font size in pixels.
  int get pixelSize => _wrapped.pixelSize;
  set pixelSize(int v) {
    _wrapped.pixelSize = v;
  }

  /// The level of control this extension has over the setting.
  LevelOfControl get levelOfControl =>
      LevelOfControl.fromJS(_wrapped.levelOfControl);
  set levelOfControl(LevelOfControl v) {
    _wrapped.levelOfControl = v.toJS;
  }
}

class OnMinimumFontSizeChangedDetails {
  OnMinimumFontSizeChangedDetails.fromJS(this._wrapped);

  OnMinimumFontSizeChangedDetails({
    /// The font size in pixels.
    required int pixelSize,

    /// The level of control this extension has over the setting.
    required LevelOfControl levelOfControl,
  }) : _wrapped = $js.OnMinimumFontSizeChangedDetails(
          pixelSize: pixelSize,
          levelOfControl: levelOfControl.toJS,
        );

  final $js.OnMinimumFontSizeChangedDetails _wrapped;

  $js.OnMinimumFontSizeChangedDetails get toJS => _wrapped;

  /// The font size in pixels.
  int get pixelSize => _wrapped.pixelSize;
  set pixelSize(int v) {
    _wrapped.pixelSize = v;
  }

  /// The level of control this extension has over the setting.
  LevelOfControl get levelOfControl =>
      LevelOfControl.fromJS(_wrapped.levelOfControl);
  set levelOfControl(LevelOfControl v) {
    _wrapped.levelOfControl = v.toJS;
  }
}

class ClearFontDetails {
  ClearFontDetails.fromJS(this._wrapped);

  ClearFontDetails({
    /// The script for which the font should be cleared. If omitted, the global
    /// script font setting is cleared.
    ScriptCode? script,

    /// The generic font family for which the font should be cleared.
    required GenericFamily genericFamily,
  }) : _wrapped = $js.ClearFontDetails(
          script: script?.toJS,
          genericFamily: genericFamily.toJS,
        );

  final $js.ClearFontDetails _wrapped;

  $js.ClearFontDetails get toJS => _wrapped;

  /// The script for which the font should be cleared. If omitted, the global
  /// script font setting is cleared.
  ScriptCode? get script => _wrapped.script?.let(ScriptCode.fromJS);
  set script(ScriptCode? v) {
    _wrapped.script = v?.toJS;
  }

  /// The generic font family for which the font should be cleared.
  GenericFamily get genericFamily =>
      GenericFamily.fromJS(_wrapped.genericFamily);
  set genericFamily(GenericFamily v) {
    _wrapped.genericFamily = v.toJS;
  }
}

class GetFontCallbackDetails {
  GetFontCallbackDetails.fromJS(this._wrapped);

  GetFontCallbackDetails({
    /// The font ID. Rather than the literal font ID preference value, this may
    /// be the ID of the font that the system resolves the preference value to.
    /// So, [fontId] can differ from the font passed to `setFont`, if, for
    /// example, the font is not available on the system. The empty string
    /// signifies fallback to the global script font setting.
    required String fontId,

    /// The level of control this extension has over the setting.
    required LevelOfControl levelOfControl,
  }) : _wrapped = $js.GetFontCallbackDetails(
          fontId: fontId,
          levelOfControl: levelOfControl.toJS,
        );

  final $js.GetFontCallbackDetails _wrapped;

  $js.GetFontCallbackDetails get toJS => _wrapped;

  /// The font ID. Rather than the literal font ID preference value, this may be
  /// the ID of the font that the system resolves the preference value to. So,
  /// [fontId] can differ from the font passed to `setFont`, if, for example,
  /// the font is not available on the system. The empty string signifies
  /// fallback to the global script font setting.
  String get fontId => _wrapped.fontId;
  set fontId(String v) {
    _wrapped.fontId = v;
  }

  /// The level of control this extension has over the setting.
  LevelOfControl get levelOfControl =>
      LevelOfControl.fromJS(_wrapped.levelOfControl);
  set levelOfControl(LevelOfControl v) {
    _wrapped.levelOfControl = v.toJS;
  }
}

class GetFontDetails {
  GetFontDetails.fromJS(this._wrapped);

  GetFontDetails({
    /// The script for which the font should be retrieved. If omitted, the font
    /// setting for the global script (script code "Zyyy") is retrieved.
    ScriptCode? script,

    /// The generic font family for which the font should be retrieved.
    required GenericFamily genericFamily,
  }) : _wrapped = $js.GetFontDetails(
          script: script?.toJS,
          genericFamily: genericFamily.toJS,
        );

  final $js.GetFontDetails _wrapped;

  $js.GetFontDetails get toJS => _wrapped;

  /// The script for which the font should be retrieved. If omitted, the font
  /// setting for the global script (script code "Zyyy") is retrieved.
  ScriptCode? get script => _wrapped.script?.let(ScriptCode.fromJS);
  set script(ScriptCode? v) {
    _wrapped.script = v?.toJS;
  }

  /// The generic font family for which the font should be retrieved.
  GenericFamily get genericFamily =>
      GenericFamily.fromJS(_wrapped.genericFamily);
  set genericFamily(GenericFamily v) {
    _wrapped.genericFamily = v.toJS;
  }
}

class SetFontDetails {
  SetFontDetails.fromJS(this._wrapped);

  SetFontDetails({
    /// The script code which the font should be set. If omitted, the font
    /// setting for the global script (script code "Zyyy") is set.
    ScriptCode? script,

    /// The generic font family for which the font should be set.
    required GenericFamily genericFamily,

    /// The font ID. The empty string means to fallback to the global script
    /// font setting.
    required String fontId,
  }) : _wrapped = $js.SetFontDetails(
          script: script?.toJS,
          genericFamily: genericFamily.toJS,
          fontId: fontId,
        );

  final $js.SetFontDetails _wrapped;

  $js.SetFontDetails get toJS => _wrapped;

  /// The script code which the font should be set. If omitted, the font setting
  /// for the global script (script code "Zyyy") is set.
  ScriptCode? get script => _wrapped.script?.let(ScriptCode.fromJS);
  set script(ScriptCode? v) {
    _wrapped.script = v?.toJS;
  }

  /// The generic font family for which the font should be set.
  GenericFamily get genericFamily =>
      GenericFamily.fromJS(_wrapped.genericFamily);
  set genericFamily(GenericFamily v) {
    _wrapped.genericFamily = v.toJS;
  }

  /// The font ID. The empty string means to fallback to the global script font
  /// setting.
  String get fontId => _wrapped.fontId;
  set fontId(String v) {
    _wrapped.fontId = v;
  }
}

class ClearDefaultFontSizeDetails {
  ClearDefaultFontSizeDetails.fromJS(this._wrapped);

  ClearDefaultFontSizeDetails() : _wrapped = $js.ClearDefaultFontSizeDetails();

  final $js.ClearDefaultFontSizeDetails _wrapped;

  $js.ClearDefaultFontSizeDetails get toJS => _wrapped;
}

class GetDefaultFontSizeCallbackDetails {
  GetDefaultFontSizeCallbackDetails.fromJS(this._wrapped);

  GetDefaultFontSizeCallbackDetails({
    /// The font size in pixels.
    required int pixelSize,

    /// The level of control this extension has over the setting.
    required LevelOfControl levelOfControl,
  }) : _wrapped = $js.GetDefaultFontSizeCallbackDetails(
          pixelSize: pixelSize,
          levelOfControl: levelOfControl.toJS,
        );

  final $js.GetDefaultFontSizeCallbackDetails _wrapped;

  $js.GetDefaultFontSizeCallbackDetails get toJS => _wrapped;

  /// The font size in pixels.
  int get pixelSize => _wrapped.pixelSize;
  set pixelSize(int v) {
    _wrapped.pixelSize = v;
  }

  /// The level of control this extension has over the setting.
  LevelOfControl get levelOfControl =>
      LevelOfControl.fromJS(_wrapped.levelOfControl);
  set levelOfControl(LevelOfControl v) {
    _wrapped.levelOfControl = v.toJS;
  }
}

class GetDefaultFontSizeDetails {
  GetDefaultFontSizeDetails.fromJS(this._wrapped);

  GetDefaultFontSizeDetails() : _wrapped = $js.GetDefaultFontSizeDetails();

  final $js.GetDefaultFontSizeDetails _wrapped;

  $js.GetDefaultFontSizeDetails get toJS => _wrapped;
}

class SetDefaultFontSizeDetails {
  SetDefaultFontSizeDetails.fromJS(this._wrapped);

  SetDefaultFontSizeDetails(
      {
      /// The font size in pixels.
      required int pixelSize})
      : _wrapped = $js.SetDefaultFontSizeDetails(pixelSize: pixelSize);

  final $js.SetDefaultFontSizeDetails _wrapped;

  $js.SetDefaultFontSizeDetails get toJS => _wrapped;

  /// The font size in pixels.
  int get pixelSize => _wrapped.pixelSize;
  set pixelSize(int v) {
    _wrapped.pixelSize = v;
  }
}

class ClearDefaultFixedFontSizeDetails {
  ClearDefaultFixedFontSizeDetails.fromJS(this._wrapped);

  ClearDefaultFixedFontSizeDetails()
      : _wrapped = $js.ClearDefaultFixedFontSizeDetails();

  final $js.ClearDefaultFixedFontSizeDetails _wrapped;

  $js.ClearDefaultFixedFontSizeDetails get toJS => _wrapped;
}

class GetDefaultFixedFontSizeCallbackDetails {
  GetDefaultFixedFontSizeCallbackDetails.fromJS(this._wrapped);

  GetDefaultFixedFontSizeCallbackDetails({
    /// The font size in pixels.
    required int pixelSize,

    /// The level of control this extension has over the setting.
    required LevelOfControl levelOfControl,
  }) : _wrapped = $js.GetDefaultFixedFontSizeCallbackDetails(
          pixelSize: pixelSize,
          levelOfControl: levelOfControl.toJS,
        );

  final $js.GetDefaultFixedFontSizeCallbackDetails _wrapped;

  $js.GetDefaultFixedFontSizeCallbackDetails get toJS => _wrapped;

  /// The font size in pixels.
  int get pixelSize => _wrapped.pixelSize;
  set pixelSize(int v) {
    _wrapped.pixelSize = v;
  }

  /// The level of control this extension has over the setting.
  LevelOfControl get levelOfControl =>
      LevelOfControl.fromJS(_wrapped.levelOfControl);
  set levelOfControl(LevelOfControl v) {
    _wrapped.levelOfControl = v.toJS;
  }
}

class GetDefaultFixedFontSizeDetails {
  GetDefaultFixedFontSizeDetails.fromJS(this._wrapped);

  GetDefaultFixedFontSizeDetails()
      : _wrapped = $js.GetDefaultFixedFontSizeDetails();

  final $js.GetDefaultFixedFontSizeDetails _wrapped;

  $js.GetDefaultFixedFontSizeDetails get toJS => _wrapped;
}

class SetDefaultFixedFontSizeDetails {
  SetDefaultFixedFontSizeDetails.fromJS(this._wrapped);

  SetDefaultFixedFontSizeDetails(
      {
      /// The font size in pixels.
      required int pixelSize})
      : _wrapped = $js.SetDefaultFixedFontSizeDetails(pixelSize: pixelSize);

  final $js.SetDefaultFixedFontSizeDetails _wrapped;

  $js.SetDefaultFixedFontSizeDetails get toJS => _wrapped;

  /// The font size in pixels.
  int get pixelSize => _wrapped.pixelSize;
  set pixelSize(int v) {
    _wrapped.pixelSize = v;
  }
}

class ClearMinimumFontSizeDetails {
  ClearMinimumFontSizeDetails.fromJS(this._wrapped);

  ClearMinimumFontSizeDetails() : _wrapped = $js.ClearMinimumFontSizeDetails();

  final $js.ClearMinimumFontSizeDetails _wrapped;

  $js.ClearMinimumFontSizeDetails get toJS => _wrapped;
}

class GetMinimumFontSizeCallbackDetails {
  GetMinimumFontSizeCallbackDetails.fromJS(this._wrapped);

  GetMinimumFontSizeCallbackDetails({
    /// The font size in pixels.
    required int pixelSize,

    /// The level of control this extension has over the setting.
    required LevelOfControl levelOfControl,
  }) : _wrapped = $js.GetMinimumFontSizeCallbackDetails(
          pixelSize: pixelSize,
          levelOfControl: levelOfControl.toJS,
        );

  final $js.GetMinimumFontSizeCallbackDetails _wrapped;

  $js.GetMinimumFontSizeCallbackDetails get toJS => _wrapped;

  /// The font size in pixels.
  int get pixelSize => _wrapped.pixelSize;
  set pixelSize(int v) {
    _wrapped.pixelSize = v;
  }

  /// The level of control this extension has over the setting.
  LevelOfControl get levelOfControl =>
      LevelOfControl.fromJS(_wrapped.levelOfControl);
  set levelOfControl(LevelOfControl v) {
    _wrapped.levelOfControl = v.toJS;
  }
}

class GetMinimumFontSizeDetails {
  GetMinimumFontSizeDetails.fromJS(this._wrapped);

  GetMinimumFontSizeDetails() : _wrapped = $js.GetMinimumFontSizeDetails();

  final $js.GetMinimumFontSizeDetails _wrapped;

  $js.GetMinimumFontSizeDetails get toJS => _wrapped;
}

class SetMinimumFontSizeDetails {
  SetMinimumFontSizeDetails.fromJS(this._wrapped);

  SetMinimumFontSizeDetails(
      {
      /// The font size in pixels.
      required int pixelSize})
      : _wrapped = $js.SetMinimumFontSizeDetails(pixelSize: pixelSize);

  final $js.SetMinimumFontSizeDetails _wrapped;

  $js.SetMinimumFontSizeDetails get toJS => _wrapped;

  /// The font size in pixels.
  int get pixelSize => _wrapped.pixelSize;
  set pixelSize(int v) {
    _wrapped.pixelSize = v;
  }
}
