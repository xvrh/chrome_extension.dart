// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'types.dart';

export 'chrome.dart';

extension JSChromeJSPrivacyExtension on JSChrome {
  @JS('privacy')
  external JSPrivacy? get privacyNullable;

  /// Use the `chrome.privacy` API to control usage of the features in Chrome
  /// that can affect a user's privacy. This API relies on the [ChromeSetting
  /// prototype of the type API](types#ChromeSetting) for getting and setting
  /// Chrome's configuration.
  JSPrivacy get privacy {
    var privacyNullable = this.privacyNullable;
    if (privacyNullable == null) {
      throw ApiNotAvailableException('chrome.privacy');
    }
    return privacyNullable;
  }
}

@JS()
@staticInterop
class JSPrivacy {}

extension JSPrivacyExtension on JSPrivacy {
  /// Settings that influence Chrome's handling of network connections in
  /// general.
  external PrivacyNetwork get network;

  /// Settings that enable or disable features that require third-party network
  /// services provided by Google and your default search provider.
  external PrivacyServices get services;

  /// Settings that determine what information Chrome makes available to
  /// websites.
  external PrivacyWebsites get websites;
}

/// The IP handling policy of WebRTC.
typedef IPHandlingPolicy = String;

@JS()
@staticInterop
@anonymous
class PrivacyNetwork {
  external factory PrivacyNetwork({
    /// If enabled, Chrome attempts to speed up your web browsing experience by
    /// pre-resolving DNS entries and preemptively opening TCP and SSL connections
    /// to servers. This preference only affects actions taken by Chrome's
    /// internal prediction service. It does not affect webpage-initiated
    /// prefectches or preconnects. This preference's value is a boolean,
    /// defaulting to `true`.
    ChromeSetting networkPredictionEnabled,

    /// Allow users to specify the media performance/privacy tradeoffs which
    /// impacts how WebRTC traffic will be routed and how much local address
    /// information is exposed. This preference's value is of type
    /// IPHandlingPolicy, defaulting to `default`.
    ChromeSetting webRTCIPHandlingPolicy,
  });
}

extension PrivacyNetworkExtension on PrivacyNetwork {
  /// If enabled, Chrome attempts to speed up your web browsing experience by
  /// pre-resolving DNS entries and preemptively opening TCP and SSL connections
  /// to servers. This preference only affects actions taken by Chrome's
  /// internal prediction service. It does not affect webpage-initiated
  /// prefectches or preconnects. This preference's value is a boolean,
  /// defaulting to `true`.
  external ChromeSetting networkPredictionEnabled;

  /// Allow users to specify the media performance/privacy tradeoffs which
  /// impacts how WebRTC traffic will be routed and how much local address
  /// information is exposed. This preference's value is of type
  /// IPHandlingPolicy, defaulting to `default`.
  external ChromeSetting webRTCIPHandlingPolicy;
}

@JS()
@staticInterop
@anonymous
class PrivacyServices {
  external factory PrivacyServices({
    /// If enabled, Chrome uses a web service to help resolve navigation errors.
    /// This preference's value is a boolean, defaulting to `true`.
    ChromeSetting alternateErrorPagesEnabled,

    /// If enabled, Chrome offers to automatically fill in forms. This
    /// preference's value is a boolean, defaulting to `true`.
    ChromeSetting autofillEnabled,

    /// If enabled, Chrome offers to automatically fill in addresses and other
    /// form data. This preference's value is a boolean, defaulting to `true`.
    ChromeSetting autofillAddressEnabled,

    /// If enabled, Chrome offers to automatically fill in credit card forms. This
    /// preference's value is a boolean, defaulting to `true`.
    ChromeSetting autofillCreditCardEnabled,

    /// If enabled, the password manager will ask if you want to save passwords.
    /// This preference's value is a boolean, defaulting to `true`.
    ChromeSetting passwordSavingEnabled,

    /// If enabled, Chrome does its best to protect you from phishing and malware.
    /// This preference's value is a boolean, defaulting to `true`.
    ChromeSetting safeBrowsingEnabled,

    /// If enabled, Chrome will send additional information to Google when
    /// SafeBrowsing blocks a page, such as the content of the blocked page. This
    /// preference's value is a boolean, defaulting to `false`.
    ChromeSetting safeBrowsingExtendedReportingEnabled,

    /// If enabled, Chrome sends the text you type into the Omnibox to your
    /// default search engine, which provides predictions of websites and searches
    /// that are likely completions of what you've typed so far. This preference's
    /// value is a boolean, defaulting to `true`.
    ChromeSetting searchSuggestEnabled,

    /// If enabled, Chrome uses a web service to help correct spelling errors.
    /// This preference's value is a boolean, defaulting to `false`.
    ChromeSetting spellingServiceEnabled,

    /// If enabled, Chrome offers to translate pages that aren't in a language you
    /// read. This preference's value is a boolean, defaulting to `true`.
    ChromeSetting translationServiceEnabled,
  });
}

extension PrivacyServicesExtension on PrivacyServices {
  /// If enabled, Chrome uses a web service to help resolve navigation errors.
  /// This preference's value is a boolean, defaulting to `true`.
  external ChromeSetting alternateErrorPagesEnabled;

  /// If enabled, Chrome offers to automatically fill in forms. This
  /// preference's value is a boolean, defaulting to `true`.
  external ChromeSetting autofillEnabled;

  /// If enabled, Chrome offers to automatically fill in addresses and other
  /// form data. This preference's value is a boolean, defaulting to `true`.
  external ChromeSetting autofillAddressEnabled;

  /// If enabled, Chrome offers to automatically fill in credit card forms. This
  /// preference's value is a boolean, defaulting to `true`.
  external ChromeSetting autofillCreditCardEnabled;

  /// If enabled, the password manager will ask if you want to save passwords.
  /// This preference's value is a boolean, defaulting to `true`.
  external ChromeSetting passwordSavingEnabled;

  /// If enabled, Chrome does its best to protect you from phishing and malware.
  /// This preference's value is a boolean, defaulting to `true`.
  external ChromeSetting safeBrowsingEnabled;

  /// If enabled, Chrome will send additional information to Google when
  /// SafeBrowsing blocks a page, such as the content of the blocked page. This
  /// preference's value is a boolean, defaulting to `false`.
  external ChromeSetting safeBrowsingExtendedReportingEnabled;

  /// If enabled, Chrome sends the text you type into the Omnibox to your
  /// default search engine, which provides predictions of websites and searches
  /// that are likely completions of what you've typed so far. This preference's
  /// value is a boolean, defaulting to `true`.
  external ChromeSetting searchSuggestEnabled;

  /// If enabled, Chrome uses a web service to help correct spelling errors.
  /// This preference's value is a boolean, defaulting to `false`.
  external ChromeSetting spellingServiceEnabled;

  /// If enabled, Chrome offers to translate pages that aren't in a language you
  /// read. This preference's value is a boolean, defaulting to `true`.
  external ChromeSetting translationServiceEnabled;
}

@JS()
@staticInterop
@anonymous
class PrivacyWebsites {
  external factory PrivacyWebsites({
    /// If disabled, Chrome blocks third-party sites from setting cookies. The
    /// value of this preference is of type boolean, and the default value is
    /// `true`.
    ChromeSetting thirdPartyCookiesAllowed,

    /// If enabled, the experimental [Privacy
    /// Sandbox](https://www.chromium.org/Home/chromium-privacy/privacy-sandbox)
    /// features are active. The value of this preference is of type boolean, and
    /// the default value is `true`.
    ChromeSetting privacySandboxEnabled,

    /// If disabled, the [Topics
    /// API](https://developer.chrome.com/en/docs/privacy-sandbox/topics/) is
    /// deactivated. The value of this preference is of type boolean, and the
    /// default value is `true`. Extensions may only disable this API by setting
    /// the value to `false`. If you try setting this API to `true`, it will throw
    /// an error.
    ChromeSetting topicsEnabled,

    /// If disabled, the [Fledge
    /// API](https://developer.chrome.com/docs/privacy-sandbox/fledge/) is
    /// deactivated. The value of this preference is of type boolean, and the
    /// default value is `true`. Extensions may only disable this API by setting
    /// the value to `false`. If you try setting this API to `true`, it will throw
    /// an error.
    ChromeSetting fledgeEnabled,

    /// If disabled, the [Attribution Reporting
    /// API](https://developer.chrome.com/en/docs/privacy-sandbox/attribution-reporting/)
    /// and [Private Aggregation
    /// API](https://developer.chrome.com/docs/privacy-sandbox/private-aggregation/)
    /// are deactivated. The value of this preference is of type boolean, and the
    /// default value is `true`. Extensions may only disable these APIs by setting
    /// the value to `false`. If you try setting these APIs to `true`, it will
    /// throw an error.
    ChromeSetting adMeasurementEnabled,

    /// If enabled, Chrome sends auditing pings when requested by a website (`<a
    /// ping>`). The value of this preference is of type boolean, and the default
    /// value is `true`.
    ChromeSetting hyperlinkAuditingEnabled,

    /// If enabled, Chrome sends `referer` headers with your requests. Yes, the
    /// name of this preference doesn't match the misspelled header. No, we're not
    /// going to change it. The value of this preference is of type boolean, and
    /// the default value is `true`.
    ChromeSetting referrersEnabled,

    /// If enabled, Chrome sends 'Do Not Track' (`DNT: 1`) header with your
    /// requests. The value of this preference is of type boolean, and the default
    /// value is `false`.
    ChromeSetting doNotTrackEnabled,

    /// *Available on Windows and ChromeOS only*: If enabled, Chrome provides a
    /// unique ID to plugins in order to run protected content. The value of this
    /// preference is of type boolean, and the default value is `true`.
    ChromeSetting? protectedContentEnabled,
  });
}

extension PrivacyWebsitesExtension on PrivacyWebsites {
  /// If disabled, Chrome blocks third-party sites from setting cookies. The
  /// value of this preference is of type boolean, and the default value is
  /// `true`.
  external ChromeSetting thirdPartyCookiesAllowed;

  /// If enabled, the experimental [Privacy
  /// Sandbox](https://www.chromium.org/Home/chromium-privacy/privacy-sandbox)
  /// features are active. The value of this preference is of type boolean, and
  /// the default value is `true`.
  external ChromeSetting privacySandboxEnabled;

  /// If disabled, the [Topics
  /// API](https://developer.chrome.com/en/docs/privacy-sandbox/topics/) is
  /// deactivated. The value of this preference is of type boolean, and the
  /// default value is `true`. Extensions may only disable this API by setting
  /// the value to `false`. If you try setting this API to `true`, it will throw
  /// an error.
  external ChromeSetting topicsEnabled;

  /// If disabled, the [Fledge
  /// API](https://developer.chrome.com/docs/privacy-sandbox/fledge/) is
  /// deactivated. The value of this preference is of type boolean, and the
  /// default value is `true`. Extensions may only disable this API by setting
  /// the value to `false`. If you try setting this API to `true`, it will throw
  /// an error.
  external ChromeSetting fledgeEnabled;

  /// If disabled, the [Attribution Reporting
  /// API](https://developer.chrome.com/en/docs/privacy-sandbox/attribution-reporting/)
  /// and [Private Aggregation
  /// API](https://developer.chrome.com/docs/privacy-sandbox/private-aggregation/)
  /// are deactivated. The value of this preference is of type boolean, and the
  /// default value is `true`. Extensions may only disable these APIs by setting
  /// the value to `false`. If you try setting these APIs to `true`, it will
  /// throw an error.
  external ChromeSetting adMeasurementEnabled;

  /// If enabled, Chrome sends auditing pings when requested by a website (`<a
  /// ping>`). The value of this preference is of type boolean, and the default
  /// value is `true`.
  external ChromeSetting hyperlinkAuditingEnabled;

  /// If enabled, Chrome sends `referer` headers with your requests. Yes, the
  /// name of this preference doesn't match the misspelled header. No, we're not
  /// going to change it. The value of this preference is of type boolean, and
  /// the default value is `true`.
  external ChromeSetting referrersEnabled;

  /// If enabled, Chrome sends 'Do Not Track' (`DNT: 1`) header with your
  /// requests. The value of this preference is of type boolean, and the default
  /// value is `false`.
  external ChromeSetting doNotTrackEnabled;

  /// *Available on Windows and ChromeOS only*: If enabled, Chrome provides a
  /// unique ID to plugins in order to run protected content. The value of this
  /// preference is of type boolean, and the default value is `true`.
  external ChromeSetting? protectedContentEnabled;
}
