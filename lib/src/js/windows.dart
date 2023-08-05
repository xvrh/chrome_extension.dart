// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSWindowsExtension on JSChrome {
  @JS('windows')
  external JSWindows? get windowsNullable;

  /// Use the `chrome.windows` API to interact with browser windows. You can use
  /// this API to create, modify, and rearrange windows in the browser.
  JSWindows get windows {
    var windowsNullable = this.windowsNullable;
    if (windowsNullable == null) {
      throw ApiNotAvailableException('chrome.windows');
    }
    return windowsNullable;
  }
}

@JS()
@staticInterop
class JSWindows {}

extension JSWindowsExtension on JSWindows {
  /// Gets details about a window.
  external JSPromise get(
    int windowId,
    QueryOptions? queryOptions,
  );

  /// Gets the [current window](#current-window).
  external JSPromise getCurrent(QueryOptions? queryOptions);

  /// Gets the window that was most recently focused - typically the window 'on
  /// top'.
  external JSPromise getLastFocused(QueryOptions? queryOptions);

  /// Gets all windows.
  external JSPromise getAll(QueryOptions? queryOptions);

  /// Creates (opens) a new browser window with any optional sizing, position,
  /// or default URL provided.
  external JSPromise create(CreateData? createData);

  /// Updates the properties of a window. Specify only the properties that to be
  /// changed; unspecified properties are unchanged.
  external JSPromise update(
    int windowId,
    UpdateInfo updateInfo,
  );

  /// Removes (closes) a window and all the tabs inside it.
  external JSPromise remove(int windowId);

  /// Fired when a window is created.
  external Event get onCreated;

  /// Fired when a window is removed (closed).
  external Event get onRemoved;

  /// Fired when the currently focused window changes. Returns
  /// `chrome.windows.WINDOW_ID_NONE` if all Chrome windows have lost focus.
  /// **Note:** On some Linux window managers, `WINDOW_ID_NONE` is always sent
  /// immediately preceding a switch from one Chrome window to another.
  external Event get onFocusChanged;

  /// Fired when a window has been resized; this event is only dispatched when
  /// the new bounds are committed, and not for in-progress changes.
  external Event get onBoundsChanged;

  /// The windowId value that represents the absence of a Chrome browser window.
  external int get WINDOW_ID_NONE;

  /// The windowId value that represents the [current
  /// window](windows#current-window).
  external int get WINDOW_ID_CURRENT;
}

/// The type of browser window this is. In some circumstances a window may not
/// be assigned a `type` property; for example, when querying closed windows
/// from the [sessions] API.
typedef WindowType = String;

/// The state of this browser window. In some circumstances a window may not be
/// assigned a `state` property; for example, when querying closed windows from
/// the [sessions] API.
typedef WindowState = String;

/// Specifies what type of browser window to create. 'panel' is deprecated and
/// is available only to existing allowlisted extensions on Chrome OS.
typedef CreateType = String;

@JS()
@staticInterop
@anonymous
class Window {
  external factory Window({
    /// The ID of the window. Window IDs are unique within a browser session. In
    /// some circumstances a window may not be assigned an `ID` property; for
    /// example, when querying windows using the [sessions] API, in which case a
    /// session ID may be present.
    int? id,

    /// Whether the window is currently the focused window.
    bool focused,

    /// The offset of the window from the top edge of the screen in pixels. In
    /// some circumstances a window may not be assigned a `top` property; for
    /// example, when querying closed windows from the [sessions] API.
    int? top,

    /// The offset of the window from the left edge of the screen in pixels. In
    /// some circumstances a window may not be assigned a `left` property; for
    /// example, when querying closed windows from the [sessions] API.
    int? left,

    /// The width of the window, including the frame, in pixels. In some
    /// circumstances a window may not be assigned a `width` property; for
    /// example, when querying closed windows from the [sessions] API.
    int? width,

    /// The height of the window, including the frame, in pixels. In some
    /// circumstances a window may not be assigned a `height` property; for
    /// example, when querying closed windows from the [sessions] API.
    int? height,

    /// Array of [tabs.Tab] objects representing the current tabs in the window.
    JSArray? tabs,

    /// Whether the window is incognito.
    bool incognito,

    /// The type of browser window this is.
    WindowType? type,

    /// The state of this browser window.
    WindowState? state,

    /// Whether the window is set to be always on top.
    bool alwaysOnTop,

    /// The session ID used to uniquely identify a window, obtained from the
    /// [sessions] API.
    String? sessionId,
  });
}

extension WindowExtension on Window {
  /// The ID of the window. Window IDs are unique within a browser session. In
  /// some circumstances a window may not be assigned an `ID` property; for
  /// example, when querying windows using the [sessions] API, in which case a
  /// session ID may be present.
  external int? id;

  /// Whether the window is currently the focused window.
  external bool focused;

  /// The offset of the window from the top edge of the screen in pixels. In
  /// some circumstances a window may not be assigned a `top` property; for
  /// example, when querying closed windows from the [sessions] API.
  external int? top;

  /// The offset of the window from the left edge of the screen in pixels. In
  /// some circumstances a window may not be assigned a `left` property; for
  /// example, when querying closed windows from the [sessions] API.
  external int? left;

  /// The width of the window, including the frame, in pixels. In some
  /// circumstances a window may not be assigned a `width` property; for
  /// example, when querying closed windows from the [sessions] API.
  external int? width;

  /// The height of the window, including the frame, in pixels. In some
  /// circumstances a window may not be assigned a `height` property; for
  /// example, when querying closed windows from the [sessions] API.
  external int? height;

  /// Array of [tabs.Tab] objects representing the current tabs in the window.
  external JSArray? tabs;

  /// Whether the window is incognito.
  external bool incognito;

  /// The type of browser window this is.
  external WindowType? type;

  /// The state of this browser window.
  external WindowState? state;

  /// Whether the window is set to be always on top.
  external bool alwaysOnTop;

  /// The session ID used to uniquely identify a window, obtained from the
  /// [sessions] API.
  external String? sessionId;
}

@JS()
@staticInterop
@anonymous
class QueryOptions {
  external factory QueryOptions({
    /// If true, the [windows.Window] object has a [tabs] property that contains a
    /// list of the [tabs.Tab] objects. The `Tab` objects only contain the `url`,
    /// `pendingUrl`, `title`, and `favIconUrl` properties if the extension's
    /// manifest file includes the `"tabs"` permission.
    bool? populate,

    /// If set, the [windows.Window] returned is filtered based on its type. If
    /// unset, the default filter is set to `['normal', 'popup']`.
    JSArray? windowTypes,
  });
}

extension QueryOptionsExtension on QueryOptions {
  /// If true, the [windows.Window] object has a [tabs] property that contains a
  /// list of the [tabs.Tab] objects. The `Tab` objects only contain the `url`,
  /// `pendingUrl`, `title`, and `favIconUrl` properties if the extension's
  /// manifest file includes the `"tabs"` permission.
  external bool? populate;

  /// If set, the [windows.Window] returned is filtered based on its type. If
  /// unset, the default filter is set to `['normal', 'popup']`.
  external JSArray? windowTypes;
}

@JS()
@staticInterop
@anonymous
class CreateData {
  external factory CreateData({
    /// A URL or array of URLs to open as tabs in the window. Fully-qualified URLs
    /// must include a scheme, e.g., 'http://www.google.com', not
    /// 'www.google.com'. Non-fully-qualified URLs are considered relative within
    /// the extension. Defaults to the New Tab Page.
    Object? url,

    /// The ID of the tab to add to the new window.
    int? tabId,

    /// The number of pixels to position the new window from the left edge of the
    /// screen. If not specified, the new window is offset naturally from the last
    /// focused window. This value is ignored for panels.
    int? left,

    /// The number of pixels to position the new window from the top edge of the
    /// screen. If not specified, the new window is offset naturally from the last
    /// focused window. This value is ignored for panels.
    int? top,

    /// The width in pixels of the new window, including the frame. If not
    /// specified, defaults to a natural width.
    int? width,

    /// The height in pixels of the new window, including the frame. If not
    /// specified, defaults to a natural height.
    int? height,

    /// If `true`, opens an active window. If `false`, opens an inactive window.
    bool? focused,

    /// Whether the new window should be an incognito window.
    bool? incognito,

    /// Specifies what type of browser window to create.
    CreateType? type,

    /// The initial state of the window. The `minimized`, `maximized`, and
    /// `fullscreen` states cannot be combined with `left`, `top`, `width`, or
    /// `height`.
    WindowState? state,

    /// If `true`, the newly-created window's 'window.opener' is set to the caller
    /// and is in the same [unit of related browsing
    /// contexts](https://www.w3.org/TR/html51/browsers.html#unit-of-related-browsing-contexts)
    /// as the caller.
    bool? setSelfAsOpener,
  });
}

extension CreateDataExtension on CreateData {
  /// A URL or array of URLs to open as tabs in the window. Fully-qualified URLs
  /// must include a scheme, e.g., 'http://www.google.com', not
  /// 'www.google.com'. Non-fully-qualified URLs are considered relative within
  /// the extension. Defaults to the New Tab Page.
  external Object? url;

  /// The ID of the tab to add to the new window.
  external int? tabId;

  /// The number of pixels to position the new window from the left edge of the
  /// screen. If not specified, the new window is offset naturally from the last
  /// focused window. This value is ignored for panels.
  external int? left;

  /// The number of pixels to position the new window from the top edge of the
  /// screen. If not specified, the new window is offset naturally from the last
  /// focused window. This value is ignored for panels.
  external int? top;

  /// The width in pixels of the new window, including the frame. If not
  /// specified, defaults to a natural width.
  external int? width;

  /// The height in pixels of the new window, including the frame. If not
  /// specified, defaults to a natural height.
  external int? height;

  /// If `true`, opens an active window. If `false`, opens an inactive window.
  external bool? focused;

  /// Whether the new window should be an incognito window.
  external bool? incognito;

  /// Specifies what type of browser window to create.
  external CreateType? type;

  /// The initial state of the window. The `minimized`, `maximized`, and
  /// `fullscreen` states cannot be combined with `left`, `top`, `width`, or
  /// `height`.
  external WindowState? state;

  /// If `true`, the newly-created window's 'window.opener' is set to the caller
  /// and is in the same [unit of related browsing
  /// contexts](https://www.w3.org/TR/html51/browsers.html#unit-of-related-browsing-contexts)
  /// as the caller.
  external bool? setSelfAsOpener;
}

@JS()
@staticInterop
@anonymous
class UpdateInfo {
  external factory UpdateInfo({
    /// The offset from the left edge of the screen to move the window to in
    /// pixels. This value is ignored for panels.
    int? left,

    /// The offset from the top edge of the screen to move the window to in
    /// pixels. This value is ignored for panels.
    int? top,

    /// The width to resize the window to in pixels. This value is ignored for
    /// panels.
    int? width,

    /// The height to resize the window to in pixels. This value is ignored for
    /// panels.
    int? height,

    /// If `true`, brings the window to the front; cannot be combined with the
    /// state 'minimized'. If `false`, brings the next window in the z-order to
    /// the front; cannot be combined with the state 'fullscreen' or 'maximized'.
    bool? focused,

    /// If `true`, causes the window to be displayed in a manner that draws the
    /// user's attention to the window, without changing the focused window. The
    /// effect lasts until the user changes focus to the window. This option has
    /// no effect if the window already has focus. Set to `false` to cancel a
    /// previous `drawAttention` request.
    bool? drawAttention,

    /// The new state of the window. The 'minimized', 'maximized', and
    /// 'fullscreen' states cannot be combined with 'left', 'top', 'width', or
    /// 'height'.
    WindowState? state,
  });
}

extension UpdateInfoExtension on UpdateInfo {
  /// The offset from the left edge of the screen to move the window to in
  /// pixels. This value is ignored for panels.
  external int? left;

  /// The offset from the top edge of the screen to move the window to in
  /// pixels. This value is ignored for panels.
  external int? top;

  /// The width to resize the window to in pixels. This value is ignored for
  /// panels.
  external int? width;

  /// The height to resize the window to in pixels. This value is ignored for
  /// panels.
  external int? height;

  /// If `true`, brings the window to the front; cannot be combined with the
  /// state 'minimized'. If `false`, brings the next window in the z-order to
  /// the front; cannot be combined with the state 'fullscreen' or 'maximized'.
  external bool? focused;

  /// If `true`, causes the window to be displayed in a manner that draws the
  /// user's attention to the window, without changing the focused window. The
  /// effect lasts until the user changes focus to the window. This option has
  /// no effect if the window already has focus. Set to `false` to cancel a
  /// previous `drawAttention` request.
  external bool? drawAttention;

  /// The new state of the window. The 'minimized', 'maximized', and
  /// 'fullscreen' states cannot be combined with 'left', 'top', 'width', or
  /// 'height'.
  external WindowState? state;
}
