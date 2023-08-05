// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/search.dart' as $js;

export 'src/chrome.dart' show chrome;

final _search = ChromeSearch._();

extension ChromeSearchExtension on Chrome {
  /// Use the `chrome.search` API to search via the default provider.
  ChromeSearch get search => _search;
}

class ChromeSearch {
  ChromeSearch._();

  bool get isAvailable => $js.chrome.searchNullable != null && alwaysTrue;

  /// Used to query the default search provider.
  /// In case of an error,
  /// [runtime.lastError] will be set.
  Future<void> query(QueryInfo queryInfo) async {
    await promiseToFuture<void>($js.chrome.search.query(queryInfo.toJS));
  }
}

enum Disposition {
  /// Display results in the calling tab or the tab from the active browser.
  currentTab('CURRENT_TAB'),

  /// Display search results in a new tab.
  newTab('NEW_TAB'),

  /// Display search results in a new window.
  newWindow('NEW_WINDOW');

  const Disposition(this.value);

  final String value;

  String get toJS => value;
  static Disposition fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class QueryInfo {
  QueryInfo.fromJS(this._wrapped);

  QueryInfo({
    /// String to query with the default search provider.
    required String text,

    /// Location where search results should be displayed.
    /// `CURRENT_TAB` is the default.
    Disposition? disposition,

    /// Location where search results should be displayed.
    /// `tabId` cannot be used with `disposition`.
    int? tabId,
  }) : _wrapped = $js.QueryInfo(
          text: text,
          disposition: disposition?.toJS,
          tabId: tabId,
        );

  final $js.QueryInfo _wrapped;

  $js.QueryInfo get toJS => _wrapped;

  /// String to query with the default search provider.
  String get text => _wrapped.text;
  set text(String v) {
    _wrapped.text = v;
  }

  /// Location where search results should be displayed.
  /// `CURRENT_TAB` is the default.
  Disposition? get disposition => _wrapped.disposition?.let(Disposition.fromJS);
  set disposition(Disposition? v) {
    _wrapped.disposition = v?.toJS;
  }

  /// Location where search results should be displayed.
  /// `tabId` cannot be used with `disposition`.
  int? get tabId => _wrapped.tabId;
  set tabId(int? v) {
    _wrapped.tabId = v;
  }
}
