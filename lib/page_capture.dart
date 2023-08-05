// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:typed_data';
import 'src/internal_helpers.dart';
import 'src/js/page_capture.dart' as $js;

export 'src/chrome.dart' show chrome;

final _pageCapture = ChromePageCapture._();

extension ChromePageCaptureExtension on Chrome {
  /// Use the `chrome.pageCapture` API to save a tab as MHTML.
  ChromePageCapture get pageCapture => _pageCapture;
}

class ChromePageCapture {
  ChromePageCapture._();

  bool get isAvailable => $js.chrome.pageCaptureNullable != null && alwaysTrue;

  /// Saves the content of the tab with given id as MHTML.
  /// [returns] Called when the MHTML has been generated.
  Future<ByteBuffer?> saveAsMHTML(SaveAsMhtmlDetails details) {
    var $completer = Completer<ByteBuffer?>();
    $js.chrome.pageCapture.saveAsMHTML(
      details.toJS,
      (JSArrayBuffer? mhtmlData) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(mhtmlData?.toDart);
        }
      }.toJS,
    );
    return $completer.future;
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
