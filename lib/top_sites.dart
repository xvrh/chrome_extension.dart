// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'src/internal_helpers.dart';
import 'src/js/top_sites.dart' as $js;

export 'src/chrome.dart' show chrome, EventStream;

final _topSites = ChromeTopSites._();

extension ChromeTopSitesExtension on Chrome {
  /// Use the `chrome.topSites` API to access the top sites (i.e. most visited
  /// sites) that are displayed on the new tab page. These do not include
  /// shortcuts customized by the user.
  ChromeTopSites get topSites => _topSites;
}

class ChromeTopSites {
  ChromeTopSites._();

  bool get isAvailable => $js.chrome.topSitesNullable != null && alwaysTrue;

  /// Gets a list of top sites.
  Future<List<MostVisitedURL>> get() async {
    var $res = await $js.chrome.topSites.get().toDart;
    final dartified = $res.dartify() as List? ?? [];
    return dartified
        .map<MostVisitedURL>(
          (e) => MostVisitedURL.fromJS(e as $js.MostVisitedURL),
        )
        .toList();
  }
}

class MostVisitedURL {
  MostVisitedURL.fromJS(this._wrapped);

  MostVisitedURL({
    /// The most visited URL.
    required String url,

    /// The title of the page
    required String title,
  }) : _wrapped = $js.MostVisitedURL(url: url, title: title);

  final $js.MostVisitedURL _wrapped;

  $js.MostVisitedURL get toJS => _wrapped;

  /// The most visited URL.
  String get url => _wrapped.url;

  set url(String v) {
    _wrapped.url = v;
  }

  /// The title of the page
  String get title => _wrapped.title;

  set title(String v) {
    _wrapped.title = v;
  }
}
