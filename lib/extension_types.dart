// ignore_for_file: unnecessary_parenthesis

library;

import 'src/internal_helpers.dart';
import 'src/js/extension_types.dart' as $js;

export 'src/chrome.dart' show chrome;

final _extensionTypes = ChromeExtensionTypes._();

extension ChromeExtensionTypesExtension on Chrome {
  /// The `chrome.extensionTypes` API contains type declarations for Chrome
  /// extensions.
  ChromeExtensionTypes get extensionTypes => _extensionTypes;
}

class ChromeExtensionTypes {
  ChromeExtensionTypes._();

  bool get isAvailable =>
      $js.chrome.extensionTypesNullable != null && alwaysTrue;
}

/// The format of an image.
enum ImageFormat {
  jpeg('jpeg'),
  png('png');

  const ImageFormat(this.value);

  final String value;

  String get toJS => value;
  static ImageFormat fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The soonest that the JavaScript or CSS will be injected into the tab.
enum RunAt {
  documentStart('document_start'),
  documentEnd('document_end'),
  documentIdle('document_idle');

  const RunAt(this.value);

  final String value;

  String get toJS => value;
  static RunAt fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The [origin](https://www.w3.org/TR/css3-cascade/#cascading-origins) of
/// injected CSS.
enum CSSOrigin {
  author('author'),
  user('user');

  const CSSOrigin(this.value);

  final String value;

  String get toJS => value;
  static CSSOrigin fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The type of frame.
enum FrameType {
  outermostFrame('outermost_frame'),
  fencedFrame('fenced_frame'),
  subFrame('sub_frame');

  const FrameType(this.value);

  final String value;

  String get toJS => value;
  static FrameType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The document lifecycle of the frame.
enum DocumentLifecycle {
  prerender('prerender'),
  active('active'),
  cached('cached'),
  pendingDeletion('pending_deletion');

  const DocumentLifecycle(this.value);

  final String value;

  String get toJS => value;
  static DocumentLifecycle fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The JavaScript world for a script to execute within. Can either be an
/// isolated world, unique to this extension, or the main world of the DOM which
/// is shared with the page's JavaScript.
enum ExecutionWorld {
  isolated('ISOLATED'),
  main('MAIN');

  const ExecutionWorld(this.value);

  final String value;

  String get toJS => value;
  static ExecutionWorld fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class ImageDetails {
  ImageDetails.fromJS(this._wrapped);

  ImageDetails({
    /// The format of the resulting image.  Default is `"jpeg"`.
    ImageFormat? format,

    /// When format is `"jpeg"`, controls the quality of the resulting image.
    /// This value is ignored for PNG images.  As quality is decreased, the
    /// resulting image will have more visual artifacts, and the number of bytes
    /// needed to store it will decrease.
    int? quality,
  }) : _wrapped = $js.ImageDetails(
          format: format?.toJS,
          quality: quality,
        );

  final $js.ImageDetails _wrapped;

  $js.ImageDetails get toJS => _wrapped;

  /// The format of the resulting image.  Default is `"jpeg"`.
  ImageFormat? get format => _wrapped.format?.let(ImageFormat.fromJS);
  set format(ImageFormat? v) {
    _wrapped.format = v?.toJS;
  }

  /// When format is `"jpeg"`, controls the quality of the resulting image.
  /// This value is ignored for PNG images.  As quality is decreased, the
  /// resulting image will have more visual artifacts, and the number of bytes
  /// needed to store it will decrease.
  int? get quality => _wrapped.quality;
  set quality(int? v) {
    _wrapped.quality = v;
  }
}

class InjectDetails {
  InjectDetails.fromJS(this._wrapped);

  InjectDetails({
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
    /// injected into all frames of current page. By default, it's `false` and
    /// is only injected into the top frame. If `true` and `frameId` is set,
    /// then the code is inserted in the selected frame and all of its child
    /// frames.
    bool? allFrames,

    /// The [frame](webNavigation#frame_ids) where the script or CSS should be
    /// injected. Defaults to 0 (the top-level frame).
    int? frameId,

    /// If matchAboutBlank is true, then the code is also injected in
    /// about:blank and about:srcdoc frames if your extension has access to its
    /// parent document. Code cannot be inserted in top-level about:-frames. By
    /// default it is `false`.
    bool? matchAboutBlank,

    /// The soonest that the JavaScript or CSS will be injected into the tab.
    /// Defaults to "document_idle".
    RunAt? runAt,

    /// The [origin](https://www.w3.org/TR/css3-cascade/#cascading-origins) of
    /// the CSS to inject. This may only be specified for CSS, not JavaScript.
    /// Defaults to `"author"`.
    CSSOrigin? cssOrigin,
  }) : _wrapped = $js.InjectDetails(
          code: code,
          file: file,
          allFrames: allFrames,
          frameId: frameId,
          matchAboutBlank: matchAboutBlank,
          runAt: runAt?.toJS,
          cssOrigin: cssOrigin?.toJS,
        );

  final $js.InjectDetails _wrapped;

  $js.InjectDetails get toJS => _wrapped;

  /// JavaScript or CSS code to inject.
  ///
  /// **Warning:**
  /// Be careful using the `code` parameter. Incorrect use of it may open your
  /// extension to [cross site
  /// scripting](https://en.wikipedia.org/wiki/Cross-site_scripting) attacks.
  String? get code => _wrapped.code;
  set code(String? v) {
    _wrapped.code = v;
  }

  /// JavaScript or CSS file to inject.
  String? get file => _wrapped.file;
  set file(String? v) {
    _wrapped.file = v;
  }

  /// If allFrames is `true`, implies that the JavaScript or CSS should be
  /// injected into all frames of current page. By default, it's `false` and is
  /// only injected into the top frame. If `true` and `frameId` is set, then the
  /// code is inserted in the selected frame and all of its child frames.
  bool? get allFrames => _wrapped.allFrames;
  set allFrames(bool? v) {
    _wrapped.allFrames = v;
  }

  /// The [frame](webNavigation#frame_ids) where the script or CSS should be
  /// injected. Defaults to 0 (the top-level frame).
  int? get frameId => _wrapped.frameId;
  set frameId(int? v) {
    _wrapped.frameId = v;
  }

  /// If matchAboutBlank is true, then the code is also injected in about:blank
  /// and about:srcdoc frames if your extension has access to its parent
  /// document. Code cannot be inserted in top-level about:-frames. By default
  /// it is `false`.
  bool? get matchAboutBlank => _wrapped.matchAboutBlank;
  set matchAboutBlank(bool? v) {
    _wrapped.matchAboutBlank = v;
  }

  /// The soonest that the JavaScript or CSS will be injected into the tab.
  /// Defaults to "document_idle".
  RunAt? get runAt => _wrapped.runAt?.let(RunAt.fromJS);
  set runAt(RunAt? v) {
    _wrapped.runAt = v?.toJS;
  }

  /// The [origin](https://www.w3.org/TR/css3-cascade/#cascading-origins) of the
  /// CSS to inject. This may only be specified for CSS, not JavaScript.
  /// Defaults to `"author"`.
  CSSOrigin? get cssOrigin => _wrapped.cssOrigin?.let(CSSOrigin.fromJS);
  set cssOrigin(CSSOrigin? v) {
    _wrapped.cssOrigin = v?.toJS;
  }
}

class DeleteInjectionDetails {
  DeleteInjectionDetails.fromJS(this._wrapped);

  DeleteInjectionDetails({
    /// CSS code to remove.
    String? code,

    /// CSS file to remove.
    String? file,

    /// If allFrames is `true`, implies that the CSS should be removed from all
    /// frames of current page. By default, it's `false` and is only removed
    /// from the top frame. If `true` and `frameId` is set, then the code is
    /// removed from the selected frame and all of its child frames.
    bool? allFrames,

    /// The [frame](webNavigation#frame_ids) from where the CSS should be
    /// removed. Defaults to 0 (the top-level frame).
    int? frameId,

    /// If matchAboutBlank is true, then the code is also removed from
    /// about:blank and about:srcdoc frames if your extension has access to its
    /// parent document. By default it is `false`.
    bool? matchAboutBlank,

    /// The [origin](https://www.w3.org/TR/css3-cascade/#cascading-origins) of
    /// the CSS to remove. Defaults to `"author"`.
    CSSOrigin? cssOrigin,
  }) : _wrapped = $js.DeleteInjectionDetails(
          code: code,
          file: file,
          allFrames: allFrames,
          frameId: frameId,
          matchAboutBlank: matchAboutBlank,
          cssOrigin: cssOrigin?.toJS,
        );

  final $js.DeleteInjectionDetails _wrapped;

  $js.DeleteInjectionDetails get toJS => _wrapped;

  /// CSS code to remove.
  String? get code => _wrapped.code;
  set code(String? v) {
    _wrapped.code = v;
  }

  /// CSS file to remove.
  String? get file => _wrapped.file;
  set file(String? v) {
    _wrapped.file = v;
  }

  /// If allFrames is `true`, implies that the CSS should be removed from all
  /// frames of current page. By default, it's `false` and is only removed from
  /// the top frame. If `true` and `frameId` is set, then the code is removed
  /// from the selected frame and all of its child frames.
  bool? get allFrames => _wrapped.allFrames;
  set allFrames(bool? v) {
    _wrapped.allFrames = v;
  }

  /// The [frame](webNavigation#frame_ids) from where the CSS should be removed.
  /// Defaults to 0 (the top-level frame).
  int? get frameId => _wrapped.frameId;
  set frameId(int? v) {
    _wrapped.frameId = v;
  }

  /// If matchAboutBlank is true, then the code is also removed from about:blank
  /// and about:srcdoc frames if your extension has access to its parent
  /// document. By default it is `false`.
  bool? get matchAboutBlank => _wrapped.matchAboutBlank;
  set matchAboutBlank(bool? v) {
    _wrapped.matchAboutBlank = v;
  }

  /// The [origin](https://www.w3.org/TR/css3-cascade/#cascading-origins) of the
  /// CSS to remove. Defaults to `"author"`.
  CSSOrigin? get cssOrigin => _wrapped.cssOrigin?.let(CSSOrigin.fromJS);
  set cssOrigin(CSSOrigin? v) {
    _wrapped.cssOrigin = v?.toJS;
  }
}
