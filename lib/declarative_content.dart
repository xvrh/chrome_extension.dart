// ignore_for_file: unnecessary_parenthesis

library;

import 'events.dart';
import 'src/internal_helpers.dart';
import 'src/js/declarative_content.dart' as $js;

export 'src/chrome.dart' show chrome;

final _declarativeContent = ChromeDeclarativeContent._();

extension ChromeDeclarativeContentExtension on Chrome {
  /// Use the `chrome.declarativeContent` API to take actions depending on the
  /// content of a page, without requiring permission to read the page's
  /// content.
  ChromeDeclarativeContent get declarativeContent => _declarativeContent;
}

class ChromeDeclarativeContent {
  ChromeDeclarativeContent._();

  bool get isAvailable =>
      $js.chrome.declarativeContentNullable != null && alwaysTrue;

  EventStream<void> get onPageChanged =>
      $js.chrome.declarativeContent.onPageChanged.asStream(($c) => () {
            return $c(null);
          });
}

enum PageStateMatcherInstanceType {
  declarativeContentPageStateMatcher('declarativeContent.PageStateMatcher');

  const PageStateMatcherInstanceType(this.value);

  final String value;

  String get toJS => value;
  static PageStateMatcherInstanceType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum ShowPageActionInstanceType {
  declarativeContentShowPageAction('declarativeContent.ShowPageAction');

  const ShowPageActionInstanceType(this.value);

  final String value;

  String get toJS => value;
  static ShowPageActionInstanceType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum ShowActionInstanceType {
  declarativeContentShowAction('declarativeContent.ShowAction');

  const ShowActionInstanceType(this.value);

  final String value;

  String get toJS => value;
  static ShowActionInstanceType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum SetIconInstanceType {
  declarativeContentSetIcon('declarativeContent.SetIcon');

  const SetIconInstanceType(this.value);

  final String value;

  String get toJS => value;
  static SetIconInstanceType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum RequestContentScriptInstanceType {
  declarativeContentRequestContentScript(
      'declarativeContent.RequestContentScript');

  const RequestContentScriptInstanceType(this.value);

  final String value;

  String get toJS => value;
  static RequestContentScriptInstanceType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// See <a
/// href="https://developer.mozilla.org/en-US/docs/Web/API/ImageData">https://developer.mozilla.org/en-US/docs/Web/API/ImageData</a>.
typedef ImageDataType = JSObject;

class PageStateMatcher {
  PageStateMatcher.fromJS(this._wrapped);

  PageStateMatcher({
    /// Matches if the conditions of the `UrlFilter` are fulfilled for the
    /// top-level URL of the page.
    UrlFilter? pageUrl,

    /// Matches if all of the CSS selectors in the array match displayed
    /// elements in a frame with the same origin as the page's main frame. All
    /// selectors in this array must be [compound
    /// selectors](http://www.w3.org/TR/selectors4/#compound) to speed up
    /// matching. Note: Listing hundreds of CSS selectors or listing CSS
    /// selectors that match hundreds of times per page can slow down web sites.
    List<String>? css,

    /// Matches if the bookmarked state of the page is equal to the specified
    /// value. Requres the [bookmarks permission](declare_permissions).
    bool? isBookmarked,
    required PageStateMatcherInstanceType instanceType,
  }) : _wrapped = $js.PageStateMatcher(
          pageUrl: pageUrl?.toJS,
          css: css?.toJSArray((e) => e),
          isBookmarked: isBookmarked,
          instanceType: instanceType.toJS,
        );

  final $js.PageStateMatcher _wrapped;

  $js.PageStateMatcher get toJS => _wrapped;

  /// Matches if the conditions of the `UrlFilter` are fulfilled for the
  /// top-level URL of the page.
  UrlFilter? get pageUrl => _wrapped.pageUrl?.let(UrlFilter.fromJS);
  set pageUrl(UrlFilter? v) {
    _wrapped.pageUrl = v?.toJS;
  }

  /// Matches if all of the CSS selectors in the array match displayed elements
  /// in a frame with the same origin as the page's main frame. All selectors in
  /// this array must be [compound
  /// selectors](http://www.w3.org/TR/selectors4/#compound) to speed up
  /// matching. Note: Listing hundreds of CSS selectors or listing CSS selectors
  /// that match hundreds of times per page can slow down web sites.
  List<String>? get css =>
      _wrapped.css?.toDart.cast<String>().map((e) => e).toList();
  set css(List<String>? v) {
    _wrapped.css = v?.toJSArray((e) => e);
  }

  /// Matches if the bookmarked state of the page is equal to the specified
  /// value. Requres the [bookmarks permission](declare_permissions).
  bool? get isBookmarked => _wrapped.isBookmarked;
  set isBookmarked(bool? v) {
    _wrapped.isBookmarked = v;
  }

  PageStateMatcherInstanceType get instanceType =>
      PageStateMatcherInstanceType.fromJS(_wrapped.instanceType);
  set instanceType(PageStateMatcherInstanceType v) {
    _wrapped.instanceType = v.toJS;
  }
}

class ShowPageAction {
  ShowPageAction.fromJS(this._wrapped);

  ShowPageAction({required ShowPageActionInstanceType instanceType})
      : _wrapped = $js.ShowPageAction(instanceType: instanceType.toJS);

  final $js.ShowPageAction _wrapped;

  $js.ShowPageAction get toJS => _wrapped;

  ShowPageActionInstanceType get instanceType =>
      ShowPageActionInstanceType.fromJS(_wrapped.instanceType);
  set instanceType(ShowPageActionInstanceType v) {
    _wrapped.instanceType = v.toJS;
  }
}

class ShowAction {
  ShowAction.fromJS(this._wrapped);

  ShowAction({required ShowActionInstanceType instanceType})
      : _wrapped = $js.ShowAction(instanceType: instanceType.toJS);

  final $js.ShowAction _wrapped;

  $js.ShowAction get toJS => _wrapped;

  ShowActionInstanceType get instanceType =>
      ShowActionInstanceType.fromJS(_wrapped.instanceType);
  set instanceType(ShowActionInstanceType v) {
    _wrapped.instanceType = v.toJS;
  }
}

class SetIcon {
  SetIcon.fromJS(this._wrapped);

  SetIcon({
    required SetIconInstanceType instanceType,

    /// Either an `ImageData` object or a dictionary {size -> ImageData}
    /// representing an icon to be set. If the icon is specified as a
    /// dictionary, the image used is chosen depending on the screen's pixel
    /// density. If the number of image pixels that fit into one screen space
    /// unit equals `scale`, then an image with size `scale * n` is selected,
    /// where <i>n</i> is the size of the icon in the UI. At least one image
    /// must be specified. Note that `details.imageData = foo` is equivalent to
    /// `details.imageData = {'16': foo}`.
    Object? imageData,
  }) : _wrapped = $js.SetIcon(
          instanceType: instanceType.toJS,
          imageData: switch (imageData) {
            JSObject() => imageData,
            Map() => imageData.jsify()!,
            null => null,
            _ => throw UnsupportedError(
                'Received type: ${imageData.runtimeType}. Supported types are: JSObject, Map')
          },
        );

  final $js.SetIcon _wrapped;

  $js.SetIcon get toJS => _wrapped;

  SetIconInstanceType get instanceType =>
      SetIconInstanceType.fromJS(_wrapped.instanceType);
  set instanceType(SetIconInstanceType v) {
    _wrapped.instanceType = v.toJS;
  }

  /// Either an `ImageData` object or a dictionary {size -> ImageData}
  /// representing an icon to be set. If the icon is specified as a dictionary,
  /// the image used is chosen depending on the screen's pixel density. If the
  /// number of image pixels that fit into one screen space unit equals `scale`,
  /// then an image with size `scale * n` is selected, where <i>n</i> is the
  /// size of the icon in the UI. At least one image must be specified. Note
  /// that `details.imageData = foo` is equivalent to `details.imageData =
  /// {'16': foo}`.
  Object? get imageData => _wrapped.imageData?.when(
        isOther: (v) => (v as $js.ImageDataType),
        isMap: (v) => v.toDartMap(),
      );
  set imageData(Object? v) {
    _wrapped.imageData = switch (v) {
      JSObject() => v,
      Map() => v.jsify()!,
      null => null,
      _ => throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: JSObject, Map')
    };
  }
}

class RequestContentScript {
  RequestContentScript.fromJS(this._wrapped);

  RequestContentScript({
    /// Names of CSS files to be injected as a part of the content script.
    List<String>? css,

    /// Names of JavaScript files to be injected as a part of the content
    /// script.
    List<String>? js,

    /// Whether the content script runs in all frames of the matching page, or
    /// in only the top frame. Default is `false`.
    bool? allFrames,

    /// Whether to insert the content script on `about:blank` and
    /// `about:srcdoc`. Default is `false`.
    bool? matchAboutBlank,
    required RequestContentScriptInstanceType instanceType,
  }) : _wrapped = $js.RequestContentScript(
          css: css?.toJSArray((e) => e),
          js: js?.toJSArray((e) => e),
          allFrames: allFrames,
          matchAboutBlank: matchAboutBlank,
          instanceType: instanceType.toJS,
        );

  final $js.RequestContentScript _wrapped;

  $js.RequestContentScript get toJS => _wrapped;

  /// Names of CSS files to be injected as a part of the content script.
  List<String>? get css =>
      _wrapped.css?.toDart.cast<String>().map((e) => e).toList();
  set css(List<String>? v) {
    _wrapped.css = v?.toJSArray((e) => e);
  }

  /// Names of JavaScript files to be injected as a part of the content script.
  List<String>? get js =>
      _wrapped.js?.toDart.cast<String>().map((e) => e).toList();
  set js(List<String>? v) {
    _wrapped.js = v?.toJSArray((e) => e);
  }

  /// Whether the content script runs in all frames of the matching page, or in
  /// only the top frame. Default is `false`.
  bool? get allFrames => _wrapped.allFrames;
  set allFrames(bool? v) {
    _wrapped.allFrames = v;
  }

  /// Whether to insert the content script on `about:blank` and `about:srcdoc`.
  /// Default is `false`.
  bool? get matchAboutBlank => _wrapped.matchAboutBlank;
  set matchAboutBlank(bool? v) {
    _wrapped.matchAboutBlank = v;
  }

  RequestContentScriptInstanceType get instanceType =>
      RequestContentScriptInstanceType.fromJS(_wrapped.instanceType);
  set instanceType(RequestContentScriptInstanceType v) {
    _wrapped.instanceType = v.toJS;
  }
}
