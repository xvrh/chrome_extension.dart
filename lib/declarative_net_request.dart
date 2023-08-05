// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'extension_types.dart';
import 'src/internal_helpers.dart';
import 'src/js/declarative_net_request.dart' as $js;

export 'src/chrome.dart' show chrome;

final _declarativeNetRequest = ChromeDeclarativeNetRequest._();

extension ChromeDeclarativeNetRequestExtension on Chrome {
  /// The `chrome.declarativeNetRequest` API is used to block or modify
  /// network requests by specifying declarative rules. This lets extensions
  /// modify network requests without intercepting them and viewing their
  /// content,
  /// thus providing more privacy.
  ChromeDeclarativeNetRequest get declarativeNetRequest =>
      _declarativeNetRequest;
}

class ChromeDeclarativeNetRequest {
  ChromeDeclarativeNetRequest._();

  bool get isAvailable =>
      $js.chrome.declarativeNetRequestNullable != null && alwaysTrue;

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
  Future<void> updateDynamicRules(UpdateRuleOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.declarativeNetRequest.updateDynamicRules(options.toJS));
  }

  /// Returns the current set of dynamic rules for the extension. Callers can
  /// optionally filter the list of fetched rules by specifying a
  /// `filter`.
  /// |filter|: An object to filter the list of fetched rules.
  /// |callback|: Called with the set of dynamic rules. An error might be
  /// raised in case of transient internal errors.
  Future<List<Rule>> getDynamicRules(GetRulesFilter? filter) async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.declarativeNetRequest.getDynamicRules(filter?.toJS));
    return $res.toDart.cast<$js.Rule>().map((e) => Rule.fromJS(e)).toList();
  }

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
  Future<void> updateSessionRules(UpdateRuleOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.declarativeNetRequest.updateSessionRules(options.toJS));
  }

  /// Returns the current set of session scoped rules for the extension.
  /// Callers can optionally filter the list of fetched rules by specifying a
  /// `filter`.
  /// |filter|: An object to filter the list of fetched rules.
  /// |callback|: Called with the set of session scoped rules.
  Future<List<Rule>> getSessionRules(GetRulesFilter? filter) async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.declarativeNetRequest.getSessionRules(filter?.toJS));
    return $res.toDart.cast<$js.Rule>().map((e) => Rule.fromJS(e)).toList();
  }

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
  Future<void> updateEnabledRulesets(UpdateRulesetOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.declarativeNetRequest.updateEnabledRulesets(options.toJS));
  }

  /// Returns the ids for the current set of enabled static rulesets.
  /// |callback|: Called with a list of ids, where each id corresponds to an
  /// enabled static [Ruleset].
  Future<List<String>> getEnabledRulesets() async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.declarativeNetRequest.getEnabledRulesets());
    return $res.toDart.cast<String>().map((e) => e).toList();
  }

  /// Disables and enables individual static rules in a [Ruleset].
  /// Changes to rules belonging to a disabled [Ruleset] will take
  /// effect the next time that it becomes enabled.
  /// |callback|: Called once the update is complete. In case of an error,
  /// [runtime.lastError] will be set and no change will be made to the
  /// enabled static rules.
  Future<void> updateStaticRules(UpdateStaticRulesOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.declarativeNetRequest.updateStaticRules(options.toJS));
  }

  /// Returns the list of static rules in the given [Ruleset] that are
  /// currently disabled.
  /// |options|: Specifies the ruleset to query.
  /// |callback|: Called with a list of ids that correspond to the disabled
  /// rules in that ruleset.
  Future<List<int>> getDisabledRuleIds(
      GetDisabledRuleIdsOptions options) async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.declarativeNetRequest.getDisabledRuleIds(options.toJS));
    return $res.toDart.cast<int>().map((e) => e).toList();
  }

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
  Future<RulesMatchedDetails> getMatchedRules(
      MatchedRulesFilter? filter) async {
    var $res = await promiseToFuture<$js.RulesMatchedDetails>(
        $js.chrome.declarativeNetRequest.getMatchedRules(filter?.toJS));
    return RulesMatchedDetails.fromJS($res);
  }

  /// Configures if the action count for tabs should be displayed as the
  /// extension action's badge text and provides a way for that action count to
  /// be incremented.
  Future<void> setExtensionActionOptions(ExtensionActionOptions options) async {
    await promiseToFuture<void>($js.chrome.declarativeNetRequest
        .setExtensionActionOptions(options.toJS));
  }

  /// Checks if the given regular expression will be supported as a
  /// `regexFilter` rule condition.
  /// |regexOptions|: The regular expression to check.
  /// |callback|: Called with details consisting of whether the regular
  /// expression is supported and the reason if not.
  Future<IsRegexSupportedResult> isRegexSupported(
      RegexOptions regexOptions) async {
    var $res = await promiseToFuture<$js.IsRegexSupportedResult>(
        $js.chrome.declarativeNetRequest.isRegexSupported(regexOptions.toJS));
    return IsRegexSupportedResult.fromJS($res);
  }

  /// Returns the number of static rules an extension can enable before the
  /// [global static rule limit](#global-static-rule-limit) is
  /// reached.
  Future<int> getAvailableStaticRuleCount() async {
    var $res = await promiseToFuture<int>(
        $js.chrome.declarativeNetRequest.getAvailableStaticRuleCount());
    return $res;
  }

  /// Checks if any of the extension's declarativeNetRequest rules would match
  /// a hypothetical request.
  /// Note: Only available for unpacked extensions as this is only intended to
  /// be used during extension development.
  /// |requestDetails|: The request details to test.
  /// |callback|: Called with the details of matched rules.
  Future<TestMatchOutcomeResult> testMatchOutcome(
      TestMatchRequestDetails request) async {
    var $res = await promiseToFuture<$js.TestMatchOutcomeResult>(
        $js.chrome.declarativeNetRequest.testMatchOutcome(request.toJS));
    return TestMatchOutcomeResult.fromJS($res);
  }

  /// The minimum number of static rules guaranteed to an extension across its
  /// enabled static rulesets. Any rules above this limit will count towards
  /// the [global static rule limit](#global-static-rule-limit).
  int get guaranteedMinimumStaticRules =>
      $js.chrome.declarativeNetRequest.GUARANTEED_MINIMUM_STATIC_RULES;

  /// The maximum number of dynamic rules that an extension can add.
  int get maxNumberOfDynamicRules =>
      $js.chrome.declarativeNetRequest.MAX_NUMBER_OF_DYNAMIC_RULES;

  /// The maximum number of combined dynamic and session scoped rules an
  /// extension can add.
  int get maxNumberOfDynamicAndSessionRules =>
      $js.chrome.declarativeNetRequest.MAX_NUMBER_OF_DYNAMIC_AND_SESSION_RULES;

  /// Time interval within which `MAX_GETMATCHEDRULES_CALLS_PER_INTERVAL
  /// getMatchedRules` calls can be made, specified in minutes.
  /// Additional calls will fail immediately and set [runtime.lastError].
  /// Note: `getMatchedRules` calls associated with a user gesture
  /// are exempt from the quota.
  int get getmatchedrulesQuotaInterval =>
      $js.chrome.declarativeNetRequest.GETMATCHEDRULES_QUOTA_INTERVAL;

  /// The number of times `getMatchedRules` can be called within a
  /// period of `GETMATCHEDRULES_QUOTA_INTERVAL`.
  int get maxGetmatchedrulesCallsPerInterval =>
      $js.chrome.declarativeNetRequest.MAX_GETMATCHEDRULES_CALLS_PER_INTERVAL;

  /// The maximum number of regular expression rules that an extension can
  /// add. This limit is evaluated separately for the set of dynamic rules and
  /// those specified in the rule resources file.
  int get maxNumberOfRegexRules =>
      $js.chrome.declarativeNetRequest.MAX_NUMBER_OF_REGEX_RULES;

  /// The maximum number of static `Rulesets` an extension can
  /// specify as part of the `"rule_resources"` manifest key.
  int get maxNumberOfStaticRulesets =>
      $js.chrome.declarativeNetRequest.MAX_NUMBER_OF_STATIC_RULESETS;

  /// The maximum number of static `Rulesets` an extension can
  /// enable at any one time.
  int get maxNumberOfEnabledStaticRulesets =>
      $js.chrome.declarativeNetRequest.MAX_NUMBER_OF_ENABLED_STATIC_RULESETS;

  /// Ruleset ID for the dynamic rules added by the extension.
  String get dynamicRulesetId =>
      $js.chrome.declarativeNetRequest.DYNAMIC_RULESET_ID;

  /// Ruleset ID for the session-scoped rules added by the extension.
  String get sessionRulesetId =>
      $js.chrome.declarativeNetRequest.SESSION_RULESET_ID;

  /// Fired when a rule is matched with a request. Only available for unpacked
  /// extensions with the `declarativeNetRequestFeedback` permission
  /// as this is intended to be used for debugging purposes only.
  /// |info|: The rule that has been matched along with information about the
  /// associated request.
  EventStream<MatchedRuleInfoDebug> get onRuleMatchedDebug =>
      $js.chrome.declarativeNetRequest.onRuleMatchedDebug
          .asStream(($c) => ($js.MatchedRuleInfoDebug info) {
                return $c(MatchedRuleInfoDebug.fromJS(info));
              });
}

/// This describes the resource type of the network request.
enum ResourceType {
  mainFrame('main_frame'),
  subFrame('sub_frame'),
  stylesheet('stylesheet'),
  script('script'),
  image('image'),
  font('font'),
  object('object'),
  xmlhttprequest('xmlhttprequest'),
  ping('ping'),
  cspReport('csp_report'),
  media('media'),
  websocket('websocket'),
  webtransport('webtransport'),
  webbundle('webbundle'),
  other('other');

  const ResourceType(this.value);

  final String value;

  String get toJS => value;
  static ResourceType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// This describes the HTTP request method of a network request.
enum RequestMethod {
  connect('connect'),
  delete('delete'),
  get('get'),
  head('head'),
  options('options'),
  patch('patch'),
  post('post'),
  put('put'),
  other('other');

  const RequestMethod(this.value);

  final String value;

  String get toJS => value;
  static RequestMethod fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// This describes whether the request is first or third party to the frame in
/// which it originated. A request is said to be first party if it has the same
/// domain (eTLD+1) as the frame in which the request originated.
enum DomainType {
  /// The network request is first party to the frame in which it originated.
  firstParty('firstParty'),

  /// The network request is third party to the frame in which it originated.
  thirdParty('thirdParty');

  const DomainType(this.value);

  final String value;

  String get toJS => value;
  static DomainType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// This describes the possible operations for a "modifyHeaders" rule.
enum HeaderOperation {
  /// Adds a new entry for the specified header. This operation is not
  /// supported for request headers.
  append('append'),

  /// Sets a new value for the specified header, removing any existing headers
  /// with the same name.
  set('set'),

  /// Removes all entries for the specified header.
  remove('remove');

  const HeaderOperation(this.value);

  final String value;

  String get toJS => value;
  static HeaderOperation fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Describes the kind of action to take if a given RuleCondition matches.
enum RuleActionType {
  /// Block the network request.
  block('block'),

  /// Redirect the network request.
  redirect('redirect'),

  /// Allow the network request. The request won't be intercepted if there is
  /// an allow rule which matches it.
  allow('allow'),

  /// Upgrade the network request url's scheme to https if the request is http
  /// or ftp.
  upgradeScheme('upgradeScheme'),

  /// Modify request/response headers from the network request.
  modifyHeaders('modifyHeaders'),

  /// Allow all requests within a frame hierarchy, including the frame request
  /// itself.
  allowAllRequests('allowAllRequests');

  const RuleActionType(this.value);

  final String value;

  String get toJS => value;
  static RuleActionType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Describes the reason why a given regular expression isn't supported.
enum UnsupportedRegexReason {
  /// The regular expression is syntactically incorrect, or uses features
  /// not available in the
  /// <a href = "https://github.com/google/re2/wiki/Syntax">RE2 syntax</a>.
  syntaxError('syntaxError'),

  /// The regular expression exceeds the memory limit.
  memoryLimitExceeded('memoryLimitExceeded');

  const UnsupportedRegexReason(this.value);

  final String value;

  String get toJS => value;
  static UnsupportedRegexReason fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class Ruleset {
  Ruleset.fromJS(this._wrapped);

  Ruleset({
    /// A non-empty string uniquely identifying the ruleset. IDs beginning with
    /// '_' are reserved for internal use.
    required String id,

    /// The path of the JSON ruleset relative to the extension directory.
    required String path,

    /// Whether the ruleset is enabled by default.
    required bool enabled,
  }) : _wrapped = $js.Ruleset(
          id: id,
          path: path,
          enabled: enabled,
        );

  final $js.Ruleset _wrapped;

  $js.Ruleset get toJS => _wrapped;

  /// A non-empty string uniquely identifying the ruleset. IDs beginning with
  /// '_' are reserved for internal use.
  String get id => _wrapped.id;
  set id(String v) {
    _wrapped.id = v;
  }

  /// The path of the JSON ruleset relative to the extension directory.
  String get path => _wrapped.path;
  set path(String v) {
    _wrapped.path = v;
  }

  /// Whether the ruleset is enabled by default.
  bool get enabled => _wrapped.enabled;
  set enabled(bool v) {
    _wrapped.enabled = v;
  }
}

class QueryKeyValue {
  QueryKeyValue.fromJS(this._wrapped);

  QueryKeyValue({
    required String key,
    required String value,

    /// If true, the query key is replaced only if it's already present.
    /// Otherwise, the key is also added if it's missing. Defaults to false.
    bool? replaceOnly,
  }) : _wrapped = $js.QueryKeyValue(
          key: key,
          value: value,
          replaceOnly: replaceOnly,
        );

  final $js.QueryKeyValue _wrapped;

  $js.QueryKeyValue get toJS => _wrapped;

  String get key => _wrapped.key;
  set key(String v) {
    _wrapped.key = v;
  }

  String get value => _wrapped.value;
  set value(String v) {
    _wrapped.value = v;
  }

  /// If true, the query key is replaced only if it's already present.
  /// Otherwise, the key is also added if it's missing. Defaults to false.
  bool? get replaceOnly => _wrapped.replaceOnly;
  set replaceOnly(bool? v) {
    _wrapped.replaceOnly = v;
  }
}

class QueryTransform {
  QueryTransform.fromJS(this._wrapped);

  QueryTransform({
    /// The list of query keys to be removed.
    List<String>? removeParams,

    /// The list of query key-value pairs to be added or replaced.
    List<QueryKeyValue>? addOrReplaceParams,
  }) : _wrapped = $js.QueryTransform(
          removeParams: removeParams?.toJSArray((e) => e),
          addOrReplaceParams: addOrReplaceParams?.toJSArray((e) => e.toJS),
        );

  final $js.QueryTransform _wrapped;

  $js.QueryTransform get toJS => _wrapped;

  /// The list of query keys to be removed.
  List<String>? get removeParams =>
      _wrapped.removeParams?.toDart.cast<String>().map((e) => e).toList();
  set removeParams(List<String>? v) {
    _wrapped.removeParams = v?.toJSArray((e) => e);
  }

  /// The list of query key-value pairs to be added or replaced.
  List<QueryKeyValue>? get addOrReplaceParams =>
      _wrapped.addOrReplaceParams?.toDart
          .cast<$js.QueryKeyValue>()
          .map((e) => QueryKeyValue.fromJS(e))
          .toList();
  set addOrReplaceParams(List<QueryKeyValue>? v) {
    _wrapped.addOrReplaceParams = v?.toJSArray((e) => e.toJS);
  }
}

class URLTransform {
  URLTransform.fromJS(this._wrapped);

  URLTransform({
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
  }) : _wrapped = $js.URLTransform(
          scheme: scheme,
          host: host,
          port: port,
          path: path,
          query: query,
          queryTransform: queryTransform?.toJS,
          fragment: fragment,
          username: username,
          password: password,
        );

  final $js.URLTransform _wrapped;

  $js.URLTransform get toJS => _wrapped;

  /// The new scheme for the request. Allowed values are "http", "https",
  /// "ftp" and "chrome-extension".
  String? get scheme => _wrapped.scheme;
  set scheme(String? v) {
    _wrapped.scheme = v;
  }

  /// The new host for the request.
  String? get host => _wrapped.host;
  set host(String? v) {
    _wrapped.host = v;
  }

  /// The new port for the request. If empty, the existing port is cleared.
  String? get port => _wrapped.port;
  set port(String? v) {
    _wrapped.port = v;
  }

  /// The new path for the request. If empty, the existing path is cleared.
  String? get path => _wrapped.path;
  set path(String? v) {
    _wrapped.path = v;
  }

  /// The new query for the request. Should be either empty, in which case the
  /// existing query is cleared; or should begin with '?'.
  String? get query => _wrapped.query;
  set query(String? v) {
    _wrapped.query = v;
  }

  /// Add, remove or replace query key-value pairs.
  QueryTransform? get queryTransform =>
      _wrapped.queryTransform?.let(QueryTransform.fromJS);
  set queryTransform(QueryTransform? v) {
    _wrapped.queryTransform = v?.toJS;
  }

  /// The new fragment for the request. Should be either empty, in which case
  /// the existing fragment is cleared; or should begin with '#'.
  String? get fragment => _wrapped.fragment;
  set fragment(String? v) {
    _wrapped.fragment = v;
  }

  /// The new username for the request.
  String? get username => _wrapped.username;
  set username(String? v) {
    _wrapped.username = v;
  }

  /// The new password for the request.
  String? get password => _wrapped.password;
  set password(String? v) {
    _wrapped.password = v;
  }
}

class Redirect {
  Redirect.fromJS(this._wrapped);

  Redirect({
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
  }) : _wrapped = $js.Redirect(
          extensionPath: extensionPath,
          transform: transform?.toJS,
          url: url,
          regexSubstitution: regexSubstitution,
        );

  final $js.Redirect _wrapped;

  $js.Redirect get toJS => _wrapped;

  /// Path relative to the extension directory. Should start with '/'.
  String? get extensionPath => _wrapped.extensionPath;
  set extensionPath(String? v) {
    _wrapped.extensionPath = v;
  }

  /// Url transformations to perform.
  URLTransform? get transform => _wrapped.transform?.let(URLTransform.fromJS);
  set transform(URLTransform? v) {
    _wrapped.transform = v?.toJS;
  }

  /// The redirect url. Redirects to JavaScript urls are not allowed.
  String? get url => _wrapped.url;
  set url(String? v) {
    _wrapped.url = v;
  }

  /// Substitution pattern for rules which specify a `regexFilter`.
  /// The first match of `regexFilter` within the url will be
  /// replaced with this pattern. Within `regexSubstitution`,
  /// backslash-escaped digits (\1 to \9) can be used to insert the
  /// corresponding capture groups. \0 refers to the entire matching text.
  String? get regexSubstitution => _wrapped.regexSubstitution;
  set regexSubstitution(String? v) {
    _wrapped.regexSubstitution = v;
  }
}

class RuleCondition {
  RuleCondition.fromJS(this._wrapped);

  RuleCondition({
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
    ///               digit or one of the following: _ - . %. This can also
    /// match
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

    /// Regular expression to match against the network request url. This
    /// follows
    /// the <a href = "https://github.com/google/re2/wiki/Syntax">RE2
    /// syntax</a>.
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
    List<String>? initiatorDomains,

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
    List<String>? excludedInitiatorDomains,

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
    List<String>? requestDomains,

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
    List<String>? excludedRequestDomains,

    /// The rule will only match network requests originating from the list of
    /// `domains`.
    List<String>? domains,

    /// The rule will not match network requests originating from the list of
    /// `excludedDomains`.
    List<String>? excludedDomains,

    /// List of resource types which the rule can match. An empty list is not
    /// allowed.
    ///
    /// Note: this must be specified for `allowAllRequests` rules and
    /// may only include the `sub_frame` and `main_frame`
    /// resource types.
    List<ResourceType>? resourceTypes,

    /// List of resource types which the rule won't match. Only one of
    /// `resourceTypes` and `excludedResourceTypes` should
    /// be specified. If neither of them is specified, all resource types except
    /// "main_frame" are blocked.
    List<ResourceType>? excludedResourceTypes,

    /// List of HTTP request methods which the rule can match. An empty list is
    /// not allowed.
    ///
    /// Note: Specifying a `requestMethods` rule condition will also
    /// exclude non-HTTP(s) requests, whereas specifying
    /// `excludedRequestMethods` will not.
    List<RequestMethod>? requestMethods,

    /// List of request methods which the rule won't match. Only one of
    /// `requestMethods` and `excludedRequestMethods`
    /// should be specified. If neither of them is specified, all request
    /// methods
    /// are matched.
    List<RequestMethod>? excludedRequestMethods,

    /// Specifies whether the network request is first-party or third-party to
    /// the domain from which it originated. If omitted, all requests are
    /// accepted.
    DomainType? domainType,

    /// List of [tabs.Tab.id] which the rule should match. An ID of
    /// [tabs.TAB_ID_NONE] matches requests which don't originate from a
    /// tab. An empty list is not allowed. Only supported for session-scoped
    /// rules.
    List<int>? tabIds,

    /// List of [tabs.Tab.id] which the rule should not match. An ID of
    /// [tabs.TAB_ID_NONE] excludes requests which don't originate from a
    /// tab. Only supported for session-scoped rules.
    List<int>? excludedTabIds,
  }) : _wrapped = $js.RuleCondition(
          urlFilter: urlFilter,
          regexFilter: regexFilter,
          isUrlFilterCaseSensitive: isUrlFilterCaseSensitive,
          initiatorDomains: initiatorDomains?.toJSArray((e) => e),
          excludedInitiatorDomains:
              excludedInitiatorDomains?.toJSArray((e) => e),
          requestDomains: requestDomains?.toJSArray((e) => e),
          excludedRequestDomains: excludedRequestDomains?.toJSArray((e) => e),
          domains: domains?.toJSArray((e) => e),
          excludedDomains: excludedDomains?.toJSArray((e) => e),
          resourceTypes: resourceTypes?.toJSArray((e) => e.toJS),
          excludedResourceTypes:
              excludedResourceTypes?.toJSArray((e) => e.toJS),
          requestMethods: requestMethods?.toJSArray((e) => e.toJS),
          excludedRequestMethods:
              excludedRequestMethods?.toJSArray((e) => e.toJS),
          domainType: domainType?.toJS,
          tabIds: tabIds?.toJSArray((e) => e),
          excludedTabIds: excludedTabIds?.toJSArray((e) => e),
        );

  final $js.RuleCondition _wrapped;

  $js.RuleCondition get toJS => _wrapped;

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
  String? get urlFilter => _wrapped.urlFilter;
  set urlFilter(String? v) {
    _wrapped.urlFilter = v;
  }

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
  String? get regexFilter => _wrapped.regexFilter;
  set regexFilter(String? v) {
    _wrapped.regexFilter = v;
  }

  /// Whether the `urlFilter` or `regexFilter`
  /// (whichever is specified) is case sensitive. Default is true.
  bool? get isUrlFilterCaseSensitive => _wrapped.isUrlFilterCaseSensitive;
  set isUrlFilterCaseSensitive(bool? v) {
    _wrapped.isUrlFilterCaseSensitive = v;
  }

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
  List<String>? get initiatorDomains =>
      _wrapped.initiatorDomains?.toDart.cast<String>().map((e) => e).toList();
  set initiatorDomains(List<String>? v) {
    _wrapped.initiatorDomains = v?.toJSArray((e) => e);
  }

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
  List<String>? get excludedInitiatorDomains =>
      _wrapped.excludedInitiatorDomains?.toDart
          .cast<String>()
          .map((e) => e)
          .toList();
  set excludedInitiatorDomains(List<String>? v) {
    _wrapped.excludedInitiatorDomains = v?.toJSArray((e) => e);
  }

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
  List<String>? get requestDomains =>
      _wrapped.requestDomains?.toDart.cast<String>().map((e) => e).toList();
  set requestDomains(List<String>? v) {
    _wrapped.requestDomains = v?.toJSArray((e) => e);
  }

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
  List<String>? get excludedRequestDomains =>
      _wrapped.excludedRequestDomains?.toDart
          .cast<String>()
          .map((e) => e)
          .toList();
  set excludedRequestDomains(List<String>? v) {
    _wrapped.excludedRequestDomains = v?.toJSArray((e) => e);
  }

  /// The rule will only match network requests originating from the list of
  /// `domains`.
  List<String>? get domains =>
      _wrapped.domains?.toDart.cast<String>().map((e) => e).toList();
  set domains(List<String>? v) {
    _wrapped.domains = v?.toJSArray((e) => e);
  }

  /// The rule will not match network requests originating from the list of
  /// `excludedDomains`.
  List<String>? get excludedDomains =>
      _wrapped.excludedDomains?.toDart.cast<String>().map((e) => e).toList();
  set excludedDomains(List<String>? v) {
    _wrapped.excludedDomains = v?.toJSArray((e) => e);
  }

  /// List of resource types which the rule can match. An empty list is not
  /// allowed.
  ///
  /// Note: this must be specified for `allowAllRequests` rules and
  /// may only include the `sub_frame` and `main_frame`
  /// resource types.
  List<ResourceType>? get resourceTypes => _wrapped.resourceTypes?.toDart
      .cast<$js.ResourceType>()
      .map((e) => ResourceType.fromJS(e))
      .toList();
  set resourceTypes(List<ResourceType>? v) {
    _wrapped.resourceTypes = v?.toJSArray((e) => e.toJS);
  }

  /// List of resource types which the rule won't match. Only one of
  /// `resourceTypes` and `excludedResourceTypes` should
  /// be specified. If neither of them is specified, all resource types except
  /// "main_frame" are blocked.
  List<ResourceType>? get excludedResourceTypes =>
      _wrapped.excludedResourceTypes?.toDart
          .cast<$js.ResourceType>()
          .map((e) => ResourceType.fromJS(e))
          .toList();
  set excludedResourceTypes(List<ResourceType>? v) {
    _wrapped.excludedResourceTypes = v?.toJSArray((e) => e.toJS);
  }

  /// List of HTTP request methods which the rule can match. An empty list is
  /// not allowed.
  ///
  /// Note: Specifying a `requestMethods` rule condition will also
  /// exclude non-HTTP(s) requests, whereas specifying
  /// `excludedRequestMethods` will not.
  List<RequestMethod>? get requestMethods => _wrapped.requestMethods?.toDart
      .cast<$js.RequestMethod>()
      .map((e) => RequestMethod.fromJS(e))
      .toList();
  set requestMethods(List<RequestMethod>? v) {
    _wrapped.requestMethods = v?.toJSArray((e) => e.toJS);
  }

  /// List of request methods which the rule won't match. Only one of
  /// `requestMethods` and `excludedRequestMethods`
  /// should be specified. If neither of them is specified, all request methods
  /// are matched.
  List<RequestMethod>? get excludedRequestMethods =>
      _wrapped.excludedRequestMethods?.toDart
          .cast<$js.RequestMethod>()
          .map((e) => RequestMethod.fromJS(e))
          .toList();
  set excludedRequestMethods(List<RequestMethod>? v) {
    _wrapped.excludedRequestMethods = v?.toJSArray((e) => e.toJS);
  }

  /// Specifies whether the network request is first-party or third-party to
  /// the domain from which it originated. If omitted, all requests are
  /// accepted.
  DomainType? get domainType => _wrapped.domainType?.let(DomainType.fromJS);
  set domainType(DomainType? v) {
    _wrapped.domainType = v?.toJS;
  }

  /// List of [tabs.Tab.id] which the rule should match. An ID of
  /// [tabs.TAB_ID_NONE] matches requests which don't originate from a
  /// tab. An empty list is not allowed. Only supported for session-scoped
  /// rules.
  List<int>? get tabIds =>
      _wrapped.tabIds?.toDart.cast<int>().map((e) => e).toList();
  set tabIds(List<int>? v) {
    _wrapped.tabIds = v?.toJSArray((e) => e);
  }

  /// List of [tabs.Tab.id] which the rule should not match. An ID of
  /// [tabs.TAB_ID_NONE] excludes requests which don't originate from a
  /// tab. Only supported for session-scoped rules.
  List<int>? get excludedTabIds =>
      _wrapped.excludedTabIds?.toDart.cast<int>().map((e) => e).toList();
  set excludedTabIds(List<int>? v) {
    _wrapped.excludedTabIds = v?.toJSArray((e) => e);
  }
}

class ModifyHeaderInfo {
  ModifyHeaderInfo.fromJS(this._wrapped);

  ModifyHeaderInfo({
    /// The name of the header to be modified.
    required String header,

    /// The operation to be performed on a header.
    required HeaderOperation operation,

    /// The new value for the header. Must be specified for `append`
    /// and `set` operations.
    String? value,
  }) : _wrapped = $js.ModifyHeaderInfo(
          header: header,
          operation: operation.toJS,
          value: value,
        );

  final $js.ModifyHeaderInfo _wrapped;

  $js.ModifyHeaderInfo get toJS => _wrapped;

  /// The name of the header to be modified.
  String get header => _wrapped.header;
  set header(String v) {
    _wrapped.header = v;
  }

  /// The operation to be performed on a header.
  HeaderOperation get operation => HeaderOperation.fromJS(_wrapped.operation);
  set operation(HeaderOperation v) {
    _wrapped.operation = v.toJS;
  }

  /// The new value for the header. Must be specified for `append`
  /// and `set` operations.
  String? get value => _wrapped.value;
  set value(String? v) {
    _wrapped.value = v;
  }
}

class RuleAction {
  RuleAction.fromJS(this._wrapped);

  RuleAction({
    /// The type of action to perform.
    required RuleActionType type,

    /// Describes how the redirect should be performed. Only valid for redirect
    /// rules.
    Redirect? redirect,

    /// The request headers to modify for the request. Only valid if
    /// RuleActionType is "modifyHeaders".
    List<ModifyHeaderInfo>? requestHeaders,

    /// The response headers to modify for the request. Only valid if
    /// RuleActionType is "modifyHeaders".
    List<ModifyHeaderInfo>? responseHeaders,
  }) : _wrapped = $js.RuleAction(
          type: type.toJS,
          redirect: redirect?.toJS,
          requestHeaders: requestHeaders?.toJSArray((e) => e.toJS),
          responseHeaders: responseHeaders?.toJSArray((e) => e.toJS),
        );

  final $js.RuleAction _wrapped;

  $js.RuleAction get toJS => _wrapped;

  /// The type of action to perform.
  RuleActionType get type => RuleActionType.fromJS(_wrapped.type);
  set type(RuleActionType v) {
    _wrapped.type = v.toJS;
  }

  /// Describes how the redirect should be performed. Only valid for redirect
  /// rules.
  Redirect? get redirect => _wrapped.redirect?.let(Redirect.fromJS);
  set redirect(Redirect? v) {
    _wrapped.redirect = v?.toJS;
  }

  /// The request headers to modify for the request. Only valid if
  /// RuleActionType is "modifyHeaders".
  List<ModifyHeaderInfo>? get requestHeaders => _wrapped.requestHeaders?.toDart
      .cast<$js.ModifyHeaderInfo>()
      .map((e) => ModifyHeaderInfo.fromJS(e))
      .toList();
  set requestHeaders(List<ModifyHeaderInfo>? v) {
    _wrapped.requestHeaders = v?.toJSArray((e) => e.toJS);
  }

  /// The response headers to modify for the request. Only valid if
  /// RuleActionType is "modifyHeaders".
  List<ModifyHeaderInfo>? get responseHeaders =>
      _wrapped.responseHeaders?.toDart
          .cast<$js.ModifyHeaderInfo>()
          .map((e) => ModifyHeaderInfo.fromJS(e))
          .toList();
  set responseHeaders(List<ModifyHeaderInfo>? v) {
    _wrapped.responseHeaders = v?.toJSArray((e) => e.toJS);
  }
}

class Rule {
  Rule.fromJS(this._wrapped);

  Rule({
    /// An id which uniquely identifies a rule. Mandatory and should be >= 1.
    required int id,

    /// Rule priority. Defaults to 1. When specified, should be >= 1.
    int? priority,

    /// The condition under which this rule is triggered.
    required RuleCondition condition,

    /// The action to take if this rule is matched.
    required RuleAction action,
  }) : _wrapped = $js.Rule(
          id: id,
          priority: priority,
          condition: condition.toJS,
          action: action.toJS,
        );

  final $js.Rule _wrapped;

  $js.Rule get toJS => _wrapped;

  /// An id which uniquely identifies a rule. Mandatory and should be >= 1.
  int get id => _wrapped.id;
  set id(int v) {
    _wrapped.id = v;
  }

  /// Rule priority. Defaults to 1. When specified, should be >= 1.
  int? get priority => _wrapped.priority;
  set priority(int? v) {
    _wrapped.priority = v;
  }

  /// The condition under which this rule is triggered.
  RuleCondition get condition => RuleCondition.fromJS(_wrapped.condition);
  set condition(RuleCondition v) {
    _wrapped.condition = v.toJS;
  }

  /// The action to take if this rule is matched.
  RuleAction get action => RuleAction.fromJS(_wrapped.action);
  set action(RuleAction v) {
    _wrapped.action = v.toJS;
  }
}

class MatchedRule {
  MatchedRule.fromJS(this._wrapped);

  MatchedRule({
    /// A matching rule's ID.
    required int ruleId,

    /// ID of the [Ruleset] this rule belongs to. For a rule originating
    /// from the set of dynamic rules, this will be equal to
    /// [DYNAMIC_RULESET_ID].
    required String rulesetId,
  }) : _wrapped = $js.MatchedRule(
          ruleId: ruleId,
          rulesetId: rulesetId,
        );

  final $js.MatchedRule _wrapped;

  $js.MatchedRule get toJS => _wrapped;

  /// A matching rule's ID.
  int get ruleId => _wrapped.ruleId;
  set ruleId(int v) {
    _wrapped.ruleId = v;
  }

  /// ID of the [Ruleset] this rule belongs to. For a rule originating
  /// from the set of dynamic rules, this will be equal to
  /// [DYNAMIC_RULESET_ID].
  String get rulesetId => _wrapped.rulesetId;
  set rulesetId(String v) {
    _wrapped.rulesetId = v;
  }
}

class GetRulesFilter {
  GetRulesFilter.fromJS(this._wrapped);

  GetRulesFilter(
      {
      /// If specified, only rules with matching IDs are included.
      List<int>? ruleIds})
      : _wrapped = $js.GetRulesFilter(ruleIds: ruleIds?.toJSArray((e) => e));

  final $js.GetRulesFilter _wrapped;

  $js.GetRulesFilter get toJS => _wrapped;

  /// If specified, only rules with matching IDs are included.
  List<int>? get ruleIds =>
      _wrapped.ruleIds?.toDart.cast<int>().map((e) => e).toList();
  set ruleIds(List<int>? v) {
    _wrapped.ruleIds = v?.toJSArray((e) => e);
  }
}

class MatchedRuleInfo {
  MatchedRuleInfo.fromJS(this._wrapped);

  MatchedRuleInfo({
    required MatchedRule rule,

    /// The time the rule was matched. Timestamps will correspond to the
    /// Javascript convention for times, i.e. number of milliseconds since the
    /// epoch.
    required double timeStamp,

    /// The tabId of the tab from which the request originated if the tab is
    /// still active. Else -1.
    required int tabId,
  }) : _wrapped = $js.MatchedRuleInfo(
          rule: rule.toJS,
          timeStamp: timeStamp,
          tabId: tabId,
        );

  final $js.MatchedRuleInfo _wrapped;

  $js.MatchedRuleInfo get toJS => _wrapped;

  MatchedRule get rule => MatchedRule.fromJS(_wrapped.rule);
  set rule(MatchedRule v) {
    _wrapped.rule = v.toJS;
  }

  /// The time the rule was matched. Timestamps will correspond to the
  /// Javascript convention for times, i.e. number of milliseconds since the
  /// epoch.
  double get timeStamp => _wrapped.timeStamp;
  set timeStamp(double v) {
    _wrapped.timeStamp = v;
  }

  /// The tabId of the tab from which the request originated if the tab is
  /// still active. Else -1.
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }
}

class MatchedRulesFilter {
  MatchedRulesFilter.fromJS(this._wrapped);

  MatchedRulesFilter({
    /// If specified, only matches rules for the given tab. Matches rules not
    /// associated with any active tab if set to -1.
    int? tabId,

    /// If specified, only matches rules after the given timestamp.
    double? minTimeStamp,
  }) : _wrapped = $js.MatchedRulesFilter(
          tabId: tabId,
          minTimeStamp: minTimeStamp,
        );

  final $js.MatchedRulesFilter _wrapped;

  $js.MatchedRulesFilter get toJS => _wrapped;

  /// If specified, only matches rules for the given tab. Matches rules not
  /// associated with any active tab if set to -1.
  int? get tabId => _wrapped.tabId;
  set tabId(int? v) {
    _wrapped.tabId = v;
  }

  /// If specified, only matches rules after the given timestamp.
  double? get minTimeStamp => _wrapped.minTimeStamp;
  set minTimeStamp(double? v) {
    _wrapped.minTimeStamp = v;
  }
}

class RulesMatchedDetails {
  RulesMatchedDetails.fromJS(this._wrapped);

  RulesMatchedDetails(
      {
      /// Rules matching the given filter.
      required List<MatchedRuleInfo> rulesMatchedInfo})
      : _wrapped = $js.RulesMatchedDetails(
            rulesMatchedInfo: rulesMatchedInfo.toJSArray((e) => e.toJS));

  final $js.RulesMatchedDetails _wrapped;

  $js.RulesMatchedDetails get toJS => _wrapped;

  /// Rules matching the given filter.
  List<MatchedRuleInfo> get rulesMatchedInfo => _wrapped.rulesMatchedInfo.toDart
      .cast<$js.MatchedRuleInfo>()
      .map((e) => MatchedRuleInfo.fromJS(e))
      .toList();
  set rulesMatchedInfo(List<MatchedRuleInfo> v) {
    _wrapped.rulesMatchedInfo = v.toJSArray((e) => e.toJS);
  }
}

class RequestDetails {
  RequestDetails.fromJS(this._wrapped);

  RequestDetails({
    /// The ID of the request. Request IDs are unique within a browser session.
    required String requestId,

    /// The URL of the request.
    required String url,

    /// The origin where the request was initiated. This does not change through
    /// redirects. If this is an opaque origin, the string 'null' will be used.
    String? initiator,

    /// Standard HTTP method.
    required String method,

    /// The value 0 indicates that the request happens in the main frame; a
    /// positive value indicates the ID of a subframe in which the request
    /// happens. If the document of a (sub-)frame is loaded (`type` is
    /// `main_frame` or `sub_frame`), `frameId`
    /// indicates the ID of this frame, not the ID of the outer frame. Frame IDs
    /// are unique within a tab.
    required int frameId,

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
    required int parentFrameId,

    /// The unique identifier for the frame's parent document, if this request
    /// is for a frame and has a parent.
    String? parentDocumentId,

    /// The ID of the tab in which the request takes place. Set to -1 if the
    /// request isn't related to a tab.
    required int tabId,

    /// The resource type of the request.
    required ResourceType type,
  }) : _wrapped = $js.RequestDetails(
          requestId: requestId,
          url: url,
          initiator: initiator,
          method: method,
          frameId: frameId,
          documentId: documentId,
          frameType: frameType?.toJS,
          documentLifecycle: documentLifecycle?.toJS,
          parentFrameId: parentFrameId,
          parentDocumentId: parentDocumentId,
          tabId: tabId,
          type: type.toJS,
        );

  final $js.RequestDetails _wrapped;

  $js.RequestDetails get toJS => _wrapped;

  /// The ID of the request. Request IDs are unique within a browser session.
  String get requestId => _wrapped.requestId;
  set requestId(String v) {
    _wrapped.requestId = v;
  }

  /// The URL of the request.
  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// The origin where the request was initiated. This does not change through
  /// redirects. If this is an opaque origin, the string 'null' will be used.
  String? get initiator => _wrapped.initiator;
  set initiator(String? v) {
    _wrapped.initiator = v;
  }

  /// Standard HTTP method.
  String get method => _wrapped.method;
  set method(String v) {
    _wrapped.method = v;
  }

  /// The value 0 indicates that the request happens in the main frame; a
  /// positive value indicates the ID of a subframe in which the request
  /// happens. If the document of a (sub-)frame is loaded (`type` is
  /// `main_frame` or `sub_frame`), `frameId`
  /// indicates the ID of this frame, not the ID of the outer frame. Frame IDs
  /// are unique within a tab.
  int get frameId => _wrapped.frameId;
  set frameId(int v) {
    _wrapped.frameId = v;
  }

  /// The unique identifier for the frame's document, if this request is for a
  /// frame.
  String? get documentId => _wrapped.documentId;
  set documentId(String? v) {
    _wrapped.documentId = v;
  }

  /// The type of the frame, if this request is for a frame.
  FrameType? get frameType => _wrapped.frameType?.let(FrameType.fromJS);
  set frameType(FrameType? v) {
    _wrapped.frameType = v?.toJS;
  }

  /// The lifecycle of the frame's document, if this request is for a
  /// frame.
  DocumentLifecycle? get documentLifecycle =>
      _wrapped.documentLifecycle?.let(DocumentLifecycle.fromJS);
  set documentLifecycle(DocumentLifecycle? v) {
    _wrapped.documentLifecycle = v?.toJS;
  }

  /// ID of frame that wraps the frame which sent the request. Set to -1 if no
  /// parent frame exists.
  int get parentFrameId => _wrapped.parentFrameId;
  set parentFrameId(int v) {
    _wrapped.parentFrameId = v;
  }

  /// The unique identifier for the frame's parent document, if this request
  /// is for a frame and has a parent.
  String? get parentDocumentId => _wrapped.parentDocumentId;
  set parentDocumentId(String? v) {
    _wrapped.parentDocumentId = v;
  }

  /// The ID of the tab in which the request takes place. Set to -1 if the
  /// request isn't related to a tab.
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }

  /// The resource type of the request.
  ResourceType get type => ResourceType.fromJS(_wrapped.type);
  set type(ResourceType v) {
    _wrapped.type = v.toJS;
  }
}

class TestMatchRequestDetails {
  TestMatchRequestDetails.fromJS(this._wrapped);

  TestMatchRequestDetails({
    /// The URL of the hypothetical request.
    required String url,

    /// The initiator URL (if any) for the hypothetical request.
    String? initiator,

    /// Standard HTTP method of the hypothetical request. Defaults to "get" for
    /// HTTP requests and is ignored for non-HTTP requests.
    RequestMethod? method,

    /// The resource type of the hypothetical request.
    required ResourceType type,

    /// The ID of the tab in which the hypothetical request takes place. Does
    /// not need to correspond to a real tab ID. Default is -1, meaning that
    /// the request isn't related to a tab.
    int? tabId,
  }) : _wrapped = $js.TestMatchRequestDetails(
          url: url,
          initiator: initiator,
          method: method?.toJS,
          type: type.toJS,
          tabId: tabId,
        );

  final $js.TestMatchRequestDetails _wrapped;

  $js.TestMatchRequestDetails get toJS => _wrapped;

  /// The URL of the hypothetical request.
  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// The initiator URL (if any) for the hypothetical request.
  String? get initiator => _wrapped.initiator;
  set initiator(String? v) {
    _wrapped.initiator = v;
  }

  /// Standard HTTP method of the hypothetical request. Defaults to "get" for
  /// HTTP requests and is ignored for non-HTTP requests.
  RequestMethod? get method => _wrapped.method?.let(RequestMethod.fromJS);
  set method(RequestMethod? v) {
    _wrapped.method = v?.toJS;
  }

  /// The resource type of the hypothetical request.
  ResourceType get type => ResourceType.fromJS(_wrapped.type);
  set type(ResourceType v) {
    _wrapped.type = v.toJS;
  }

  /// The ID of the tab in which the hypothetical request takes place. Does
  /// not need to correspond to a real tab ID. Default is -1, meaning that
  /// the request isn't related to a tab.
  int? get tabId => _wrapped.tabId;
  set tabId(int? v) {
    _wrapped.tabId = v;
  }
}

class MatchedRuleInfoDebug {
  MatchedRuleInfoDebug.fromJS(this._wrapped);

  MatchedRuleInfoDebug({
    required MatchedRule rule,

    /// Details about the request for which the rule was matched.
    required RequestDetails request,
  }) : _wrapped = $js.MatchedRuleInfoDebug(
          rule: rule.toJS,
          request: request.toJS,
        );

  final $js.MatchedRuleInfoDebug _wrapped;

  $js.MatchedRuleInfoDebug get toJS => _wrapped;

  MatchedRule get rule => MatchedRule.fromJS(_wrapped.rule);
  set rule(MatchedRule v) {
    _wrapped.rule = v.toJS;
  }

  /// Details about the request for which the rule was matched.
  RequestDetails get request => RequestDetails.fromJS(_wrapped.request);
  set request(RequestDetails v) {
    _wrapped.request = v.toJS;
  }
}

class DNRInfo {
  DNRInfo.fromJS(this._wrapped);

  DNRInfo({required List<Ruleset> ruleResources})
      : _wrapped =
            $js.DNRInfo(rule_resources: ruleResources.toJSArray((e) => e.toJS));

  final $js.DNRInfo _wrapped;

  $js.DNRInfo get toJS => _wrapped;

  List<Ruleset> get ruleResources => _wrapped.rule_resources.toDart
      .cast<$js.Ruleset>()
      .map((e) => Ruleset.fromJS(e))
      .toList();
  set ruleResources(List<Ruleset> v) {
    _wrapped.rule_resources = v.toJSArray((e) => e.toJS);
  }
}

class ManifestKeys {
  ManifestKeys.fromJS(this._wrapped);

  ManifestKeys({required DNRInfo declarativeNetRequest})
      : _wrapped = $js.ManifestKeys(
            declarative_net_request: declarativeNetRequest.toJS);

  final $js.ManifestKeys _wrapped;

  $js.ManifestKeys get toJS => _wrapped;

  DNRInfo get declarativeNetRequest =>
      DNRInfo.fromJS(_wrapped.declarative_net_request);
  set declarativeNetRequest(DNRInfo v) {
    _wrapped.declarative_net_request = v.toJS;
  }
}

class RegexOptions {
  RegexOptions.fromJS(this._wrapped);

  RegexOptions({
    /// The regular expresson to check.
    required String regex,

    /// Whether the `regex` specified is case sensitive. Default is
    /// true.
    bool? isCaseSensitive,

    /// Whether the `regex` specified requires capturing. Capturing is
    /// only required for redirect rules which specify a
    /// `regexSubstition` action. The default is false.
    bool? requireCapturing,
  }) : _wrapped = $js.RegexOptions(
          regex: regex,
          isCaseSensitive: isCaseSensitive,
          requireCapturing: requireCapturing,
        );

  final $js.RegexOptions _wrapped;

  $js.RegexOptions get toJS => _wrapped;

  /// The regular expresson to check.
  String get regex => _wrapped.regex;
  set regex(String v) {
    _wrapped.regex = v;
  }

  /// Whether the `regex` specified is case sensitive. Default is
  /// true.
  bool? get isCaseSensitive => _wrapped.isCaseSensitive;
  set isCaseSensitive(bool? v) {
    _wrapped.isCaseSensitive = v;
  }

  /// Whether the `regex` specified requires capturing. Capturing is
  /// only required for redirect rules which specify a
  /// `regexSubstition` action. The default is false.
  bool? get requireCapturing => _wrapped.requireCapturing;
  set requireCapturing(bool? v) {
    _wrapped.requireCapturing = v;
  }
}

class IsRegexSupportedResult {
  IsRegexSupportedResult.fromJS(this._wrapped);

  IsRegexSupportedResult({
    required bool isSupported,

    /// Specifies the reason why the regular expression is not supported. Only
    /// provided if `isSupported` is false.
    UnsupportedRegexReason? reason,
  }) : _wrapped = $js.IsRegexSupportedResult(
          isSupported: isSupported,
          reason: reason?.toJS,
        );

  final $js.IsRegexSupportedResult _wrapped;

  $js.IsRegexSupportedResult get toJS => _wrapped;

  bool get isSupported => _wrapped.isSupported;
  set isSupported(bool v) {
    _wrapped.isSupported = v;
  }

  /// Specifies the reason why the regular expression is not supported. Only
  /// provided if `isSupported` is false.
  UnsupportedRegexReason? get reason =>
      _wrapped.reason?.let(UnsupportedRegexReason.fromJS);
  set reason(UnsupportedRegexReason? v) {
    _wrapped.reason = v?.toJS;
  }
}

class TestMatchOutcomeResult {
  TestMatchOutcomeResult.fromJS(this._wrapped);

  TestMatchOutcomeResult(
      {
      /// The rules (if any) that match the hypothetical request.
      required List<MatchedRule> matchedRules})
      : _wrapped = $js.TestMatchOutcomeResult(
            matchedRules: matchedRules.toJSArray((e) => e.toJS));

  final $js.TestMatchOutcomeResult _wrapped;

  $js.TestMatchOutcomeResult get toJS => _wrapped;

  /// The rules (if any) that match the hypothetical request.
  List<MatchedRule> get matchedRules => _wrapped.matchedRules.toDart
      .cast<$js.MatchedRule>()
      .map((e) => MatchedRule.fromJS(e))
      .toList();
  set matchedRules(List<MatchedRule> v) {
    _wrapped.matchedRules = v.toJSArray((e) => e.toJS);
  }
}

class UpdateRuleOptions {
  UpdateRuleOptions.fromJS(this._wrapped);

  UpdateRuleOptions({
    /// IDs of the rules to remove. Any invalid IDs will be ignored.
    List<int>? removeRuleIds,

    /// Rules to add.
    List<Rule>? addRules,
  }) : _wrapped = $js.UpdateRuleOptions(
          removeRuleIds: removeRuleIds?.toJSArray((e) => e),
          addRules: addRules?.toJSArray((e) => e.toJS),
        );

  final $js.UpdateRuleOptions _wrapped;

  $js.UpdateRuleOptions get toJS => _wrapped;

  /// IDs of the rules to remove. Any invalid IDs will be ignored.
  List<int>? get removeRuleIds =>
      _wrapped.removeRuleIds?.toDart.cast<int>().map((e) => e).toList();
  set removeRuleIds(List<int>? v) {
    _wrapped.removeRuleIds = v?.toJSArray((e) => e);
  }

  /// Rules to add.
  List<Rule>? get addRules => _wrapped.addRules?.toDart
      .cast<$js.Rule>()
      .map((e) => Rule.fromJS(e))
      .toList();
  set addRules(List<Rule>? v) {
    _wrapped.addRules = v?.toJSArray((e) => e.toJS);
  }
}

class UpdateRulesetOptions {
  UpdateRulesetOptions.fromJS(this._wrapped);

  UpdateRulesetOptions({
    /// The set of ids corresponding to a static [Ruleset] that should be
    /// disabled.
    List<String>? disableRulesetIds,

    /// The set of ids corresponding to a static [Ruleset] that should be
    /// enabled.
    List<String>? enableRulesetIds,
  }) : _wrapped = $js.UpdateRulesetOptions(
          disableRulesetIds: disableRulesetIds?.toJSArray((e) => e),
          enableRulesetIds: enableRulesetIds?.toJSArray((e) => e),
        );

  final $js.UpdateRulesetOptions _wrapped;

  $js.UpdateRulesetOptions get toJS => _wrapped;

  /// The set of ids corresponding to a static [Ruleset] that should be
  /// disabled.
  List<String>? get disableRulesetIds =>
      _wrapped.disableRulesetIds?.toDart.cast<String>().map((e) => e).toList();
  set disableRulesetIds(List<String>? v) {
    _wrapped.disableRulesetIds = v?.toJSArray((e) => e);
  }

  /// The set of ids corresponding to a static [Ruleset] that should be
  /// enabled.
  List<String>? get enableRulesetIds =>
      _wrapped.enableRulesetIds?.toDart.cast<String>().map((e) => e).toList();
  set enableRulesetIds(List<String>? v) {
    _wrapped.enableRulesetIds = v?.toJSArray((e) => e);
  }
}

class UpdateStaticRulesOptions {
  UpdateStaticRulesOptions.fromJS(this._wrapped);

  UpdateStaticRulesOptions({
    /// The id corresponding to a static [Ruleset].
    required String rulesetId,

    /// Set of ids corresponding to rules in the [Ruleset] to disable.
    List<int>? disableRuleIds,

    /// Set of ids corresponding to rules in the [Ruleset] to enable.
    List<int>? enableRuleIds,
  }) : _wrapped = $js.UpdateStaticRulesOptions(
          rulesetId: rulesetId,
          disableRuleIds: disableRuleIds?.toJSArray((e) => e),
          enableRuleIds: enableRuleIds?.toJSArray((e) => e),
        );

  final $js.UpdateStaticRulesOptions _wrapped;

  $js.UpdateStaticRulesOptions get toJS => _wrapped;

  /// The id corresponding to a static [Ruleset].
  String get rulesetId => _wrapped.rulesetId;
  set rulesetId(String v) {
    _wrapped.rulesetId = v;
  }

  /// Set of ids corresponding to rules in the [Ruleset] to disable.
  List<int>? get disableRuleIds =>
      _wrapped.disableRuleIds?.toDart.cast<int>().map((e) => e).toList();
  set disableRuleIds(List<int>? v) {
    _wrapped.disableRuleIds = v?.toJSArray((e) => e);
  }

  /// Set of ids corresponding to rules in the [Ruleset] to enable.
  List<int>? get enableRuleIds =>
      _wrapped.enableRuleIds?.toDart.cast<int>().map((e) => e).toList();
  set enableRuleIds(List<int>? v) {
    _wrapped.enableRuleIds = v?.toJSArray((e) => e);
  }
}

class GetDisabledRuleIdsOptions {
  GetDisabledRuleIdsOptions.fromJS(this._wrapped);

  GetDisabledRuleIdsOptions(
      {
      /// The id corresponding to a static [Ruleset].
      required String rulesetId})
      : _wrapped = $js.GetDisabledRuleIdsOptions(rulesetId: rulesetId);

  final $js.GetDisabledRuleIdsOptions _wrapped;

  $js.GetDisabledRuleIdsOptions get toJS => _wrapped;

  /// The id corresponding to a static [Ruleset].
  String get rulesetId => _wrapped.rulesetId;
  set rulesetId(String v) {
    _wrapped.rulesetId = v;
  }
}

class TabActionCountUpdate {
  TabActionCountUpdate.fromJS(this._wrapped);

  TabActionCountUpdate({
    /// The tab for which to update the action count.
    required int tabId,

    /// The amount to increment the tab's action count by. Negative values will
    /// decrement the count.
    required int increment,
  }) : _wrapped = $js.TabActionCountUpdate(
          tabId: tabId,
          increment: increment,
        );

  final $js.TabActionCountUpdate _wrapped;

  $js.TabActionCountUpdate get toJS => _wrapped;

  /// The tab for which to update the action count.
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }

  /// The amount to increment the tab's action count by. Negative values will
  /// decrement the count.
  int get increment => _wrapped.increment;
  set increment(int v) {
    _wrapped.increment = v;
  }
}

class ExtensionActionOptions {
  ExtensionActionOptions.fromJS(this._wrapped);

  ExtensionActionOptions({
    /// Whether to automatically display the action count for a page as the
    /// extension's badge text. This preference is persisted across sessions.
    bool? displayActionCountAsBadgeText,

    /// Details of how the tab's action count should be adjusted.
    TabActionCountUpdate? tabUpdate,
  }) : _wrapped = $js.ExtensionActionOptions(
          displayActionCountAsBadgeText: displayActionCountAsBadgeText,
          tabUpdate: tabUpdate?.toJS,
        );

  final $js.ExtensionActionOptions _wrapped;

  $js.ExtensionActionOptions get toJS => _wrapped;

  /// Whether to automatically display the action count for a page as the
  /// extension's badge text. This preference is persisted across sessions.
  bool? get displayActionCountAsBadgeText =>
      _wrapped.displayActionCountAsBadgeText;
  set displayActionCountAsBadgeText(bool? v) {
    _wrapped.displayActionCountAsBadgeText = v;
  }

  /// Details of how the tab's action count should be adjusted.
  TabActionCountUpdate? get tabUpdate =>
      _wrapped.tabUpdate?.let(TabActionCountUpdate.fromJS);
  set tabUpdate(TabActionCountUpdate? v) {
    _wrapped.tabUpdate = v?.toJS;
  }
}
