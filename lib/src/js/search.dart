// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import
// ignore_for_file: unintended_html_in_doc_comment

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

extension type JSSearch._(JSObject _) {
  /// Used to query the default search provider.
  /// In case of an error,
  /// [runtime.lastError] will be set.
  external JSPromise query(QueryInfo queryInfo);
}

typedef Disposition = String;
extension type QueryInfo._(JSObject _) implements JSObject {
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

  /// String to query with the default search provider.
  external String text;

  /// Location where search results should be displayed.
  /// `CURRENT_TAB` is the default.
  external Disposition? disposition;

  /// Location where search results should be displayed.
  /// `tabId` cannot be used with `disposition`.
  external int? tabId;
}
