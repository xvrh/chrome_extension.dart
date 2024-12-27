// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import
// ignore_for_file: unintended_html_in_doc_comment

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSPageCaptureExtension on JSChrome {
  @JS('pageCapture')
  external JSPageCapture? get pageCaptureNullable;

  /// Use the `chrome.pageCapture` API to save a tab as MHTML.
  JSPageCapture get pageCapture {
    var pageCaptureNullable = this.pageCaptureNullable;
    if (pageCaptureNullable == null) {
      throw ApiNotAvailableException('chrome.pageCapture');
    }
    return pageCaptureNullable;
  }
}

extension type JSPageCapture._(JSObject _) {
  /// Saves the content of the tab with given id as MHTML.
  external JSPromise saveAsMHTML(SaveAsMhtmlDetails details);
}
extension type SaveAsMhtmlDetails._(JSObject _) implements JSObject {
  external factory SaveAsMhtmlDetails(
      {
      /// The id of the tab to save as MHTML.
      int tabId});

  /// The id of the tab to save as MHTML.
  external int tabId;
}
