// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSEventsExtension on JSChrome {
  @JS('events')
  external JSEvents? get eventsNullable;

  /// The `chrome.events` namespace contains common types used by APIs
  /// dispatching events to notify you when something interesting happens.
  JSEvents get events {
    var eventsNullable = this.eventsNullable;
    if (eventsNullable == null) {
      throw ApiNotAvailableException('chrome.events');
    }
    return eventsNullable;
  }
}

@JS()
@staticInterop
class JSEvents {}

extension JSEventsExtension on JSEvents {}

@JS()
@staticInterop
@anonymous
class Rule {
  external factory Rule({
    /// Optional identifier that allows referencing this rule.
    String? id,

    /// Tags can be used to annotate rules and perform operations on sets of
    /// rules.
    JSArray? tags,

    /// List of conditions that can trigger the actions.
    JSArray conditions,

    /// List of actions that are triggered if one of the conditions is fulfilled.
    JSArray actions,

    /// Optional priority of this rule. Defaults to 100.
    int? priority,
  });
}

extension RuleExtension on Rule {
  /// Optional identifier that allows referencing this rule.
  external String? id;

  /// Tags can be used to annotate rules and perform operations on sets of
  /// rules.
  external JSArray? tags;

  /// List of conditions that can trigger the actions.
  external JSArray conditions;

  /// List of actions that are triggered if one of the conditions is fulfilled.
  external JSArray actions;

  /// Optional priority of this rule. Defaults to 100.
  external int? priority;
}

@JS()
@staticInterop
@anonymous
class Event {
  external factory Event();
}

extension EventExtension on Event {
  /// Registers an event listener _callback_ to an event.
  external void addListener(

      /// Called when an event occurs. The parameters of this function depend on
      /// the type of event.
      Function callback);

  /// Deregisters an event listener _callback_ from an event.
  external void removeListener(

      /// Listener that shall be unregistered.
      Function callback);

  external bool hasListener(

      /// Listener whose registration status shall be tested.
      Function callback);

  external bool hasListeners();

  /// Registers rules to handle events.
  external void addRules(
    /// Name of the event this function affects.
    String eventName,

    /// If provided, this is an integer that uniquely identfies the <webview>
    /// associated with this function call.
    int webViewInstanceId,

    /// Rules to be registered. These do not replace previously registered
    /// rules.
    JSArray rules,

    /// Called with registered rules.
    JSFunction? callback,
  );

  /// Returns currently registered rules.
  external void getRules(
    /// Name of the event this function affects.
    String eventName,

    /// If provided, this is an integer that uniquely identfies the <webview>
    /// associated with this function call.
    int webViewInstanceId,

    /// If an array is passed, only rules with identifiers contained in this
    /// array are returned.
    JSArray? ruleIdentifiers,

    /// Called with registered rules.
    JSFunction callback,
  );

  /// Unregisters currently registered rules.
  external void removeRules(
    /// Name of the event this function affects.
    String eventName,

    /// If provided, this is an integer that uniquely identfies the <webview>
    /// associated with this function call.
    int webViewInstanceId,

    /// If an array is passed, only rules with identifiers contained in this
    /// array are unregistered.
    JSArray? ruleIdentifiers,

    /// Called when rules were unregistered.
    JSFunction? callback,
  );
}

@JS()
@staticInterop
@anonymous
class UrlFilter {
  external factory UrlFilter({
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

    /// Matches if the URL without query segment and fragment identifier matches a
    /// specified regular expression. Port numbers are stripped from the URL if
    /// they match the default port number. The regular expressions use the [RE2
    /// syntax](https://github.com/google/re2/blob/master/doc/syntax.txt).
    String? originAndPathMatches,

    /// Matches if the URL (without fragment identifier) starts with a specified
    /// string. Port numbers are stripped from the URL if they match the default
    /// port number.
    String? urlPrefix,

    /// Matches if the URL (without fragment identifier) ends with a specified
    /// string. Port numbers are stripped from the URL if they match the default
    /// port number.
    String? urlSuffix,

    /// Matches if the scheme of the URL is equal to any of the schemes specified
    /// in the array.
    JSArray? schemes,

    /// Matches if the port of the URL is contained in any of the specified port
    /// lists. For example `[80, 443, [1000, 1200]]` matches all requests on port
    /// 80, 443 and in the range 1000-1200.
    JSArray? ports,
  });
}

extension UrlFilterExtension on UrlFilter {
  /// Matches if the host name of the URL contains a specified string. To test
  /// whether a host name component has a prefix 'foo', use hostContains:
  /// '.foo'. This matches 'www.foobar.com' and 'foo.com', because an implicit
  /// dot is added at the beginning of the host name. Similarly, hostContains
  /// can be used to match against component suffix ('foo.') and to exactly
  /// match against components ('.foo.'). Suffix- and exact-matching for the
  /// last components need to be done separately using hostSuffix, because no
  /// implicit dot is added at the end of the host name.
  external String? hostContains;

  /// Matches if the host name of the URL is equal to a specified string.
  external String? hostEquals;

  /// Matches if the host name of the URL starts with a specified string.
  external String? hostPrefix;

  /// Matches if the host name of the URL ends with a specified string.
  external String? hostSuffix;

  /// Matches if the path segment of the URL contains a specified string.
  external String? pathContains;

  /// Matches if the path segment of the URL is equal to a specified string.
  external String? pathEquals;

  /// Matches if the path segment of the URL starts with a specified string.
  external String? pathPrefix;

  /// Matches if the path segment of the URL ends with a specified string.
  external String? pathSuffix;

  /// Matches if the query segment of the URL contains a specified string.
  external String? queryContains;

  /// Matches if the query segment of the URL is equal to a specified string.
  external String? queryEquals;

  /// Matches if the query segment of the URL starts with a specified string.
  external String? queryPrefix;

  /// Matches if the query segment of the URL ends with a specified string.
  external String? querySuffix;

  /// Matches if the URL (without fragment identifier) contains a specified
  /// string. Port numbers are stripped from the URL if they match the default
  /// port number.
  external String? urlContains;

  /// Matches if the URL (without fragment identifier) is equal to a specified
  /// string. Port numbers are stripped from the URL if they match the default
  /// port number.
  external String? urlEquals;

  /// Matches if the URL (without fragment identifier) matches a specified
  /// regular expression. Port numbers are stripped from the URL if they match
  /// the default port number. The regular expressions use the [RE2
  /// syntax](https://github.com/google/re2/blob/master/doc/syntax.txt).
  external String? urlMatches;

  /// Matches if the URL without query segment and fragment identifier matches a
  /// specified regular expression. Port numbers are stripped from the URL if
  /// they match the default port number. The regular expressions use the [RE2
  /// syntax](https://github.com/google/re2/blob/master/doc/syntax.txt).
  external String? originAndPathMatches;

  /// Matches if the URL (without fragment identifier) starts with a specified
  /// string. Port numbers are stripped from the URL if they match the default
  /// port number.
  external String? urlPrefix;

  /// Matches if the URL (without fragment identifier) ends with a specified
  /// string. Port numbers are stripped from the URL if they match the default
  /// port number.
  external String? urlSuffix;

  /// Matches if the scheme of the URL is equal to any of the schemes specified
  /// in the array.
  external JSArray? schemes;

  /// Matches if the port of the URL is contained in any of the specified port
  /// lists. For example `[80, 443, [1000, 1200]]` matches all requests on port
  /// 80, 443 and in the range 1000-1200.
  external JSArray? ports;
}
