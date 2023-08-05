// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

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

@JS()
@staticInterop
class JSPageCapture {}

extension JSPageCaptureExtension on JSPageCapture {
  /// Saves the content of the tab with given id as MHTML.
  external void saveAsMHTML(
    SaveAsMhtmlDetails details,

    /// Called when the MHTML has been generated.
    JSFunction callback,
  );
}

@JS()
@staticInterop
@anonymous
class SaveAsMhtmlDetails {
  external factory SaveAsMhtmlDetails(
      {
      /// The id of the tab to save as MHTML.
      int tabId});
}

extension SaveAsMhtmlDetailsExtension on SaveAsMhtmlDetails {
  /// The id of the tab to save as MHTML.
  external int tabId;
}
