// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/history.dart' as $js;

export 'src/chrome.dart' show chrome;

final _history = ChromeHistory._();

extension ChromeHistoryExtension on Chrome {
  /// Use the `chrome.history` API to interact with the browser's record of
  /// visited pages. You can add, remove, and query for URLs in the browser's
  /// history. To override the history page with your own version, see [Override
  /// Pages](override).
  ChromeHistory get history => _history;
}

class ChromeHistory {
  ChromeHistory._();

  bool get isAvailable => $js.chrome.historyNullable != null && alwaysTrue;

  /// Searches the history for the last visit time of each page matching the
  /// query.
  Future<List<HistoryItem>> search(SearchQuery query) async {
    var $res =
        await promiseToFuture<JSArray>($js.chrome.history.search(query.toJS));
    return $res.toDart
        .cast<$js.HistoryItem>()
        .map((e) => HistoryItem.fromJS(e))
        .toList();
  }

  /// Retrieves information about visits to a URL.
  Future<List<VisitItem>> getVisits(UrlDetails details) async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.history.getVisits(details.toJS));
    return $res.toDart
        .cast<$js.VisitItem>()
        .map((e) => VisitItem.fromJS(e))
        .toList();
  }

  /// Adds a URL to the history at the current time with a [transition
  /// type](#transition_types) of "link".
  Future<void> addUrl(UrlDetails details) async {
    await promiseToFuture<void>($js.chrome.history.addUrl(details.toJS));
  }

  /// Removes all occurrences of the given URL from the history.
  Future<void> deleteUrl(UrlDetails details) async {
    await promiseToFuture<void>($js.chrome.history.deleteUrl(details.toJS));
  }

  /// Removes all items within the specified date range from the history.  Pages
  /// will not be removed from the history unless all visits fall within the
  /// range.
  Future<void> deleteRange(DeleteRangeRange range) async {
    await promiseToFuture<void>($js.chrome.history.deleteRange(range.toJS));
  }

  /// Deletes all items from the history.
  Future<void> deleteAll() async {
    await promiseToFuture<void>($js.chrome.history.deleteAll());
  }

  /// Fired when a URL is visited, providing the HistoryItem data for that URL.
  /// This event fires before the page has loaded.
  EventStream<HistoryItem> get onVisited =>
      $js.chrome.history.onVisited.asStream(($c) => ($js.HistoryItem result) {
            return $c(HistoryItem.fromJS(result));
          });

  /// Fired when one or more URLs are removed from the history service.  When
  /// all visits have been removed the URL is purged from history.
  EventStream<OnVisitRemovedRemoved> get onVisitRemoved =>
      $js.chrome.history.onVisitRemoved
          .asStream(($c) => ($js.OnVisitRemovedRemoved removed) {
                return $c(OnVisitRemovedRemoved.fromJS(removed));
              });
}

/// The [transition type](#transition_types) for this visit from its referrer.
enum TransitionType {
  link('link'),
  typed('typed'),
  autoBookmark('auto_bookmark'),
  autoSubframe('auto_subframe'),
  manualSubframe('manual_subframe'),
  generated('generated'),
  autoToplevel('auto_toplevel'),
  formSubmit('form_submit'),
  reload('reload'),
  keyword('keyword'),
  keywordGenerated('keyword_generated');

  const TransitionType(this.value);

  final String value;

  String get toJS => value;
  static TransitionType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class HistoryItem {
  HistoryItem.fromJS(this._wrapped);

  HistoryItem({
    /// The unique identifier for the item.
    required String id,

    /// The URL navigated to by a user.
    String? url,

    /// The title of the page when it was last loaded.
    String? title,

    /// When this page was last loaded, represented in milliseconds since the
    /// epoch.
    double? lastVisitTime,

    /// The number of times the user has navigated to this page.
    int? visitCount,

    /// The number of times the user has navigated to this page by typing in the
    /// address.
    int? typedCount,
  }) : _wrapped = $js.HistoryItem(
          id: id,
          url: url,
          title: title,
          lastVisitTime: lastVisitTime,
          visitCount: visitCount,
          typedCount: typedCount,
        );

  final $js.HistoryItem _wrapped;

  $js.HistoryItem get toJS => _wrapped;

  /// The unique identifier for the item.
  String get id => _wrapped.id;
  set id(String v) {
    _wrapped.id = v;
  }

  /// The URL navigated to by a user.
  String? get url => _wrapped.url;
  set url(String? v) {
    _wrapped.url = v;
  }

  /// The title of the page when it was last loaded.
  String? get title => _wrapped.title;
  set title(String? v) {
    _wrapped.title = v;
  }

  /// When this page was last loaded, represented in milliseconds since the
  /// epoch.
  double? get lastVisitTime => _wrapped.lastVisitTime;
  set lastVisitTime(double? v) {
    _wrapped.lastVisitTime = v;
  }

  /// The number of times the user has navigated to this page.
  int? get visitCount => _wrapped.visitCount;
  set visitCount(int? v) {
    _wrapped.visitCount = v;
  }

  /// The number of times the user has navigated to this page by typing in the
  /// address.
  int? get typedCount => _wrapped.typedCount;
  set typedCount(int? v) {
    _wrapped.typedCount = v;
  }
}

class VisitItem {
  VisitItem.fromJS(this._wrapped);

  VisitItem({
    /// The unique identifier for the item.
    required String id,

    /// The unique identifier for this visit.
    required String visitId,

    /// When this visit occurred, represented in milliseconds since the epoch.
    double? visitTime,

    /// The visit ID of the referrer.
    required String referringVisitId,

    /// The [transition type](#transition_types) for this visit from its
    /// referrer.
    required TransitionType transition,
  }) : _wrapped = $js.VisitItem(
          id: id,
          visitId: visitId,
          visitTime: visitTime,
          referringVisitId: referringVisitId,
          transition: transition.toJS,
        );

  final $js.VisitItem _wrapped;

  $js.VisitItem get toJS => _wrapped;

  /// The unique identifier for the item.
  String get id => _wrapped.id;
  set id(String v) {
    _wrapped.id = v;
  }

  /// The unique identifier for this visit.
  String get visitId => _wrapped.visitId;
  set visitId(String v) {
    _wrapped.visitId = v;
  }

  /// When this visit occurred, represented in milliseconds since the epoch.
  double? get visitTime => _wrapped.visitTime;
  set visitTime(double? v) {
    _wrapped.visitTime = v;
  }

  /// The visit ID of the referrer.
  String get referringVisitId => _wrapped.referringVisitId;
  set referringVisitId(String v) {
    _wrapped.referringVisitId = v;
  }

  /// The [transition type](#transition_types) for this visit from its referrer.
  TransitionType get transition => TransitionType.fromJS(_wrapped.transition);
  set transition(TransitionType v) {
    _wrapped.transition = v.toJS;
  }
}

class UrlDetails {
  UrlDetails.fromJS(this._wrapped);

  UrlDetails(
      {
      /// The URL for the operation. It must be in the format as returned from a
      /// call to history.search.
      required String url})
      : _wrapped = $js.UrlDetails(url: url);

  final $js.UrlDetails _wrapped;

  $js.UrlDetails get toJS => _wrapped;

  /// The URL for the operation. It must be in the format as returned from a
  /// call to history.search.
  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }
}

class OnVisitRemovedRemoved {
  OnVisitRemovedRemoved.fromJS(this._wrapped);

  OnVisitRemovedRemoved({
    /// True if all history was removed.  If true, then urls will be empty.
    required bool allHistory,
    List<String>? urls,
  }) : _wrapped = $js.OnVisitRemovedRemoved(
          allHistory: allHistory,
          urls: urls?.toJSArray((e) => e),
        );

  final $js.OnVisitRemovedRemoved _wrapped;

  $js.OnVisitRemovedRemoved get toJS => _wrapped;

  /// True if all history was removed.  If true, then urls will be empty.
  bool get allHistory => _wrapped.allHistory;
  set allHistory(bool v) {
    _wrapped.allHistory = v;
  }

  List<String>? get urls =>
      _wrapped.urls?.toDart.cast<String>().map((e) => e).toList();
  set urls(List<String>? v) {
    _wrapped.urls = v?.toJSArray((e) => e);
  }
}

class SearchQuery {
  SearchQuery.fromJS(this._wrapped);

  SearchQuery({
    /// A free-text query to the history service.  Leave empty to retrieve all
    /// pages.
    required String text,

    /// Limit results to those visited after this date, represented in
    /// milliseconds since the epoch. If not specified, this defaults to 24
    /// hours in the past.
    double? startTime,

    /// Limit results to those visited before this date, represented in
    /// milliseconds since the epoch.
    double? endTime,

    /// The maximum number of results to retrieve.  Defaults to 100.
    int? maxResults,
  }) : _wrapped = $js.SearchQuery(
          text: text,
          startTime: startTime,
          endTime: endTime,
          maxResults: maxResults,
        );

  final $js.SearchQuery _wrapped;

  $js.SearchQuery get toJS => _wrapped;

  /// A free-text query to the history service.  Leave empty to retrieve all
  /// pages.
  String get text => _wrapped.text;
  set text(String v) {
    _wrapped.text = v;
  }

  /// Limit results to those visited after this date, represented in
  /// milliseconds since the epoch. If not specified, this defaults to 24 hours
  /// in the past.
  double? get startTime => _wrapped.startTime;
  set startTime(double? v) {
    _wrapped.startTime = v;
  }

  /// Limit results to those visited before this date, represented in
  /// milliseconds since the epoch.
  double? get endTime => _wrapped.endTime;
  set endTime(double? v) {
    _wrapped.endTime = v;
  }

  /// The maximum number of results to retrieve.  Defaults to 100.
  int? get maxResults => _wrapped.maxResults;
  set maxResults(int? v) {
    _wrapped.maxResults = v;
  }
}

class DeleteRangeRange {
  DeleteRangeRange.fromJS(this._wrapped);

  DeleteRangeRange({
    /// Items added to history after this date, represented in milliseconds
    /// since the epoch.
    required double startTime,

    /// Items added to history before this date, represented in milliseconds
    /// since the epoch.
    required double endTime,
  }) : _wrapped = $js.DeleteRangeRange(
          startTime: startTime,
          endTime: endTime,
        );

  final $js.DeleteRangeRange _wrapped;

  $js.DeleteRangeRange get toJS => _wrapped;

  /// Items added to history after this date, represented in milliseconds since
  /// the epoch.
  double get startTime => _wrapped.startTime;
  set startTime(double v) {
    _wrapped.startTime = v;
  }

  /// Items added to history before this date, represented in milliseconds since
  /// the epoch.
  double get endTime => _wrapped.endTime;
  set endTime(double v) {
    _wrapped.endTime = v;
  }
}
