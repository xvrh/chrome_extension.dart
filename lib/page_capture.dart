// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'src/internal_helpers.dart';
import 'src/js/page_capture.dart' as $js;

export 'src/chrome.dart' show chrome, EventStream;

final _pageCapture = ChromePageCapture._();

extension ChromePageCaptureExtension on Chrome {
  /// Use the `chrome.pageCapture` API to save a tab as MHTML.
  ChromePageCapture get pageCapture => _pageCapture;
}

class ChromePageCapture {
  ChromePageCapture._();

  bool get isAvailable => $js.chrome.pageCaptureNullable != null && alwaysTrue;

  /// Saves the content of the tab with given id as MHTML.
  /// [returns] Resolves when the MHTML has been generated.
  Future<JSObject?> saveAsMHTML(SaveAsMhtmlDetails details) async {
    var $res = await $js.chrome.pageCapture.saveAsMHTML(details.toJS).toDart;
    return $res;
  }
}

class SaveAsMhtmlDetails {
  SaveAsMhtmlDetails.fromJS(this._wrapped);

  SaveAsMhtmlDetails(
      {
      /// The id of the tab to save as MHTML.
      required int tabId})
      : _wrapped = $js.SaveAsMhtmlDetails(tabId: tabId);

  final $js.SaveAsMhtmlDetails _wrapped;

  $js.SaveAsMhtmlDetails get toJS => _wrapped;

  /// The id of the tab to save as MHTML.
  int get tabId => _wrapped.tabId;

  set tabId(int v) {
    _wrapped.tabId = v;
  }
}
