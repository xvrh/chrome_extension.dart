// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSSearchExtension on JSChrome {
  @JS('search')
  external JSSearch? get searchNullable;

  /// Use the `chrome.search` API to search via the default provider.
  JSSearch get search {
    var searchNullable = this.searchNullable;
    if (searchNullable == null) {
      throw ApiNotAvailableException('chrome.search');
    }
    return searchNullable;
  }
}

@JS()
@staticInterop
class JSSearch {}

extension JSSearchExtension on JSSearch {
  /// Used to query the default search provider.
  /// In case of an error,
  /// [runtime.lastError] will be set.
  external JSPromise query(QueryInfo queryInfo);
}

typedef Disposition = String;

@JS()
@staticInterop
@anonymous
class QueryInfo {
  external factory QueryInfo({
    /// String to query with the default search provider.
    String text,

    /// Location where search results should be displayed.
    /// `CURRENT_TAB` is the default.
    Disposition? disposition,

    /// Location where search results should be displayed.
    /// `tabId` cannot be used with `disposition`.
    int? tabId,
  });
}

extension QueryInfoExtension on QueryInfo {
  /// String to query with the default search provider.
  external String text;

  /// Location where search results should be displayed.
  /// `CURRENT_TAB` is the default.
  external Disposition? disposition;

  /// Location where search results should be displayed.
  /// `tabId` cannot be used with `disposition`.
  external int? tabId;
}
