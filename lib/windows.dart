// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/tabs.dart' as $js_tabs;
import 'src/js/windows.dart' as $js;
import 'tabs.dart';

export 'src/chrome.dart' show chrome;

final _windows = ChromeWindows._();

extension ChromeWindowsExtension on Chrome {
  /// Use the `chrome.windows` API to interact with browser windows. You can use
  /// this API to create, modify, and rearrange windows in the browser.
  ChromeWindows get windows => _windows;
}

class ChromeWindows {
  ChromeWindows._();

  bool get isAvailable => $js.chrome.windowsNullable != null && alwaysTrue;

  /// Gets details about a window.
  Future<Window> get(
    int windowId,
    QueryOptions? queryOptions,
  ) async {
    var $res = await promiseToFuture<$js.Window>($js.chrome.windows.get(
      windowId,
      queryOptions?.toJS,
    ));
    return Window.fromJS($res);
  }

  /// Gets the [current window](#current-window).
  Future<Window> getCurrent(QueryOptions? queryOptions) async {
    var $res = await promiseToFuture<$js.Window>(
        $js.chrome.windows.getCurrent(queryOptions?.toJS));
    return Window.fromJS($res);
  }

  /// Gets the window that was most recently focused - typically the window 'on
  /// top'.
  Future<Window> getLastFocused(QueryOptions? queryOptions) async {
    var $res = await promiseToFuture<$js.Window>(
        $js.chrome.windows.getLastFocused(queryOptions?.toJS));
    return Window.fromJS($res);
  }

  /// Gets all windows.
  Future<List<Window>> getAll(QueryOptions? queryOptions) async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.windows.getAll(queryOptions?.toJS));
    return $res.toDart.cast<$js.Window>().map((e) => Window.fromJS(e)).toList();
  }

  /// Creates (opens) a new browser window with any optional sizing, position,
  /// or default URL provided.
  Future<Window?> create(CreateData? createData) async {
    var $res = await promiseToFuture<$js.Window?>(
        $js.chrome.windows.create(createData?.toJS));
    return $res?.let(Window.fromJS);
  }

  /// Updates the properties of a window. Specify only the properties that to be
  /// changed; unspecified properties are unchanged.
  Future<Window> update(
    int windowId,
    UpdateInfo updateInfo,
  ) async {
    var $res = await promiseToFuture<$js.Window>($js.chrome.windows.update(
      windowId,
      updateInfo.toJS,
    ));
    return Window.fromJS($res);
  }

  /// Removes (closes) a window and all the tabs inside it.
  Future<void> remove(int windowId) async {
    await promiseToFuture<void>($js.chrome.windows.remove(windowId));
  }

  /// The windowId value that represents the absence of a Chrome browser window.
  int get windowIdNone => $js.chrome.windows.WINDOW_ID_NONE;

  /// The windowId value that represents the [current
  /// window](windows#current-window).
  int get windowIdCurrent => $js.chrome.windows.WINDOW_ID_CURRENT;

  /// Fired when a window is created.
  EventStream<Window> get onCreated =>
      $js.chrome.windows.onCreated.asStream(($c) => ($js.Window window) {
            return $c(Window.fromJS(window));
          });

  /// Fired when a window is removed (closed).
  EventStream<int> get onRemoved =>
      $js.chrome.windows.onRemoved.asStream(($c) => (int windowId) {
            return $c(windowId);
          });

  /// Fired when the currently focused window changes. Returns
  /// `chrome.windows.WINDOW_ID_NONE` if all Chrome windows have lost focus.
  /// **Note:** On some Linux window managers, `WINDOW_ID_NONE` is always sent
  /// immediately preceding a switch from one Chrome window to another.
  EventStream<int> get onFocusChanged =>
      $js.chrome.windows.onFocusChanged.asStream(($c) => (int windowId) {
            return $c(windowId);
          });

  /// Fired when a window has been resized; this event is only dispatched when
  /// the new bounds are committed, and not for in-progress changes.
  EventStream<Window> get onBoundsChanged =>
      $js.chrome.windows.onBoundsChanged.asStream(($c) => ($js.Window window) {
            return $c(Window.fromJS(window));
          });
}

/// The type of browser window this is. In some circumstances a window may not
/// be assigned a `type` property; for example, when querying closed windows
/// from the [sessions] API.
enum WindowType {
  /// A normal browser window.
  normal('normal'),

  /// A browser popup.
  popup('popup'),

  /// <i>Deprecated in this API.</i> A Chrome App panel-style window. Extensions
  /// can only see their own panel windows.
  panel('panel'),

  /// <i>Deprecated in this API.</i> A Chrome App window. Extensions can only
  /// see their app own windows.
  app('app'),

  /// A Developer Tools window.
  devtools('devtools');

  const WindowType(this.value);

  final String value;

  String get toJS => value;
  static WindowType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The state of this browser window. In some circumstances a window may not be
/// assigned a `state` property; for example, when querying closed windows from
/// the [sessions] API.
enum WindowState {
  /// Normal window state (not minimized, maximized, or fullscreen).
  normal('normal'),

  /// Minimized window state.
  minimized('minimized'),

  /// Maximized window state.
  maximized('maximized'),

  /// Fullscreen window state.
  fullscreen('fullscreen'),

  /// Locked fullscreen window state. This fullscreen state cannot be exited by
  /// user action and is available only to allowlisted extensions on Chrome OS.
  lockedFullscreen('locked-fullscreen');

  const WindowState(this.value);

  final String value;

  String get toJS => value;
  static WindowState fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Specifies what type of browser window to create. 'panel' is deprecated and
/// is available only to existing allowlisted extensions on Chrome OS.
enum CreateType {
  normal('normal'),
  popup('popup'),
  panel('panel');

  const CreateType(this.value);

  final String value;

  String get toJS => value;
  static CreateType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class Window {
  Window.fromJS(this._wrapped);

  Window({
    /// The ID of the window. Window IDs are unique within a browser session. In
    /// some circumstances a window may not be assigned an `ID` property; for
    /// example, when querying windows using the [sessions] API, in which case a
    /// session ID may be present.
    int? id,

    /// Whether the window is currently the focused window.
    required bool focused,

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
    List<Tab>? tabs,

    /// Whether the window is incognito.
    required bool incognito,

    /// The type of browser window this is.
    WindowType? type,

    /// The state of this browser window.
    WindowState? state,

    /// Whether the window is set to be always on top.
    required bool alwaysOnTop,

    /// The session ID used to uniquely identify a window, obtained from the
    /// [sessions] API.
    String? sessionId,
  }) : _wrapped = $js.Window(
          id: id,
          focused: focused,
          top: top,
          left: left,
          width: width,
          height: height,
          tabs: tabs?.toJSArray((e) => e.toJS),
          incognito: incognito,
          type: type?.toJS,
          state: state?.toJS,
          alwaysOnTop: alwaysOnTop,
          sessionId: sessionId,
        );

  final $js.Window _wrapped;

  $js.Window get toJS => _wrapped;

  /// The ID of the window. Window IDs are unique within a browser session. In
  /// some circumstances a window may not be assigned an `ID` property; for
  /// example, when querying windows using the [sessions] API, in which case a
  /// session ID may be present.
  int? get id => _wrapped.id;
  set id(int? v) {
    _wrapped.id = v;
  }

  /// Whether the window is currently the focused window.
  bool get focused => _wrapped.focused;
  set focused(bool v) {
    _wrapped.focused = v;
  }

  /// The offset of the window from the top edge of the screen in pixels. In
  /// some circumstances a window may not be assigned a `top` property; for
  /// example, when querying closed windows from the [sessions] API.
  int? get top => _wrapped.top;
  set top(int? v) {
    _wrapped.top = v;
  }

  /// The offset of the window from the left edge of the screen in pixels. In
  /// some circumstances a window may not be assigned a `left` property; for
  /// example, when querying closed windows from the [sessions] API.
  int? get left => _wrapped.left;
  set left(int? v) {
    _wrapped.left = v;
  }

  /// The width of the window, including the frame, in pixels. In some
  /// circumstances a window may not be assigned a `width` property; for
  /// example, when querying closed windows from the [sessions] API.
  int? get width => _wrapped.width;
  set width(int? v) {
    _wrapped.width = v;
  }

  /// The height of the window, including the frame, in pixels. In some
  /// circumstances a window may not be assigned a `height` property; for
  /// example, when querying closed windows from the [sessions] API.
  int? get height => _wrapped.height;
  set height(int? v) {
    _wrapped.height = v;
  }

  /// Array of [tabs.Tab] objects representing the current tabs in the window.
  List<Tab>? get tabs => _wrapped.tabs?.toDart
      .cast<$js_tabs.Tab>()
      .map((e) => Tab.fromJS(e))
      .toList();
  set tabs(List<Tab>? v) {
    _wrapped.tabs = v?.toJSArray((e) => e.toJS);
  }

  /// Whether the window is incognito.
  bool get incognito => _wrapped.incognito;
  set incognito(bool v) {
    _wrapped.incognito = v;
  }

  /// The type of browser window this is.
  WindowType? get type => _wrapped.type?.let(WindowType.fromJS);
  set type(WindowType? v) {
    _wrapped.type = v?.toJS;
  }

  /// The state of this browser window.
  WindowState? get state => _wrapped.state?.let(WindowState.fromJS);
  set state(WindowState? v) {
    _wrapped.state = v?.toJS;
  }

  /// Whether the window is set to be always on top.
  bool get alwaysOnTop => _wrapped.alwaysOnTop;
  set alwaysOnTop(bool v) {
    _wrapped.alwaysOnTop = v;
  }

  /// The session ID used to uniquely identify a window, obtained from the
  /// [sessions] API.
  String? get sessionId => _wrapped.sessionId;
  set sessionId(String? v) {
    _wrapped.sessionId = v;
  }
}

class QueryOptions {
  QueryOptions.fromJS(this._wrapped);

  QueryOptions({
    /// If true, the [windows.Window] object has a [tabs] property that contains
    /// a list of the [tabs.Tab] objects. The `Tab` objects only contain the
    /// `url`, `pendingUrl`, `title`, and `favIconUrl` properties if the
    /// extension's manifest file includes the `"tabs"` permission.
    bool? populate,

    /// If set, the [windows.Window] returned is filtered based on its type. If
    /// unset, the default filter is set to `['normal', 'popup']`.
    List<WindowType>? windowTypes,
  }) : _wrapped = $js.QueryOptions(
          populate: populate,
          windowTypes: windowTypes?.toJSArray((e) => e.toJS),
        );

  final $js.QueryOptions _wrapped;

  $js.QueryOptions get toJS => _wrapped;

  /// If true, the [windows.Window] object has a [tabs] property that contains a
  /// list of the [tabs.Tab] objects. The `Tab` objects only contain the `url`,
  /// `pendingUrl`, `title`, and `favIconUrl` properties if the extension's
  /// manifest file includes the `"tabs"` permission.
  bool? get populate => _wrapped.populate;
  set populate(bool? v) {
    _wrapped.populate = v;
  }

  /// If set, the [windows.Window] returned is filtered based on its type. If
  /// unset, the default filter is set to `['normal', 'popup']`.
  List<WindowType>? get windowTypes => _wrapped.windowTypes?.toDart
      .cast<$js.WindowType>()
      .map((e) => WindowType.fromJS(e))
      .toList();
  set windowTypes(List<WindowType>? v) {
    _wrapped.windowTypes = v?.toJSArray((e) => e.toJS);
  }
}

class CreateData {
  CreateData.fromJS(this._wrapped);

  CreateData({
    /// A URL or array of URLs to open as tabs in the window. Fully-qualified
    /// URLs must include a scheme, e.g., 'http://www.google.com', not
    /// 'www.google.com'. Non-fully-qualified URLs are considered relative
    /// within the extension. Defaults to the New Tab Page.
    Object? url,

    /// The ID of the tab to add to the new window.
    int? tabId,

    /// The number of pixels to position the new window from the left edge of
    /// the screen. If not specified, the new window is offset naturally from
    /// the last focused window. This value is ignored for panels.
    int? left,

    /// The number of pixels to position the new window from the top edge of the
    /// screen. If not specified, the new window is offset naturally from the
    /// last focused window. This value is ignored for panels.
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

    /// If `true`, the newly-created window's 'window.opener' is set to the
    /// caller and is in the same [unit of related browsing
    /// contexts](https://www.w3.org/TR/html51/browsers.html#unit-of-related-browsing-contexts)
    /// as the caller.
    bool? setSelfAsOpener,
  }) : _wrapped = $js.CreateData(
          url: switch (url) {
            String() => url,
            List() => url.toJSArrayString(),
            null => null,
            _ => throw UnsupportedError(
                'Received type: ${url.runtimeType}. Supported types are: String, List<String>')
          },
          tabId: tabId,
          left: left,
          top: top,
          width: width,
          height: height,
          focused: focused,
          incognito: incognito,
          type: type?.toJS,
          state: state?.toJS,
          setSelfAsOpener: setSelfAsOpener,
        );

  final $js.CreateData _wrapped;

  $js.CreateData get toJS => _wrapped;

  /// A URL or array of URLs to open as tabs in the window. Fully-qualified URLs
  /// must include a scheme, e.g., 'http://www.google.com', not
  /// 'www.google.com'. Non-fully-qualified URLs are considered relative within
  /// the extension. Defaults to the New Tab Page.
  Object? get url => _wrapped.url?.when(
        isString: (v) => v,
        isArray: (v) => v.toDart.cast<String>().map((e) => e).toList(),
      );
  set url(Object? v) {
    _wrapped.url = switch (v) {
      String() => v,
      List() => v.toJSArrayString(),
      null => null,
      _ => throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: String, List<String>')
    };
  }

  /// The ID of the tab to add to the new window.
  int? get tabId => _wrapped.tabId;
  set tabId(int? v) {
    _wrapped.tabId = v;
  }

  /// The number of pixels to position the new window from the left edge of the
  /// screen. If not specified, the new window is offset naturally from the last
  /// focused window. This value is ignored for panels.
  int? get left => _wrapped.left;
  set left(int? v) {
    _wrapped.left = v;
  }

  /// The number of pixels to position the new window from the top edge of the
  /// screen. If not specified, the new window is offset naturally from the last
  /// focused window. This value is ignored for panels.
  int? get top => _wrapped.top;
  set top(int? v) {
    _wrapped.top = v;
  }

  /// The width in pixels of the new window, including the frame. If not
  /// specified, defaults to a natural width.
  int? get width => _wrapped.width;
  set width(int? v) {
    _wrapped.width = v;
  }

  /// The height in pixels of the new window, including the frame. If not
  /// specified, defaults to a natural height.
  int? get height => _wrapped.height;
  set height(int? v) {
    _wrapped.height = v;
  }

  /// If `true`, opens an active window. If `false`, opens an inactive window.
  bool? get focused => _wrapped.focused;
  set focused(bool? v) {
    _wrapped.focused = v;
  }

  /// Whether the new window should be an incognito window.
  bool? get incognito => _wrapped.incognito;
  set incognito(bool? v) {
    _wrapped.incognito = v;
  }

  /// Specifies what type of browser window to create.
  CreateType? get type => _wrapped.type?.let(CreateType.fromJS);
  set type(CreateType? v) {
    _wrapped.type = v?.toJS;
  }

  /// The initial state of the window. The `minimized`, `maximized`, and
  /// `fullscreen` states cannot be combined with `left`, `top`, `width`, or
  /// `height`.
  WindowState? get state => _wrapped.state?.let(WindowState.fromJS);
  set state(WindowState? v) {
    _wrapped.state = v?.toJS;
  }

  /// If `true`, the newly-created window's 'window.opener' is set to the caller
  /// and is in the same [unit of related browsing
  /// contexts](https://www.w3.org/TR/html51/browsers.html#unit-of-related-browsing-contexts)
  /// as the caller.
  bool? get setSelfAsOpener => _wrapped.setSelfAsOpener;
  set setSelfAsOpener(bool? v) {
    _wrapped.setSelfAsOpener = v;
  }
}

class UpdateInfo {
  UpdateInfo.fromJS(this._wrapped);

  UpdateInfo({
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
    /// the front; cannot be combined with the state 'fullscreen' or
    /// 'maximized'.
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
  }) : _wrapped = $js.UpdateInfo(
          left: left,
          top: top,
          width: width,
          height: height,
          focused: focused,
          drawAttention: drawAttention,
          state: state?.toJS,
        );

  final $js.UpdateInfo _wrapped;

  $js.UpdateInfo get toJS => _wrapped;

  /// The offset from the left edge of the screen to move the window to in
  /// pixels. This value is ignored for panels.
  int? get left => _wrapped.left;
  set left(int? v) {
    _wrapped.left = v;
  }

  /// The offset from the top edge of the screen to move the window to in
  /// pixels. This value is ignored for panels.
  int? get top => _wrapped.top;
  set top(int? v) {
    _wrapped.top = v;
  }

  /// The width to resize the window to in pixels. This value is ignored for
  /// panels.
  int? get width => _wrapped.width;
  set width(int? v) {
    _wrapped.width = v;
  }

  /// The height to resize the window to in pixels. This value is ignored for
  /// panels.
  int? get height => _wrapped.height;
  set height(int? v) {
    _wrapped.height = v;
  }

  /// If `true`, brings the window to the front; cannot be combined with the
  /// state 'minimized'. If `false`, brings the next window in the z-order to
  /// the front; cannot be combined with the state 'fullscreen' or 'maximized'.
  bool? get focused => _wrapped.focused;
  set focused(bool? v) {
    _wrapped.focused = v;
  }

  /// If `true`, causes the window to be displayed in a manner that draws the
  /// user's attention to the window, without changing the focused window. The
  /// effect lasts until the user changes focus to the window. This option has
  /// no effect if the window already has focus. Set to `false` to cancel a
  /// previous `drawAttention` request.
  bool? get drawAttention => _wrapped.drawAttention;
  set drawAttention(bool? v) {
    _wrapped.drawAttention = v;
  }

  /// The new state of the window. The 'minimized', 'maximized', and
  /// 'fullscreen' states cannot be combined with 'left', 'top', 'width', or
  /// 'height'.
  WindowState? get state => _wrapped.state?.let(WindowState.fromJS);
  set state(WindowState? v) {
    _wrapped.state = v?.toJS;
  }
}
