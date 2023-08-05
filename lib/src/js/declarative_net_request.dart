// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

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

@JS()
@staticInterop
class JSDeclarativeNetRequest {}

extension JSDeclarativeNetRequestExtension on JSDeclarativeNetRequest {
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
  /// <li>[MAX_NUMBER_OF_DYNAMIC_AND_SESSION_RULES] is the maximum number
  /// of combined dynamic and session rules an extension can add.</li>
  /// </ul>
  /// |callback|: Called once the update is complete or has failed. In case of
  /// an error, [runtime.lastError] will be set and no change will be made
  /// to the rule set. This can happen for multiple reasons, such as invalid
  /// rule format, duplicate rule ID, rule count limit exceeded, internal
  /// errors, and others.
  external JSPromise updateDynamicRules(UpdateRuleOptions options);

  /// Returns the current set of dynamic rules for the extension. Callers can
  /// optionally filter the list of fetched rules by specifying a
  /// `filter`.
  /// |filter|: An object to filter the list of fetched rules.
  /// |callback|: Called with the set of dynamic rules. An error might be
  /// raised in case of transient internal errors.
  external JSPromise getDynamicRules(GetRulesFilter? filter);

  /// Modifies the current set of session scoped rules for the extension.
  /// The rules with IDs listed in `options.removeRuleIds` are first
  /// removed, and then the rules given in `options.addRules` are
  /// added. Notes:
  /// <ul>
  /// <li>This update happens as a single atomic operation: either all
  /// specified rules are added and removed, or an error is returned.</li>
  /// <li>These rules are not persisted across sessions and are backed in
  /// memory.</li>
  /// <li>[MAX_NUMBER_OF_DYNAMIC_AND_SESSION_RULES] is the maximum number
  /// of combined dynamic and session rules an extension can add.</li>
  /// </ul>
  /// |callback|: Called once the update is complete or has failed. In case of
  /// an error, [runtime.lastError] will be set and no change will be made
  /// to the rule set. This can happen for multiple reasons, such as invalid
  /// rule format, duplicate rule ID, rule count limit exceeded, and others.
  external JSPromise updateSessionRules(UpdateRuleOptions options);

  /// Returns the current set of session scoped rules for the extension.
  /// Callers can optionally filter the list of fetched rules by specifying a
  /// `filter`.
  /// |filter|: An object to filter the list of fetched rules.
  /// |callback|: Called with the set of session scoped rules.
  external JSPromise getSessionRules(GetRulesFilter? filter);

  /// Updates the set of enabled static rulesets for the extension. The
  /// rulesets with IDs listed in `options.disableRulesetIds` are
  /// first removed, and then the rulesets listed in
  /// `options.enableRulesetIds` are added.<br/>
  /// Note that the set of enabled static rulesets is persisted across sessions
  /// but not across extension updates, i.e. the `rule_resources`
  /// manifest key will determine the set of enabled static rulesets on each
  /// extension update.
  /// |callback|: Called once the update is complete. In case of an error,
  /// [runtime.lastError] will be set and no change will be made to set of
  /// enabled rulesets. This can happen for multiple reasons, such as invalid
  /// ruleset IDs, rule count limit exceeded, or internal errors.
  external JSPromise updateEnabledRulesets(UpdateRulesetOptions options);

  /// Returns the ids for the current set of enabled static rulesets.
  /// |callback|: Called with a list of ids, where each id corresponds to an
  /// enabled static [Ruleset].
  external JSPromise getEnabledRulesets();

  /// Disables and enables individual static rules in a [Ruleset].
  /// Changes to rules belonging to a disabled [Ruleset] will take
  /// effect the next time that it becomes enabled.
  /// |callback|: Called once the update is complete. In case of an error,
  /// [runtime.lastError] will be set and no change will be made to the
  /// enabled static rules.
  external JSPromise updateStaticRules(UpdateStaticRulesOptions options);

  /// Returns the list of static rules in the given [Ruleset] that are
  /// currently disabled.
  /// |options|: Specifies the ruleset to query.
  /// |callback|: Called with a list of ids that correspond to the disabled
  /// rules in that ruleset.
  external JSPromise getDisabledRuleIds(GetDisabledRuleIdsOptions options);

  /// Returns all rules matched for the extension. Callers can optionally
  /// filter the list of matched rules by specifying a `filter`.
  /// This method is only available to extensions with the
  /// `declarativeNetRequestFeedback` permission or having the
  /// `activeTab` permission granted for the `tabId`
  /// specified in `filter`.
  /// Note: Rules not associated with an active document that were matched more
  /// than five minutes ago will not be returned.
  /// |filter|: An object to filter the list of matched rules.
  /// |callback|: Called once the list of matched rules has been fetched. In
  /// case of an error, [runtime.lastError] will be set and no rules will
  /// be returned. This can happen for multiple reasons, such as insufficient
  /// permissions, or exceeding the quota.
  external JSPromise getMatchedRules(MatchedRulesFilter? filter);

  /// Configures if the action count for tabs should be displayed as the
  /// extension action's badge text and provides a way for that action count to
  /// be incremented.
  external JSPromise setExtensionActionOptions(ExtensionActionOptions options);

  /// Checks if the given regular expression will be supported as a
  /// `regexFilter` rule condition.
  /// |regexOptions|: The regular expression to check.
  /// |callback|: Called with details consisting of whether the regular
  /// expression is supported and the reason if not.
  external JSPromise isRegexSupported(RegexOptions regexOptions);

  /// Returns the number of static rules an extension can enable before the
  /// [global static rule limit](#global-static-rule-limit) is
  /// reached.
  external JSPromise getAvailableStaticRuleCount();

  /// Checks if any of the extension's declarativeNetRequest rules would match
  /// a hypothetical request.
  /// Note: Only available for unpacked extensions as this is only intended to
  /// be used during extension development.
  /// |requestDetails|: The request details to test.
  /// |callback|: Called with the details of matched rules.
  external JSPromise testMatchOutcome(TestMatchRequestDetails request);

  /// Fired when a rule is matched with a request. Only available for unpacked
  /// extensions with the `declarativeNetRequestFeedback` permission
  /// as this is intended to be used for debugging purposes only.
  /// |info|: The rule that has been matched along with information about the
  /// associated request.
  external Event get onRuleMatchedDebug;

  /// The minimum number of static rules guaranteed to an extension across its
  /// enabled static rulesets. Any rules above this limit will count towards
  /// the [global static rule limit](#global-static-rule-limit).
  external int get GUARANTEED_MINIMUM_STATIC_RULES;

  /// The maximum number of dynamic rules that an extension can add.
  external int get MAX_NUMBER_OF_DYNAMIC_RULES;

  /// The maximum number of combined dynamic and session scoped rules an
  /// extension can add.
  external int get MAX_NUMBER_OF_DYNAMIC_AND_SESSION_RULES;

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
typedef ResourceType = String;

/// This describes the HTTP request method of a network request.
typedef RequestMethod = String;

/// This describes whether the request is first or third party to the frame in
/// which it originated. A request is said to be first party if it has the same
/// domain (eTLD+1) as the frame in which the request originated.
typedef DomainType = String;

/// This describes the possible operations for a "modifyHeaders" rule.
typedef HeaderOperation = String;

/// Describes the kind of action to take if a given RuleCondition matches.
typedef RuleActionType = String;

/// Describes the reason why a given regular expression isn't supported.
typedef UnsupportedRegexReason = String;

@JS()
@staticInterop
@anonymous
class Ruleset {
  external factory Ruleset({
    /// A non-empty string uniquely identifying the ruleset. IDs beginning with
    /// '_' are reserved for internal use.
    String id,

    /// The path of the JSON ruleset relative to the extension directory.
    String path,

    /// Whether the ruleset is enabled by default.
    bool enabled,
  });
}

extension RulesetExtension on Ruleset {
  /// A non-empty string uniquely identifying the ruleset. IDs beginning with
  /// '_' are reserved for internal use.
  external String id;

  /// The path of the JSON ruleset relative to the extension directory.
  external String path;

  /// Whether the ruleset is enabled by default.
  external bool enabled;
}

@JS()
@staticInterop
@anonymous
class QueryKeyValue {
  external factory QueryKeyValue({
    String key,
    String value,

    /// If true, the query key is replaced only if it's already present.
    /// Otherwise, the key is also added if it's missing. Defaults to false.
    bool? replaceOnly,
  });
}

extension QueryKeyValueExtension on QueryKeyValue {
  external String key;

  external String value;

  /// If true, the query key is replaced only if it's already present.
  /// Otherwise, the key is also added if it's missing. Defaults to false.
  external bool? replaceOnly;
}

@JS()
@staticInterop
@anonymous
class QueryTransform {
  external factory QueryTransform({
    /// The list of query keys to be removed.
    JSArray? removeParams,

    /// The list of query key-value pairs to be added or replaced.
    JSArray? addOrReplaceParams,
  });
}

extension QueryTransformExtension on QueryTransform {
  /// The list of query keys to be removed.
  external JSArray? removeParams;

  /// The list of query key-value pairs to be added or replaced.
  external JSArray? addOrReplaceParams;
}

@JS()
@staticInterop
@anonymous
class URLTransform {
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
}

extension URLTransformExtension on URLTransform {
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

@JS()
@staticInterop
@anonymous
class Redirect {
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
}

extension RedirectExtension on Redirect {
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

@JS()
@staticInterop
@anonymous
class RuleCondition {
  external factory RuleCondition({
    /// The pattern which is matched against the network request url.
    /// Supported constructs:
    ///
    /// **'*'**  : Wildcard: Matches any number of characters.
    ///
    /// **'|'**  : Left/right anchor: If used at either end of the pattern,
    ///               specifies the beginning/end of the url respectively.
    ///
    /// **'||'** : Domain name anchor: If used at the beginning of the pattern,
    ///               specifies the start of a (sub-)domain of the URL.
    ///
    /// **'^'**  : Separator character: This matches anything except a letter, a
    ///               digit or one of the following: _ - . %. This can also match
    ///               the end of the URL.
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
    /// (whichever is specified) is case sensitive. Default is true.
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
  });
}

extension RuleConditionExtension on RuleCondition {
  /// The pattern which is matched against the network request url.
  /// Supported constructs:
  ///
  /// **'*'**  : Wildcard: Matches any number of characters.
  ///
  /// **'|'**  : Left/right anchor: If used at either end of the pattern,
  ///               specifies the beginning/end of the url respectively.
  ///
  /// **'||'** : Domain name anchor: If used at the beginning of the pattern,
  ///               specifies the start of a (sub-)domain of the URL.
  ///
  /// **'^'**  : Separator character: This matches anything except a letter, a
  ///               digit or one of the following: _ - . %. This can also match
  ///               the end of the URL.
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
  /// (whichever is specified) is case sensitive. Default is true.
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
}

@JS()
@staticInterop
@anonymous
class ModifyHeaderInfo {
  external factory ModifyHeaderInfo({
    /// The name of the header to be modified.
    String header,

    /// The operation to be performed on a header.
    HeaderOperation operation,

    /// The new value for the header. Must be specified for `append`
    /// and `set` operations.
    String? value,
  });
}

extension ModifyHeaderInfoExtension on ModifyHeaderInfo {
  /// The name of the header to be modified.
  external String header;

  /// The operation to be performed on a header.
  external HeaderOperation operation;

  /// The new value for the header. Must be specified for `append`
  /// and `set` operations.
  external String? value;
}

@JS()
@staticInterop
@anonymous
class RuleAction {
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
}

extension RuleActionExtension on RuleAction {
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

@JS()
@staticInterop
@anonymous
class Rule {
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
}

extension RuleExtension on Rule {
  /// An id which uniquely identifies a rule. Mandatory and should be >= 1.
  external int id;

  /// Rule priority. Defaults to 1. When specified, should be >= 1.
  external int? priority;

  /// The condition under which this rule is triggered.
  external RuleCondition condition;

  /// The action to take if this rule is matched.
  external RuleAction action;
}

@JS()
@staticInterop
@anonymous
class MatchedRule {
  external factory MatchedRule({
    /// A matching rule's ID.
    int ruleId,

    /// ID of the [Ruleset] this rule belongs to. For a rule originating
    /// from the set of dynamic rules, this will be equal to
    /// [DYNAMIC_RULESET_ID].
    String rulesetId,
  });
}

extension MatchedRuleExtension on MatchedRule {
  /// A matching rule's ID.
  external int ruleId;

  /// ID of the [Ruleset] this rule belongs to. For a rule originating
  /// from the set of dynamic rules, this will be equal to
  /// [DYNAMIC_RULESET_ID].
  external String rulesetId;
}

@JS()
@staticInterop
@anonymous
class GetRulesFilter {
  external factory GetRulesFilter(
      {
      /// If specified, only rules with matching IDs are included.
      JSArray? ruleIds});
}

extension GetRulesFilterExtension on GetRulesFilter {
  /// If specified, only rules with matching IDs are included.
  external JSArray? ruleIds;
}

@JS()
@staticInterop
@anonymous
class MatchedRuleInfo {
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
}

extension MatchedRuleInfoExtension on MatchedRuleInfo {
  external MatchedRule rule;

  /// The time the rule was matched. Timestamps will correspond to the
  /// Javascript convention for times, i.e. number of milliseconds since the
  /// epoch.
  external double timeStamp;

  /// The tabId of the tab from which the request originated if the tab is
  /// still active. Else -1.
  external int tabId;
}

@JS()
@staticInterop
@anonymous
class MatchedRulesFilter {
  external factory MatchedRulesFilter({
    /// If specified, only matches rules for the given tab. Matches rules not
    /// associated with any active tab if set to -1.
    int? tabId,

    /// If specified, only matches rules after the given timestamp.
    double? minTimeStamp,
  });
}

extension MatchedRulesFilterExtension on MatchedRulesFilter {
  /// If specified, only matches rules for the given tab. Matches rules not
  /// associated with any active tab if set to -1.
  external int? tabId;

  /// If specified, only matches rules after the given timestamp.
  external double? minTimeStamp;
}

@JS()
@staticInterop
@anonymous
class RulesMatchedDetails {
  external factory RulesMatchedDetails(
      {
      /// Rules matching the given filter.
      JSArray rulesMatchedInfo});
}

extension RulesMatchedDetailsExtension on RulesMatchedDetails {
  /// Rules matching the given filter.
  external JSArray rulesMatchedInfo;
}

@JS()
@staticInterop
@anonymous
class RequestDetails {
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
}

extension RequestDetailsExtension on RequestDetails {
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

@JS()
@staticInterop
@anonymous
class TestMatchRequestDetails {
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
  });
}

extension TestMatchRequestDetailsExtension on TestMatchRequestDetails {
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
}

@JS()
@staticInterop
@anonymous
class MatchedRuleInfoDebug {
  external factory MatchedRuleInfoDebug({
    MatchedRule rule,

    /// Details about the request for which the rule was matched.
    RequestDetails request,
  });
}

extension MatchedRuleInfoDebugExtension on MatchedRuleInfoDebug {
  external MatchedRule rule;

  /// Details about the request for which the rule was matched.
  external RequestDetails request;
}

@JS()
@staticInterop
@anonymous
class DNRInfo {
  external factory DNRInfo({JSArray rule_resources});
}

extension DNRInfoExtension on DNRInfo {
  external JSArray rule_resources;
}

@JS()
@staticInterop
@anonymous
class ManifestKeys {
  external factory ManifestKeys({DNRInfo declarative_net_request});
}

extension ManifestKeysExtension on ManifestKeys {
  external DNRInfo declarative_net_request;
}

@JS()
@staticInterop
@anonymous
class RegexOptions {
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
}

extension RegexOptionsExtension on RegexOptions {
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

@JS()
@staticInterop
@anonymous
class IsRegexSupportedResult {
  external factory IsRegexSupportedResult({
    bool isSupported,

    /// Specifies the reason why the regular expression is not supported. Only
    /// provided if `isSupported` is false.
    UnsupportedRegexReason? reason,
  });
}

extension IsRegexSupportedResultExtension on IsRegexSupportedResult {
  external bool isSupported;

  /// Specifies the reason why the regular expression is not supported. Only
  /// provided if `isSupported` is false.
  external UnsupportedRegexReason? reason;
}

@JS()
@staticInterop
@anonymous
class TestMatchOutcomeResult {
  external factory TestMatchOutcomeResult(
      {
      /// The rules (if any) that match the hypothetical request.
      JSArray matchedRules});
}

extension TestMatchOutcomeResultExtension on TestMatchOutcomeResult {
  /// The rules (if any) that match the hypothetical request.
  external JSArray matchedRules;
}

@JS()
@staticInterop
@anonymous
class UpdateRuleOptions {
  external factory UpdateRuleOptions({
    /// IDs of the rules to remove. Any invalid IDs will be ignored.
    JSArray? removeRuleIds,

    /// Rules to add.
    JSArray? addRules,
  });
}

extension UpdateRuleOptionsExtension on UpdateRuleOptions {
  /// IDs of the rules to remove. Any invalid IDs will be ignored.
  external JSArray? removeRuleIds;

  /// Rules to add.
  external JSArray? addRules;
}

@JS()
@staticInterop
@anonymous
class UpdateRulesetOptions {
  external factory UpdateRulesetOptions({
    /// The set of ids corresponding to a static [Ruleset] that should be
    /// disabled.
    JSArray? disableRulesetIds,

    /// The set of ids corresponding to a static [Ruleset] that should be
    /// enabled.
    JSArray? enableRulesetIds,
  });
}

extension UpdateRulesetOptionsExtension on UpdateRulesetOptions {
  /// The set of ids corresponding to a static [Ruleset] that should be
  /// disabled.
  external JSArray? disableRulesetIds;

  /// The set of ids corresponding to a static [Ruleset] that should be
  /// enabled.
  external JSArray? enableRulesetIds;
}

@JS()
@staticInterop
@anonymous
class UpdateStaticRulesOptions {
  external factory UpdateStaticRulesOptions({
    /// The id corresponding to a static [Ruleset].
    String rulesetId,

    /// Set of ids corresponding to rules in the [Ruleset] to disable.
    JSArray? disableRuleIds,

    /// Set of ids corresponding to rules in the [Ruleset] to enable.
    JSArray? enableRuleIds,
  });
}

extension UpdateStaticRulesOptionsExtension on UpdateStaticRulesOptions {
  /// The id corresponding to a static [Ruleset].
  external String rulesetId;

  /// Set of ids corresponding to rules in the [Ruleset] to disable.
  external JSArray? disableRuleIds;

  /// Set of ids corresponding to rules in the [Ruleset] to enable.
  external JSArray? enableRuleIds;
}

@JS()
@staticInterop
@anonymous
class GetDisabledRuleIdsOptions {
  external factory GetDisabledRuleIdsOptions(
      {
      /// The id corresponding to a static [Ruleset].
      String rulesetId});
}

extension GetDisabledRuleIdsOptionsExtension on GetDisabledRuleIdsOptions {
  /// The id corresponding to a static [Ruleset].
  external String rulesetId;
}

@JS()
@staticInterop
@anonymous
class TabActionCountUpdate {
  external factory TabActionCountUpdate({
    /// The tab for which to update the action count.
    int tabId,

    /// The amount to increment the tab's action count by. Negative values will
    /// decrement the count.
    int increment,
  });
}

extension TabActionCountUpdateExtension on TabActionCountUpdate {
  /// The tab for which to update the action count.
  external int tabId;

  /// The amount to increment the tab's action count by. Negative values will
  /// decrement the count.
  external int increment;
}

@JS()
@staticInterop
@anonymous
class ExtensionActionOptions {
  external factory ExtensionActionOptions({
    /// Whether to automatically display the action count for a page as the
    /// extension's badge text. This preference is persisted across sessions.
    bool? displayActionCountAsBadgeText,

    /// Details of how the tab's action count should be adjusted.
    TabActionCountUpdate? tabUpdate,
  });
}

extension ExtensionActionOptionsExtension on ExtensionActionOptions {
  /// Whether to automatically display the action count for a page as the
  /// extension's badge text. This preference is persisted across sessions.
  external bool? displayActionCountAsBadgeText;

  /// Details of how the tab's action count should be adjusted.
  external TabActionCountUpdate? tabUpdate;
}
