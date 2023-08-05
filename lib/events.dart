// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/events.dart' as $js;

export 'src/chrome.dart' show chrome;

final _events = ChromeEvents._();

extension ChromeEventsExtension on Chrome {
  /// The `chrome.events` namespace contains common types used by APIs
  /// dispatching events to notify you when something interesting happens.
  ChromeEvents get events => _events;
}

class ChromeEvents {
  ChromeEvents._();

  bool get isAvailable => $js.chrome.eventsNullable != null && alwaysTrue;
}

class Rule {
  Rule.fromJS(this._wrapped);

  Rule({
    /// Optional identifier that allows referencing this rule.
    String? id,

    /// Tags can be used to annotate rules and perform operations on sets of
    /// rules.
    List<String>? tags,

    /// List of conditions that can trigger the actions.
    required List<Object> conditions,

    /// List of actions that are triggered if one of the conditions is
    /// fulfilled.
    required List<Object> actions,

    /// Optional priority of this rule. Defaults to 100.
    int? priority,
  }) : _wrapped = $js.Rule(
          id: id,
          tags: tags?.toJSArray((e) => e),
          conditions: conditions.toJSArray((e) => e.jsify()!),
          actions: actions.toJSArray((e) => e.jsify()!),
          priority: priority,
        );

  final $js.Rule _wrapped;

  $js.Rule get toJS => _wrapped;

  /// Optional identifier that allows referencing this rule.
  String? get id => _wrapped.id;
  set id(String? v) {
    _wrapped.id = v;
  }

  /// Tags can be used to annotate rules and perform operations on sets of
  /// rules.
  List<String>? get tags =>
      _wrapped.tags?.toDart.cast<String>().map((e) => e).toList();
  set tags(List<String>? v) {
    _wrapped.tags = v?.toJSArray((e) => e);
  }

  /// List of conditions that can trigger the actions.
  List<Object> get conditions => _wrapped.conditions.toDart
      .cast<JSAny>()
      .map((e) => e.dartify()!)
      .toList();
  set conditions(List<Object> v) {
    _wrapped.conditions = v.toJSArray((e) => e.jsify()!);
  }

  /// List of actions that are triggered if one of the conditions is fulfilled.
  List<Object> get actions =>
      _wrapped.actions.toDart.cast<JSAny>().map((e) => e.dartify()!).toList();
  set actions(List<Object> v) {
    _wrapped.actions = v.toJSArray((e) => e.jsify()!);
  }

  /// Optional priority of this rule. Defaults to 100.
  int? get priority => _wrapped.priority;
  set priority(int? v) {
    _wrapped.priority = v;
  }
}

class Event {
  Event.fromJS(this._wrapped);

  Event() : _wrapped = $js.Event();

  final $js.Event _wrapped;

  $js.Event get toJS => _wrapped;

  /// Registers an event listener _callback_ to an event.
  /// [callback] Called when an event occurs. The parameters of this function
  /// depend on the type of event.
  void addListener(Function callback) {
    _wrapped.addListener(allowInterop(callback));
  }

  /// Deregisters an event listener _callback_ from an event.
  /// [callback] Listener that shall be unregistered.
  void removeListener(Function callback) {
    _wrapped.removeListener(allowInterop(callback));
  }

  /// [callback] Listener whose registration status shall be tested.
  /// [returns] True if _callback_ is registered to the event.
  bool hasListener(Function callback) {
    return _wrapped.hasListener(allowInterop(callback));
  }

  /// [returns] True if any event listeners are registered to the event.
  bool hasListeners() {
    return _wrapped.hasListeners();
  }

  /// Registers rules to handle events.
  /// [eventName] Name of the event this function affects.
  /// [webViewInstanceId] If provided, this is an integer that uniquely
  /// identfies the <webview> associated with this function call.
  /// [rules] Rules to be registered. These do not replace previously
  /// registered rules.
  /// [returns] Called with registered rules.
  Future<List<Rule>> addRules(
    String eventName,
    int webViewInstanceId,
    List<Rule> rules,
  ) {
    var $completer = Completer<List<Rule>>();
    _wrapped.addRules(
      eventName,
      webViewInstanceId,
      rules.toJSArray((e) => e.toJS),
      (JSArray rules) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(rules.toDart
              .cast<$js.Rule>()
              .map((e) => Rule.fromJS(e))
              .toList());
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Returns currently registered rules.
  /// [eventName] Name of the event this function affects.
  /// [webViewInstanceId] If provided, this is an integer that uniquely
  /// identfies the <webview> associated with this function call.
  /// [ruleIdentifiers] If an array is passed, only rules with identifiers
  /// contained in this array are returned.
  /// [returns] Called with registered rules.
  Future<List<Rule>> getRules(
    String eventName,
    int webViewInstanceId,
    List<String>? ruleIdentifiers,
  ) {
    var $completer = Completer<List<Rule>>();
    _wrapped.getRules(
      eventName,
      webViewInstanceId,
      ruleIdentifiers?.toJSArray((e) => e),
      (JSArray rules) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(rules.toDart
              .cast<$js.Rule>()
              .map((e) => Rule.fromJS(e))
              .toList());
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Unregisters currently registered rules.
  /// [eventName] Name of the event this function affects.
  /// [webViewInstanceId] If provided, this is an integer that uniquely
  /// identfies the <webview> associated with this function call.
  /// [ruleIdentifiers] If an array is passed, only rules with identifiers
  /// contained in this array are unregistered.
  /// [returns] Called when rules were unregistered.
  Future<void> removeRules(
    String eventName,
    int webViewInstanceId,
    List<String>? ruleIdentifiers,
  ) {
    var $completer = Completer<void>();
    _wrapped.removeRules(
      eventName,
      webViewInstanceId,
      ruleIdentifiers?.toJSArray((e) => e),
      () {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(null);
        }
      }.toJS,
    );
    return $completer.future;
  }
}

class UrlFilter {
  UrlFilter.fromJS(this._wrapped);

  UrlFilter({
    /// Matches if the host name of the URL contains a specified string. To test
    /// whether a host name component has a prefix 'foo', use hostContains:
    /// '.foo'. This matches 'www.foobar.com' and 'foo.com', because an implicit
    /// dot is added at the beginning of the host name. Similarly, hostContains
    /// can be used to match against component suffix ('foo.') and to exactly
    /// match against components ('.foo.'). Suffix- and exact-matching for the
    /// last components need to be done separately using hostSuffix, because no
    /// implicit dot is added at the end of the host name.
    String? hostContains,

    /// Matches if the host name of the URL is equal to a specified string.
    String? hostEquals,

    /// Matches if the host name of the URL starts with a specified string.
    String? hostPrefix,

    /// Matches if the host name of the URL ends with a specified string.
    String? hostSuffix,

    /// Matches if the path segment of the URL contains a specified string.
    String? pathContains,

    /// Matches if the path segment of the URL is equal to a specified string.
    String? pathEquals,

    /// Matches if the path segment of the URL starts with a specified string.
    String? pathPrefix,

    /// Matches if the path segment of the URL ends with a specified string.
    String? pathSuffix,

    /// Matches if the query segment of the URL contains a specified string.
    String? queryContains,

    /// Matches if the query segment of the URL is equal to a specified string.
    String? queryEquals,

    /// Matches if the query segment of the URL starts with a specified string.
    String? queryPrefix,

    /// Matches if the query segment of the URL ends with a specified string.
    String? querySuffix,

    /// Matches if the URL (without fragment identifier) contains a specified
    /// string. Port numbers are stripped from the URL if they match the default
    /// port number.
    String? urlContains,

    /// Matches if the URL (without fragment identifier) is equal to a specified
    /// string. Port numbers are stripped from the URL if they match the default
    /// port number.
    String? urlEquals,

    /// Matches if the URL (without fragment identifier) matches a specified
    /// regular expression. Port numbers are stripped from the URL if they match
    /// the default port number. The regular expressions use the [RE2
    /// syntax](https://github.com/google/re2/blob/master/doc/syntax.txt).
    String? urlMatches,

    /// Matches if the URL without query segment and fragment identifier matches
    /// a specified regular expression. Port numbers are stripped from the URL
    /// if they match the default port number. The regular expressions use the
    /// [RE2 syntax](https://github.com/google/re2/blob/master/doc/syntax.txt).
    String? originAndPathMatches,

    /// Matches if the URL (without fragment identifier) starts with a specified
    /// string. Port numbers are stripped from the URL if they match the default
    /// port number.
    String? urlPrefix,

    /// Matches if the URL (without fragment identifier) ends with a specified
    /// string. Port numbers are stripped from the URL if they match the default
    /// port number.
    String? urlSuffix,

    /// Matches if the scheme of the URL is equal to any of the schemes
    /// specified in the array.
    List<String>? schemes,

    /// Matches if the port of the URL is contained in any of the specified port
    /// lists. For example `[80, 443, [1000, 1200]]` matches all requests on
    /// port 80, 443 and in the range 1000-1200.
    List<Object>? ports,
  }) : _wrapped = $js.UrlFilter(
          hostContains: hostContains,
          hostEquals: hostEquals,
          hostPrefix: hostPrefix,
          hostSuffix: hostSuffix,
          pathContains: pathContains,
          pathEquals: pathEquals,
          pathPrefix: pathPrefix,
          pathSuffix: pathSuffix,
          queryContains: queryContains,
          queryEquals: queryEquals,
          queryPrefix: queryPrefix,
          querySuffix: querySuffix,
          urlContains: urlContains,
          urlEquals: urlEquals,
          urlMatches: urlMatches,
          originAndPathMatches: originAndPathMatches,
          urlPrefix: urlPrefix,
          urlSuffix: urlSuffix,
          schemes: schemes?.toJSArray((e) => e),
          ports: ports?.toJSArray((e) => switch (e) {
                int() => e,
                List<int>() => e.toJSArray((e) => e),
                _ => throw UnsupportedError(
                    'Received type: ${e.runtimeType}. Supported types are: int, List<int>')
              }),
        );

  final $js.UrlFilter _wrapped;

  $js.UrlFilter get toJS => _wrapped;

  /// Matches if the host name of the URL contains a specified string. To test
  /// whether a host name component has a prefix 'foo', use hostContains:
  /// '.foo'. This matches 'www.foobar.com' and 'foo.com', because an implicit
  /// dot is added at the beginning of the host name. Similarly, hostContains
  /// can be used to match against component suffix ('foo.') and to exactly
  /// match against components ('.foo.'). Suffix- and exact-matching for the
  /// last components need to be done separately using hostSuffix, because no
  /// implicit dot is added at the end of the host name.
  String? get hostContains => _wrapped.hostContains;
  set hostContains(String? v) {
    _wrapped.hostContains = v;
  }

  /// Matches if the host name of the URL is equal to a specified string.
  String? get hostEquals => _wrapped.hostEquals;
  set hostEquals(String? v) {
    _wrapped.hostEquals = v;
  }

  /// Matches if the host name of the URL starts with a specified string.
  String? get hostPrefix => _wrapped.hostPrefix;
  set hostPrefix(String? v) {
    _wrapped.hostPrefix = v;
  }

  /// Matches if the host name of the URL ends with a specified string.
  String? get hostSuffix => _wrapped.hostSuffix;
  set hostSuffix(String? v) {
    _wrapped.hostSuffix = v;
  }

  /// Matches if the path segment of the URL contains a specified string.
  String? get pathContains => _wrapped.pathContains;
  set pathContains(String? v) {
    _wrapped.pathContains = v;
  }

  /// Matches if the path segment of the URL is equal to a specified string.
  String? get pathEquals => _wrapped.pathEquals;
  set pathEquals(String? v) {
    _wrapped.pathEquals = v;
  }

  /// Matches if the path segment of the URL starts with a specified string.
  String? get pathPrefix => _wrapped.pathPrefix;
  set pathPrefix(String? v) {
    _wrapped.pathPrefix = v;
  }

  /// Matches if the path segment of the URL ends with a specified string.
  String? get pathSuffix => _wrapped.pathSuffix;
  set pathSuffix(String? v) {
    _wrapped.pathSuffix = v;
  }

  /// Matches if the query segment of the URL contains a specified string.
  String? get queryContains => _wrapped.queryContains;
  set queryContains(String? v) {
    _wrapped.queryContains = v;
  }

  /// Matches if the query segment of the URL is equal to a specified string.
  String? get queryEquals => _wrapped.queryEquals;
  set queryEquals(String? v) {
    _wrapped.queryEquals = v;
  }

  /// Matches if the query segment of the URL starts with a specified string.
  String? get queryPrefix => _wrapped.queryPrefix;
  set queryPrefix(String? v) {
    _wrapped.queryPrefix = v;
  }

  /// Matches if the query segment of the URL ends with a specified string.
  String? get querySuffix => _wrapped.querySuffix;
  set querySuffix(String? v) {
    _wrapped.querySuffix = v;
  }

  /// Matches if the URL (without fragment identifier) contains a specified
  /// string. Port numbers are stripped from the URL if they match the default
  /// port number.
  String? get urlContains => _wrapped.urlContains;
  set urlContains(String? v) {
    _wrapped.urlContains = v;
  }

  /// Matches if the URL (without fragment identifier) is equal to a specified
  /// string. Port numbers are stripped from the URL if they match the default
  /// port number.
  String? get urlEquals => _wrapped.urlEquals;
  set urlEquals(String? v) {
    _wrapped.urlEquals = v;
  }

  /// Matches if the URL (without fragment identifier) matches a specified
  /// regular expression. Port numbers are stripped from the URL if they match
  /// the default port number. The regular expressions use the [RE2
  /// syntax](https://github.com/google/re2/blob/master/doc/syntax.txt).
  String? get urlMatches => _wrapped.urlMatches;
  set urlMatches(String? v) {
    _wrapped.urlMatches = v;
  }

  /// Matches if the URL without query segment and fragment identifier matches a
  /// specified regular expression. Port numbers are stripped from the URL if
  /// they match the default port number. The regular expressions use the [RE2
  /// syntax](https://github.com/google/re2/blob/master/doc/syntax.txt).
  String? get originAndPathMatches => _wrapped.originAndPathMatches;
  set originAndPathMatches(String? v) {
    _wrapped.originAndPathMatches = v;
  }

  /// Matches if the URL (without fragment identifier) starts with a specified
  /// string. Port numbers are stripped from the URL if they match the default
  /// port number.
  String? get urlPrefix => _wrapped.urlPrefix;
  set urlPrefix(String? v) {
    _wrapped.urlPrefix = v;
  }

  /// Matches if the URL (without fragment identifier) ends with a specified
  /// string. Port numbers are stripped from the URL if they match the default
  /// port number.
  String? get urlSuffix => _wrapped.urlSuffix;
  set urlSuffix(String? v) {
    _wrapped.urlSuffix = v;
  }

  /// Matches if the scheme of the URL is equal to any of the schemes specified
  /// in the array.
  List<String>? get schemes =>
      _wrapped.schemes?.toDart.cast<String>().map((e) => e).toList();
  set schemes(List<String>? v) {
    _wrapped.schemes = v?.toJSArray((e) => e);
  }

  /// Matches if the port of the URL is contained in any of the specified port
  /// lists. For example `[80, 443, [1000, 1200]]` matches all requests on port
  /// 80, 443 and in the range 1000-1200.
  List<Object>? get ports => _wrapped.ports?.toDart
      .cast<Object>()
      .map((e) => e.when(
            isInt: (v) => v,
            isArray: (v) => v.toDart.cast<int>().map((e) => e).toList(),
          ))
      .toList();
  set ports(List<Object>? v) {
    _wrapped.ports = v?.toJSArray((e) => switch (e) {
          int() => e,
          List<int>() => e.toJSArray((e) => e),
          _ => throw UnsupportedError(
              'Received type: ${e.runtimeType}. Supported types are: int, List<int>')
        });
  }
}
