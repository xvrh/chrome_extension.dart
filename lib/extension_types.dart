// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'src/internal_helpers.dart';
import 'src/js/extension_types.dart' as $js;

export 'src/chrome.dart' show chrome, EventStream;

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

  JSString get toJS => value.toJS;

  static ImageFormat fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

/// The soonest that the JavaScript or CSS will be injected into the tab.
enum RunAt {
  /// Script is injected after any files from css, but before any other DOM is
  /// constructed or any other script is run.
  documentStart('document_start'),

  /// Script is injected immediately after the DOM is complete, but before
  /// subresources like images and frames have loaded.
  documentEnd('document_end'),

  /// The browser chooses a time to inject the script between "document_end" and
  /// immediately after the `window.onload` event fires. The exact moment of
  /// injection depends on how complex the document is and how long it is taking
  /// to load, and is optimized for page load speed. Content scripts running at
  /// "document_idle" don't need to listen for the `window.onload` event; they
  /// are guaranteed to run after the DOM completes. If a script definitely
  /// needs to run after `window.onload`, the extension can check if `onload`
  /// has already fired by using the `document.readyState` property.
  documentIdle('document_idle');

  const RunAt(this.value);

  final String value;

  JSString get toJS => value.toJS;

  static RunAt fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

/// The [origin](https://www.w3.org/TR/css3-cascade/#cascading-origins) of
/// injected CSS.
enum CSSOrigin {
  author('author'),
  user('user');

  const CSSOrigin(this.value);

  final String value;

  JSString get toJS => value.toJS;

  static CSSOrigin fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

/// The type of frame.
enum FrameType {
  outermostFrame('outermost_frame'),
  fencedFrame('fenced_frame'),
  subFrame('sub_frame');

  const FrameType(this.value);

  final String value;

  JSString get toJS => value.toJS;

  static FrameType fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

/// The document lifecycle of the frame.
enum DocumentLifecycle {
  prerender('prerender'),
  active('active'),
  cached('cached'),
  pendingDeletion('pending_deletion');

  const DocumentLifecycle(this.value);

  final String value;

  JSString get toJS => value.toJS;

  static DocumentLifecycle fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

/// The JavaScript world for a script to execute within. Can either be an
/// isolated world unique to this extension, the main world of the DOM which is
/// shared with the page's JavaScript, or a user scripts world that is only
/// available for scripts registered with the User Scripts API.
enum ExecutionWorld {
  isolated('ISOLATED'),
  main('MAIN'),
  userScript('USER_SCRIPT');

  const ExecutionWorld(this.value);

  final String value;

  JSString get toJS => value.toJS;

  static ExecutionWorld fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

typedef ColorArray = List<int>;

/// Pixel data for an image. Must be an ImageData object; for example, from a
/// `canvas` element.
typedef ImageDataType = JSObject;

class Rect {
  Rect.fromJS(this._wrapped);

  Rect({
    /// The x coordinate of the rectangle.
    required int x,

    /// The y coordinate of the rectangle.
    required int y,

    /// The width of the rectangle.
    required int width,

    /// The height of the rectangle.
    required int height,
  }) : _wrapped = $js.Rect(
          x: x,
          y: y,
          width: width,
          height: height,
        );

  final $js.Rect _wrapped;

  $js.Rect get toJS => _wrapped;

  /// The x coordinate of the rectangle.
  int get x => _wrapped.x;

  set x(int v) {
    _wrapped.x = v;
  }

  /// The y coordinate of the rectangle.
  int get y => _wrapped.y;

  set y(int v) {
    _wrapped.y = v;
  }

  /// The width of the rectangle.
  int get width => _wrapped.width;

  set width(int v) {
    _wrapped.width = v;
  }

  /// The height of the rectangle.
  int get height => _wrapped.height;

  set height(int v) {
    _wrapped.height = v;
  }
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

    /// An object specifying the area of the document to capture, in CSS pixels,
    /// relative to the page. If omitted, the currently visible viewport is
    /// captured.
    Rect? rect,

    /// The scale factor to apply to the image. Defaults to devicePixelRatio.
    double? scale,
  }) : _wrapped = $js.ImageDetails(
          format: format?.toJS,
          quality: quality,
          rect: rect?.toJS,
          scale: scale,
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

  /// An object specifying the area of the document to capture, in CSS pixels,
  /// relative to the page. If omitted, the currently visible viewport is
  /// captured.
  Rect? get rect => _wrapped.rect?.let(Rect.fromJS);

  set rect(Rect? v) {
    _wrapped.rect = v?.toJS;
  }

  /// The scale factor to apply to the image. Defaults to devicePixelRatio.
  double? get scale => _wrapped.scale;

  set scale(double? v) {
    _wrapped.scale = v;
  }
}

class InjectDetails {
  InjectDetails.fromJS(this._wrapped);

  InjectDetails({
    /// JavaScript or CSS code to inject.
    ///
    /// <aside class='warning'>**Warning:** Be careful using the `code`
    /// parameter. Incorrect use of it may open your extension to [cross site
    /// scripting](https://en.wikipedia.org/wiki/Cross-site_scripting)
    /// attacks</aside>
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
  /// <aside class='warning'>**Warning:** Be careful using the `code` parameter.
  /// Incorrect use of it may open your extension to [cross site
  /// scripting](https://en.wikipedia.org/wiki/Cross-site_scripting)
  /// attacks</aside>
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
