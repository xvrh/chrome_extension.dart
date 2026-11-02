// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import
// ignore_for_file: unintended_html_in_doc_comment

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'extension_types.dart';

export 'chrome.dart';

extension JSChromeJSDeclarativeNetRequestExtension on JSChrome {
  @JS('declarativeNetRequest')
  external JSDeclarativeNetRequest? get declarativeNetRequestNullable;

  /// The `chrome.declarativeNetRequest` API is used to block or modify
  /// network requests by specifying declarative rules. This lets extensions
  /// modify network requests without intercepting them and viewing their
  /// content,
  /// thus providing more privacy.
  JSDeclarativeNetRequest get declarativeNetRequest {
    var declarativeNetRequestNullable = this.declarativeNetRequestNullable;
    if (declarativeNetRequestNullable == null) {
      throw ApiNotAvailableException('chrome.declarativeNetRequest');
    }
    return declarativeNetRequestNullable;
  }
}

extension type JSDeclarativeNetRequest._(JSObject _) {
  /// Modifies the current set of dynamic rules for the extension.
  /// The rules with IDs listed in `options.removeRuleIds` are first
  /// removed, and then the rules given in `options.addRules` are
  /// added. Notes:
  /// <ul>
  /// <li>This update happens as a single atomic operation: either all
  /// specified rules are added and removed, or an error is returned.</li>
  /// <li>These rules are persisted across browser sessions and across
  /// extension updates.</li>
  /// <li>Static rules specified as part of the extension package can not be
  /// removed using this function.</li>
  /// <li>[MAX_NUMBER_OF_DYNAMIC_RULES] is the maximum number
  /// of dynamic rules an extension can add. The number of
  /// [unsafe rules](#safe_rules) must not exceed
  /// [MAX_NUMBER_OF_UNSAFE_DYNAMIC_RULES].</li>
  /// </ul>
  /// |Returns|: Promise that resolves once the update is complete.
  /// In case of an error, the promise will be rejected and no change will be
  /// made to the rule set. This can happen for multiple reasons, such as
  /// invalid rule format, duplicate rule ID, rule count limit exceeded,
  /// internal errors, and others.
  external JSPromise updateDynamicRules(UpdateRuleOptions options);

  /// Returns the current set of dynamic rules for the extension. Callers can
  /// optionally filter the list of fetched rules by specifying a
  /// `filter`.
  /// |filter|: An object to filter the list of fetched rules.
  /// |Returns|: Promise that resolves with the set of dynamic rules. The
  /// Promise may be rejected in case of transient internal errors.
  external JSPromise<JSArray> getDynamicRules(GetRulesFilter? filter);

  /// Modifies the current set of session scoped rules for the extension.
  /// The rules with IDs listed in `options.removeRuleIds` are first
  /// removed, and then the rules given in `options.addRules` are
  /// added. Notes:
  /// <ul>
  /// <li>This update happens as a single atomic operation: either all
  /// specified rules are added and removed, or an error is returned.</li>
  /// <li>These rules are not persisted across sessions and are backed in
  /// memory.</li>
  /// <li>[MAX_NUMBER_OF_SESSION_RULES] is the maximum number
  /// of session rules an extension can add.</li>
  /// </ul>
  /// |Returns|: Promise that resolves once the update is complete. In case
  /// of an error, the promise will be rejected and no change will be
  /// made to the rule set. This can happen for multiple reasons, such as
  /// invalid rule format, duplicate rule ID, rule count limit exceeded, and
  /// others.
  external JSPromise updateSessionRules(UpdateRuleOptions options);

  /// Returns the current set of session scoped rules for the extension.
  /// Callers can optionally filter the list of fetched rules by specifying a
  /// `filter`.
  /// |filter|: An object to filter the list of fetched rules.
  /// |Returns|: Promise that resolves with the set of session scoped rules.
  external JSPromise<JSArray> getSessionRules(GetRulesFilter? filter);

  /// Updates the set of enabled static rulesets for the extension. The
  /// rulesets with IDs listed in `options.disableRulesetIds` are
  /// first removed, and then the rulesets listed in
  /// `options.enableRulesetIds` are added.<br/>
  /// Note that the set of enabled static rulesets is persisted across sessions
  /// but not across extension updates, i.e. the `rule_resources`
  /// manifest key will determine the set of enabled static rulesets on each
  /// extension update.
  /// |Returns|: Promise that resolves once the update is complete. In case of
  /// an error, the promise will be rejected and no change will be made to the
  /// set of enabled rulesets. This can happen for multiple reasons, such as
  /// invalid ruleset IDs, rule count limit exceeded, or internal errors.
  external JSPromise updateEnabledRulesets(UpdateRulesetOptions options);

  /// Returns the ids for the current set of enabled static rulesets.
  /// |Returns|: Promise that resolves with a list of ids, where each id
  /// corresponds to an enabled static [Ruleset].
  external JSPromise<JSArray> getEnabledRulesets();

  /// Disables and enables individual static rules in a [Ruleset].
  /// Changes to rules belonging to a disabled [Ruleset] will take
  /// effect the next time that it becomes enabled.
  /// |Returns|: Promise that resolves when the update is complete. In case of
  /// an error, the promise will be rejected and no change will be made to the
  /// enabled static rules.
  external JSPromise updateStaticRules(UpdateStaticRulesOptions options);

  /// Returns the list of static rules in the given [Ruleset] that are
  /// currently disabled.
  /// |options|: Specifies the ruleset to query.
  /// |Returns|: Promise that resolves with a list of ids that correspond to
  ///  the disabled rules in that ruleset.
  external JSPromise<JSArray> getDisabledRuleIds(
      GetDisabledRuleIdsOptions options);

  /// Returns all rules matched for the extension. Callers can optionally
  /// filter the list of matched rules by specifying a `filter`.
  /// This method is only available to extensions with the
  /// `"declarativeNetRequestFeedback"` permission or having the
  /// `"activeTab"` permission granted for the `tabId`
  /// specified in `filter`.
  /// Note: Rules not associated with an active document that were matched more
  /// than five minutes ago will not be returned.
  /// |filter|: An object to filter the list of matched rules.
  /// |Returns|: Promise that resolves once the list of matched rules has been
  /// fetched. In case of an error, the Promise will be rejected. This can
  /// happen for multiple reasons, such as insufficient permissions, or
  /// exceeding the quota.
  external JSPromise<RulesMatchedDetails> getMatchedRules(
      MatchedRulesFilter? filter);

  /// Configures if the action count for tabs should be displayed as the
  /// extension action's badge text and provides a way for that action count to
  /// be incremented.
  external JSPromise setExtensionActionOptions(ExtensionActionOptions options);

  /// Checks if the given regular expression will be supported as a
  /// `regexFilter` rule condition.
  /// |regexOptions|: The regular expression to check.
  /// |Returns|: Promise that resolves with details consisting of whether the
  /// regular expression is supported and the reason if not.
  external JSPromise<IsRegexSupportedResult> isRegexSupported(
      RegexOptions regexOptions);

  /// Returns the number of static rules an extension can enable before the
  /// [global static rule limit](#global-static-rule-limit) is
  /// reached.
  external JSPromise<JSNumber> getAvailableStaticRuleCount();

  /// Checks if any of the extension's declarativeNetRequest rules would match
  /// a hypothetical request.
  /// Note: Only available for unpacked extensions as this is only intended to
  /// be used during extension development.
  /// |requestDetails|: The request details to test.
  /// |Returns|: Promise that resolves with the details of matched rules.
  external JSPromise<TestMatchOutcomeResult> testMatchOutcome(
      TestMatchRequestDetails request);

  /// Fired when a rule is matched with a request. Only available for unpacked
  /// extensions with the `"declarativeNetRequestFeedback"` permission
  /// as this is intended to be used for debugging purposes only.
  external Event get onRuleMatchedDebug;

  /// The minimum number of static rules guaranteed to an extension across its
  /// enabled static rulesets. Any rules above this limit will count towards
  /// the [global static rule limit](#global-static-rule-limit).
  external int get GUARANTEED_MINIMUM_STATIC_RULES;

  /// The maximum number of combined dynamic and session scoped rules an
  /// extension can add.
  external int get MAX_NUMBER_OF_DYNAMIC_AND_SESSION_RULES;

  /// The maximum number of dynamic rules that an extension can add.
  external int get MAX_NUMBER_OF_DYNAMIC_RULES;

  /// The maximum number of "unsafe" dynamic rules that an extension can add.
  external int get MAX_NUMBER_OF_UNSAFE_DYNAMIC_RULES;

  /// The maximum number of session scoped rules that an extension can add.
  external int get MAX_NUMBER_OF_SESSION_RULES;

  /// The maximum number of "unsafe" session scoped rules that an extension can
  /// add.
  external int get MAX_NUMBER_OF_UNSAFE_SESSION_RULES;

  /// Time interval within which `MAX_GETMATCHEDRULES_CALLS_PER_INTERVAL
  /// getMatchedRules` calls can be made, specified in minutes.
  /// Additional calls will fail immediately and set [runtime.lastError].
  /// Note: `getMatchedRules` calls associated with a user gesture
  /// are exempt from the quota.
  external int get GETMATCHEDRULES_QUOTA_INTERVAL;

  /// The number of times `getMatchedRules` can be called within a
  /// period of `GETMATCHEDRULES_QUOTA_INTERVAL`.
  external int get MAX_GETMATCHEDRULES_CALLS_PER_INTERVAL;

  /// The maximum number of regular expression rules that an extension can
  /// add. This limit is evaluated separately for the set of dynamic rules and
  /// those specified in the rule resources file.
  external int get MAX_NUMBER_OF_REGEX_RULES;

  /// The maximum number of static `Rulesets` an extension can
  /// specify as part of the `"rule_resources"` manifest key.
  external int get MAX_NUMBER_OF_STATIC_RULESETS;

  /// The maximum number of static `Rulesets` an extension can
  /// enable at any one time.
  external int get MAX_NUMBER_OF_ENABLED_STATIC_RULESETS;

  /// Ruleset ID for the dynamic rules added by the extension.
  external String get DYNAMIC_RULESET_ID;

  /// Ruleset ID for the session-scoped rules added by the extension.
  external String get SESSION_RULESET_ID;
}

/// This describes the resource type of the network request.
typedef ResourceType = JSString;

/// This describes the HTTP request method of a network request.
typedef RequestMethod = JSString;

/// This describes whether the request is first or third party to the frame in
/// which it originated. A request is said to be first party if it has the same
/// domain (eTLD+1) as the frame in which the request originated.
typedef DomainType = JSString;

/// This describes the possible operations for a "modifyHeaders" rule.
typedef HeaderOperation = JSString;

/// Describes the kind of action to take if a given RuleCondition matches.
typedef RuleActionType = JSString;

/// Describes the reason why a given regular expression isn't supported.
typedef UnsupportedRegexReason = JSString;

/// <!-- Lists the types of condition currently supported by RuleCondition, to
/// aid feature detection. Must be kept consistent with the RuleCondition
/// dictionary. -->
typedef RuleConditionKeys = JSString;
extension type Ruleset._(JSObject _) implements JSObject {
  external factory Ruleset({
    /// A non-empty string uniquely identifying the ruleset. IDs beginning with
    /// '_' are reserved for internal use.
    String id,

    /// The path of the JSON ruleset relative to the extension directory.
    String path,

    /// Whether the ruleset is enabled by default.
    bool enabled,
  });

  /// A non-empty string uniquely identifying the ruleset. IDs beginning with
  /// '_' are reserved for internal use.
  external String id;

  /// The path of the JSON ruleset relative to the extension directory.
  external String path;

  /// Whether the ruleset is enabled by default.
  external bool enabled;
}
extension type QueryKeyValue._(JSObject _) implements JSObject {
  external factory QueryKeyValue({
    String key,
    String value,

    /// If true, the query key is replaced only if it's already present.
    /// Otherwise, the key is also added if it's missing. Defaults to false.
    bool? replaceOnly,
  });

  external String key;

  external String value;

  /// If true, the query key is replaced only if it's already present.
  /// Otherwise, the key is also added if it's missing. Defaults to false.
  external bool? replaceOnly;
}
extension type QueryTransform._(JSObject _) implements JSObject {
  external factory QueryTransform({
    /// The list of query keys to be removed.
    JSArray? removeParams,

    /// The list of query key-value pairs to be added or replaced.
    JSArray? addOrReplaceParams,
  });

  /// The list of query keys to be removed.
  external JSArray? removeParams;

  /// The list of query key-value pairs to be added or replaced.
  external JSArray? addOrReplaceParams;
}
extension type URLTransform._(JSObject _) implements JSObject {
  external factory URLTransform({
    /// The new scheme for the request. Allowed values are "http", "https",
    /// "ftp" and "chrome-extension".
    String? scheme,

    /// The new host for the request.
    String? host,

    /// The new port for the request. If empty, the existing port is cleared.
    String? port,

    /// The new path for the request. If empty, the existing path is cleared.
    String? path,

    /// The new query for the request. Should be either empty, in which case the
    /// existing query is cleared; or should begin with '?'.
    String? query,

    /// Add, remove or replace query key-value pairs.
    QueryTransform? queryTransform,

    /// The new fragment for the request. Should be either empty, in which case
    /// the existing fragment is cleared; or should begin with '#'.
    String? fragment,

    /// The new username for the request.
    String? username,

    /// The new password for the request.
    String? password,
  });

  /// The new scheme for the request. Allowed values are "http", "https",
  /// "ftp" and "chrome-extension".
  external String? scheme;

  /// The new host for the request.
  external String? host;

  /// The new port for the request. If empty, the existing port is cleared.
  external String? port;

  /// The new path for the request. If empty, the existing path is cleared.
  external String? path;

  /// The new query for the request. Should be either empty, in which case the
  /// existing query is cleared; or should begin with '?'.
  external String? query;

  /// Add, remove or replace query key-value pairs.
  external QueryTransform? queryTransform;

  /// The new fragment for the request. Should be either empty, in which case
  /// the existing fragment is cleared; or should begin with '#'.
  external String? fragment;

  /// The new username for the request.
  external String? username;

  /// The new password for the request.
  external String? password;
}
extension type Redirect._(JSObject _) implements JSObject {
  external factory Redirect({
    /// Path relative to the extension directory. Should start with '/'.
    String? extensionPath,

    /// Url transformations to perform.
    URLTransform? transform,

    /// The redirect url. Redirects to JavaScript urls are not allowed.
    String? url,

    /// Substitution pattern for rules which specify a `regexFilter`.
    /// The first match of `regexFilter` within the url will be
    /// replaced with this pattern. Within `regexSubstitution`,
    /// backslash-escaped digits (\1 to \9) can be used to insert the
    /// corresponding capture groups. \0 refers to the entire matching text.
    String? regexSubstitution,
  });

  /// Path relative to the extension directory. Should start with '/'.
  external String? extensionPath;

  /// Url transformations to perform.
  external URLTransform? transform;

  /// The redirect url. Redirects to JavaScript urls are not allowed.
  external String? url;

  /// Substitution pattern for rules which specify a `regexFilter`.
  /// The first match of `regexFilter` within the url will be
  /// replaced with this pattern. Within `regexSubstitution`,
  /// backslash-escaped digits (\1 to \9) can be used to insert the
  /// corresponding capture groups. \0 refers to the entire matching text.
  external String? regexSubstitution;
}
extension type HeaderInfo._(JSObject _) implements JSObject {
  external factory HeaderInfo({
    /// The name of the header. This condition matches on the name
    /// only if both `values` and `excludedValues` are not specified.
    String header,

    /// If specified, this condition matches if the header's value matches at
    /// least one pattern in this list. This supports case-insensitive header
    /// value matching plus the following constructs:
    ///
    /// **'*'**  : Matches any number of characters.
    ///
    /// **'?'**  : Matches zero or one character(s).
    ///
    /// '*' and '?' can be escaped with a backslash, e.g. '\*' and '\?'
    JSArray? values,

    /// If specified, this condition is not matched if the header exists but its
    /// value contains at least one element in this list. This uses the same
    /// match pattern syntax as `values`.
    JSArray? excludedValues,
  });

  /// The name of the header. This condition matches on the name
  /// only if both `values` and `excludedValues` are not specified.
  external String header;

  /// If specified, this condition matches if the header's value matches at
  /// least one pattern in this list. This supports case-insensitive header
  /// value matching plus the following constructs:
  ///
  /// **'*'**  : Matches any number of characters.
  ///
  /// **'?'**  : Matches zero or one character(s).
  ///
  /// '*' and '?' can be escaped with a backslash, e.g. '\*' and '\?'
  external JSArray? values;

  /// If specified, this condition is not matched if the header exists but its
  /// value contains at least one element in this list. This uses the same
  /// match pattern syntax as `values`.
  external JSArray? excludedValues;
}
extension type RuleCondition._(JSObject _) implements JSObject {
  external factory RuleCondition({
    /// The pattern which is matched against the network request url.
    /// Supported constructs:
    ///
    /// **'*'**  : Wildcard: Matches any number of characters.
    ///
    /// **'|'**  : Left/right anchor: If used at either end of the pattern,
    ///               specifies the beginning/end of the url respectively.
    ///
    /// **'||'** : Domain name anchor: If used at the beginning of the
    ///               pattern, specifies the start of a (sub-)domain of the URL.
    ///
    /// **'^'**  : Separator character: This matches anything except a letter,
    ///               a digit, or one of the following: `_`,
    ///               `-`, `.`, or `%`. This
    ///               also match the end of the URL.
    ///
    /// Therefore `urlFilter` is composed of the following parts:
    /// (optional Left/Domain name anchor) + pattern + (optional Right anchor).
    ///
    /// If omitted, all urls are matched. An empty string is not allowed.
    ///
    /// A pattern beginning with `||*` is not allowed. Use
    /// `*` instead.
    ///
    /// Note: Only one of `urlFilter` or `regexFilter` can
    /// be specified.
    ///
    /// Note: The `urlFilter` must be composed of only ASCII
    /// characters. This is matched against a url where the host is encoded in
    /// the punycode format (in case of internationalized domains) and any other
    /// non-ascii characters are url encoded in utf-8.
    /// For example, when the request url is
    /// http://abc.&#x0440;&#x0444;?q=&#x0444;, the
    /// `urlFilter` will be matched against the url
    /// http://abc.xn--p1ai/?q=%D1%84.
    String? urlFilter,

    /// Regular expression to match against the network request url. This follows
    /// the <a href = "https://github.com/google/re2/wiki/Syntax">RE2 syntax</a>.
    ///
    /// Note: Only one of `urlFilter` or `regexFilter` can
    /// be specified.
    ///
    /// Note: The `regexFilter` must be composed of only ASCII
    /// characters. This is matched against a url where the host is encoded in
    /// the punycode format (in case of internationalized domains) and any other
    /// non-ascii characters are url encoded in utf-8.
    String? regexFilter,

    /// Whether the `urlFilter` or `regexFilter`
    /// (whichever is specified) is case sensitive. Default is false.
    bool? isUrlFilterCaseSensitive,

    /// The rule will only match network requests originating from the list of
    /// `initiatorDomains`. If the list is omitted, the rule is
    /// applied to requests from all domains. An empty list is not allowed.
    ///
    /// Notes:
    /// <ul>
    ///  <li>Sub-domains like "a.example.com" are also allowed.</li>
    ///  <li>The entries must consist of only ascii characters.</li>
    ///  <li>Use punycode encoding for internationalized domains.</li>
    ///  <li>
    ///    This matches against the request initiator and not the request url.
    ///  </li>
    ///  <li>Sub-domains of the listed domains are also matched.</li>
    /// </ul>
    JSArray? initiatorDomains,

    /// The rule will not match network requests originating from the list of
    /// `excludedInitiatorDomains`. If the list is empty or omitted,
    /// no domains are excluded. This takes precedence over
    /// `initiatorDomains`.
    ///
    /// Notes:
    /// <ul>
    ///  <li>Sub-domains like "a.example.com" are also allowed.</li>
    ///  <li>The entries must consist of only ascii characters.</li>
    ///  <li>Use punycode encoding for internationalized domains.</li>
    ///  <li>
    ///    This matches against the request initiator and not the request url.
    ///  </li>
    ///  <li>Sub-domains of the listed domains are also excluded.</li>
    /// </ul>
    JSArray? excludedInitiatorDomains,

    /// The rule will only match network requests when the domain matches one
    /// from the list of `requestDomains`. If the list is omitted,
    /// the rule is applied to requests from all domains. An empty list is not
    /// allowed.
    ///
    /// Notes:
    /// <ul>
    ///  <li>Sub-domains like "a.example.com" are also allowed.</li>
    ///  <li>The entries must consist of only ascii characters.</li>
    ///  <li>Use punycode encoding for internationalized domains.</li>
    ///  <li>Sub-domains of the listed domains are also matched.</li>
    /// </ul>
    JSArray? requestDomains,

    /// The rule will not match network requests when the domains matches one
    /// from the list of `excludedRequestDomains`. If the list is
    /// empty or omitted, no domains are excluded. This takes precedence over
    /// `requestDomains`.
    ///
    /// Notes:
    /// <ul>
    ///  <li>Sub-domains like "a.example.com" are also allowed.</li>
    ///  <li>The entries must consist of only ascii characters.</li>
    ///  <li>Use punycode encoding for internationalized domains.</li>
    ///  <li>Sub-domains of the listed domains are also excluded.</li>
    /// </ul>
    JSArray? excludedRequestDomains,

    /// The rule will only match network requests when the associated top-level
    /// frame's domain matches one from the list of `topDomains`. If
    /// the list is omitted, the rule is applied to requests associated with all
    /// top-level frame domains. An empty list is not allowed.
    ///
    /// Notes:
    /// <ul>
    ///  <li>Sub-domains like "a.example.com" are also allowed.</li>
    ///  <li>The entries must consist of only ascii characters.</li>
    ///  <li>Use punycode encoding for internationalized domains.</li>
    ///  <li>Sub-domains of the listed domains are also matched.</li>
    ///  <li>For requests with no associated top-level frame (e.g. ServiceWorker
    ///      initiated requests, the request initiator's domain is considered
    ///      instead.</li>
    /// </ul>
    JSArray? topDomains,

    /// The rule will not match network requests when the associated top-level
    /// frame's domain matches one from the list of
    /// `excludedTopDomains`. If the list is empty or omitted, no
    /// domains are excluded. This takes precedence over
    /// `topDomains`.
    ///
    /// Notes:
    /// <ul>
    ///  <li>Sub-domains like "a.example.com" are also allowed.</li>
    ///  <li>The entries must consist of only ascii characters.</li>
    ///  <li>Use punycode encoding for internationalized domains.</li>
    ///  <li>Sub-domains of the listed domains are also excluded.</li>
    ///  <li>For requests with no associated top-level frame (e.g. ServiceWorker
    ///      initiated requests, the request initiator's domain is considered
    ///      instead.</li>
    /// </ul>
    JSArray? excludedTopDomains,

    /// The rule will only match network requests originating from the list of
    /// `domains`.
    JSArray? domains,

    /// The rule will not match network requests originating from the list of
    /// `excludedDomains`.
    JSArray? excludedDomains,

    /// List of resource types which the rule can match. An empty list is not
    /// allowed.
    ///
    /// Note: this must be specified for `allowAllRequests` rules and
    /// may only include the `sub_frame` and `main_frame`
    /// resource types.
    JSArray? resourceTypes,

    /// List of resource types which the rule won't match. Only one of
    /// `resourceTypes` and `excludedResourceTypes` should
    /// be specified. If neither of them is specified, all resource types except
    /// "main_frame" are blocked.
    JSArray? excludedResourceTypes,

    /// List of HTTP request methods which the rule can match. An empty list is
    /// not allowed.
    ///
    /// Note: Specifying a `requestMethods` rule condition will also
    /// exclude non-HTTP(s) requests, whereas specifying
    /// `excludedRequestMethods` will not.
    JSArray? requestMethods,

    /// List of request methods which the rule won't match. Only one of
    /// `requestMethods` and `excludedRequestMethods`
    /// should be specified. If neither of them is specified, all request methods
    /// are matched.
    JSArray? excludedRequestMethods,

    /// Specifies whether the network request is first-party or third-party to
    /// the domain from which it originated. If omitted, all requests are
    /// accepted.
    DomainType? domainType,

    /// List of [tabs.Tab.id] which the rule should match. An ID of
    /// [tabs.TAB_ID_NONE] matches requests which don't originate from a
    /// tab. An empty list is not allowed. Only supported for session-scoped
    /// rules.
    JSArray? tabIds,

    /// List of [tabs.Tab.id] which the rule should not match. An ID of
    /// [tabs.TAB_ID_NONE] excludes requests which don't originate from a
    /// tab. Only supported for session-scoped rules.
    JSArray? excludedTabIds,

    /// Rule matches if the request matches any response header condition in this
    /// list (if specified).
    JSArray? responseHeaders,

    /// Rule does not match if the request matches any response header
    /// condition in this list (if specified). If both `excludedResponseHeaders`
    /// and `responseHeaders` are specified, then the `excludedResponseHeaders`
    /// property takes precedence.
    JSArray? excludedResponseHeaders,
  });

  /// The pattern which is matched against the network request url.
  /// Supported constructs:
  ///
  /// **'*'**  : Wildcard: Matches any number of characters.
  ///
  /// **'|'**  : Left/right anchor: If used at either end of the pattern,
  ///               specifies the beginning/end of the url respectively.
  ///
  /// **'||'** : Domain name anchor: If used at the beginning of the
  ///               pattern, specifies the start of a (sub-)domain of the URL.
  ///
  /// **'^'**  : Separator character: This matches anything except a letter,
  ///               a digit, or one of the following: `_`,
  ///               `-`, `.`, or `%`. This
  ///               also match the end of the URL.
  ///
  /// Therefore `urlFilter` is composed of the following parts:
  /// (optional Left/Domain name anchor) + pattern + (optional Right anchor).
  ///
  /// If omitted, all urls are matched. An empty string is not allowed.
  ///
  /// A pattern beginning with `||*` is not allowed. Use
  /// `*` instead.
  ///
  /// Note: Only one of `urlFilter` or `regexFilter` can
  /// be specified.
  ///
  /// Note: The `urlFilter` must be composed of only ASCII
  /// characters. This is matched against a url where the host is encoded in
  /// the punycode format (in case of internationalized domains) and any other
  /// non-ascii characters are url encoded in utf-8.
  /// For example, when the request url is
  /// http://abc.&#x0440;&#x0444;?q=&#x0444;, the
  /// `urlFilter` will be matched against the url
  /// http://abc.xn--p1ai/?q=%D1%84.
  external String? urlFilter;

  /// Regular expression to match against the network request url. This follows
  /// the <a href = "https://github.com/google/re2/wiki/Syntax">RE2 syntax</a>.
  ///
  /// Note: Only one of `urlFilter` or `regexFilter` can
  /// be specified.
  ///
  /// Note: The `regexFilter` must be composed of only ASCII
  /// characters. This is matched against a url where the host is encoded in
  /// the punycode format (in case of internationalized domains) and any other
  /// non-ascii characters are url encoded in utf-8.
  external String? regexFilter;

  /// Whether the `urlFilter` or `regexFilter`
  /// (whichever is specified) is case sensitive. Default is false.
  external bool? isUrlFilterCaseSensitive;

  /// The rule will only match network requests originating from the list of
  /// `initiatorDomains`. If the list is omitted, the rule is
  /// applied to requests from all domains. An empty list is not allowed.
  ///
  /// Notes:
  /// <ul>
  ///  <li>Sub-domains like "a.example.com" are also allowed.</li>
  ///  <li>The entries must consist of only ascii characters.</li>
  ///  <li>Use punycode encoding for internationalized domains.</li>
  ///  <li>
  ///    This matches against the request initiator and not the request url.
  ///  </li>
  ///  <li>Sub-domains of the listed domains are also matched.</li>
  /// </ul>
  external JSArray? initiatorDomains;

  /// The rule will not match network requests originating from the list of
  /// `excludedInitiatorDomains`. If the list is empty or omitted,
  /// no domains are excluded. This takes precedence over
  /// `initiatorDomains`.
  ///
  /// Notes:
  /// <ul>
  ///  <li>Sub-domains like "a.example.com" are also allowed.</li>
  ///  <li>The entries must consist of only ascii characters.</li>
  ///  <li>Use punycode encoding for internationalized domains.</li>
  ///  <li>
  ///    This matches against the request initiator and not the request url.
  ///  </li>
  ///  <li>Sub-domains of the listed domains are also excluded.</li>
  /// </ul>
  external JSArray? excludedInitiatorDomains;

  /// The rule will only match network requests when the domain matches one
  /// from the list of `requestDomains`. If the list is omitted,
  /// the rule is applied to requests from all domains. An empty list is not
  /// allowed.
  ///
  /// Notes:
  /// <ul>
  ///  <li>Sub-domains like "a.example.com" are also allowed.</li>
  ///  <li>The entries must consist of only ascii characters.</li>
  ///  <li>Use punycode encoding for internationalized domains.</li>
  ///  <li>Sub-domains of the listed domains are also matched.</li>
  /// </ul>
  external JSArray? requestDomains;

  /// The rule will not match network requests when the domains matches one
  /// from the list of `excludedRequestDomains`. If the list is
  /// empty or omitted, no domains are excluded. This takes precedence over
  /// `requestDomains`.
  ///
  /// Notes:
  /// <ul>
  ///  <li>Sub-domains like "a.example.com" are also allowed.</li>
  ///  <li>The entries must consist of only ascii characters.</li>
  ///  <li>Use punycode encoding for internationalized domains.</li>
  ///  <li>Sub-domains of the listed domains are also excluded.</li>
  /// </ul>
  external JSArray? excludedRequestDomains;

  /// The rule will only match network requests when the associated top-level
  /// frame's domain matches one from the list of `topDomains`. If
  /// the list is omitted, the rule is applied to requests associated with all
  /// top-level frame domains. An empty list is not allowed.
  ///
  /// Notes:
  /// <ul>
  ///  <li>Sub-domains like "a.example.com" are also allowed.</li>
  ///  <li>The entries must consist of only ascii characters.</li>
  ///  <li>Use punycode encoding for internationalized domains.</li>
  ///  <li>Sub-domains of the listed domains are also matched.</li>
  ///  <li>For requests with no associated top-level frame (e.g. ServiceWorker
  ///      initiated requests, the request initiator's domain is considered
  ///      instead.</li>
  /// </ul>
  external JSArray? topDomains;

  /// The rule will not match network requests when the associated top-level
  /// frame's domain matches one from the list of
  /// `excludedTopDomains`. If the list is empty or omitted, no
  /// domains are excluded. This takes precedence over
  /// `topDomains`.
  ///
  /// Notes:
  /// <ul>
  ///  <li>Sub-domains like "a.example.com" are also allowed.</li>
  ///  <li>The entries must consist of only ascii characters.</li>
  ///  <li>Use punycode encoding for internationalized domains.</li>
  ///  <li>Sub-domains of the listed domains are also excluded.</li>
  ///  <li>For requests with no associated top-level frame (e.g. ServiceWorker
  ///      initiated requests, the request initiator's domain is considered
  ///      instead.</li>
  /// </ul>
  external JSArray? excludedTopDomains;

  /// The rule will only match network requests originating from the list of
  /// `domains`.
  external JSArray? domains;

  /// The rule will not match network requests originating from the list of
  /// `excludedDomains`.
  external JSArray? excludedDomains;

  /// List of resource types which the rule can match. An empty list is not
  /// allowed.
  ///
  /// Note: this must be specified for `allowAllRequests` rules and
  /// may only include the `sub_frame` and `main_frame`
  /// resource types.
  external JSArray? resourceTypes;

  /// List of resource types which the rule won't match. Only one of
  /// `resourceTypes` and `excludedResourceTypes` should
  /// be specified. If neither of them is specified, all resource types except
  /// "main_frame" are blocked.
  external JSArray? excludedResourceTypes;

  /// List of HTTP request methods which the rule can match. An empty list is
  /// not allowed.
  ///
  /// Note: Specifying a `requestMethods` rule condition will also
  /// exclude non-HTTP(s) requests, whereas specifying
  /// `excludedRequestMethods` will not.
  external JSArray? requestMethods;

  /// List of request methods which the rule won't match. Only one of
  /// `requestMethods` and `excludedRequestMethods`
  /// should be specified. If neither of them is specified, all request methods
  /// are matched.
  external JSArray? excludedRequestMethods;

  /// Specifies whether the network request is first-party or third-party to
  /// the domain from which it originated. If omitted, all requests are
  /// accepted.
  external DomainType? domainType;

  /// List of [tabs.Tab.id] which the rule should match. An ID of
  /// [tabs.TAB_ID_NONE] matches requests which don't originate from a
  /// tab. An empty list is not allowed. Only supported for session-scoped
  /// rules.
  external JSArray? tabIds;

  /// List of [tabs.Tab.id] which the rule should not match. An ID of
  /// [tabs.TAB_ID_NONE] excludes requests which don't originate from a
  /// tab. Only supported for session-scoped rules.
  external JSArray? excludedTabIds;

  /// Rule matches if the request matches any response header condition in this
  /// list (if specified).
  external JSArray? responseHeaders;

  /// Rule does not match if the request matches any response header
  /// condition in this list (if specified). If both `excludedResponseHeaders`
  /// and `responseHeaders` are specified, then the `excludedResponseHeaders`
  /// property takes precedence.
  external JSArray? excludedResponseHeaders;
}
extension type HeaderRegexOptions._(JSObject _) implements JSObject {
  external factory HeaderRegexOptions(
      {
      /// Whether the regex should match all groups for the value. This is only
      /// relevant if a regex substitution is present and would thus need to be
      /// applied onto all matching groups. Equivalent to the "g" flag.
      /// Defaults to false.
      bool? matchAll});

  /// Whether the regex should match all groups for the value. This is only
  /// relevant if a regex substitution is present and would thus need to be
  /// applied onto all matching groups. Equivalent to the "g" flag.
  /// Defaults to false.
  external bool? matchAll;
}
extension type ModifyHeaderInfo._(JSObject _) implements JSObject {
  external factory ModifyHeaderInfo({
    /// The name of the header to be modified.
    String header,

    /// The operation to be performed on a header.
    /// <!-- TODO(crbug.com/352093575): Make this field optional: It is ignored
    /// if `regexSubstitution` is specified but is required otherwise. -->
    HeaderOperation operation,

    /// The new value for the header. Must be specified for `append`
    /// and `set` operations.
    /// <!-- TODO(crbug.com/352093575): Ignored if `regexSubstitution` is
    /// specified, -->
    String? value,

    /// A regular expression to match against the header value. This follows the
    /// RE2 syntax for consistency with the rest of the API.
    String? regexFilter,

    /// Substitution pattern for the response header. `regexFilter` must be
    /// specified for this to be valid. Takes precedence over `value` and
    /// `operation` if specified and valid.
    String? regexSubstitution,

    /// Options for the regex filter. If not specified, all options will be
    /// default.
    HeaderRegexOptions? regexOptions,
  });

  /// The name of the header to be modified.
  external String header;

  /// The operation to be performed on a header.
  /// <!-- TODO(crbug.com/352093575): Make this field optional: It is ignored
  /// if `regexSubstitution` is specified but is required otherwise. -->
  external HeaderOperation operation;

  /// The new value for the header. Must be specified for `append`
  /// and `set` operations.
  /// <!-- TODO(crbug.com/352093575): Ignored if `regexSubstitution` is
  /// specified, -->
  external String? value;

  /// A regular expression to match against the header value. This follows the
  /// RE2 syntax for consistency with the rest of the API.
  external String? regexFilter;

  /// Substitution pattern for the response header. `regexFilter` must be
  /// specified for this to be valid. Takes precedence over `value` and
  /// `operation` if specified and valid.
  external String? regexSubstitution;

  /// Options for the regex filter. If not specified, all options will be
  /// default.
  external HeaderRegexOptions? regexOptions;
}
extension type RuleAction._(JSObject _) implements JSObject {
  external factory RuleAction({
    /// The type of action to perform.
    RuleActionType type,

    /// Describes how the redirect should be performed. Only valid for redirect
    /// rules.
    Redirect? redirect,

    /// The request headers to modify for the request. Only valid if
    /// RuleActionType is "modifyHeaders".
    JSArray? requestHeaders,

    /// The response headers to modify for the request. Only valid if
    /// RuleActionType is "modifyHeaders".
    JSArray? responseHeaders,
  });

  /// The type of action to perform.
  external RuleActionType type;

  /// Describes how the redirect should be performed. Only valid for redirect
  /// rules.
  external Redirect? redirect;

  /// The request headers to modify for the request. Only valid if
  /// RuleActionType is "modifyHeaders".
  external JSArray? requestHeaders;

  /// The response headers to modify for the request. Only valid if
  /// RuleActionType is "modifyHeaders".
  external JSArray? responseHeaders;
}
extension type Rule._(JSObject _) implements JSObject {
  external factory Rule({
    /// An id which uniquely identifies a rule. Mandatory and should be >= 1.
    int id,

    /// Rule priority. Defaults to 1. When specified, should be >= 1.
    int? priority,

    /// The condition under which this rule is triggered.
    RuleCondition condition,

    /// The action to take if this rule is matched.
    RuleAction action,
  });

  /// An id which uniquely identifies a rule. Mandatory and should be >= 1.
  external int id;

  /// Rule priority. Defaults to 1. When specified, should be >= 1.
  external int? priority;

  /// The condition under which this rule is triggered.
  external RuleCondition condition;

  /// The action to take if this rule is matched.
  external RuleAction action;
}
extension type MatchedRule._(JSObject _) implements JSObject {
  external factory MatchedRule({
    /// A matching rule's ID.
    int ruleId,

    /// ID of the [Ruleset] this rule belongs to. For a rule originating
    /// from the set of dynamic rules, this will be equal to
    /// [DYNAMIC_RULESET_ID].
    String rulesetId,
  });

  /// A matching rule's ID.
  external int ruleId;

  /// ID of the [Ruleset] this rule belongs to. For a rule originating
  /// from the set of dynamic rules, this will be equal to
  /// [DYNAMIC_RULESET_ID].
  external String rulesetId;
}
extension type GetRulesFilter._(JSObject _) implements JSObject {
  external factory GetRulesFilter(
      {
      /// If specified, only rules with matching IDs are included.
      JSArray? ruleIds});

  /// If specified, only rules with matching IDs are included.
  external JSArray? ruleIds;
}
extension type MatchedRuleInfo._(JSObject _) implements JSObject {
  external factory MatchedRuleInfo({
    MatchedRule rule,

    /// The time the rule was matched. Timestamps will correspond to the
    /// Javascript convention for times, i.e. number of milliseconds since the
    /// epoch.
    double timeStamp,

    /// The tabId of the tab from which the request originated if the tab is
    /// still active. Else -1.
    int tabId,
  });

  external MatchedRule rule;

  /// The time the rule was matched. Timestamps will correspond to the
  /// Javascript convention for times, i.e. number of milliseconds since the
  /// epoch.
  external double timeStamp;

  /// The tabId of the tab from which the request originated if the tab is
  /// still active. Else -1.
  external int tabId;
}
extension type MatchedRulesFilter._(JSObject _) implements JSObject {
  external factory MatchedRulesFilter({
    /// If specified, only matches rules for the given tab. Matches rules not
    /// associated with any active tab if set to -1.
    int? tabId,

    /// If specified, only matches rules after the given timestamp.
    double? minTimeStamp,
  });

  /// If specified, only matches rules for the given tab. Matches rules not
  /// associated with any active tab if set to -1.
  external int? tabId;

  /// If specified, only matches rules after the given timestamp.
  external double? minTimeStamp;
}
extension type RulesMatchedDetails._(JSObject _) implements JSObject {
  external factory RulesMatchedDetails(
      {
      /// Rules matching the given filter.
      JSArray rulesMatchedInfo});

  /// Rules matching the given filter.
  external JSArray rulesMatchedInfo;
}
extension type RequestDetails._(JSObject _) implements JSObject {
  external factory RequestDetails({
    /// The ID of the request. Request IDs are unique within a browser session.
    String requestId,

    /// The URL of the request.
    String url,

    /// The origin where the request was initiated. This does not change through
    /// redirects. If this is an opaque origin, the string 'null' will be used.
    String? initiator,

    /// Standard HTTP method.
    String method,

    /// The value 0 indicates that the request happens in the main frame; a
    /// positive value indicates the ID of a subframe in which the request
    /// happens. If the document of a (sub-)frame is loaded (`type` is
    /// `main_frame` or `sub_frame`), `frameId`
    /// indicates the ID of this frame, not the ID of the outer frame. Frame IDs
    /// are unique within a tab.
    int frameId,

    /// The unique identifier for the frame's document, if this request is for a
    /// frame.
    String? documentId,

    /// The type of the frame, if this request is for a frame.
    FrameType? frameType,

    /// The lifecycle of the frame's document, if this request is for a
    /// frame.
    DocumentLifecycle? documentLifecycle,

    /// ID of frame that wraps the frame which sent the request. Set to -1 if no
    /// parent frame exists.
    int parentFrameId,

    /// The unique identifier for the frame's parent document, if this request
    /// is for a frame and has a parent.
    String? parentDocumentId,

    /// The ID of the tab in which the request takes place. Set to -1 if the
    /// request isn't related to a tab.
    int tabId,

    /// The resource type of the request.
    ResourceType type,
  });

  /// The ID of the request. Request IDs are unique within a browser session.
  external String requestId;

  /// The URL of the request.
  external String url;

  /// The origin where the request was initiated. This does not change through
  /// redirects. If this is an opaque origin, the string 'null' will be used.
  external String? initiator;

  /// Standard HTTP method.
  external String method;

  /// The value 0 indicates that the request happens in the main frame; a
  /// positive value indicates the ID of a subframe in which the request
  /// happens. If the document of a (sub-)frame is loaded (`type` is
  /// `main_frame` or `sub_frame`), `frameId`
  /// indicates the ID of this frame, not the ID of the outer frame. Frame IDs
  /// are unique within a tab.
  external int frameId;

  /// The unique identifier for the frame's document, if this request is for a
  /// frame.
  external String? documentId;

  /// The type of the frame, if this request is for a frame.
  external FrameType? frameType;

  /// The lifecycle of the frame's document, if this request is for a
  /// frame.
  external DocumentLifecycle? documentLifecycle;

  /// ID of frame that wraps the frame which sent the request. Set to -1 if no
  /// parent frame exists.
  external int parentFrameId;

  /// The unique identifier for the frame's parent document, if this request
  /// is for a frame and has a parent.
  external String? parentDocumentId;

  /// The ID of the tab in which the request takes place. Set to -1 if the
  /// request isn't related to a tab.
  external int tabId;

  /// The resource type of the request.
  external ResourceType type;
}
extension type TestMatchRequestDetails._(JSObject _) implements JSObject {
  external factory TestMatchRequestDetails({
    /// The URL of the hypothetical request.
    String url,

    /// The initiator URL (if any) for the hypothetical request.
    String? initiator,

    /// Standard HTTP method of the hypothetical request. Defaults to "get" for
    /// HTTP requests and is ignored for non-HTTP requests.
    RequestMethod? method,

    /// The resource type of the hypothetical request.
    ResourceType type,

    /// The ID of the tab in which the hypothetical request takes place. Does
    /// not need to correspond to a real tab ID. Default is -1, meaning that
    /// the request isn't related to a tab.
    int? tabId,

    /// The associated top-level frame URL (if any) for the request.
    String? topUrl,

    /// The headers provided by a hypothetical response if the request does not
    /// get blocked or redirected before it is sent. Represented as an object
    /// which maps a header name to a list of string values. If not specified,
    /// the hypothetical response would return empty response headers, which can
    /// match rules which match on the non-existence of headers.
    /// E.g. `{"content-type": ["text/html; charset=utf-8",
    /// "multipart/form-data"]}`
    JSAny? responseHeaders,
  });

  /// The URL of the hypothetical request.
  external String url;

  /// The initiator URL (if any) for the hypothetical request.
  external String? initiator;

  /// Standard HTTP method of the hypothetical request. Defaults to "get" for
  /// HTTP requests and is ignored for non-HTTP requests.
  external RequestMethod? method;

  /// The resource type of the hypothetical request.
  external ResourceType type;

  /// The ID of the tab in which the hypothetical request takes place. Does
  /// not need to correspond to a real tab ID. Default is -1, meaning that
  /// the request isn't related to a tab.
  external int? tabId;

  /// The associated top-level frame URL (if any) for the request.
  external String? topUrl;

  /// The headers provided by a hypothetical response if the request does not
  /// get blocked or redirected before it is sent. Represented as an object
  /// which maps a header name to a list of string values. If not specified,
  /// the hypothetical response would return empty response headers, which can
  /// match rules which match on the non-existence of headers.
  /// E.g. `{"content-type": ["text/html; charset=utf-8",
  /// "multipart/form-data"]}`
  external JSAny? responseHeaders;
}
extension type MatchedRuleInfoDebug._(JSObject _) implements JSObject {
  external factory MatchedRuleInfoDebug({
    MatchedRule rule,

    /// Details about the request for which the rule was matched.
    RequestDetails request,
  });

  external MatchedRule rule;

  /// Details about the request for which the rule was matched.
  external RequestDetails request;
}
extension type DNRInfo._(JSObject _) implements JSObject {
  external factory DNRInfo({JSArray rule_resources});

  external JSArray rule_resources;
}
extension type RegexOptions._(JSObject _) implements JSObject {
  external factory RegexOptions({
    /// The regular expresson to check.
    String regex,

    /// Whether the `regex` specified is case sensitive. Default is
    /// true.
    bool? isCaseSensitive,

    /// Whether the `regex` specified requires capturing. Capturing is
    /// only required for redirect rules which specify a
    /// `regexSubstition` action. The default is false.
    bool? requireCapturing,
  });

  /// The regular expresson to check.
  external String regex;

  /// Whether the `regex` specified is case sensitive. Default is
  /// true.
  external bool? isCaseSensitive;

  /// Whether the `regex` specified requires capturing. Capturing is
  /// only required for redirect rules which specify a
  /// `regexSubstition` action. The default is false.
  external bool? requireCapturing;
}
extension type IsRegexSupportedResult._(JSObject _) implements JSObject {
  external factory IsRegexSupportedResult({
    bool isSupported,

    /// Specifies the reason why the regular expression is not supported. Only
    /// provided if `isSupported` is false.
    UnsupportedRegexReason? reason,
  });

  external bool isSupported;

  /// Specifies the reason why the regular expression is not supported. Only
  /// provided if `isSupported` is false.
  external UnsupportedRegexReason? reason;
}
extension type TestMatchOutcomeResult._(JSObject _) implements JSObject {
  external factory TestMatchOutcomeResult(
      {
      /// The rules (if any) that match the hypothetical request.
      JSArray matchedRules});

  /// The rules (if any) that match the hypothetical request.
  external JSArray matchedRules;
}
extension type UpdateRuleOptions._(JSObject _) implements JSObject {
  external factory UpdateRuleOptions({
    /// IDs of the rules to remove. Any invalid IDs will be ignored.
    JSArray? removeRuleIds,

    /// Rules to add.
    JSArray? addRules,
  });

  /// IDs of the rules to remove. Any invalid IDs will be ignored.
  external JSArray? removeRuleIds;

  /// Rules to add.
  external JSArray? addRules;
}
extension type UpdateRulesetOptions._(JSObject _) implements JSObject {
  external factory UpdateRulesetOptions({
    /// The set of ids corresponding to a static [Ruleset] that should be
    /// disabled.
    JSArray? disableRulesetIds,

    /// The set of ids corresponding to a static [Ruleset] that should be
    /// enabled.
    JSArray? enableRulesetIds,
  });

  /// The set of ids corresponding to a static [Ruleset] that should be
  /// disabled.
  external JSArray? disableRulesetIds;

  /// The set of ids corresponding to a static [Ruleset] that should be
  /// enabled.
  external JSArray? enableRulesetIds;
}
extension type UpdateStaticRulesOptions._(JSObject _) implements JSObject {
  external factory UpdateStaticRulesOptions({
    /// The id corresponding to a static [Ruleset].
    String rulesetId,

    /// Set of ids corresponding to rules in the [Ruleset] to disable.
    JSArray? disableRuleIds,

    /// Set of ids corresponding to rules in the [Ruleset] to enable.
    JSArray? enableRuleIds,
  });

  /// The id corresponding to a static [Ruleset].
  external String rulesetId;

  /// Set of ids corresponding to rules in the [Ruleset] to disable.
  external JSArray? disableRuleIds;

  /// Set of ids corresponding to rules in the [Ruleset] to enable.
  external JSArray? enableRuleIds;
}
extension type GetDisabledRuleIdsOptions._(JSObject _) implements JSObject {
  external factory GetDisabledRuleIdsOptions(
      {
      /// The id corresponding to a static [Ruleset].
      String rulesetId});

  /// The id corresponding to a static [Ruleset].
  external String rulesetId;
}
extension type TabActionCountUpdate._(JSObject _) implements JSObject {
  external factory TabActionCountUpdate({
    /// The tab for which to update the action count.
    int tabId,

    /// The amount to increment the tab's action count by. Negative values will
    /// decrement the count.
    int increment,
  });

  /// The tab for which to update the action count.
  external int tabId;

  /// The amount to increment the tab's action count by. Negative values will
  /// decrement the count.
  external int increment;
}
extension type ExtensionActionOptions._(JSObject _) implements JSObject {
  external factory ExtensionActionOptions({
    /// Whether to automatically display the action count for a page as the
    /// extension's badge text. This preference is persisted across sessions.
    bool? displayActionCountAsBadgeText,

    /// Details of how the tab's action count should be adjusted.
    TabActionCountUpdate? tabUpdate,
  });

  /// Whether to automatically display the action count for a page as the
  /// extension's badge text. This preference is persisted across sessions.
  external bool? displayActionCountAsBadgeText;

  /// Details of how the tab's action count should be adjusted.
  external TabActionCountUpdate? tabUpdate;
}
