// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/content_settings.dart' as $js;

export 'src/chrome.dart' show chrome;

final _contentSettings = ChromeContentSettings._();

extension ChromeContentSettingsExtension on Chrome {
  /// Use the `chrome.contentSettings` API to change settings that control
  /// whether websites can use features such as cookies, JavaScript, and
  /// plugins. More generally speaking, content settings allow you to customize
  /// Chrome's behavior on a per-site basis instead of globally.
  ChromeContentSettings get contentSettings => _contentSettings;
}

class ChromeContentSettings {
  ChromeContentSettings._();

  bool get isAvailable =>
      $js.chrome.contentSettingsNullable != null && alwaysTrue;

  /// Whether to allow sites to use the [Private State Tokens
  /// API](https://developer.chrome.com/docs/privacy-sandbox/trust-tokens/). One
  /// of
  /// [allow]: Allow sites to use the Private State Tokens API,
  /// [block]: Block sites from using the Private State Tokens API.
  /// Default is [allow].
  ///  The primary URL is the URL of the top-level frame. The secondary URL is
  /// not used. NOTE: When calling `set()`, the primary pattern must be
  /// `<all_urls>`.
  ContentSetting get autoVerify =>
      ContentSetting.fromJS($js.chrome.contentSettings.autoVerify);

  /// Whether to allow cookies and other local data to be set by websites. One
  /// of
  /// [allow]: Accept cookies,
  /// [block]: Block cookies,
  /// [session_only]: Accept cookies only for the current session.
  /// Default is [allow].
  /// The primary URL is the URL representing the cookie origin. The secondary
  /// URL is the URL of the top-level frame.
  ContentSetting get cookies =>
      ContentSetting.fromJS($js.chrome.contentSettings.cookies);

  /// Whether to show images. One of
  /// [allow]: Show images,
  /// [block]: Don't show images.
  /// Default is [allow].
  /// The primary URL is the URL of the top-level frame. The secondary URL is
  /// the URL of the image.
  ContentSetting get images =>
      ContentSetting.fromJS($js.chrome.contentSettings.images);

  /// Whether to run JavaScript. One of
  /// [allow]: Run JavaScript,
  /// [block]: Don't run JavaScript.
  /// Default is [allow].
  /// The primary URL is the URL of the top-level frame. The secondary URL is
  /// not used.
  ContentSetting get javascript =>
      ContentSetting.fromJS($js.chrome.contentSettings.javascript);

  /// Whether to allow Geolocation. One of
  /// [allow]: Allow sites to track your physical location,
  /// [block]: Don't allow sites to track your physical location,
  /// [ask]: Ask before allowing sites to track your physical location.
  /// Default is [ask].
  /// The primary URL is the URL of the document which requested location data.
  /// The secondary URL is the URL of the top-level frame (which may or may not
  /// differ from the requesting URL).
  ContentSetting get location =>
      ContentSetting.fromJS($js.chrome.contentSettings.location);

  /// <i>Deprecated.</i> With Flash support removed in Chrome 88, this
  /// permission no longer has any effect. Value is always [block]. Calls to
  /// `set()` and `clear()` will be ignored.
  ContentSetting get plugins =>
      ContentSetting.fromJS($js.chrome.contentSettings.plugins);

  /// Whether to allow sites to show pop-ups. One of
  /// [allow]: Allow sites to show pop-ups,
  /// [block]: Don't allow sites to show pop-ups.
  /// Default is [block].
  /// The primary URL is the URL of the top-level frame. The secondary URL is
  /// not used.
  ContentSetting get popups =>
      ContentSetting.fromJS($js.chrome.contentSettings.popups);

  /// Whether to allow sites to show desktop notifications. One of
  /// [allow]: Allow sites to show desktop notifications,
  /// [block]: Don't allow sites to show desktop notifications,
  /// [ask]: Ask when a site wants to show desktop notifications.
  /// Default is [ask].
  /// The primary URL is the URL of the document which wants to show the
  /// notification. The secondary URL is not used.
  ContentSetting get notifications =>
      ContentSetting.fromJS($js.chrome.contentSettings.notifications);

  /// <i>Deprecated.</i> No longer has any effect. Fullscreen permission is now
  /// automatically granted for all sites. Value is always [allow].
  ContentSetting get fullscreen =>
      ContentSetting.fromJS($js.chrome.contentSettings.fullscreen);

  /// <i>Deprecated.</i> No longer has any effect. Mouse lock permission is now
  /// automatically granted for all sites. Value is always [allow].
  ContentSetting get mouselock =>
      ContentSetting.fromJS($js.chrome.contentSettings.mouselock);

  /// Whether to allow sites to access the microphone. One of
  /// [allow]: Allow sites to access the microphone,
  /// [block]: Don't allow sites to access the microphone,
  /// [ask]: Ask when a site wants to access the microphone.
  /// Default is [ask].
  /// The primary URL is the URL of the document which requested microphone
  /// access. The secondary URL is not used.
  /// NOTE: The 'allow' setting is not valid if both patterns are '<all_urls>'.
  ContentSetting get microphone =>
      ContentSetting.fromJS($js.chrome.contentSettings.microphone);

  /// Whether to allow sites to access the camera. One of
  /// [allow]: Allow sites to access the camera,
  /// [block]: Don't allow sites to access the camera,
  /// [ask]: Ask when a site wants to access the camera.
  /// Default is [ask].
  /// The primary URL is the URL of the document which requested camera access.
  /// The secondary URL is not used.
  /// NOTE: The 'allow' setting is not valid if both patterns are '<all_urls>'.
  ContentSetting get camera =>
      ContentSetting.fromJS($js.chrome.contentSettings.camera);

  /// <i>Deprecated.</i> Previously, controlled whether to allow sites to run
  /// plugins unsandboxed, however, with the Flash broker process removed in
  /// Chrome 88, this permission no longer has any effect. Value is always
  /// [block]. Calls to `set()` and `clear()` will be ignored.
  ContentSetting get unsandboxedPlugins =>
      ContentSetting.fromJS($js.chrome.contentSettings.unsandboxedPlugins);

  /// Whether to allow sites to download multiple files automatically. One of
  /// [allow]: Allow sites to download multiple files automatically,
  /// [block]: Don't allow sites to download multiple files automatically,
  /// [ask]: Ask when a site wants to download files automatically after the
  /// first file.
  /// Default is [ask].
  /// The primary URL is the URL of the top-level frame. The secondary URL is
  /// not used.
  ContentSetting get automaticDownloads =>
      ContentSetting.fromJS($js.chrome.contentSettings.automaticDownloads);
}

/// The scope of the ContentSetting. One of
/// [regular]: setting for regular profile (which is inherited by the incognito
/// profile if not overridden elsewhere),
/// [incognito_session_only]: setting for incognito profile that can only be set
/// during an incognito session and is deleted when the incognito session ends
/// (overrides regular settings).
enum Scope {
  regular('regular'),
  incognitoSessionOnly('incognito_session_only');

  const Scope(this.value);

  final String value;

  String get toJS => value;
  static Scope fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum AutoVerifyContentSetting {
  allow('allow'),
  block('block');

  const AutoVerifyContentSetting(this.value);

  final String value;

  String get toJS => value;
  static AutoVerifyContentSetting fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum CookiesContentSetting {
  allow('allow'),
  block('block'),
  sessionOnly('session_only');

  const CookiesContentSetting(this.value);

  final String value;

  String get toJS => value;
  static CookiesContentSetting fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum ImagesContentSetting {
  allow('allow'),
  block('block');

  const ImagesContentSetting(this.value);

  final String value;

  String get toJS => value;
  static ImagesContentSetting fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum JavascriptContentSetting {
  allow('allow'),
  block('block');

  const JavascriptContentSetting(this.value);

  final String value;

  String get toJS => value;
  static JavascriptContentSetting fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum LocationContentSetting {
  allow('allow'),
  block('block'),
  ask('ask');

  const LocationContentSetting(this.value);

  final String value;

  String get toJS => value;
  static LocationContentSetting fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum PluginsContentSetting {
  block('block');

  const PluginsContentSetting(this.value);

  final String value;

  String get toJS => value;
  static PluginsContentSetting fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum PopupsContentSetting {
  allow('allow'),
  block('block');

  const PopupsContentSetting(this.value);

  final String value;

  String get toJS => value;
  static PopupsContentSetting fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum NotificationsContentSetting {
  allow('allow'),
  block('block'),
  ask('ask');

  const NotificationsContentSetting(this.value);

  final String value;

  String get toJS => value;
  static NotificationsContentSetting fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum FullscreenContentSetting {
  allow('allow');

  const FullscreenContentSetting(this.value);

  final String value;

  String get toJS => value;
  static FullscreenContentSetting fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum MouselockContentSetting {
  allow('allow');

  const MouselockContentSetting(this.value);

  final String value;

  String get toJS => value;
  static MouselockContentSetting fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum MicrophoneContentSetting {
  allow('allow'),
  block('block'),
  ask('ask');

  const MicrophoneContentSetting(this.value);

  final String value;

  String get toJS => value;
  static MicrophoneContentSetting fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum CameraContentSetting {
  allow('allow'),
  block('block'),
  ask('ask');

  const CameraContentSetting(this.value);

  final String value;

  String get toJS => value;
  static CameraContentSetting fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum PpapiBrokerContentSetting {
  block('block');

  const PpapiBrokerContentSetting(this.value);

  final String value;

  String get toJS => value;
  static PpapiBrokerContentSetting fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum MultipleAutomaticDownloadsContentSetting {
  allow('allow'),
  block('block'),
  ask('ask');

  const MultipleAutomaticDownloadsContentSetting(this.value);

  final String value;

  String get toJS => value;
  static MultipleAutomaticDownloadsContentSetting fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class ResourceIdentifier {
  ResourceIdentifier.fromJS(this._wrapped);

  ResourceIdentifier({
    /// The resource identifier for the given content type.
    required String id,

    /// A human readable description of the resource.
    String? description,
  }) : _wrapped = $js.ResourceIdentifier(
          id: id,
          description: description,
        );

  final $js.ResourceIdentifier _wrapped;

  $js.ResourceIdentifier get toJS => _wrapped;

  /// The resource identifier for the given content type.
  String get id => _wrapped.id;
  set id(String v) {
    _wrapped.id = v;
  }

  /// A human readable description of the resource.
  String? get description => _wrapped.description;
  set description(String? v) {
    _wrapped.description = v;
  }
}

class ContentSetting {
  ContentSetting.fromJS(this._wrapped);

  ContentSetting() : _wrapped = $js.ContentSetting();

  final $js.ContentSetting _wrapped;

  $js.ContentSetting get toJS => _wrapped;

  /// Clear all content setting rules set by this extension.
  Future<void> clear(ClearDetails details) async {
    await promiseToFuture<void>(_wrapped.clear(details.toJS));
  }

  /// Gets the current content setting for a given pair of URLs.
  Future<GetCallbackDetails> get(GetDetails details) async {
    var $res = await promiseToFuture<$js.GetCallbackDetails>(
        _wrapped.get(details.toJS));
    return GetCallbackDetails.fromJS($res);
  }

  /// Applies a new content setting rule.
  Future<void> set(SetDetails details) async {
    await promiseToFuture<void>(_wrapped.set(details.toJS));
  }

  Future<List<ResourceIdentifier>?> getResourceIdentifiers() async {
    var $res =
        await promiseToFuture<JSArray?>(_wrapped.getResourceIdentifiers());
    return $res?.toDart
        .cast<$js.ResourceIdentifier>()
        .map((e) => ResourceIdentifier.fromJS(e))
        .toList();
  }
}

class ClearDetails {
  ClearDetails.fromJS(this._wrapped);

  ClearDetails(
      {
      /// Where to clear the setting (default: regular).
      Scope? scope})
      : _wrapped = $js.ClearDetails(scope: scope?.toJS);

  final $js.ClearDetails _wrapped;

  $js.ClearDetails get toJS => _wrapped;

  /// Where to clear the setting (default: regular).
  Scope? get scope => _wrapped.scope?.let(Scope.fromJS);
  set scope(Scope? v) {
    _wrapped.scope = v?.toJS;
  }
}

class GetCallbackDetails {
  GetCallbackDetails.fromJS(this._wrapped);

  GetCallbackDetails(
      {
      /// The content setting. See the description of the individual
      /// ContentSetting objects for the possible values.
      required Object setting})
      : _wrapped = $js.GetCallbackDetails(setting: setting.jsify()!);

  final $js.GetCallbackDetails _wrapped;

  $js.GetCallbackDetails get toJS => _wrapped;

  /// The content setting. See the description of the individual ContentSetting
  /// objects for the possible values.
  Object get setting => _wrapped.setting.dartify()!;
  set setting(Object v) {
    _wrapped.setting = v.jsify()!;
  }
}

class GetDetails {
  GetDetails.fromJS(this._wrapped);

  GetDetails({
    /// The primary URL for which the content setting should be retrieved. Note
    /// that the meaning of a primary URL depends on the content type.
    required String primaryUrl,

    /// The secondary URL for which the content setting should be retrieved.
    /// Defaults to the primary URL. Note that the meaning of a secondary URL
    /// depends on the content type, and not all content types use secondary
    /// URLs.
    String? secondaryUrl,

    /// A more specific identifier of the type of content for which the settings
    /// should be retrieved.
    ResourceIdentifier? resourceIdentifier,

    /// Whether to check the content settings for an incognito session. (default
    /// false)
    bool? incognito,
  }) : _wrapped = $js.GetDetails(
          primaryUrl: primaryUrl,
          secondaryUrl: secondaryUrl,
          resourceIdentifier: resourceIdentifier?.toJS,
          incognito: incognito,
        );

  final $js.GetDetails _wrapped;

  $js.GetDetails get toJS => _wrapped;

  /// The primary URL for which the content setting should be retrieved. Note
  /// that the meaning of a primary URL depends on the content type.
  String get primaryUrl => _wrapped.primaryUrl;
  set primaryUrl(String v) {
    _wrapped.primaryUrl = v;
  }

  /// The secondary URL for which the content setting should be retrieved.
  /// Defaults to the primary URL. Note that the meaning of a secondary URL
  /// depends on the content type, and not all content types use secondary URLs.
  String? get secondaryUrl => _wrapped.secondaryUrl;
  set secondaryUrl(String? v) {
    _wrapped.secondaryUrl = v;
  }

  /// A more specific identifier of the type of content for which the settings
  /// should be retrieved.
  ResourceIdentifier? get resourceIdentifier =>
      _wrapped.resourceIdentifier?.let(ResourceIdentifier.fromJS);
  set resourceIdentifier(ResourceIdentifier? v) {
    _wrapped.resourceIdentifier = v?.toJS;
  }

  /// Whether to check the content settings for an incognito session. (default
  /// false)
  bool? get incognito => _wrapped.incognito;
  set incognito(bool? v) {
    _wrapped.incognito = v;
  }
}

class SetDetails {
  SetDetails.fromJS(this._wrapped);

  SetDetails({
    /// The pattern for the primary URL. For details on the format of a pattern,
    /// see [Content Setting Patterns](contentSettings#patterns).
    required String primaryPattern,

    /// The pattern for the secondary URL. Defaults to matching all URLs. For
    /// details on the format of a pattern, see [Content Setting
    /// Patterns](contentSettings#patterns).
    String? secondaryPattern,

    /// The resource identifier for the content type.
    ResourceIdentifier? resourceIdentifier,

    /// The setting applied by this rule. See the description of the individual
    /// ContentSetting objects for the possible values.
    required Object setting,

    /// Where to set the setting (default: regular).
    Scope? scope,
  }) : _wrapped = $js.SetDetails(
          primaryPattern: primaryPattern,
          secondaryPattern: secondaryPattern,
          resourceIdentifier: resourceIdentifier?.toJS,
          setting: setting.jsify()!,
          scope: scope?.toJS,
        );

  final $js.SetDetails _wrapped;

  $js.SetDetails get toJS => _wrapped;

  /// The pattern for the primary URL. For details on the format of a pattern,
  /// see [Content Setting Patterns](contentSettings#patterns).
  String get primaryPattern => _wrapped.primaryPattern;
  set primaryPattern(String v) {
    _wrapped.primaryPattern = v;
  }

  /// The pattern for the secondary URL. Defaults to matching all URLs. For
  /// details on the format of a pattern, see [Content Setting
  /// Patterns](contentSettings#patterns).
  String? get secondaryPattern => _wrapped.secondaryPattern;
  set secondaryPattern(String? v) {
    _wrapped.secondaryPattern = v;
  }

  /// The resource identifier for the content type.
  ResourceIdentifier? get resourceIdentifier =>
      _wrapped.resourceIdentifier?.let(ResourceIdentifier.fromJS);
  set resourceIdentifier(ResourceIdentifier? v) {
    _wrapped.resourceIdentifier = v?.toJS;
  }

  /// The setting applied by this rule. See the description of the individual
  /// ContentSetting objects for the possible values.
  Object get setting => _wrapped.setting.dartify()!;
  set setting(Object v) {
    _wrapped.setting = v.jsify()!;
  }

  /// Where to set the setting (default: regular).
  Scope? get scope => _wrapped.scope?.let(Scope.fromJS);
  set scope(Scope? v) {
    _wrapped.scope = v?.toJS;
  }
}
