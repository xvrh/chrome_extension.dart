// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import
// ignore_for_file: unintended_html_in_doc_comment

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSActionExtension on JSChrome {
  @JS('action')
  external JSAction? get actionNullable;

  /// Use the `chrome.action` API to control the extension's icon in the Google
  /// Chrome toolbar.
  JSAction get action {
    var actionNullable = this.actionNullable;
    if (actionNullable == null) {
      throw ApiNotAvailableException('chrome.action');
    }
    return actionNullable;
  }
}

extension type JSAction._(JSObject _) {
  /// Sets the title of the action. This shows up in the tooltip.
  external JSPromise setTitle(SetTitleDetails details);

  /// Gets the title of the action.
  external JSPromise getTitle(TabDetails details);

  /// Sets the icon for the action. The icon can be specified either as the path
  /// to an image file or as the pixel data from a canvas element, or as
  /// dictionary of either one of those. Either the **path** or the
  /// **imageData** property must be specified.
  external JSPromise setIcon(SetIconDetails details);

  /// Sets the HTML document to be opened as a popup when the user clicks on the
  /// action's icon.
  external JSPromise setPopup(SetPopupDetails details);

  /// Gets the html document set as the popup for this action.
  external JSPromise getPopup(TabDetails details);

  /// Sets the badge text for the action. The badge is displayed on top of the
  /// icon.
  external JSPromise setBadgeText(SetBadgeTextDetails details);

  /// Gets the badge text of the action. If no tab is specified, the
  /// non-tab-specific badge text is returned. If
  /// [displayActionCountAsBadgeText](declarativeNetRequest#setExtensionActionOptions)
  /// is enabled, a placeholder text will be returned unless the
  /// [declarativeNetRequestFeedback](/docs/extensions/develop/concepts/declare-permissions#declarativeNetRequestFeedback)
  /// permission is present or tab-specific badge text was provided.
  external JSPromise getBadgeText(TabDetails details);

  /// Sets the background color for the badge.
  external JSPromise setBadgeBackgroundColor(
      SetBadgeBackgroundColorDetails details);

  /// Gets the background color of the action.
  external JSPromise getBadgeBackgroundColor(TabDetails details);

  /// Sets the text color for the badge.
  external JSPromise setBadgeTextColor(SetBadgeTextColorDetails details);

  /// Gets the text color of the action.
  external JSPromise getBadgeTextColor(TabDetails details);

  /// Enables the action for a tab. By default, actions are enabled.
  external JSPromise enable(

      /// The id of the tab for which you want to modify the action.
      int? tabId);

  /// Disables the action for a tab.
  external JSPromise disable(

      /// The id of the tab for which you want to modify the action.
      int? tabId);

  /// Indicates whether the extension action is enabled for a tab (or globally
  /// if no `tabId` is provided). Actions enabled using only
  /// [declarativeContent] always return false.
  external JSPromise isEnabled(

      /// The id of the tab for which you want check enabled status.
      int? tabId);

  /// Returns the user-specified settings relating to an extension's action.
  external JSPromise getUserSettings();

  /// Opens the extension's popup.
  external JSPromise openPopup(

      /// Specifies options for opening the popup.
      OpenPopupOptions? options);

  /// Fired when an action icon is clicked.  This event will not fire if the
  /// action has a popup.
  external Event get onClicked;
}
extension type TabDetails._(JSObject _) implements JSObject {
  external factory TabDetails(
      {
      /// The ID of the tab to query state for. If no tab is specified, the
      /// non-tab-specific state is returned.
      int? tabId});

  /// The ID of the tab to query state for. If no tab is specified, the
  /// non-tab-specific state is returned.
  external int? tabId;
}
extension type UserSettings._(JSObject _) implements JSObject {
  external factory UserSettings(
      {
      /// Whether the extension's action icon is visible on browser windows'
      /// top-level toolbar (i.e., whether the extension has been 'pinned' by the
      /// user).
      bool isOnToolbar});

  /// Whether the extension's action icon is visible on browser windows'
  /// top-level toolbar (i.e., whether the extension has been 'pinned' by the
  /// user).
  external bool isOnToolbar;
}
extension type OpenPopupOptions._(JSObject _) implements JSObject {
  external factory OpenPopupOptions(
      {
      /// The id of the window to open the action popup in. Defaults to the
      /// currently-active window if unspecified.
      int? windowId});

  /// The id of the window to open the action popup in. Defaults to the
  /// currently-active window if unspecified.
  external int? windowId;
}
extension type SetTitleDetails._(JSObject _) implements JSObject {
  external factory SetTitleDetails({
    /// The string the action should display when moused over.
    String title,

    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,
  });

  /// The string the action should display when moused over.
  external String title;

  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  external int? tabId;
}
extension type SetIconDetails._(JSObject _) implements JSObject {
  external factory SetIconDetails({
    /// Either an ImageData object or a dictionary {size -> ImageData}
    /// representing icon to be set. If the icon is specified as a dictionary, the
    /// actual image to be used is chosen depending on screen's pixel density. If
    /// the number of image pixels that fit into one screen space unit equals
    /// `scale`, then image with size `scale` * n will be selected, where n is the
    /// size of the icon in the UI. At least one image must be specified. Note
    /// that 'details.imageData = foo' is equivalent to 'details.imageData =
    /// {'16': foo}'
    JSAny? imageData,

    /// Either a relative image path or a dictionary {size -> relative image path}
    /// pointing to icon to be set. If the icon is specified as a dictionary, the
    /// actual image to be used is chosen depending on screen's pixel density. If
    /// the number of image pixels that fit into one screen space unit equals
    /// `scale`, then image with size `scale` * n will be selected, where n is the
    /// size of the icon in the UI. At least one image must be specified. Note
    /// that 'details.path = foo' is equivalent to 'details.path = {'16': foo}'
    JSAny? path,

    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,
  });

  /// Either an ImageData object or a dictionary {size -> ImageData}
  /// representing icon to be set. If the icon is specified as a dictionary, the
  /// actual image to be used is chosen depending on screen's pixel density. If
  /// the number of image pixels that fit into one screen space unit equals
  /// `scale`, then image with size `scale` * n will be selected, where n is the
  /// size of the icon in the UI. At least one image must be specified. Note
  /// that 'details.imageData = foo' is equivalent to 'details.imageData =
  /// {'16': foo}'
  external JSAny? imageData;

  /// Either a relative image path or a dictionary {size -> relative image path}
  /// pointing to icon to be set. If the icon is specified as a dictionary, the
  /// actual image to be used is chosen depending on screen's pixel density. If
  /// the number of image pixels that fit into one screen space unit equals
  /// `scale`, then image with size `scale` * n will be selected, where n is the
  /// size of the icon in the UI. At least one image must be specified. Note
  /// that 'details.path = foo' is equivalent to 'details.path = {'16': foo}'
  external JSAny? path;

  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  external int? tabId;
}
extension type SetPopupDetails._(JSObject _) implements JSObject {
  external factory SetPopupDetails({
    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,

    /// The relative path to the HTML file to show in a popup. If set to the empty
    /// string (`''`), no popup is shown.
    String popup,
  });

  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  external int? tabId;

  /// The relative path to the HTML file to show in a popup. If set to the empty
  /// string (`''`), no popup is shown.
  external String popup;
}
extension type SetBadgeTextDetails._(JSObject _) implements JSObject {
  external factory SetBadgeTextDetails({
    /// Any number of characters can be passed, but only about four can fit in the
    /// space. If an empty string (`''`) is passed, the badge text is cleared.  If
    /// `tabId` is specified and `text` is null, the text for the specified tab is
    /// cleared and defaults to the global badge text.
    String? text,

    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,
  });

  /// Any number of characters can be passed, but only about four can fit in the
  /// space. If an empty string (`''`) is passed, the badge text is cleared.  If
  /// `tabId` is specified and `text` is null, the text for the specified tab is
  /// cleared and defaults to the global badge text.
  external String? text;

  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  external int? tabId;
}
extension type SetBadgeBackgroundColorDetails._(JSObject _)
    implements JSObject {
  external factory SetBadgeBackgroundColorDetails({
    /// An array of four integers in the range [0,255] that make up the RGBA color
    /// of the badge. For example, opaque red is `[255, 0, 0, 255]`. Can also be a
    /// string with a CSS value, with opaque red being `#FF0000` or `#F00`.
    JSAny color,

    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,
  });

  /// An array of four integers in the range [0,255] that make up the RGBA color
  /// of the badge. For example, opaque red is `[255, 0, 0, 255]`. Can also be a
  /// string with a CSS value, with opaque red being `#FF0000` or `#F00`.
  external JSAny color;

  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  external int? tabId;
}
extension type SetBadgeTextColorDetails._(JSObject _) implements JSObject {
  external factory SetBadgeTextColorDetails({
    /// An array of four integers in the range [0,255] that make up the RGBA color
    /// of the badge. For example, opaque red is `[255, 0, 0, 255]`. Can also be a
    /// string with a CSS value, with opaque red being `#FF0000` or `#F00`. Not
    /// setting this value will cause a color to be automatically chosen that will
    /// contrast with the badge's background color so the text will be visible.
    /// Colors with alpha values equivalent to 0 will not be set and will return
    /// an error.
    JSAny color,

    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,
  });

  /// An array of four integers in the range [0,255] that make up the RGBA color
  /// of the badge. For example, opaque red is `[255, 0, 0, 255]`. Can also be a
  /// string with a CSS value, with opaque red being `#FF0000` or `#F00`. Not
  /// setting this value will cause a color to be automatically chosen that will
  /// contrast with the badge's background color so the text will be visible.
  /// Colors with alpha values equivalent to 0 will not be set and will return
  /// an error.
  external JSAny color;

  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  external int? tabId;
}
