// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSContextMenusExtension on JSChrome {
  @JS('contextMenus')
  external JSContextMenus? get contextMenusNullable;

  /// Use the `chrome.contextMenus` API to add items to Google Chrome's context
  /// menu. You can choose what types of objects your context menu additions
  /// apply to, such as images, hyperlinks, and pages.
  JSContextMenus get contextMenus {
    var contextMenusNullable = this.contextMenusNullable;
    if (contextMenusNullable == null) {
      throw ApiNotAvailableException('chrome.contextMenus');
    }
    return contextMenusNullable;
  }
}

@JS()
@staticInterop
class JSContextMenus {}

extension JSContextMenusExtension on JSContextMenus {
  /// Creates a new context menu item. If an error occurs during creation, it
  /// may not be detected until the creation callback fires; details will be in
  /// [runtime.lastError].
  external Object create(
    CreateProperties createProperties,

    /// Called when the item has been created in the browser. If an error occurs
    /// during creation, details will be available in [runtime.lastError].
    Function? callback,
  );

  /// Updates a previously created context menu item.
  external void update(
    /// The ID of the item to update.
    Object id,

    /// The properties to update. Accepts the same values as the
    /// [contextMenus.create] function.
    UpdateProperties updateProperties,

    /// Called when the context menu has been updated.
    JSFunction? callback,
  );

  /// Removes a context menu item.
  external void remove(
    /// The ID of the context menu item to remove.
    Object menuItemId,

    /// Called when the context menu has been removed.
    JSFunction? callback,
  );

  /// Removes all context menu items added by this extension.
  external void removeAll(

      /// Called when removal is complete.
      JSFunction? callback);

  /// Fired when a context menu item is clicked.
  external Event get onClicked;

  /// The maximum number of top level extension items that can be added to an
  /// extension action context menu. Any items beyond this limit will be
  /// ignored.
  external int get ACTION_MENU_TOP_LEVEL_LIMIT;
}

/// The different contexts a menu can appear in. Specifying 'all' is equivalent
/// to the combination of all other contexts except for 'launcher'. The
/// 'launcher' context is only supported by apps and is used to add menu items
/// to the context menu that appears when clicking the app icon in the
/// launcher/taskbar/dock/etc. Different platforms might put limitations on what
/// is actually supported in a launcher context menu.
typedef ContextType = String;

/// The type of menu item.
typedef ItemType = String;

@JS()
@staticInterop
@anonymous
class OnClickData {
  external factory OnClickData({
    /// The ID of the menu item that was clicked.
    Object menuItemId,

    /// The parent ID, if any, for the item clicked.
    Object? parentMenuItemId,

    /// One of 'image', 'video', or 'audio' if the context menu was activated on
    /// one of these types of elements.
    String? mediaType,

    /// If the element is a link, the URL it points to.
    String? linkUrl,

    /// Will be present for elements with a 'src' URL.
    String? srcUrl,

    /// The URL of the page where the menu item was clicked. This property is not
    /// set if the click occured in a context where there is no current page, such
    /// as in a launcher context menu.
    String? pageUrl,

    ///  The URL of the frame of the element where the context menu was clicked,
    /// if it was in a frame.
    String? frameUrl,

    ///  The [ID of the frame](webNavigation#frame_ids) of the element where the
    /// context menu was clicked, if it was in a frame.
    int? frameId,

    /// The text for the context selection, if any.
    String? selectionText,

    /// A flag indicating whether the element is editable (text input, textarea,
    /// etc.).
    bool editable,

    /// A flag indicating the state of a checkbox or radio item before it was
    /// clicked.
    bool? wasChecked,

    /// A flag indicating the state of a checkbox or radio item after it is
    /// clicked.
    bool? checked,
  });
}

extension OnClickDataExtension on OnClickData {
  /// The ID of the menu item that was clicked.
  external Object menuItemId;

  /// The parent ID, if any, for the item clicked.
  external Object? parentMenuItemId;

  /// One of 'image', 'video', or 'audio' if the context menu was activated on
  /// one of these types of elements.
  external String? mediaType;

  /// If the element is a link, the URL it points to.
  external String? linkUrl;

  /// Will be present for elements with a 'src' URL.
  external String? srcUrl;

  /// The URL of the page where the menu item was clicked. This property is not
  /// set if the click occured in a context where there is no current page, such
  /// as in a launcher context menu.
  external String? pageUrl;

  ///  The URL of the frame of the element where the context menu was clicked,
  /// if it was in a frame.
  external String? frameUrl;

  ///  The [ID of the frame](webNavigation#frame_ids) of the element where the
  /// context menu was clicked, if it was in a frame.
  external int? frameId;

  /// The text for the context selection, if any.
  external String? selectionText;

  /// A flag indicating whether the element is editable (text input, textarea,
  /// etc.).
  external bool editable;

  /// A flag indicating the state of a checkbox or radio item before it was
  /// clicked.
  external bool? wasChecked;

  /// A flag indicating the state of a checkbox or radio item after it is
  /// clicked.
  external bool? checked;
}

@JS()
@staticInterop
@anonymous
class CreateProperties {
  external factory CreateProperties({
    /// The type of menu item. Defaults to `normal`.
    ItemType? type,

    /// The unique ID to assign to this item. Mandatory for event pages. Cannot be
    /// the same as another ID for this extension.
    String? id,

    /// The text to display in the item; this is _required_ unless `type` is
    /// `separator`. When the context is `selection`, use `%s` within the string
    /// to show the selected text. For example, if this parameter's value is
    /// "Translate '%s' to Pig Latin" and the user selects the word "cool", the
    /// context menu item for the selection is "Translate 'cool' to Pig Latin".
    String? title,

    /// The initial state of a checkbox or radio button: `true` for selected,
    /// `false` for unselected. Only one radio button can be selected at a time in
    /// a given group.
    bool? checked,

    /// List of contexts this menu item will appear in. Defaults to `['page']`.
    JSArray? contexts,

    /// Whether the item is visible in the menu.
    bool? visible,

    /// A function that is called back when the menu item is clicked. Event pages
    /// cannot use this; instead, they should register a listener for
    /// [contextMenus.onClicked].
    Function? onclick,

    /// The ID of a parent menu item; this makes the item a child of a previously
    /// added item.
    Object? parentId,

    /// Restricts the item to apply only to documents or frames whose URL matches
    /// one of the given patterns. For details on pattern formats, see [Match
    /// Patterns](match_patterns).
    JSArray? documentUrlPatterns,

    /// Similar to `documentUrlPatterns`, filters based on the `src` attribute of
    /// `img`, `audio`, and `video` tags and the `href` attribute of `a` tags.
    JSArray? targetUrlPatterns,

    /// Whether this context menu item is enabled or disabled. Defaults to `true`.
    bool? enabled,
  });
}

extension CreatePropertiesExtension on CreateProperties {
  /// The type of menu item. Defaults to `normal`.
  external ItemType? type;

  /// The unique ID to assign to this item. Mandatory for event pages. Cannot be
  /// the same as another ID for this extension.
  external String? id;

  /// The text to display in the item; this is _required_ unless `type` is
  /// `separator`. When the context is `selection`, use `%s` within the string
  /// to show the selected text. For example, if this parameter's value is
  /// "Translate '%s' to Pig Latin" and the user selects the word "cool", the
  /// context menu item for the selection is "Translate 'cool' to Pig Latin".
  external String? title;

  /// The initial state of a checkbox or radio button: `true` for selected,
  /// `false` for unselected. Only one radio button can be selected at a time in
  /// a given group.
  external bool? checked;

  /// List of contexts this menu item will appear in. Defaults to `['page']`.
  external JSArray? contexts;

  /// Whether the item is visible in the menu.
  external bool? visible;

  /// A function that is called back when the menu item is clicked. Event pages
  /// cannot use this; instead, they should register a listener for
  /// [contextMenus.onClicked].
  external Function? onclick;

  /// The ID of a parent menu item; this makes the item a child of a previously
  /// added item.
  external Object? parentId;

  /// Restricts the item to apply only to documents or frames whose URL matches
  /// one of the given patterns. For details on pattern formats, see [Match
  /// Patterns](match_patterns).
  external JSArray? documentUrlPatterns;

  /// Similar to `documentUrlPatterns`, filters based on the `src` attribute of
  /// `img`, `audio`, and `video` tags and the `href` attribute of `a` tags.
  external JSArray? targetUrlPatterns;

  /// Whether this context menu item is enabled or disabled. Defaults to `true`.
  external bool? enabled;
}

@JS()
@staticInterop
@anonymous
class UpdateProperties {
  external factory UpdateProperties({
    ItemType? type,
    String? title,
    bool? checked,
    JSArray? contexts,

    /// Whether the item is visible in the menu.
    bool? visible,
    Function? onclick,

    /// The ID of the item to be made this item's parent. Note: You cannot set an
    /// item to become a child of its own descendant.
    Object? parentId,
    JSArray? documentUrlPatterns,
    JSArray? targetUrlPatterns,
    bool? enabled,
  });
}

extension UpdatePropertiesExtension on UpdateProperties {
  external ItemType? type;

  external String? title;

  external bool? checked;

  external JSArray? contexts;

  /// Whether the item is visible in the menu.
  external bool? visible;

  external Function? onclick;

  /// The ID of the item to be made this item's parent. Note: You cannot set an
  /// item to become a child of its own descendant.
  external Object? parentId;

  external JSArray? documentUrlPatterns;

  external JSArray? targetUrlPatterns;

  external bool? enabled;
}
