// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import
// ignore_for_file: unintended_html_in_doc_comment

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSOffscreenExtension on JSChrome {
  @JS('offscreen')
  external JSOffscreen? get offscreenNullable;

  /// Use the `offscreen` API to create and manage offscreen documents.
  JSOffscreen get offscreen {
    var offscreenNullable = this.offscreenNullable;
    if (offscreenNullable == null) {
      throw ApiNotAvailableException('chrome.offscreen');
    }
    return offscreenNullable;
  }
}

extension type JSOffscreen._(JSObject _) {
  /// Creates a new offscreen document for the extension.
  /// |parameters|: The parameters describing the offscreen document to create.
  /// |Returns|: Promise that resolves when the offscreen document is created
  /// and has completed its initial page load.
  external JSPromise createDocument(CreateParameters parameters);

  /// Closes the currently-open offscreen document for the extension.
  /// |Returns|: Promise that resolves when the offscreen document has been
  /// closed.
  external JSPromise closeDocument();

  /// Determines whether the extension has an active document.
  /// |Returns|: Promise that resolves with the result of whether the
  /// extension has an active offscreen document.
  external JSPromise<JSBoolean> hasDocument();
}

typedef Reason = JSString;
extension type CreateParameters._(JSObject _) implements JSObject {
  external factory CreateParameters({
    /// The reason(s) the extension is creating the offscreen document.
    JSArray reasons,

    /// The (relative) URL to load in the document.
    String url,

    /// A developer-provided string that explains, in more detail, the need for
    /// the background context. The user agent _may_ use this in display to the
    /// user.
    String justification,
  });

  /// The reason(s) the extension is creating the offscreen document.
  external JSArray reasons;

  /// The (relative) URL to load in the document.
  external String url;

  /// A developer-provided string that explains, in more detail, the need for
  /// the background context. The user agent _may_ use this in display to the
  /// user.
  external String justification;
}
