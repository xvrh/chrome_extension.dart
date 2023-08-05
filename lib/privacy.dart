// ignore_for_file: unnecessary_parenthesis

library;

import 'src/internal_helpers.dart';
import 'src/js/privacy.dart' as $js;
import 'types.dart';

export 'src/chrome.dart' show chrome;

final _privacy = ChromePrivacy._();

extension ChromePrivacyExtension on Chrome {
  /// Use the `chrome.privacy` API to control usage of the features in Chrome
  /// that can affect a user's privacy. This API relies on the [ChromeSetting
  /// prototype of the type API](types#ChromeSetting) for getting and setting
  /// Chrome's configuration.
  ChromePrivacy get privacy => _privacy;
}

class ChromePrivacy {
  ChromePrivacy._();

  bool get isAvailable => $js.chrome.privacyNullable != null && alwaysTrue;

  /// Settings that influence Chrome's handling of network connections in
  /// general.
  PrivacyNetwork get network =>
      PrivacyNetwork.fromJS($js.chrome.privacy.network);

  /// Settings that enable or disable features that require third-party network
  /// services provided by Google and your default search provider.
  PrivacyServices get services =>
      PrivacyServices.fromJS($js.chrome.privacy.services);

  /// Settings that determine what information Chrome makes available to
  /// websites.
  PrivacyWebsites get websites =>
      PrivacyWebsites.fromJS($js.chrome.privacy.websites);
}

/// The IP handling policy of WebRTC.
enum IPHandlingPolicy {
  default$('default'),
  defaultPublicAndPrivateInterfaces('default_public_and_private_interfaces'),
  defaultPublicInterfaceOnly('default_public_interface_only'),
  disableNonProxiedUdp('disable_non_proxied_udp');

  const IPHandlingPolicy(this.value);

  final String value;

  String get toJS => value;
  static IPHandlingPolicy fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class PrivacyNetwork {
  PrivacyNetwork.fromJS(this._wrapped);

  PrivacyNetwork({
    /// If enabled, Chrome attempts to speed up your web browsing experience by
    /// pre-resolving DNS entries and preemptively opening TCP and SSL
    /// connections to servers. This preference only affects actions taken by
    /// Chrome's internal prediction service. It does not affect
    /// webpage-initiated prefectches or preconnects. This preference's value is
    /// a boolean, defaulting to `true`.
    required ChromeSetting networkPredictionEnabled,

    /// Allow users to specify the media performance/privacy tradeoffs which
    /// impacts how WebRTC traffic will be routed and how much local address
    /// information is exposed. This preference's value is of type
    /// IPHandlingPolicy, defaulting to `default`.
    required ChromeSetting webRtcipHandlingPolicy,
  }) : _wrapped = $js.PrivacyNetwork(
          networkPredictionEnabled: networkPredictionEnabled.toJS,
          webRTCIPHandlingPolicy: webRtcipHandlingPolicy.toJS,
        );

  final $js.PrivacyNetwork _wrapped;

  $js.PrivacyNetwork get toJS => _wrapped;

  /// If enabled, Chrome attempts to speed up your web browsing experience by
  /// pre-resolving DNS entries and preemptively opening TCP and SSL connections
  /// to servers. This preference only affects actions taken by Chrome's
  /// internal prediction service. It does not affect webpage-initiated
  /// prefectches or preconnects. This preference's value is a boolean,
  /// defaulting to `true`.
  ChromeSetting get networkPredictionEnabled =>
      ChromeSetting.fromJS(_wrapped.networkPredictionEnabled);
  set networkPredictionEnabled(ChromeSetting v) {
    _wrapped.networkPredictionEnabled = v.toJS;
  }

  /// Allow users to specify the media performance/privacy tradeoffs which
  /// impacts how WebRTC traffic will be routed and how much local address
  /// information is exposed. This preference's value is of type
  /// IPHandlingPolicy, defaulting to `default`.
  ChromeSetting get webRtcipHandlingPolicy =>
      ChromeSetting.fromJS(_wrapped.webRTCIPHandlingPolicy);
  set webRtcipHandlingPolicy(ChromeSetting v) {
    _wrapped.webRTCIPHandlingPolicy = v.toJS;
  }
}

class PrivacyServices {
  PrivacyServices.fromJS(this._wrapped);

  PrivacyServices({
    /// If enabled, Chrome uses a web service to help resolve navigation errors.
    /// This preference's value is a boolean, defaulting to `true`.
    required ChromeSetting alternateErrorPagesEnabled,

    /// If enabled, Chrome offers to automatically fill in forms. This
    /// preference's value is a boolean, defaulting to `true`.
    required ChromeSetting autofillEnabled,

    /// If enabled, Chrome offers to automatically fill in addresses and other
    /// form data. This preference's value is a boolean, defaulting to `true`.
    required ChromeSetting autofillAddressEnabled,

    /// If enabled, Chrome offers to automatically fill in credit card forms.
    /// This preference's value is a boolean, defaulting to `true`.
    required ChromeSetting autofillCreditCardEnabled,

    /// If enabled, the password manager will ask if you want to save passwords.
    /// This preference's value is a boolean, defaulting to `true`.
    required ChromeSetting passwordSavingEnabled,

    /// If enabled, Chrome does its best to protect you from phishing and
    /// malware. This preference's value is a boolean, defaulting to `true`.
    required ChromeSetting safeBrowsingEnabled,

    /// If enabled, Chrome will send additional information to Google when
    /// SafeBrowsing blocks a page, such as the content of the blocked page.
    /// This preference's value is a boolean, defaulting to `false`.
    required ChromeSetting safeBrowsingExtendedReportingEnabled,

    /// If enabled, Chrome sends the text you type into the Omnibox to your
    /// default search engine, which provides predictions of websites and
    /// searches that are likely completions of what you've typed so far. This
    /// preference's value is a boolean, defaulting to `true`.
    required ChromeSetting searchSuggestEnabled,

    /// If enabled, Chrome uses a web service to help correct spelling errors.
    /// This preference's value is a boolean, defaulting to `false`.
    required ChromeSetting spellingServiceEnabled,

    /// If enabled, Chrome offers to translate pages that aren't in a language
    /// you read. This preference's value is a boolean, defaulting to `true`.
    required ChromeSetting translationServiceEnabled,
  }) : _wrapped = $js.PrivacyServices(
          alternateErrorPagesEnabled: alternateErrorPagesEnabled.toJS,
          autofillEnabled: autofillEnabled.toJS,
          autofillAddressEnabled: autofillAddressEnabled.toJS,
          autofillCreditCardEnabled: autofillCreditCardEnabled.toJS,
          passwordSavingEnabled: passwordSavingEnabled.toJS,
          safeBrowsingEnabled: safeBrowsingEnabled.toJS,
          safeBrowsingExtendedReportingEnabled:
              safeBrowsingExtendedReportingEnabled.toJS,
          searchSuggestEnabled: searchSuggestEnabled.toJS,
          spellingServiceEnabled: spellingServiceEnabled.toJS,
          translationServiceEnabled: translationServiceEnabled.toJS,
        );

  final $js.PrivacyServices _wrapped;

  $js.PrivacyServices get toJS => _wrapped;

  /// If enabled, Chrome uses a web service to help resolve navigation errors.
  /// This preference's value is a boolean, defaulting to `true`.
  ChromeSetting get alternateErrorPagesEnabled =>
      ChromeSetting.fromJS(_wrapped.alternateErrorPagesEnabled);
  set alternateErrorPagesEnabled(ChromeSetting v) {
    _wrapped.alternateErrorPagesEnabled = v.toJS;
  }

  /// If enabled, Chrome offers to automatically fill in forms. This
  /// preference's value is a boolean, defaulting to `true`.
  ChromeSetting get autofillEnabled =>
      ChromeSetting.fromJS(_wrapped.autofillEnabled);
  set autofillEnabled(ChromeSetting v) {
    _wrapped.autofillEnabled = v.toJS;
  }

  /// If enabled, Chrome offers to automatically fill in addresses and other
  /// form data. This preference's value is a boolean, defaulting to `true`.
  ChromeSetting get autofillAddressEnabled =>
      ChromeSetting.fromJS(_wrapped.autofillAddressEnabled);
  set autofillAddressEnabled(ChromeSetting v) {
    _wrapped.autofillAddressEnabled = v.toJS;
  }

  /// If enabled, Chrome offers to automatically fill in credit card forms. This
  /// preference's value is a boolean, defaulting to `true`.
  ChromeSetting get autofillCreditCardEnabled =>
      ChromeSetting.fromJS(_wrapped.autofillCreditCardEnabled);
  set autofillCreditCardEnabled(ChromeSetting v) {
    _wrapped.autofillCreditCardEnabled = v.toJS;
  }

  /// If enabled, the password manager will ask if you want to save passwords.
  /// This preference's value is a boolean, defaulting to `true`.
  ChromeSetting get passwordSavingEnabled =>
      ChromeSetting.fromJS(_wrapped.passwordSavingEnabled);
  set passwordSavingEnabled(ChromeSetting v) {
    _wrapped.passwordSavingEnabled = v.toJS;
  }

  /// If enabled, Chrome does its best to protect you from phishing and malware.
  /// This preference's value is a boolean, defaulting to `true`.
  ChromeSetting get safeBrowsingEnabled =>
      ChromeSetting.fromJS(_wrapped.safeBrowsingEnabled);
  set safeBrowsingEnabled(ChromeSetting v) {
    _wrapped.safeBrowsingEnabled = v.toJS;
  }

  /// If enabled, Chrome will send additional information to Google when
  /// SafeBrowsing blocks a page, such as the content of the blocked page. This
  /// preference's value is a boolean, defaulting to `false`.
  ChromeSetting get safeBrowsingExtendedReportingEnabled =>
      ChromeSetting.fromJS(_wrapped.safeBrowsingExtendedReportingEnabled);
  set safeBrowsingExtendedReportingEnabled(ChromeSetting v) {
    _wrapped.safeBrowsingExtendedReportingEnabled = v.toJS;
  }

  /// If enabled, Chrome sends the text you type into the Omnibox to your
  /// default search engine, which provides predictions of websites and searches
  /// that are likely completions of what you've typed so far. This preference's
  /// value is a boolean, defaulting to `true`.
  ChromeSetting get searchSuggestEnabled =>
      ChromeSetting.fromJS(_wrapped.searchSuggestEnabled);
  set searchSuggestEnabled(ChromeSetting v) {
    _wrapped.searchSuggestEnabled = v.toJS;
  }

  /// If enabled, Chrome uses a web service to help correct spelling errors.
  /// This preference's value is a boolean, defaulting to `false`.
  ChromeSetting get spellingServiceEnabled =>
      ChromeSetting.fromJS(_wrapped.spellingServiceEnabled);
  set spellingServiceEnabled(ChromeSetting v) {
    _wrapped.spellingServiceEnabled = v.toJS;
  }

  /// If enabled, Chrome offers to translate pages that aren't in a language you
  /// read. This preference's value is a boolean, defaulting to `true`.
  ChromeSetting get translationServiceEnabled =>
      ChromeSetting.fromJS(_wrapped.translationServiceEnabled);
  set translationServiceEnabled(ChromeSetting v) {
    _wrapped.translationServiceEnabled = v.toJS;
  }
}

class PrivacyWebsites {
  PrivacyWebsites.fromJS(this._wrapped);

  PrivacyWebsites({
    /// If disabled, Chrome blocks third-party sites from setting cookies. The
    /// value of this preference is of type boolean, and the default value is
    /// `true`.
    required ChromeSetting thirdPartyCookiesAllowed,

    /// If enabled, the experimental [Privacy
    /// Sandbox](https://www.chromium.org/Home/chromium-privacy/privacy-sandbox)
    /// features are active. The value of this preference is of type boolean,
    /// and the default value is `true`.
    required ChromeSetting privacySandboxEnabled,

    /// If disabled, the [Topics
    /// API](https://developer.chrome.com/en/docs/privacy-sandbox/topics/) is
    /// deactivated. The value of this preference is of type boolean, and the
    /// default value is `true`. Extensions may only disable this API by setting
    /// the value to `false`. If you try setting this API to `true`, it will
    /// throw an error.
    required ChromeSetting topicsEnabled,

    /// If disabled, the [Fledge
    /// API](https://developer.chrome.com/docs/privacy-sandbox/fledge/) is
    /// deactivated. The value of this preference is of type boolean, and the
    /// default value is `true`. Extensions may only disable this API by setting
    /// the value to `false`. If you try setting this API to `true`, it will
    /// throw an error.
    required ChromeSetting fledgeEnabled,

    /// If disabled, the [Attribution Reporting
    /// API](https://developer.chrome.com/en/docs/privacy-sandbox/attribution-reporting/)
    /// and [Private Aggregation
    /// API](https://developer.chrome.com/docs/privacy-sandbox/private-aggregation/)
    /// are deactivated. The value of this preference is of type boolean, and
    /// the default value is `true`. Extensions may only disable these APIs by
    /// setting the value to `false`. If you try setting these APIs to `true`,
    /// it will throw an error.
    required ChromeSetting adMeasurementEnabled,

    /// If enabled, Chrome sends auditing pings when requested by a website (`<a
    /// ping>`). The value of this preference is of type boolean, and the
    /// default value is `true`.
    required ChromeSetting hyperlinkAuditingEnabled,

    /// If enabled, Chrome sends `referer` headers with your requests. Yes, the
    /// name of this preference doesn't match the misspelled header. No, we're
    /// not going to change it. The value of this preference is of type boolean,
    /// and the default value is `true`.
    required ChromeSetting referrersEnabled,

    /// If enabled, Chrome sends 'Do Not Track' (`DNT: 1`) header with your
    /// requests. The value of this preference is of type boolean, and the
    /// default value is `false`.
    required ChromeSetting doNotTrackEnabled,

    /// *Available on Windows and ChromeOS only*: If enabled, Chrome provides a
    /// unique ID to plugins in order to run protected content. The value of
    /// this preference is of type boolean, and the default value is `true`.
    ChromeSetting? protectedContentEnabled,
  }) : _wrapped = $js.PrivacyWebsites(
          thirdPartyCookiesAllowed: thirdPartyCookiesAllowed.toJS,
          privacySandboxEnabled: privacySandboxEnabled.toJS,
          topicsEnabled: topicsEnabled.toJS,
          fledgeEnabled: fledgeEnabled.toJS,
          adMeasurementEnabled: adMeasurementEnabled.toJS,
          hyperlinkAuditingEnabled: hyperlinkAuditingEnabled.toJS,
          referrersEnabled: referrersEnabled.toJS,
          doNotTrackEnabled: doNotTrackEnabled.toJS,
          protectedContentEnabled: protectedContentEnabled?.toJS,
        );

  final $js.PrivacyWebsites _wrapped;

  $js.PrivacyWebsites get toJS => _wrapped;

  /// If disabled, Chrome blocks third-party sites from setting cookies. The
  /// value of this preference is of type boolean, and the default value is
  /// `true`.
  ChromeSetting get thirdPartyCookiesAllowed =>
      ChromeSetting.fromJS(_wrapped.thirdPartyCookiesAllowed);
  set thirdPartyCookiesAllowed(ChromeSetting v) {
    _wrapped.thirdPartyCookiesAllowed = v.toJS;
  }

  /// If enabled, the experimental [Privacy
  /// Sandbox](https://www.chromium.org/Home/chromium-privacy/privacy-sandbox)
  /// features are active. The value of this preference is of type boolean, and
  /// the default value is `true`.
  ChromeSetting get privacySandboxEnabled =>
      ChromeSetting.fromJS(_wrapped.privacySandboxEnabled);
  set privacySandboxEnabled(ChromeSetting v) {
    _wrapped.privacySandboxEnabled = v.toJS;
  }

  /// If disabled, the [Topics
  /// API](https://developer.chrome.com/en/docs/privacy-sandbox/topics/) is
  /// deactivated. The value of this preference is of type boolean, and the
  /// default value is `true`. Extensions may only disable this API by setting
  /// the value to `false`. If you try setting this API to `true`, it will throw
  /// an error.
  ChromeSetting get topicsEnabled =>
      ChromeSetting.fromJS(_wrapped.topicsEnabled);
  set topicsEnabled(ChromeSetting v) {
    _wrapped.topicsEnabled = v.toJS;
  }

  /// If disabled, the [Fledge
  /// API](https://developer.chrome.com/docs/privacy-sandbox/fledge/) is
  /// deactivated. The value of this preference is of type boolean, and the
  /// default value is `true`. Extensions may only disable this API by setting
  /// the value to `false`. If you try setting this API to `true`, it will throw
  /// an error.
  ChromeSetting get fledgeEnabled =>
      ChromeSetting.fromJS(_wrapped.fledgeEnabled);
  set fledgeEnabled(ChromeSetting v) {
    _wrapped.fledgeEnabled = v.toJS;
  }

  /// If disabled, the [Attribution Reporting
  /// API](https://developer.chrome.com/en/docs/privacy-sandbox/attribution-reporting/)
  /// and [Private Aggregation
  /// API](https://developer.chrome.com/docs/privacy-sandbox/private-aggregation/)
  /// are deactivated. The value of this preference is of type boolean, and the
  /// default value is `true`. Extensions may only disable these APIs by setting
  /// the value to `false`. If you try setting these APIs to `true`, it will
  /// throw an error.
  ChromeSetting get adMeasurementEnabled =>
      ChromeSetting.fromJS(_wrapped.adMeasurementEnabled);
  set adMeasurementEnabled(ChromeSetting v) {
    _wrapped.adMeasurementEnabled = v.toJS;
  }

  /// If enabled, Chrome sends auditing pings when requested by a website (`<a
  /// ping>`). The value of this preference is of type boolean, and the default
  /// value is `true`.
  ChromeSetting get hyperlinkAuditingEnabled =>
      ChromeSetting.fromJS(_wrapped.hyperlinkAuditingEnabled);
  set hyperlinkAuditingEnabled(ChromeSetting v) {
    _wrapped.hyperlinkAuditingEnabled = v.toJS;
  }

  /// If enabled, Chrome sends `referer` headers with your requests. Yes, the
  /// name of this preference doesn't match the misspelled header. No, we're not
  /// going to change it. The value of this preference is of type boolean, and
  /// the default value is `true`.
  ChromeSetting get referrersEnabled =>
      ChromeSetting.fromJS(_wrapped.referrersEnabled);
  set referrersEnabled(ChromeSetting v) {
    _wrapped.referrersEnabled = v.toJS;
  }

  /// If enabled, Chrome sends 'Do Not Track' (`DNT: 1`) header with your
  /// requests. The value of this preference is of type boolean, and the default
  /// value is `false`.
  ChromeSetting get doNotTrackEnabled =>
      ChromeSetting.fromJS(_wrapped.doNotTrackEnabled);
  set doNotTrackEnabled(ChromeSetting v) {
    _wrapped.doNotTrackEnabled = v.toJS;
  }

  /// *Available on Windows and ChromeOS only*: If enabled, Chrome provides a
  /// unique ID to plugins in order to run protected content. The value of this
  /// preference is of type boolean, and the default value is `true`.
  ChromeSetting? get protectedContentEnabled =>
      _wrapped.protectedContentEnabled?.let(ChromeSetting.fromJS);
  set protectedContentEnabled(ChromeSetting? v) {
    _wrapped.protectedContentEnabled = v?.toJS;
  }
}
