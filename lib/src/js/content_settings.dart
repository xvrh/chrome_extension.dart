// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSContentSettingsExtension on JSChrome {
  @JS('contentSettings')
  external JSContentSettings? get contentSettingsNullable;

  /// Use the `chrome.contentSettings` API to change settings that control
  /// whether websites can use features such as cookies, JavaScript, and
  /// plugins. More generally speaking, content settings allow you to customize
  /// Chrome's behavior on a per-site basis instead of globally.
  JSContentSettings get contentSettings {
    var contentSettingsNullable = this.contentSettingsNullable;
    if (contentSettingsNullable == null) {
      throw ApiNotAvailableException('chrome.contentSettings');
    }
    return contentSettingsNullable;
  }
}

@JS()
@staticInterop
class JSContentSettings {}

extension JSContentSettingsExtension on JSContentSettings {
  /// Whether to allow sites to use the [Private State Tokens
  /// API](https://developer.chrome.com/docs/privacy-sandbox/trust-tokens/). One
  /// of
  /// [allow]: Allow sites to use the Private State Tokens API,
  /// [block]: Block sites from using the Private State Tokens API.
  /// Default is [allow].
  ///  The primary URL is the URL of the top-level frame. The secondary URL is
  /// not used. NOTE: When calling `set()`, the primary pattern must be
  /// `<all_urls>`.
  external ContentSetting get autoVerify;

  /// Whether to allow cookies and other local data to be set by websites. One
  /// of
  /// [allow]: Accept cookies,
  /// [block]: Block cookies,
  /// [session_only]: Accept cookies only for the current session.
  /// Default is [allow].
  /// The primary URL is the URL representing the cookie origin. The secondary
  /// URL is the URL of the top-level frame.
  external ContentSetting get cookies;

  /// Whether to show images. One of
  /// [allow]: Show images,
  /// [block]: Don't show images.
  /// Default is [allow].
  /// The primary URL is the URL of the top-level frame. The secondary URL is
  /// the URL of the image.
  external ContentSetting get images;

  /// Whether to run JavaScript. One of
  /// [allow]: Run JavaScript,
  /// [block]: Don't run JavaScript.
  /// Default is [allow].
  /// The primary URL is the URL of the top-level frame. The secondary URL is
  /// not used.
  external ContentSetting get javascript;

  /// Whether to allow Geolocation. One of
  /// [allow]: Allow sites to track your physical location,
  /// [block]: Don't allow sites to track your physical location,
  /// [ask]: Ask before allowing sites to track your physical location.
  /// Default is [ask].
  /// The primary URL is the URL of the document which requested location data.
  /// The secondary URL is the URL of the top-level frame (which may or may not
  /// differ from the requesting URL).
  external ContentSetting get location;

  /// <i>Deprecated.</i> With Flash support removed in Chrome 88, this
  /// permission no longer has any effect. Value is always [block]. Calls to
  /// `set()` and `clear()` will be ignored.
  external ContentSetting get plugins;

  /// Whether to allow sites to show pop-ups. One of
  /// [allow]: Allow sites to show pop-ups,
  /// [block]: Don't allow sites to show pop-ups.
  /// Default is [block].
  /// The primary URL is the URL of the top-level frame. The secondary URL is
  /// not used.
  external ContentSetting get popups;

  /// Whether to allow sites to show desktop notifications. One of
  /// [allow]: Allow sites to show desktop notifications,
  /// [block]: Don't allow sites to show desktop notifications,
  /// [ask]: Ask when a site wants to show desktop notifications.
  /// Default is [ask].
  /// The primary URL is the URL of the document which wants to show the
  /// notification. The secondary URL is not used.
  external ContentSetting get notifications;

  /// <i>Deprecated.</i> No longer has any effect. Fullscreen permission is now
  /// automatically granted for all sites. Value is always [allow].
  external ContentSetting get fullscreen;

  /// <i>Deprecated.</i> No longer has any effect. Mouse lock permission is now
  /// automatically granted for all sites. Value is always [allow].
  external ContentSetting get mouselock;

  /// Whether to allow sites to access the microphone. One of
  /// [allow]: Allow sites to access the microphone,
  /// [block]: Don't allow sites to access the microphone,
  /// [ask]: Ask when a site wants to access the microphone.
  /// Default is [ask].
  /// The primary URL is the URL of the document which requested microphone
  /// access. The secondary URL is not used.
  /// NOTE: The 'allow' setting is not valid if both patterns are '<all_urls>'.
  external ContentSetting get microphone;

  /// Whether to allow sites to access the camera. One of
  /// [allow]: Allow sites to access the camera,
  /// [block]: Don't allow sites to access the camera,
  /// [ask]: Ask when a site wants to access the camera.
  /// Default is [ask].
  /// The primary URL is the URL of the document which requested camera access.
  /// The secondary URL is not used.
  /// NOTE: The 'allow' setting is not valid if both patterns are '<all_urls>'.
  external ContentSetting get camera;

  /// <i>Deprecated.</i> Previously, controlled whether to allow sites to run
  /// plugins unsandboxed, however, with the Flash broker process removed in
  /// Chrome 88, this permission no longer has any effect. Value is always
  /// [block]. Calls to `set()` and `clear()` will be ignored.
  external ContentSetting get unsandboxedPlugins;

  /// Whether to allow sites to download multiple files automatically. One of
  /// [allow]: Allow sites to download multiple files automatically,
  /// [block]: Don't allow sites to download multiple files automatically,
  /// [ask]: Ask when a site wants to download files automatically after the
  /// first file.
  /// Default is [ask].
  /// The primary URL is the URL of the top-level frame. The secondary URL is
  /// not used.
  external ContentSetting get automaticDownloads;
}

/// The scope of the ContentSetting. One of
/// [regular]: setting for regular profile (which is inherited by the incognito
/// profile if not overridden elsewhere),
/// [incognito_session_only]: setting for incognito profile that can only be set
/// during an incognito session and is deleted when the incognito session ends
/// (overrides regular settings).
typedef Scope = String;

typedef AutoVerifyContentSetting = String;

typedef CookiesContentSetting = String;

typedef ImagesContentSetting = String;

typedef JavascriptContentSetting = String;

typedef LocationContentSetting = String;

typedef PluginsContentSetting = String;

typedef PopupsContentSetting = String;

typedef NotificationsContentSetting = String;

typedef FullscreenContentSetting = String;

typedef MouselockContentSetting = String;

typedef MicrophoneContentSetting = String;

typedef CameraContentSetting = String;

typedef PpapiBrokerContentSetting = String;

typedef MultipleAutomaticDownloadsContentSetting = String;

@JS()
@staticInterop
@anonymous
class ResourceIdentifier {
  external factory ResourceIdentifier({
    /// The resource identifier for the given content type.
    String id,

    /// A human readable description of the resource.
    String? description,
  });
}

extension ResourceIdentifierExtension on ResourceIdentifier {
  /// The resource identifier for the given content type.
  external String id;

  /// A human readable description of the resource.
  external String? description;
}

@JS()
@staticInterop
@anonymous
class ContentSetting {
  external factory ContentSetting();
}

extension ContentSettingExtension on ContentSetting {
  /// Clear all content setting rules set by this extension.
  external JSPromise clear(ClearDetails details);

  /// Gets the current content setting for a given pair of URLs.
  external JSPromise get(GetDetails details);

  /// Applies a new content setting rule.
  external JSPromise set(SetDetails details);

  external JSPromise getResourceIdentifiers();
}

@JS()
@staticInterop
@anonymous
class ClearDetails {
  external factory ClearDetails(
      {
      /// Where to clear the setting (default: regular).
      Scope? scope});
}

extension ClearDetailsExtension on ClearDetails {
  /// Where to clear the setting (default: regular).
  external Scope? scope;
}

@JS()
@staticInterop
@anonymous
class GetCallbackDetails {
  external factory GetCallbackDetails(
      {
      /// The content setting. See the description of the individual ContentSetting
      /// objects for the possible values.
      JSAny setting});
}

extension GetCallbackDetailsExtension on GetCallbackDetails {
  /// The content setting. See the description of the individual ContentSetting
  /// objects for the possible values.
  external JSAny setting;
}

@JS()
@staticInterop
@anonymous
class GetDetails {
  external factory GetDetails({
    /// The primary URL for which the content setting should be retrieved. Note
    /// that the meaning of a primary URL depends on the content type.
    String primaryUrl,

    /// The secondary URL for which the content setting should be retrieved.
    /// Defaults to the primary URL. Note that the meaning of a secondary URL
    /// depends on the content type, and not all content types use secondary URLs.
    String? secondaryUrl,

    /// A more specific identifier of the type of content for which the settings
    /// should be retrieved.
    ResourceIdentifier? resourceIdentifier,

    /// Whether to check the content settings for an incognito session. (default
    /// false)
    bool? incognito,
  });
}

extension GetDetailsExtension on GetDetails {
  /// The primary URL for which the content setting should be retrieved. Note
  /// that the meaning of a primary URL depends on the content type.
  external String primaryUrl;

  /// The secondary URL for which the content setting should be retrieved.
  /// Defaults to the primary URL. Note that the meaning of a secondary URL
  /// depends on the content type, and not all content types use secondary URLs.
  external String? secondaryUrl;

  /// A more specific identifier of the type of content for which the settings
  /// should be retrieved.
  external ResourceIdentifier? resourceIdentifier;

  /// Whether to check the content settings for an incognito session. (default
  /// false)
  external bool? incognito;
}

@JS()
@staticInterop
@anonymous
class SetDetails {
  external factory SetDetails({
    /// The pattern for the primary URL. For details on the format of a pattern,
    /// see [Content Setting Patterns](contentSettings#patterns).
    String primaryPattern,

    /// The pattern for the secondary URL. Defaults to matching all URLs. For
    /// details on the format of a pattern, see [Content Setting
    /// Patterns](contentSettings#patterns).
    String? secondaryPattern,

    /// The resource identifier for the content type.
    ResourceIdentifier? resourceIdentifier,

    /// The setting applied by this rule. See the description of the individual
    /// ContentSetting objects for the possible values.
    JSAny setting,

    /// Where to set the setting (default: regular).
    Scope? scope,
  });
}

extension SetDetailsExtension on SetDetails {
  /// The pattern for the primary URL. For details on the format of a pattern,
  /// see [Content Setting Patterns](contentSettings#patterns).
  external String primaryPattern;

  /// The pattern for the secondary URL. Defaults to matching all URLs. For
  /// details on the format of a pattern, see [Content Setting
  /// Patterns](contentSettings#patterns).
  external String? secondaryPattern;

  /// The resource identifier for the content type.
  external ResourceIdentifier? resourceIdentifier;

  /// The setting applied by this rule. See the description of the individual
  /// ContentSetting objects for the possible values.
  external JSAny setting;

  /// Where to set the setting (default: regular).
  external Scope? scope;
}
