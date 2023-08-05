// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/browser_action.dart' as $js;
import 'src/js/tabs.dart' as $js_tabs;
import 'tabs.dart';

export 'src/chrome.dart' show chrome;

final _browserAction = ChromeBrowserAction._();

extension ChromeBrowserActionExtension on Chrome {
  /// Use browser actions to put icons in the main Google Chrome toolbar, to the
  /// right of the address bar. In addition to its [icon](browserAction#icon), a
  /// browser action can have a [tooltip](browserAction#tooltip), a
  /// [badge](browserAction#badge), and a [popup](browserAction#popups).
  ChromeBrowserAction get browserAction => _browserAction;
}

class ChromeBrowserAction {
  ChromeBrowserAction._();

  bool get isAvailable =>
      $js.chrome.browserActionNullable != null && alwaysTrue;

  /// Sets the title of the browser action. This title appears in the tooltip.
  Future<void> setTitle(SetTitleDetails details) async {
    await promiseToFuture<void>(
        $js.chrome.browserAction.setTitle(details.toJS));
  }

  /// Gets the title of the browser action.
  Future<String> getTitle(TabDetails details) async {
    var $res = await promiseToFuture<String>(
        $js.chrome.browserAction.getTitle(details.toJS));
    return $res;
  }

  /// Sets the icon for the browser action. The icon can be specified as the
  /// path to an image file, as the pixel data from a canvas element, or as a
  /// dictionary of one of those. Either the `path` or the `imageData` property
  /// must be specified.
  Future<void> setIcon(SetIconDetails details) {
    var $completer = Completer<void>();
    $js.chrome.browserAction.setIcon(
      details.toJS,
      () {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(null);
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Sets the HTML document to be opened as a popup when the user clicks the
  /// browser action icon.
  Future<void> setPopup(SetPopupDetails details) async {
    await promiseToFuture<void>(
        $js.chrome.browserAction.setPopup(details.toJS));
  }

  /// Gets the HTML document that is set as the popup for this browser action.
  Future<String> getPopup(TabDetails details) async {
    var $res = await promiseToFuture<String>(
        $js.chrome.browserAction.getPopup(details.toJS));
    return $res;
  }

  /// Sets the badge text for the browser action. The badge is displayed on top
  /// of the icon.
  Future<void> setBadgeText(SetBadgeTextDetails details) async {
    await promiseToFuture<void>(
        $js.chrome.browserAction.setBadgeText(details.toJS));
  }

  /// Gets the badge text of the browser action. If no tab is specified, the
  /// non-tab-specific badge text is returned.
  Future<String> getBadgeText(TabDetails details) async {
    var $res = await promiseToFuture<String>(
        $js.chrome.browserAction.getBadgeText(details.toJS));
    return $res;
  }

  /// Sets the background color for the badge.
  Future<void> setBadgeBackgroundColor(
      SetBadgeBackgroundColorDetails details) async {
    await promiseToFuture<void>(
        $js.chrome.browserAction.setBadgeBackgroundColor(details.toJS));
  }

  /// Gets the background color of the browser action.
  Future<List<int>> getBadgeBackgroundColor(TabDetails details) async {
    var $res = await promiseToFuture<$js.ColorArray>(
        $js.chrome.browserAction.getBadgeBackgroundColor(details.toJS));
    return $res.toDart.cast<int>().map((e) => e).toList();
  }

  /// Enables the browser action for a tab. Defaults to enabled.
  /// [tabId] The ID of the tab for which to modify the browser action.
  Future<void> enable(int? tabId) async {
    await promiseToFuture<void>($js.chrome.browserAction.enable(tabId));
  }

  /// Disables the browser action for a tab.
  /// [tabId] The ID of the tab for which to modify the browser action.
  Future<void> disable(int? tabId) async {
    await promiseToFuture<void>($js.chrome.browserAction.disable(tabId));
  }

  /// Opens the extension popup window in the active window but does not grant
  /// tab permissions.
  Future<Map?> openPopup() {
    var $completer = Completer<Map?>();
    $js.chrome.browserAction.openPopup((JSAny? popupView) {
      if (checkRuntimeLastError($completer)) {
        $completer.complete(popupView?.toDartMap());
      }
    }.toJS);
    return $completer.future;
  }

  /// Fired when a browser action icon is clicked. Does not fire if the browser
  /// action has a popup.
  EventStream<Tab> get onClicked =>
      $js.chrome.browserAction.onClicked.asStream(($c) => ($js_tabs.Tab tab) {
            return $c(Tab.fromJS(tab));
          });
}

typedef ColorArray = List<int>;

/// Pixel data for an image. Must be an ImageData object; for example, from a
/// `canvas` element.
typedef ImageDataType = JSObject;

class TabDetails {
  TabDetails.fromJS(this._wrapped);

  TabDetails(
      {
      /// The ID of the tab to query state for. If no tab is specified, the
      /// non-tab-specific state is returned.
      int? tabId})
      : _wrapped = $js.TabDetails(tabId: tabId);

  final $js.TabDetails _wrapped;

  $js.TabDetails get toJS => _wrapped;

  /// The ID of the tab to query state for. If no tab is specified, the
  /// non-tab-specific state is returned.
  int? get tabId => _wrapped.tabId;
  set tabId(int? v) {
    _wrapped.tabId = v;
  }
}

class SetTitleDetails {
  SetTitleDetails.fromJS(this._wrapped);

  SetTitleDetails({
    /// The string the browser action should display when moused over.
    required String title,

    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,
  }) : _wrapped = $js.SetTitleDetails(
          title: title,
          tabId: tabId,
        );

  final $js.SetTitleDetails _wrapped;

  $js.SetTitleDetails get toJS => _wrapped;

  /// The string the browser action should display when moused over.
  String get title => _wrapped.title;
  set title(String v) {
    _wrapped.title = v;
  }

  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  int? get tabId => _wrapped.tabId;
  set tabId(int? v) {
    _wrapped.tabId = v;
  }
}

class SetIconDetails {
  SetIconDetails.fromJS(this._wrapped);

  SetIconDetails({
    /// Either an ImageData object or a dictionary {size -> ImageData}
    /// representing an icon to be set. If the icon is specified as a
    /// dictionary, the image used is chosen depending on the screen's pixel
    /// density. If the number of image pixels that fit into one screen space
    /// unit equals `scale`, then an image with size `scale` * n is selected,
    /// where <i>n</i> is the size of the icon in the UI. At least one image
    /// must be specified. Note that 'details.imageData = foo' is equivalent to
    /// 'details.imageData = {'16': foo}'
    Object? imageData,

    /// Either a relative image path or a dictionary {size -> relative image
    /// path} pointing to an icon to be set. If the icon is specified as a
    /// dictionary, the image used is chosen depending on the screen's pixel
    /// density. If the number of image pixels that fit into one screen space
    /// unit equals `scale`, then an image with size `scale` * n is selected,
    /// where <i>n</i> is the size of the icon in the UI. At least one image
    /// must be specified. Note that 'details.path = foo' is equivalent to
    /// 'details.path = {'16': foo}'
    Object? path,

    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,
  }) : _wrapped = $js.SetIconDetails(
          imageData: switch (imageData) {
            JSObject() => imageData,
            Map() => imageData.jsify()!,
            null => null,
            _ => throw UnsupportedError(
                'Received type: ${imageData.runtimeType}. Supported types are: JSObject, Map')
          },
          path: switch (path) {
            String() => path,
            Map() => path.jsify()!,
            null => null,
            _ => throw UnsupportedError(
                'Received type: ${path.runtimeType}. Supported types are: String, Map')
          },
          tabId: tabId,
        );

  final $js.SetIconDetails _wrapped;

  $js.SetIconDetails get toJS => _wrapped;

  /// Either an ImageData object or a dictionary {size -> ImageData}
  /// representing an icon to be set. If the icon is specified as a dictionary,
  /// the image used is chosen depending on the screen's pixel density. If the
  /// number of image pixels that fit into one screen space unit equals `scale`,
  /// then an image with size `scale` * n is selected, where <i>n</i> is the
  /// size of the icon in the UI. At least one image must be specified. Note
  /// that 'details.imageData = foo' is equivalent to 'details.imageData =
  /// {'16': foo}'
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

  /// Either a relative image path or a dictionary {size -> relative image path}
  /// pointing to an icon to be set. If the icon is specified as a dictionary,
  /// the image used is chosen depending on the screen's pixel density. If the
  /// number of image pixels that fit into one screen space unit equals `scale`,
  /// then an image with size `scale` * n is selected, where <i>n</i> is the
  /// size of the icon in the UI. At least one image must be specified. Note
  /// that 'details.path = foo' is equivalent to 'details.path = {'16': foo}'
  Object? get path => _wrapped.path?.when(
        isString: (v) => v,
        isMap: (v) => v.toDartMap(),
      );
  set path(Object? v) {
    _wrapped.path = switch (v) {
      String() => v,
      Map() => v.jsify()!,
      null => null,
      _ => throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: String, Map')
    };
  }

  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  int? get tabId => _wrapped.tabId;
  set tabId(int? v) {
    _wrapped.tabId = v;
  }
}

class SetPopupDetails {
  SetPopupDetails.fromJS(this._wrapped);

  SetPopupDetails({
    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,

    /// The relative path to the HTML file to show in a popup. If set to the
    /// empty string (`''`), no popup is shown.
    required String popup,
  }) : _wrapped = $js.SetPopupDetails(
          tabId: tabId,
          popup: popup,
        );

  final $js.SetPopupDetails _wrapped;

  $js.SetPopupDetails get toJS => _wrapped;

  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  int? get tabId => _wrapped.tabId;
  set tabId(int? v) {
    _wrapped.tabId = v;
  }

  /// The relative path to the HTML file to show in a popup. If set to the empty
  /// string (`''`), no popup is shown.
  String get popup => _wrapped.popup;
  set popup(String v) {
    _wrapped.popup = v;
  }
}

class SetBadgeTextDetails {
  SetBadgeTextDetails.fromJS(this._wrapped);

  SetBadgeTextDetails({
    /// Any number of characters can be passed, but only about four can fit into
    /// the space. If an empty string (`''`) is passed, the badge text is
    /// cleared.  If `tabId` is specified and `text` is null, the text for the
    /// specified tab is cleared and defaults to the global badge text.
    String? text,

    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,
  }) : _wrapped = $js.SetBadgeTextDetails(
          text: text,
          tabId: tabId,
        );

  final $js.SetBadgeTextDetails _wrapped;

  $js.SetBadgeTextDetails get toJS => _wrapped;

  /// Any number of characters can be passed, but only about four can fit into
  /// the space. If an empty string (`''`) is passed, the badge text is cleared.
  ///  If `tabId` is specified and `text` is null, the text for the specified
  /// tab is cleared and defaults to the global badge text.
  String? get text => _wrapped.text;
  set text(String? v) {
    _wrapped.text = v;
  }

  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  int? get tabId => _wrapped.tabId;
  set tabId(int? v) {
    _wrapped.tabId = v;
  }
}

class SetBadgeBackgroundColorDetails {
  SetBadgeBackgroundColorDetails.fromJS(this._wrapped);

  SetBadgeBackgroundColorDetails({
    /// An array of four integers in the range 0-255 that make up the RGBA color
    /// of the badge. Can also be a string with a CSS hex color value; for
    /// example, `#FF0000` or `#F00` (red). Renders colors at full opacity.
    required Object color,

    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,
  }) : _wrapped = $js.SetBadgeBackgroundColorDetails(
          color: switch (color) {
            String() => color,
            List<int>() => color.toJSArray((e) => e),
            _ => throw UnsupportedError(
                'Received type: ${color.runtimeType}. Supported types are: String, List<int>')
          },
          tabId: tabId,
        );

  final $js.SetBadgeBackgroundColorDetails _wrapped;

  $js.SetBadgeBackgroundColorDetails get toJS => _wrapped;

  /// An array of four integers in the range 0-255 that make up the RGBA color
  /// of the badge. Can also be a string with a CSS hex color value; for
  /// example, `#FF0000` or `#F00` (red). Renders colors at full opacity.
  Object get color => _wrapped.color.when(
        isString: (v) => v,
        isOther: (v) =>
            (v as $js.ColorArray).toDart.cast<int>().map((e) => e).toList(),
      );
  set color(Object v) {
    _wrapped.color = switch (v) {
      String() => v,
      List<int>() => v.toJSArray((e) => e),
      _ => throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: String, List<int>')
    };
  }

  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  int? get tabId => _wrapped.tabId;
  set tabId(int? v) {
    _wrapped.tabId = v;
  }
}
