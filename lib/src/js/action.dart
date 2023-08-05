// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

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

@JS()
@staticInterop
class JSAction {}

extension JSActionExtension on JSAction {
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
  /// [declarativeNetRequestFeedback](declare_permissions#declarativeNetRequestFeedback)
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

@JS()
@staticInterop
@anonymous
class TabDetails {
  external factory TabDetails(
      {
      /// The ID of the tab to query state for. If no tab is specified, the
      /// non-tab-specific state is returned.
      int? tabId});
}

extension TabDetailsExtension on TabDetails {
  /// The ID of the tab to query state for. If no tab is specified, the
  /// non-tab-specific state is returned.
  external int? tabId;
}

@JS()
@staticInterop
@anonymous
class UserSettings {
  external factory UserSettings(
      {
      /// Whether the extension's action icon is visible on browser windows'
      /// top-level toolbar (i.e., whether the extension has been 'pinned' by the
      /// user).
      bool isOnToolbar});
}

extension UserSettingsExtension on UserSettings {
  /// Whether the extension's action icon is visible on browser windows'
  /// top-level toolbar (i.e., whether the extension has been 'pinned' by the
  /// user).
  external bool isOnToolbar;
}

@JS()
@staticInterop
@anonymous
class OpenPopupOptions {
  external factory OpenPopupOptions(
      {
      /// The id of the window to open the action popup in. Defaults to the
      /// currently-active window if unspecified.
      int? windowId});
}

extension OpenPopupOptionsExtension on OpenPopupOptions {
  /// The id of the window to open the action popup in. Defaults to the
  /// currently-active window if unspecified.
  external int? windowId;
}

@JS()
@staticInterop
@anonymous
class SetTitleDetails {
  external factory SetTitleDetails({
    /// The string the action should display when moused over.
    String title,

    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,
  });
}

extension SetTitleDetailsExtension on SetTitleDetails {
  /// The string the action should display when moused over.
  external String title;

  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  external int? tabId;
}

@JS()
@staticInterop
@anonymous
class SetIconDetails {
  external factory SetIconDetails({
    /// Either an ImageData object or a dictionary {size -> ImageData}
    /// representing icon to be set. If the icon is specified as a dictionary, the
    /// actual image to be used is chosen depending on screen's pixel density. If
    /// the number of image pixels that fit into one screen space unit equals
    /// `scale`, then image with size `scale` * n will be selected, where n is the
    /// size of the icon in the UI. At least one image must be specified. Note
    /// that 'details.imageData = foo' is equivalent to 'details.imageData =
    /// {'16': foo}'
    Object? imageData,

    /// Either a relative image path or a dictionary {size -> relative image path}
    /// pointing to icon to be set. If the icon is specified as a dictionary, the
    /// actual image to be used is chosen depending on screen's pixel density. If
    /// the number of image pixels that fit into one screen space unit equals
    /// `scale`, then image with size `scale` * n will be selected, where n is the
    /// size of the icon in the UI. At least one image must be specified. Note
    /// that 'details.path = foo' is equivalent to 'details.path = {'16': foo}'
    Object? path,

    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,
  });
}

extension SetIconDetailsExtension on SetIconDetails {
  /// Either an ImageData object or a dictionary {size -> ImageData}
  /// representing icon to be set. If the icon is specified as a dictionary, the
  /// actual image to be used is chosen depending on screen's pixel density. If
  /// the number of image pixels that fit into one screen space unit equals
  /// `scale`, then image with size `scale` * n will be selected, where n is the
  /// size of the icon in the UI. At least one image must be specified. Note
  /// that 'details.imageData = foo' is equivalent to 'details.imageData =
  /// {'16': foo}'
  external Object? imageData;

  /// Either a relative image path or a dictionary {size -> relative image path}
  /// pointing to icon to be set. If the icon is specified as a dictionary, the
  /// actual image to be used is chosen depending on screen's pixel density. If
  /// the number of image pixels that fit into one screen space unit equals
  /// `scale`, then image with size `scale` * n will be selected, where n is the
  /// size of the icon in the UI. At least one image must be specified. Note
  /// that 'details.path = foo' is equivalent to 'details.path = {'16': foo}'
  external Object? path;

  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  external int? tabId;
}

@JS()
@staticInterop
@anonymous
class SetPopupDetails {
  external factory SetPopupDetails({
    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,

    /// The relative path to the HTML file to show in a popup. If set to the empty
    /// string (`''`), no popup is shown.
    String popup,
  });
}

extension SetPopupDetailsExtension on SetPopupDetails {
  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  external int? tabId;

  /// The relative path to the HTML file to show in a popup. If set to the empty
  /// string (`''`), no popup is shown.
  external String popup;
}

@JS()
@staticInterop
@anonymous
class SetBadgeTextDetails {
  external factory SetBadgeTextDetails({
    /// Any number of characters can be passed, but only about four can fit in the
    /// space.
    String text,

    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,
  });
}

extension SetBadgeTextDetailsExtension on SetBadgeTextDetails {
  /// Any number of characters can be passed, but only about four can fit in the
  /// space.
  external String text;

  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  external int? tabId;
}

@JS()
@staticInterop
@anonymous
class SetBadgeBackgroundColorDetails {
  external factory SetBadgeBackgroundColorDetails({
    /// An array of four integers in the range [0,255] that make up the RGBA color
    /// of the badge. For example, opaque red is `[255, 0, 0, 255]`. Can also be a
    /// string with a CSS value, with opaque red being `#FF0000` or `#F00`.
    Object color,

    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,
  });
}

extension SetBadgeBackgroundColorDetailsExtension
    on SetBadgeBackgroundColorDetails {
  /// An array of four integers in the range [0,255] that make up the RGBA color
  /// of the badge. For example, opaque red is `[255, 0, 0, 255]`. Can also be a
  /// string with a CSS value, with opaque red being `#FF0000` or `#F00`.
  external Object color;

  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  external int? tabId;
}

@JS()
@staticInterop
@anonymous
class SetBadgeTextColorDetails {
  external factory SetBadgeTextColorDetails({
    /// An array of four integers in the range [0,255] that make up the RGBA color
    /// of the badge. For example, opaque red is `[255, 0, 0, 255]`. Can also be a
    /// string with a CSS value, with opaque red being `#FF0000` or `#F00`. Not
    /// setting this value will cause a color to be automatically chosen that will
    /// contrast with the badge's background color so the text will be visible.
    /// Colors with alpha values equivalent to 0 will not be set and will return
    /// an error.
    Object color,

    /// Limits the change to when a particular tab is selected. Automatically
    /// resets when the tab is closed.
    int? tabId,
  });
}

extension SetBadgeTextColorDetailsExtension on SetBadgeTextColorDetails {
  /// An array of four integers in the range [0,255] that make up the RGBA color
  /// of the badge. For example, opaque red is `[255, 0, 0, 255]`. Can also be a
  /// string with a CSS value, with opaque red being `#FF0000` or `#F00`. Not
  /// setting this value will cause a color to be automatically chosen that will
  /// contrast with the badge's background color so the text will be visible.
  /// Colors with alpha values equivalent to 0 will not be set and will return
  /// an error.
  external Object color;

  /// Limits the change to when a particular tab is selected. Automatically
  /// resets when the tab is closed.
  external int? tabId;
}
