// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSDocumentScanExtension on JSChrome {
  @JS('documentScan')
  external JSDocumentScan? get documentScanNullable;

  /// Use the `chrome.documentScan` API to discover and retrieve
  /// images from attached paper document scanners.
  JSDocumentScan get documentScan {
    var documentScanNullable = this.documentScanNullable;
    if (documentScanNullable == null) {
      throw ApiNotAvailableException('chrome.documentScan');
    }
    return documentScanNullable;
  }
}

@JS()
@staticInterop
class JSDocumentScan {}

extension JSDocumentScanExtension on JSDocumentScan {
  /// Performs a document scan.  On success, the PNG data will be
  /// sent to the callback.
  /// |options| : Object containing scan parameters.
  /// |callback| : Called with the result and data from the scan.
  external JSPromise scan(ScanOptions options);
}

@JS()
@staticInterop
@anonymous
class ScanOptions {
  external factory ScanOptions({
    /// The MIME types that are accepted by the caller.
    JSArray? mimeTypes,

    /// The number of scanned images allowed (defaults to 1).
    int? maxImages,
  });
}

extension ScanOptionsExtension on ScanOptions {
  /// The MIME types that are accepted by the caller.
  external JSArray? mimeTypes;

  /// The number of scanned images allowed (defaults to 1).
  external int? maxImages;
}

@JS()
@staticInterop
@anonymous
class ScanResults {
  external factory ScanResults({
    /// The data image URLs in a form that can be passed as the "src" value to
    /// an image tag.
    JSArray dataUrls,

    /// The MIME type of `dataUrls`.
    String mimeType,
  });
}

extension ScanResultsExtension on ScanResults {
  /// The data image URLs in a form that can be passed as the "src" value to
  /// an image tag.
  external JSArray dataUrls;

  /// The MIME type of `dataUrls`.
  external String mimeType;
}
