// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSExtensionTypesExtension on JSChrome {
  @JS('extensionTypes')
  external JSExtensionTypes? get extensionTypesNullable;

  /// The `chrome.extensionTypes` API contains type declarations for Chrome
  /// extensions.
  JSExtensionTypes get extensionTypes {
    var extensionTypesNullable = this.extensionTypesNullable;
    if (extensionTypesNullable == null) {
      throw ApiNotAvailableException('chrome.extensionTypes');
    }
    return extensionTypesNullable;
  }
}

@JS()
@staticInterop
class JSExtensionTypes {}

extension JSExtensionTypesExtension on JSExtensionTypes {}

/// The format of an image.
typedef ImageFormat = String;

/// The soonest that the JavaScript or CSS will be injected into the tab.
typedef RunAt = String;

/// The [origin](https://www.w3.org/TR/css3-cascade/#cascading-origins) of
/// injected CSS.
typedef CSSOrigin = String;

/// The type of frame.
typedef FrameType = String;

/// The document lifecycle of the frame.
typedef DocumentLifecycle = String;

/// The JavaScript world for a script to execute within. Can either be an
/// isolated world, unique to this extension, or the main world of the DOM which
/// is shared with the page's JavaScript.
typedef ExecutionWorld = String;

@JS()
@staticInterop
@anonymous
class ImageDetails {
  external factory ImageDetails({
    /// The format of the resulting image.  Default is `"jpeg"`.
    ImageFormat? format,

    /// When format is `"jpeg"`, controls the quality of the resulting image.
    /// This value is ignored for PNG images.  As quality is decreased, the
    /// resulting image will have more visual artifacts, and the number of bytes
    /// needed to store it will decrease.
    int? quality,
  });
}

extension ImageDetailsExtension on ImageDetails {
  /// The format of the resulting image.  Default is `"jpeg"`.
  external ImageFormat? format;

  /// When format is `"jpeg"`, controls the quality of the resulting image.
  /// This value is ignored for PNG images.  As quality is decreased, the
  /// resulting image will have more visual artifacts, and the number of bytes
  /// needed to store it will decrease.
  external int? quality;
}

@JS()
@staticInterop
@anonymous
class InjectDetails {
  external factory InjectDetails({
    /// JavaScript or CSS code to inject.
    ///
    /// **Warning:**
    /// Be careful using the `code` parameter. Incorrect use of it may open your
    /// extension to [cross site
    /// scripting](https://en.wikipedia.org/wiki/Cross-site_scripting) attacks.
    String? code,

    /// JavaScript or CSS file to inject.
    String? file,

    /// If allFrames is `true`, implies that the JavaScript or CSS should be
    /// injected into all frames of current page. By default, it's `false` and is
    /// only injected into the top frame. If `true` and `frameId` is set, then the
    /// code is inserted in the selected frame and all of its child frames.
    bool? allFrames,

    /// The [frame](webNavigation#frame_ids) where the script or CSS should be
    /// injected. Defaults to 0 (the top-level frame).
    int? frameId,

    /// If matchAboutBlank is true, then the code is also injected in about:blank
    /// and about:srcdoc frames if your extension has access to its parent
    /// document. Code cannot be inserted in top-level about:-frames. By default
    /// it is `false`.
    bool? matchAboutBlank,

    /// The soonest that the JavaScript or CSS will be injected into the tab.
    /// Defaults to "document_idle".
    RunAt? runAt,

    /// The [origin](https://www.w3.org/TR/css3-cascade/#cascading-origins) of the
    /// CSS to inject. This may only be specified for CSS, not JavaScript.
    /// Defaults to `"author"`.
    CSSOrigin? cssOrigin,
  });
}

extension InjectDetailsExtension on InjectDetails {
  /// JavaScript or CSS code to inject.
  ///
  /// **Warning:**
  /// Be careful using the `code` parameter. Incorrect use of it may open your
  /// extension to [cross site
  /// scripting](https://en.wikipedia.org/wiki/Cross-site_scripting) attacks.
  external String? code;

  /// JavaScript or CSS file to inject.
  external String? file;

  /// If allFrames is `true`, implies that the JavaScript or CSS should be
  /// injected into all frames of current page. By default, it's `false` and is
  /// only injected into the top frame. If `true` and `frameId` is set, then the
  /// code is inserted in the selected frame and all of its child frames.
  external bool? allFrames;

  /// The [frame](webNavigation#frame_ids) where the script or CSS should be
  /// injected. Defaults to 0 (the top-level frame).
  external int? frameId;

  /// If matchAboutBlank is true, then the code is also injected in about:blank
  /// and about:srcdoc frames if your extension has access to its parent
  /// document. Code cannot be inserted in top-level about:-frames. By default
  /// it is `false`.
  external bool? matchAboutBlank;

  /// The soonest that the JavaScript or CSS will be injected into the tab.
  /// Defaults to "document_idle".
  external RunAt? runAt;

  /// The [origin](https://www.w3.org/TR/css3-cascade/#cascading-origins) of the
  /// CSS to inject. This may only be specified for CSS, not JavaScript.
  /// Defaults to `"author"`.
  external CSSOrigin? cssOrigin;
}

@JS()
@staticInterop
@anonymous
class DeleteInjectionDetails {
  external factory DeleteInjectionDetails({
    /// CSS code to remove.
    String? code,

    /// CSS file to remove.
    String? file,

    /// If allFrames is `true`, implies that the CSS should be removed from all
    /// frames of current page. By default, it's `false` and is only removed from
    /// the top frame. If `true` and `frameId` is set, then the code is removed
    /// from the selected frame and all of its child frames.
    bool? allFrames,

    /// The [frame](webNavigation#frame_ids) from where the CSS should be removed.
    /// Defaults to 0 (the top-level frame).
    int? frameId,

    /// If matchAboutBlank is true, then the code is also removed from about:blank
    /// and about:srcdoc frames if your extension has access to its parent
    /// document. By default it is `false`.
    bool? matchAboutBlank,

    /// The [origin](https://www.w3.org/TR/css3-cascade/#cascading-origins) of the
    /// CSS to remove. Defaults to `"author"`.
    CSSOrigin? cssOrigin,
  });
}

extension DeleteInjectionDetailsExtension on DeleteInjectionDetails {
  /// CSS code to remove.
  external String? code;

  /// CSS file to remove.
  external String? file;

  /// If allFrames is `true`, implies that the CSS should be removed from all
  /// frames of current page. By default, it's `false` and is only removed from
  /// the top frame. If `true` and `frameId` is set, then the code is removed
  /// from the selected frame and all of its child frames.
  external bool? allFrames;

  /// The [frame](webNavigation#frame_ids) from where the CSS should be removed.
  /// Defaults to 0 (the top-level frame).
  external int? frameId;

  /// If matchAboutBlank is true, then the code is also removed from about:blank
  /// and about:srcdoc frames if your extension has access to its parent
  /// document. By default it is `false`.
  external bool? matchAboutBlank;

  /// The [origin](https://www.w3.org/TR/css3-cascade/#cascading-origins) of the
  /// CSS to remove. Defaults to `"author"`.
  external CSSOrigin? cssOrigin;
}
