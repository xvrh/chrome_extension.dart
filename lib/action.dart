// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/action.dart' as $js;
import 'src/js/browser_action.dart' as $js_browser_action;
import 'src/js/tabs.dart' as $js_tabs;
import 'tabs.dart';

export 'src/chrome.dart' show chrome;

final _action = ChromeAction._();

extension ChromeActionExtension on Chrome {
  /// Use the `chrome.action` API to control the extension's icon in the Google
  /// Chrome toolbar.
  ChromeAction get action => _action;
}

class ChromeAction {
  ChromeAction._();

  bool get isAvailable => $js.chrome.actionNullable != null && alwaysTrue;

  /// Sets the title of the action. This shows up in the tooltip.
  Future<void> setTitle(SetTitleDetails details) async {
    await promiseToFuture<void>($js.chrome.action.setTitle(details.toJS));
  }

  /// Gets the title of the action.
  Future<String> getTitle(TabDetails details) async {
    var $res =
        await promiseToFuture<String>($js.chrome.action.getTitle(details.toJS));
    return $res;
  }

  /// Sets the icon for the action. The icon can be specified either as the path
  /// to an image file or as the pixel data from a canvas element, or as
  /// dictionary of either one of those. Either the **path** or the
  /// **imageData** property must be specified.
  Future<void> setIcon(SetIconDetails details) async {
    await promiseToFuture<void>($js.chrome.action.setIcon(details.toJS));
  }

  /// Sets the HTML document to be opened as a popup when the user clicks on the
  /// action's icon.
  Future<void> setPopup(SetPopupDetails details) async {
    await promiseToFuture<void>($js.chrome.action.setPopup(details.toJS));
  }

  /// Gets the html document set as the popup for this action.
  Future<String> getPopup(TabDetails details) async {
    var $res =
        await promiseToFuture<String>($js.chrome.action.getPopup(details.toJS));
    return $res;
  }

  /// Sets the badge text for the action. The badge is displayed on top of the
  /// icon.
  Future<void> setBadgeText(SetBadgeTextDetails details) async {
    await promiseToFuture<void>($js.chrome.action.setBadgeText(details.toJS));
  }

  /// Gets the badge text of the action. If no tab is specified, the
  /// non-tab-specific badge text is returned. If
  /// [displayActionCountAsBadgeText](declarativeNetRequest#setExtensionActionOptions)
  /// is enabled, a placeholder text will be returned unless the
  /// [declarativeNetRequestFeedback](declare_permissions#declarativeNetRequestFeedback)
  /// permission is present or tab-specific badge text was provided.
  Future<String> getBadgeText(TabDetails details) async {
    var $res = await promiseToFuture<String>(
        $js.chrome.action.getBadgeText(details.toJS));
    return $res;
  }

  /// Sets the background color for the badge.
  Future<void> setBadgeBackgroundColor(
      SetBadgeBackgroundColorDetails details) async {
    await promiseToFuture<void>(
        $js.chrome.action.setBadgeBackgroundColor(details.toJS));
  }

  /// Gets the background color of the action.
  Future<List<int>> getBadgeBackgroundColor(TabDetails details) async {
    var $res = await promiseToFuture<$js_browser_action.ColorArray>(
        $js.chrome.action.getBadgeBackgroundColor(details.toJS));
    return $res.toDart.cast<int>().map((e) => e).toList();
  }

  /// Sets the text color for the badge.
  Future<void> setBadgeTextColor(SetBadgeTextColorDetails details) async {
    await promiseToFuture<void>(
        $js.chrome.action.setBadgeTextColor(details.toJS));
  }

  /// Gets the text color of the action.
  Future<List<int>> getBadgeTextColor(TabDetails details) async {
    var $res = await promiseToFuture<$js_browser_action.ColorArray>(
        $js.chrome.action.getBadgeTextColor(details.toJS));
    return $res.toDart.cast<int>().map((e) => e).toList();
  }

  /// Enables the action for a tab. By default, actions are enabled.
  /// [tabId] The id of the tab for which you want to modify the action.
  Future<void> enable(int? tabId) async {
    await promiseToFuture<void>($js.chrome.action.enable(tabId));
  }

  /// Disables the action for a tab.
  /// [tabId] The id of the tab for which you want to modify the action.
  Future<void> disable(int? tabId) async {
    await promiseToFuture<void>($js.chrome.action.disable(tabId));
  }

  /// Indicates whether the extension action is enabled for a tab (or globally
  /// if no `tabId` is provided). Actions enabled using only
  /// [declarativeContent] always return false.
  /// [tabId] The id of the tab for which you want check enabled status.
  Future<bool> isEnabled(int? tabId) async {
    var $res = await promiseToFuture<bool>($js.chrome.action.isEnabled(tabId));
    return $res;
  }

  /// Returns the user-specified settings relating to an extension's action.
  Future<UserSettings> getUserSettings() async {
    var $res = await promiseToFuture<$js.UserSettings>(
        $js.chrome.action.getUserSettings());
    return UserSettings.fromJS($res);
  }

  /// Opens the extension's popup.
  /// [options] Specifies options for opening the popup.
  Future<void> openPopup(OpenPopupOptions? options) async {
    await promiseToFuture<void>($js.chrome.action.openPopup(options?.toJS));
  }

  /// Fired when an action icon is clicked.  This event will not fire if the
  /// action has a popup.
  EventStream<Tab> get onClicked =>
      $js.chrome.action.onClicked.asStream(($c) => ($js_tabs.Tab tab) {
            return $c(Tab.fromJS(tab));
          });
}

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

class UserSettings {
  UserSettings.fromJS(this._wrapped);

  UserSettings(
      {
      /// Whether the extension's action icon is visible on browser windows'
      /// top-level toolbar (i.e., whether the extension has been 'pinned' by the
      /// user).
      required bool isOnToolbar})
      : _wrapped = $js.UserSettings(isOnToolbar: isOnToolbar);

  final $js.UserSettings _wrapped;

  $js.UserSettings get toJS => _wrapped;

  /// Whether the extension's action icon is visible on browser windows'
  /// top-level toolbar (i.e., whether the extension has been 'pinned' by the
  /// user).
  bool get isOnToolbar => _wrapped.isOnToolbar;
  set isOnToolbar(bool v) {
    _wrapped.isOnToolbar = v;
  }
}

class OpenPopupOptions {
  OpenPopupOptions.fromJS(this._wrapped);

  OpenPopupOptions(
      {
      /// The id of the window to open the action popup in. Defaults to the
      /// currently-active window if unspecified.
      int? windowId})
      : _wrapped = $js.OpenPopupOptions(windowId: windowId);

  final $js.OpenPopupOptions _wrapped;

  $js.OpenPopupOptions get toJS => _wrapped;

  /// The id of the window to open the action popup in. Defaults to the
  /// currently-active window if unspecified.
  int? get windowId => _wrapped.windowId;
  set windowId(int? v) {
    _wrapped.windowId = v;
  }
}

class SetTitleDetails {
  SetTitleDetails.fromJS(this._wrapped);

  SetTitleDetails({
    /// The string the action should display when moused over.
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

  /// The string the action should display when moused over.
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
    /// representing icon to be set. If the icon is specified as a dictionary,
    /// the actual image to be used is chosen depending on screen's pixel
    /// density. If the number of image pixels that fit into one screen space
    /// unit equals `scale`, then image with size `scale` * n will be selected,
    /// where n is the size of the icon in the UI. At least one image must be
    /// specified. Note that 'details.imageData = foo' is equivalent to
    /// 'details.imageData = {'16': foo}'
    Object? imageData,

    /// Either a relative image path or a dictionary {size -> relative image
    /// path} pointing to icon to be set. If the icon is specified as a
    /// dictionary, the actual image to be used is chosen depending on screen's
    /// pixel density. If the number of image pixels that fit into one screen
    /// space unit equals `scale`, then image with size `scale` * n will be
    /// selected, where n is the size of the icon in the UI. At least one image
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
  /// representing icon to be set. If the icon is specified as a dictionary, the
  /// actual image to be used is chosen depending on screen's pixel density. If
  /// the number of image pixels that fit into one screen space unit equals
  /// `scale`, then image with size `scale` * n will be selected, where n is the
  /// size of the icon in the UI. At least one image must be specified. Note
  /// that 'details.imageData = foo' is equivalent to 'details.imageData =
  /// {'16': foo}'
  Object? get imageData => _wrapped.imageData?.when(
        isOther: (v) => (v as $js_browser_action.ImageDataType),
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
  /// pointing to icon to be set. If the icon is specified as a dictionary, the
  /// actual image to be used is chosen depending on screen's pixel density. If
  /// the number of image pixels that fit into one screen space unit equals
  /// `scale`, then image with size `scale` * n will be selected, where n is the
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
    /// Any number of characters can be passed, but only about four can fit in
    /// the space.
    required String text,

    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,
  }) : _wrapped = $js.SetBadgeTextDetails(
          text: text,
          tabId: tabId,
        );

  final $js.SetBadgeTextDetails _wrapped;

  $js.SetBadgeTextDetails get toJS => _wrapped;

  /// Any number of characters can be passed, but only about four can fit in the
  /// space.
  String get text => _wrapped.text;
  set text(String v) {
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
    /// An array of four integers in the range [0,255] that make up the RGBA
    /// color of the badge. For example, opaque red is `[255, 0, 0, 255]`. Can
    /// also be a string with a CSS value, with opaque red being `#FF0000` or
    /// `#F00`.
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

  /// An array of four integers in the range [0,255] that make up the RGBA color
  /// of the badge. For example, opaque red is `[255, 0, 0, 255]`. Can also be a
  /// string with a CSS value, with opaque red being `#FF0000` or `#F00`.
  Object get color => _wrapped.color.when(
        isString: (v) => v,
        isOther: (v) => (v as $js_browser_action.ColorArray)
            .toDart
            .cast<int>()
            .map((e) => e)
            .toList(),
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

class SetBadgeTextColorDetails {
  SetBadgeTextColorDetails.fromJS(this._wrapped);

  SetBadgeTextColorDetails({
    /// An array of four integers in the range [0,255] that make up the RGBA
    /// color of the badge. For example, opaque red is `[255, 0, 0, 255]`. Can
    /// also be a string with a CSS value, with opaque red being `#FF0000` or
    /// `#F00`. Not setting this value will cause a color to be automatically
    /// chosen that will contrast with the badge's background color so the text
    /// will be visible. Colors with alpha values equivalent to 0 will not be
    /// set and will return an error.
    required Object color,

    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,
  }) : _wrapped = $js.SetBadgeTextColorDetails(
          color: switch (color) {
            String() => color,
            List<int>() => color.toJSArray((e) => e),
            _ => throw UnsupportedError(
                'Received type: ${color.runtimeType}. Supported types are: String, List<int>')
          },
          tabId: tabId,
        );

  final $js.SetBadgeTextColorDetails _wrapped;

  $js.SetBadgeTextColorDetails get toJS => _wrapped;

  /// An array of four integers in the range [0,255] that make up the RGBA color
  /// of the badge. For example, opaque red is `[255, 0, 0, 255]`. Can also be a
  /// string with a CSS value, with opaque red being `#FF0000` or `#F00`. Not
  /// setting this value will cause a color to be automatically chosen that will
  /// contrast with the badge's background color so the text will be visible.
  /// Colors with alpha values equivalent to 0 will not be set and will return
  /// an error.
  Object get color => _wrapped.color.when(
        isString: (v) => v,
        isOther: (v) => (v as $js_browser_action.ColorArray)
            .toDart
            .cast<int>()
            .map((e) => e)
            .toList(),
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
