// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'extension_types.dart';
import 'runtime.dart';
import 'src/internal_helpers.dart';
import 'src/js/tabs.dart' as $js;
import 'src/js/windows.dart' as $js_windows;
import 'windows.dart';

export 'src/chrome.dart' show chrome;

final _tabs = ChromeTabs._();

extension ChromeTabsExtension on Chrome {
  /// Use the `chrome.tabs` API to interact with the browser's tab system. You
  /// can use this API to create, modify, and rearrange tabs in the browser.
  ChromeTabs get tabs => _tabs;
}

class ChromeTabs {
  ChromeTabs._();

  bool get isAvailable => $js.chrome.tabsNullable != null && alwaysTrue;

  /// Retrieves details about the specified tab.
  Future<Tab> get(int tabId) async {
    var $res = await promiseToFuture<$js.Tab>($js.chrome.tabs.get(tabId));
    return Tab.fromJS($res);
  }

  /// Gets the tab that this script call is being made from. May be undefined if
  /// called from a non-tab context (for example, a background page or popup
  /// view).
  Future<Tab?> getCurrent() async {
    var $res = await promiseToFuture<$js.Tab?>($js.chrome.tabs.getCurrent());
    return $res?.let(Tab.fromJS);
  }

  /// Connects to the content script(s) in the specified tab. The
  /// [runtime.onConnect] event is fired in each content script running in the
  /// specified tab for the current extension. For more details, see [Content
  /// Script Messaging](messaging).
  /// [returns] A port that can be used to communicate with the content
  /// scripts running in the specified tab. The port's [runtime.Port] event is
  /// fired if the tab closes or does not exist.
  Port connect(
    int tabId,
    ConnectInfo? connectInfo,
  ) {
    return Port.fromJS($js.chrome.tabs.connect(
      tabId,
      connectInfo?.toJS,
    ));
  }

  /// Sends a single request to the content script(s) in the specified tab, with
  /// an optional callback to run when a response is sent back.  The
  /// [extension.onRequest] event is fired in each content script running in the
  /// specified tab for the current extension.
  @Deprecated(r'Please use $(ref:runtime.sendMessage).')
  Future<Object> sendRequest(
    int tabId,
    Object request,
  ) async {
    var $res = await promiseToFuture<JSAny>($js.chrome.tabs.sendRequest(
      tabId,
      request.jsify()!,
    ));
    return $res.dartify()!;
  }

  /// Sends a single message to the content script(s) in the specified tab, with
  /// an optional callback to run when a response is sent back.  The
  /// [runtime.onMessage] event is fired in each content script running in the
  /// specified tab for the current extension.
  /// [message] The message to send. This message should be a JSON-ifiable
  /// object.
  Future<Object> sendMessage(
    int tabId,
    Object message,
    SendMessageOptions? options,
  ) async {
    var $res = await promiseToFuture<JSAny>($js.chrome.tabs.sendMessage(
      tabId,
      message.jsify()!,
      options?.toJS,
    ));
    return $res.dartify()!;
  }

  /// Gets the tab that is selected in the specified window.
  /// [windowId] Defaults to the [current window](windows#current-window).
  @Deprecated(r'Please use $(ref:tabs.query) <code>{active: true}</code>.')
  Future<Tab> getSelected(int? windowId) async {
    var $res =
        await promiseToFuture<$js.Tab>($js.chrome.tabs.getSelected(windowId));
    return Tab.fromJS($res);
  }

  /// Gets details about all tabs in the specified window.
  /// [windowId] Defaults to the [current window](windows#current-window).
  @Deprecated(
      r'Please use $(ref:tabs.query) <code>{windowId: windowId}</code>.')
  Future<List<Tab>> getAllInWindow(int? windowId) async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.tabs.getAllInWindow(windowId));
    return $res.toDart.cast<$js.Tab>().map((e) => Tab.fromJS(e)).toList();
  }

  /// Creates a new tab.
  Future<Tab> create(CreateProperties createProperties) async {
    var $res = await promiseToFuture<$js.Tab>(
        $js.chrome.tabs.create(createProperties.toJS));
    return Tab.fromJS($res);
  }

  /// Duplicates a tab.
  /// [tabId] The ID of the tab to duplicate.
  Future<Tab?> duplicate(int tabId) async {
    var $res =
        await promiseToFuture<$js.Tab?>($js.chrome.tabs.duplicate(tabId));
    return $res?.let(Tab.fromJS);
  }

  /// Gets all tabs that have the specified properties, or all tabs if no
  /// properties are specified.
  Future<List<Tab>> query(QueryInfo queryInfo) async {
    var $res =
        await promiseToFuture<JSArray>($js.chrome.tabs.query(queryInfo.toJS));
    return $res.toDart.cast<$js.Tab>().map((e) => Tab.fromJS(e)).toList();
  }

  /// Highlights the given tabs and focuses on the first of group. Will appear
  /// to do nothing if the specified tab is currently active.
  Future<Window> highlight(HighlightInfo highlightInfo) async {
    var $res = await promiseToFuture<$js_windows.Window>(
        $js.chrome.tabs.highlight(highlightInfo.toJS));
    return Window.fromJS($res);
  }

  /// Modifies the properties of a tab. Properties that are not specified in
  /// [updateProperties] are not modified.
  /// [tabId] Defaults to the selected tab of the [current
  /// window](windows#current-window).
  Future<Tab?> update(
    int? tabId,
    UpdateProperties updateProperties,
  ) async {
    var $res = await promiseToFuture<$js.Tab?>($js.chrome.tabs.update(
      tabId,
      updateProperties.toJS,
    ));
    return $res?.let(Tab.fromJS);
  }

  /// Moves one or more tabs to a new position within its window, or to a new
  /// window. Note that tabs can only be moved to and from normal (window.type
  /// === "normal") windows.
  /// [tabIds] The tab ID or list of tab IDs to move.
  Future<Object> move(
    Object tabIds,
    MoveProperties moveProperties,
  ) async {
    var $res = await promiseToFuture<Object>($js.chrome.tabs.move(
      switch (tabIds) {
        int() => tabIds,
        List<int>() => tabIds.toJSArray((e) => e),
        _ => throw UnsupportedError(
            'Received type: ${tabIds.runtimeType}. Supported types are: int, List<int>')
      },
      moveProperties.toJS,
    ));
    return $res.when(
      isOther: (v) => Tab.fromJS((v as $js.Tab)),
      isArray: (v) =>
          v.toDart.cast<$js.Tab>().map((e) => Tab.fromJS(e)).toList(),
    );
  }

  /// Reload a tab.
  /// [tabId] The ID of the tab to reload; defaults to the selected tab of the
  /// current window.
  Future<void> reload(
    int? tabId,
    ReloadProperties? reloadProperties,
  ) async {
    await promiseToFuture<void>($js.chrome.tabs.reload(
      tabId,
      reloadProperties?.toJS,
    ));
  }

  /// Closes one or more tabs.
  /// [tabIds] The tab ID or list of tab IDs to close.
  Future<void> remove(Object tabIds) async {
    await promiseToFuture<void>($js.chrome.tabs.remove(switch (tabIds) {
      int() => tabIds,
      List<int>() => tabIds.toJSArray((e) => e),
      _ => throw UnsupportedError(
          'Received type: ${tabIds.runtimeType}. Supported types are: int, List<int>')
    }));
  }

  /// Adds one or more tabs to a specified group, or if no group is specified,
  /// adds the given tabs to a newly created group.
  Future<int> group(GroupOptions options) async {
    var $res = await promiseToFuture<int>($js.chrome.tabs.group(options.toJS));
    return $res;
  }

  /// Removes one or more tabs from their respective groups. If any groups
  /// become empty, they are deleted.
  /// [tabIds] The tab ID or list of tab IDs to remove from their respective
  /// groups.
  Future<void> ungroup(Object tabIds) async {
    await promiseToFuture<void>($js.chrome.tabs.ungroup(switch (tabIds) {
      int() => tabIds,
      List<int>() => tabIds.toJSArray((e) => e),
      _ => throw UnsupportedError(
          'Received type: ${tabIds.runtimeType}. Supported types are: int, List<int>')
    }));
  }

  /// Detects the primary language of the content in a tab.
  /// [tabId] Defaults to the active tab of the [current
  /// window](windows#current-window).
  Future<String> detectLanguage(int? tabId) async {
    var $res =
        await promiseToFuture<String>($js.chrome.tabs.detectLanguage(tabId));
    return $res;
  }

  /// Captures the visible area of the currently active tab in the specified
  /// window. In order to call this method, the extension must have either the
  /// <a href='declare_permissions'><all_urls></a> permission or the
  /// [activeTab](activeTab) permission. In addition to sites that extensions
  /// can normally access, this method allows extensions to capture sensitive
  /// sites that are otherwise restricted, including chrome:-scheme pages, other
  /// extensions' pages, and data: URLs. These sensitive sites can only be
  /// captured with the activeTab permission. File URLs may be captured only if
  /// the extension has been granted file access.
  /// [windowId] The target window. Defaults to the [current
  /// window](windows#current-window).
  Future<String> captureVisibleTab(
    int? windowId,
    ImageDetails? options,
  ) async {
    var $res = await promiseToFuture<String>($js.chrome.tabs.captureVisibleTab(
      windowId,
      options?.toJS,
    ));
    return $res;
  }

  /// Injects JavaScript code into a page. For details, see the [programmatic
  /// injection](content_scripts#pi) section of the content scripts doc.
  /// [tabId] The ID of the tab in which to run the script; defaults to the
  /// active tab of the current window.
  /// [details] Details of the script to run. Either the code or the file
  /// property must be set, but both may not be set at the same time.
  /// [returns] Called after all the JavaScript has been executed.
  @Deprecated(r'Replaced by $(ref:scripting.executeScript) in Manifest V3.')
  Future<List<Object>?> executeScript(
    int? tabId,
    InjectDetails details,
  ) async {
    var $res = await promiseToFuture<JSArray?>($js.chrome.tabs.executeScript(
      tabId,
      details.toJS,
    ));
    return $res?.toDart.cast<JSAny>().map((e) => e.dartify()!).toList();
  }

  /// Injects CSS into a page. Styles inserted with this method can be removed
  /// with [scripting.removeCSS]. For details, see the [programmatic
  /// injection](content_scripts#pi) section of the content scripts doc.
  /// [tabId] The ID of the tab in which to insert the CSS; defaults to the
  /// active tab of the current window.
  /// [details] Details of the CSS text to insert. Either the code or the file
  /// property must be set, but both may not be set at the same time.
  /// [returns] Called when all the CSS has been inserted.
  @Deprecated(r'Replaced by $(ref:scripting.insertCSS) in Manifest V3.')
  Future<void> insertCSS(
    int? tabId,
    InjectDetails details,
  ) async {
    await promiseToFuture<void>($js.chrome.tabs.insertCSS(
      tabId,
      details.toJS,
    ));
  }

  /// Removes from a page CSS that was previously injected by a call to
  /// [scripting.insertCSS].
  /// [tabId] The ID of the tab from which to remove the CSS; defaults to the
  /// active tab of the current window.
  /// [details] Details of the CSS text to remove. Either the code or the file
  /// property must be set, but both may not be set at the same time.
  /// [returns] Called when all the CSS has been removed.
  @Deprecated(r'Replaced by $(ref:scripting.removeCSS) in Manifest V3.')
  Future<void> removeCSS(
    int? tabId,
    DeleteInjectionDetails details,
  ) async {
    await promiseToFuture<void>($js.chrome.tabs.removeCSS(
      tabId,
      details.toJS,
    ));
  }

  /// Zooms a specified tab.
  /// [tabId] The ID of the tab to zoom; defaults to the active tab of the
  /// current window.
  /// [zoomFactor] The new zoom factor. A value of `0` sets the tab to its
  /// current default zoom factor. Values greater than `0` specify a (possibly
  /// non-default) zoom factor for the tab.
  /// [returns] Called after the zoom factor has been changed.
  Future<void> setZoom(
    int? tabId,
    double zoomFactor,
  ) async {
    await promiseToFuture<void>($js.chrome.tabs.setZoom(
      tabId,
      zoomFactor,
    ));
  }

  /// Gets the current zoom factor of a specified tab.
  /// [tabId] The ID of the tab to get the current zoom factor from; defaults
  /// to the active tab of the current window.
  /// [returns] Called with the tab's current zoom factor after it has been
  /// fetched.
  Future<double> getZoom(int? tabId) async {
    var $res = await promiseToFuture<double>($js.chrome.tabs.getZoom(tabId));
    return $res;
  }

  /// Sets the zoom settings for a specified tab, which define how zoom changes
  /// are handled. These settings are reset to defaults upon navigating the tab.
  /// [tabId] The ID of the tab to change the zoom settings for; defaults to
  /// the active tab of the current window.
  /// [zoomSettings] Defines how zoom changes are handled and at what scope.
  /// [returns] Called after the zoom settings are changed.
  Future<void> setZoomSettings(
    int? tabId,
    ZoomSettings zoomSettings,
  ) async {
    await promiseToFuture<void>($js.chrome.tabs.setZoomSettings(
      tabId,
      zoomSettings.toJS,
    ));
  }

  /// Gets the current zoom settings of a specified tab.
  /// [tabId] The ID of the tab to get the current zoom settings from;
  /// defaults to the active tab of the current window.
  /// [returns] Called with the tab's current zoom settings.
  Future<ZoomSettings> getZoomSettings(int? tabId) async {
    var $res = await promiseToFuture<$js.ZoomSettings>(
        $js.chrome.tabs.getZoomSettings(tabId));
    return ZoomSettings.fromJS($res);
  }

  /// Discards a tab from memory. Discarded tabs are still visible on the tab
  /// strip and are reloaded when activated.
  /// [tabId] The ID of the tab to be discarded. If specified, the tab is
  /// discarded unless it is active or already discarded. If omitted, the
  /// browser discards the least important tab. This can fail if no
  /// discardable tabs exist.
  /// [returns] Called after the operation is completed.
  Future<Tab?> discard(int? tabId) async {
    var $res = await promiseToFuture<$js.Tab?>($js.chrome.tabs.discard(tabId));
    return $res?.let(Tab.fromJS);
  }

  /// Go foward to the next page, if one is available.
  /// [tabId] The ID of the tab to navigate forward; defaults to the selected
  /// tab of the current window.
  Future<void> goForward(int? tabId) async {
    await promiseToFuture<void>($js.chrome.tabs.goForward(tabId));
  }

  /// Go back to the previous page, if one is available.
  /// [tabId] The ID of the tab to navigate back; defaults to the selected tab
  /// of the current window.
  Future<void> goBack(int? tabId) async {
    await promiseToFuture<void>($js.chrome.tabs.goBack(tabId));
  }

  /// The maximum number of times that [captureVisibleTab] can be called per
  /// second. [captureVisibleTab] is expensive and should not be called too
  /// often.
  int get maxCaptureVisibleTabCallsPerSecond =>
      $js.chrome.tabs.MAX_CAPTURE_VISIBLE_TAB_CALLS_PER_SECOND;

  /// An ID that represents the absence of a browser tab.
  int get tabIdNone => $js.chrome.tabs.TAB_ID_NONE;

  /// Fired when a tab is created. Note that the tab's URL and tab group
  /// membership may not be set at the time this event is fired, but you can
  /// listen to onUpdated events so as to be notified when a URL is set or the
  /// tab is added to a tab group.
  EventStream<Tab> get onCreated =>
      $js.chrome.tabs.onCreated.asStream(($c) => ($js.Tab tab) {
            return $c(Tab.fromJS(tab));
          });

  /// Fired when a tab is updated.
  EventStream<OnUpdatedEvent> get onUpdated =>
      $js.chrome.tabs.onUpdated.asStream(($c) => (
            int tabId,
            $js.OnUpdatedChangeInfo changeInfo,
            $js.Tab tab,
          ) {
            return $c(OnUpdatedEvent(
              tabId: tabId,
              changeInfo: OnUpdatedChangeInfo.fromJS(changeInfo),
              tab: Tab.fromJS(tab),
            ));
          });

  /// Fired when a tab is moved within a window. Only one move event is fired,
  /// representing the tab the user directly moved. Move events are not fired
  /// for the other tabs that must move in response to the manually-moved tab.
  /// This event is not fired when a tab is moved between windows; for details,
  /// see [tabs.onDetached].
  EventStream<OnMovedEvent> get onMoved =>
      $js.chrome.tabs.onMoved.asStream(($c) => (
            int tabId,
            $js.OnMovedMoveInfo moveInfo,
          ) {
            return $c(OnMovedEvent(
              tabId: tabId,
              moveInfo: OnMovedMoveInfo.fromJS(moveInfo),
            ));
          });

  /// Fires when the selected tab in a window changes.
  EventStream<OnSelectionChangedEvent> get onSelectionChanged =>
      $js.chrome.tabs.onSelectionChanged.asStream(($c) => (
            int tabId,
            $js.OnSelectionChangedSelectInfo selectInfo,
          ) {
            return $c(OnSelectionChangedEvent(
              tabId: tabId,
              selectInfo: OnSelectionChangedSelectInfo.fromJS(selectInfo),
            ));
          });

  /// Fires when the selected tab in a window changes. Note that the tab's URL
  /// may not be set at the time this event fired, but you can listen to
  /// [tabs.onUpdated] events so as to be notified when a URL is set.
  EventStream<OnActiveChangedEvent> get onActiveChanged =>
      $js.chrome.tabs.onActiveChanged.asStream(($c) => (
            int tabId,
            $js.OnActiveChangedSelectInfo selectInfo,
          ) {
            return $c(OnActiveChangedEvent(
              tabId: tabId,
              selectInfo: OnActiveChangedSelectInfo.fromJS(selectInfo),
            ));
          });

  /// Fires when the active tab in a window changes. Note that the tab's URL may
  /// not be set at the time this event fired, but you can listen to onUpdated
  /// events so as to be notified when a URL is set.
  EventStream<OnActivatedActiveInfo> get onActivated =>
      $js.chrome.tabs.onActivated
          .asStream(($c) => ($js.OnActivatedActiveInfo activeInfo) {
                return $c(OnActivatedActiveInfo.fromJS(activeInfo));
              });

  /// Fired when the highlighted or selected tabs in a window changes.
  EventStream<OnHighlightChangedSelectInfo> get onHighlightChanged =>
      $js.chrome.tabs.onHighlightChanged
          .asStream(($c) => ($js.OnHighlightChangedSelectInfo selectInfo) {
                return $c(OnHighlightChangedSelectInfo.fromJS(selectInfo));
              });

  /// Fired when the highlighted or selected tabs in a window changes.
  EventStream<OnHighlightedHighlightInfo> get onHighlighted =>
      $js.chrome.tabs.onHighlighted
          .asStream(($c) => ($js.OnHighlightedHighlightInfo highlightInfo) {
                return $c(OnHighlightedHighlightInfo.fromJS(highlightInfo));
              });

  /// Fired when a tab is detached from a window; for example, because it was
  /// moved between windows.
  EventStream<OnDetachedEvent> get onDetached =>
      $js.chrome.tabs.onDetached.asStream(($c) => (
            int tabId,
            $js.OnDetachedDetachInfo detachInfo,
          ) {
            return $c(OnDetachedEvent(
              tabId: tabId,
              detachInfo: OnDetachedDetachInfo.fromJS(detachInfo),
            ));
          });

  /// Fired when a tab is attached to a window; for example, because it was
  /// moved between windows.
  EventStream<OnAttachedEvent> get onAttached =>
      $js.chrome.tabs.onAttached.asStream(($c) => (
            int tabId,
            $js.OnAttachedAttachInfo attachInfo,
          ) {
            return $c(OnAttachedEvent(
              tabId: tabId,
              attachInfo: OnAttachedAttachInfo.fromJS(attachInfo),
            ));
          });

  /// Fired when a tab is closed.
  EventStream<OnRemovedEvent> get onRemoved =>
      $js.chrome.tabs.onRemoved.asStream(($c) => (
            int tabId,
            $js.OnRemovedRemoveInfo removeInfo,
          ) {
            return $c(OnRemovedEvent(
              tabId: tabId,
              removeInfo: OnRemovedRemoveInfo.fromJS(removeInfo),
            ));
          });

  /// Fired when a tab is replaced with another tab due to prerendering or
  /// instant.
  EventStream<OnReplacedEvent> get onReplaced =>
      $js.chrome.tabs.onReplaced.asStream(($c) => (
            int addedTabId,
            int removedTabId,
          ) {
            return $c(OnReplacedEvent(
              addedTabId: addedTabId,
              removedTabId: removedTabId,
            ));
          });

  /// Fired when a tab is zoomed.
  EventStream<OnZoomChangeZoomChangeInfo> get onZoomChange =>
      $js.chrome.tabs.onZoomChange
          .asStream(($c) => ($js.OnZoomChangeZoomChangeInfo zoomChangeInfo) {
                return $c(OnZoomChangeZoomChangeInfo.fromJS(zoomChangeInfo));
              });
}

/// The tab's loading status.
enum TabStatus {
  unloaded('unloaded'),
  loading('loading'),
  complete('complete');

  const TabStatus(this.value);

  final String value;

  String get toJS => value;
  static TabStatus fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// An event that caused a muted state change.
enum MutedInfoReason {
  /// A user input action set the muted state.
  user('user'),

  /// Tab capture was started, forcing a muted state change.
  capture('capture'),

  /// An extension, identified by the extensionId field, set the muted state.
  extension('extension');

  const MutedInfoReason(this.value);

  final String value;

  String get toJS => value;
  static MutedInfoReason fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Defines how zoom changes are handled, i.e., which entity is responsible for
/// the actual scaling of the page; defaults to `automatic`.
enum ZoomSettingsMode {
  /// Zoom changes are handled automatically by the browser.
  automatic('automatic'),

  /// Overrides the automatic handling of zoom changes. The `onZoomChange` event
  /// will still be dispatched, and it is the extension's responsibility to
  /// listen for this event and manually scale the page. This mode does not
  /// support `per-origin` zooming, and thus ignores the `scope` zoom setting
  /// and assumes `per-tab`.
  manual('manual'),

  /// Disables all zooming in the tab. The tab reverts to the default zoom
  /// level, and all attempted zoom changes are ignored.
  disabled('disabled');

  const ZoomSettingsMode(this.value);

  final String value;

  String get toJS => value;
  static ZoomSettingsMode fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Defines whether zoom changes persist for the page's origin, or only take
/// effect in this tab; defaults to `per-origin` when in `automatic` mode, and
/// `per-tab` otherwise.
enum ZoomSettingsScope {
  /// Zoom changes persist in the zoomed page's origin, i.e., all other tabs
  /// navigated to that same origin are zoomed as well. Moreover, `per-origin`
  /// zoom changes are saved with the origin, meaning that when navigating to
  /// other pages in the same origin, they are all zoomed to the same zoom
  /// factor. The `per-origin` scope is only available in the `automatic` mode.
  perOrigin('per-origin'),

  /// Zoom changes only take effect in this tab, and zoom changes in other tabs
  /// do not affect the zooming of this tab. Also, `per-tab` zoom changes are
  /// reset on navigation; navigating a tab always loads pages with their
  /// `per-origin` zoom factors.
  perTab('per-tab');

  const ZoomSettingsScope(this.value);

  final String value;

  String get toJS => value;
  static ZoomSettingsScope fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The type of window.
enum WindowType {
  normal('normal'),
  popup('popup'),
  panel('panel'),
  app('app'),
  devtools('devtools');

  const WindowType(this.value);

  final String value;

  String get toJS => value;
  static WindowType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class MutedInfo {
  MutedInfo.fromJS(this._wrapped);

  MutedInfo({
    /// Whether the tab is muted (prevented from playing sound). The tab may be
    /// muted even if it has not played or is not currently playing sound.
    /// Equivalent to whether the 'muted' audio indicator is showing.
    required bool muted,

    /// The reason the tab was muted or unmuted. Not set if the tab's mute state
    /// has never been changed.
    MutedInfoReason? reason,

    /// The ID of the extension that changed the muted state. Not set if an
    /// extension was not the reason the muted state last changed.
    String? extensionId,
  }) : _wrapped = $js.MutedInfo(
          muted: muted,
          reason: reason?.toJS,
          extensionId: extensionId,
        );

  final $js.MutedInfo _wrapped;

  $js.MutedInfo get toJS => _wrapped;

  /// Whether the tab is muted (prevented from playing sound). The tab may be
  /// muted even if it has not played or is not currently playing sound.
  /// Equivalent to whether the 'muted' audio indicator is showing.
  bool get muted => _wrapped.muted;
  set muted(bool v) {
    _wrapped.muted = v;
  }

  /// The reason the tab was muted or unmuted. Not set if the tab's mute state
  /// has never been changed.
  MutedInfoReason? get reason => _wrapped.reason?.let(MutedInfoReason.fromJS);
  set reason(MutedInfoReason? v) {
    _wrapped.reason = v?.toJS;
  }

  /// The ID of the extension that changed the muted state. Not set if an
  /// extension was not the reason the muted state last changed.
  String? get extensionId => _wrapped.extensionId;
  set extensionId(String? v) {
    _wrapped.extensionId = v;
  }
}

class Tab {
  Tab.fromJS(this._wrapped);

  Tab({
    /// The ID of the tab. Tab IDs are unique within a browser session. Under
    /// some circumstances a tab may not be assigned an ID; for example, when
    /// querying foreign tabs using the [sessions] API, in which case a session
    /// ID may be present. Tab ID can also be set to `chrome.tabs.TAB_ID_NONE`
    /// for apps and devtools windows.
    int? id,

    /// The zero-based index of the tab within its window.
    required int index,

    /// The ID of the group that the tab belongs to.
    required int groupId,

    /// The ID of the window that contains the tab.
    required int windowId,

    /// The ID of the tab that opened this tab, if any. This property is only
    /// present if the opener tab still exists.
    int? openerTabId,

    /// Whether the tab is selected.
    required bool selected,

    /// Whether the tab is highlighted.
    required bool highlighted,

    /// Whether the tab is active in its window. Does not necessarily mean the
    /// window is focused.
    required bool active,

    /// Whether the tab is pinned.
    required bool pinned,

    /// Whether the tab has produced sound over the past couple of seconds (but
    /// it might not be heard if also muted). Equivalent to whether the 'speaker
    /// audio' indicator is showing.
    bool? audible,

    /// Whether the tab is discarded. A discarded tab is one whose content has
    /// been unloaded from memory, but is still visible in the tab strip. Its
    /// content is reloaded the next time it is activated.
    required bool discarded,

    /// Whether the tab can be discarded automatically by the browser when
    /// resources are low.
    required bool autoDiscardable,

    /// The tab's muted state and the reason for the last state change.
    MutedInfo? mutedInfo,

    /// The last committed URL of the main frame of the tab. This property is
    /// only present if the extension's manifest includes the `"tabs"`
    /// permission and may be an empty string if the tab has not yet committed.
    /// See also [Tab.pendingUrl].
    String? url,

    /// The URL the tab is navigating to, before it has committed. This property
    /// is only present if the extension's manifest includes the `"tabs"`
    /// permission and there is a pending navigation.
    String? pendingUrl,

    /// The title of the tab. This property is only present if the extension's
    /// manifest includes the `"tabs"` permission.
    String? title,

    /// The URL of the tab's favicon. This property is only present if the
    /// extension's manifest includes the `"tabs"` permission. It may also be an
    /// empty string if the tab is loading.
    String? favIconUrl,

    /// The tab's loading status.
    TabStatus? status,

    /// Whether the tab is in an incognito window.
    required bool incognito,

    /// The width of the tab in pixels.
    int? width,

    /// The height of the tab in pixels.
    int? height,

    /// The session ID used to uniquely identify a tab obtained from the
    /// [sessions] API.
    String? sessionId,
  }) : _wrapped = $js.Tab(
          id: id,
          index: index,
          groupId: groupId,
          windowId: windowId,
          openerTabId: openerTabId,
          selected: selected,
          highlighted: highlighted,
          active: active,
          pinned: pinned,
          audible: audible,
          discarded: discarded,
          autoDiscardable: autoDiscardable,
          mutedInfo: mutedInfo?.toJS,
          url: url,
          pendingUrl: pendingUrl,
          title: title,
          favIconUrl: favIconUrl,
          status: status?.toJS,
          incognito: incognito,
          width: width,
          height: height,
          sessionId: sessionId,
        );

  final $js.Tab _wrapped;

  $js.Tab get toJS => _wrapped;

  /// The ID of the tab. Tab IDs are unique within a browser session. Under some
  /// circumstances a tab may not be assigned an ID; for example, when querying
  /// foreign tabs using the [sessions] API, in which case a session ID may be
  /// present. Tab ID can also be set to `chrome.tabs.TAB_ID_NONE` for apps and
  /// devtools windows.
  int? get id => _wrapped.id;
  set id(int? v) {
    _wrapped.id = v;
  }

  /// The zero-based index of the tab within its window.
  int get index => _wrapped.index;
  set index(int v) {
    _wrapped.index = v;
  }

  /// The ID of the group that the tab belongs to.
  int get groupId => _wrapped.groupId;
  set groupId(int v) {
    _wrapped.groupId = v;
  }

  /// The ID of the window that contains the tab.
  int get windowId => _wrapped.windowId;
  set windowId(int v) {
    _wrapped.windowId = v;
  }

  /// The ID of the tab that opened this tab, if any. This property is only
  /// present if the opener tab still exists.
  int? get openerTabId => _wrapped.openerTabId;
  set openerTabId(int? v) {
    _wrapped.openerTabId = v;
  }

  /// Whether the tab is selected.
  bool get selected => _wrapped.selected;
  set selected(bool v) {
    _wrapped.selected = v;
  }

  /// Whether the tab is highlighted.
  bool get highlighted => _wrapped.highlighted;
  set highlighted(bool v) {
    _wrapped.highlighted = v;
  }

  /// Whether the tab is active in its window. Does not necessarily mean the
  /// window is focused.
  bool get active => _wrapped.active;
  set active(bool v) {
    _wrapped.active = v;
  }

  /// Whether the tab is pinned.
  bool get pinned => _wrapped.pinned;
  set pinned(bool v) {
    _wrapped.pinned = v;
  }

  /// Whether the tab has produced sound over the past couple of seconds (but it
  /// might not be heard if also muted). Equivalent to whether the 'speaker
  /// audio' indicator is showing.
  bool? get audible => _wrapped.audible;
  set audible(bool? v) {
    _wrapped.audible = v;
  }

  /// Whether the tab is discarded. A discarded tab is one whose content has
  /// been unloaded from memory, but is still visible in the tab strip. Its
  /// content is reloaded the next time it is activated.
  bool get discarded => _wrapped.discarded;
  set discarded(bool v) {
    _wrapped.discarded = v;
  }

  /// Whether the tab can be discarded automatically by the browser when
  /// resources are low.
  bool get autoDiscardable => _wrapped.autoDiscardable;
  set autoDiscardable(bool v) {
    _wrapped.autoDiscardable = v;
  }

  /// The tab's muted state and the reason for the last state change.
  MutedInfo? get mutedInfo => _wrapped.mutedInfo?.let(MutedInfo.fromJS);
  set mutedInfo(MutedInfo? v) {
    _wrapped.mutedInfo = v?.toJS;
  }

  /// The last committed URL of the main frame of the tab. This property is only
  /// present if the extension's manifest includes the `"tabs"` permission and
  /// may be an empty string if the tab has not yet committed. See also
  /// [Tab.pendingUrl].
  String? get url => _wrapped.url;
  set url(String? v) {
    _wrapped.url = v;
  }

  /// The URL the tab is navigating to, before it has committed. This property
  /// is only present if the extension's manifest includes the `"tabs"`
  /// permission and there is a pending navigation.
  String? get pendingUrl => _wrapped.pendingUrl;
  set pendingUrl(String? v) {
    _wrapped.pendingUrl = v;
  }

  /// The title of the tab. This property is only present if the extension's
  /// manifest includes the `"tabs"` permission.
  String? get title => _wrapped.title;
  set title(String? v) {
    _wrapped.title = v;
  }

  /// The URL of the tab's favicon. This property is only present if the
  /// extension's manifest includes the `"tabs"` permission. It may also be an
  /// empty string if the tab is loading.
  String? get favIconUrl => _wrapped.favIconUrl;
  set favIconUrl(String? v) {
    _wrapped.favIconUrl = v;
  }

  /// The tab's loading status.
  TabStatus? get status => _wrapped.status?.let(TabStatus.fromJS);
  set status(TabStatus? v) {
    _wrapped.status = v?.toJS;
  }

  /// Whether the tab is in an incognito window.
  bool get incognito => _wrapped.incognito;
  set incognito(bool v) {
    _wrapped.incognito = v;
  }

  /// The width of the tab in pixels.
  int? get width => _wrapped.width;
  set width(int? v) {
    _wrapped.width = v;
  }

  /// The height of the tab in pixels.
  int? get height => _wrapped.height;
  set height(int? v) {
    _wrapped.height = v;
  }

  /// The session ID used to uniquely identify a tab obtained from the
  /// [sessions] API.
  String? get sessionId => _wrapped.sessionId;
  set sessionId(String? v) {
    _wrapped.sessionId = v;
  }
}

class ZoomSettings {
  ZoomSettings.fromJS(this._wrapped);

  ZoomSettings({
    /// Defines how zoom changes are handled, i.e., which entity is responsible
    /// for the actual scaling of the page; defaults to `automatic`.
    ZoomSettingsMode? mode,

    /// Defines whether zoom changes persist for the page's origin, or only take
    /// effect in this tab; defaults to `per-origin` when in `automatic` mode,
    /// and `per-tab` otherwise.
    ZoomSettingsScope? scope,

    /// Used to return the default zoom level for the current tab in calls to
    /// tabs.getZoomSettings.
    double? defaultZoomFactor,
  }) : _wrapped = $js.ZoomSettings(
          mode: mode?.toJS,
          scope: scope?.toJS,
          defaultZoomFactor: defaultZoomFactor,
        );

  final $js.ZoomSettings _wrapped;

  $js.ZoomSettings get toJS => _wrapped;

  /// Defines how zoom changes are handled, i.e., which entity is responsible
  /// for the actual scaling of the page; defaults to `automatic`.
  ZoomSettingsMode? get mode => _wrapped.mode?.let(ZoomSettingsMode.fromJS);
  set mode(ZoomSettingsMode? v) {
    _wrapped.mode = v?.toJS;
  }

  /// Defines whether zoom changes persist for the page's origin, or only take
  /// effect in this tab; defaults to `per-origin` when in `automatic` mode, and
  /// `per-tab` otherwise.
  ZoomSettingsScope? get scope => _wrapped.scope?.let(ZoomSettingsScope.fromJS);
  set scope(ZoomSettingsScope? v) {
    _wrapped.scope = v?.toJS;
  }

  /// Used to return the default zoom level for the current tab in calls to
  /// tabs.getZoomSettings.
  double? get defaultZoomFactor => _wrapped.defaultZoomFactor;
  set defaultZoomFactor(double? v) {
    _wrapped.defaultZoomFactor = v;
  }
}

class OnUpdatedChangeInfo {
  OnUpdatedChangeInfo.fromJS(this._wrapped);

  OnUpdatedChangeInfo({
    /// The tab's loading status.
    TabStatus? status,

    /// The tab's URL if it has changed.
    String? url,

    /// The tab's new group.
    int? groupId,

    /// The tab's new pinned state.
    bool? pinned,

    /// The tab's new audible state.
    bool? audible,

    /// The tab's new discarded state.
    bool? discarded,

    /// The tab's new auto-discardable state.
    bool? autoDiscardable,

    /// The tab's new muted state and the reason for the change.
    MutedInfo? mutedInfo,

    /// The tab's new favicon URL.
    String? favIconUrl,

    /// The tab's new title.
    String? title,
  }) : _wrapped = $js.OnUpdatedChangeInfo(
          status: status?.toJS,
          url: url,
          groupId: groupId,
          pinned: pinned,
          audible: audible,
          discarded: discarded,
          autoDiscardable: autoDiscardable,
          mutedInfo: mutedInfo?.toJS,
          favIconUrl: favIconUrl,
          title: title,
        );

  final $js.OnUpdatedChangeInfo _wrapped;

  $js.OnUpdatedChangeInfo get toJS => _wrapped;

  /// The tab's loading status.
  TabStatus? get status => _wrapped.status?.let(TabStatus.fromJS);
  set status(TabStatus? v) {
    _wrapped.status = v?.toJS;
  }

  /// The tab's URL if it has changed.
  String? get url => _wrapped.url;
  set url(String? v) {
    _wrapped.url = v;
  }

  /// The tab's new group.
  int? get groupId => _wrapped.groupId;
  set groupId(int? v) {
    _wrapped.groupId = v;
  }

  /// The tab's new pinned state.
  bool? get pinned => _wrapped.pinned;
  set pinned(bool? v) {
    _wrapped.pinned = v;
  }

  /// The tab's new audible state.
  bool? get audible => _wrapped.audible;
  set audible(bool? v) {
    _wrapped.audible = v;
  }

  /// The tab's new discarded state.
  bool? get discarded => _wrapped.discarded;
  set discarded(bool? v) {
    _wrapped.discarded = v;
  }

  /// The tab's new auto-discardable state.
  bool? get autoDiscardable => _wrapped.autoDiscardable;
  set autoDiscardable(bool? v) {
    _wrapped.autoDiscardable = v;
  }

  /// The tab's new muted state and the reason for the change.
  MutedInfo? get mutedInfo => _wrapped.mutedInfo?.let(MutedInfo.fromJS);
  set mutedInfo(MutedInfo? v) {
    _wrapped.mutedInfo = v?.toJS;
  }

  /// The tab's new favicon URL.
  String? get favIconUrl => _wrapped.favIconUrl;
  set favIconUrl(String? v) {
    _wrapped.favIconUrl = v;
  }

  /// The tab's new title.
  String? get title => _wrapped.title;
  set title(String? v) {
    _wrapped.title = v;
  }
}

class OnMovedMoveInfo {
  OnMovedMoveInfo.fromJS(this._wrapped);

  OnMovedMoveInfo({
    required int windowId,
    required int fromIndex,
    required int toIndex,
  }) : _wrapped = $js.OnMovedMoveInfo(
          windowId: windowId,
          fromIndex: fromIndex,
          toIndex: toIndex,
        );

  final $js.OnMovedMoveInfo _wrapped;

  $js.OnMovedMoveInfo get toJS => _wrapped;

  int get windowId => _wrapped.windowId;
  set windowId(int v) {
    _wrapped.windowId = v;
  }

  int get fromIndex => _wrapped.fromIndex;
  set fromIndex(int v) {
    _wrapped.fromIndex = v;
  }

  int get toIndex => _wrapped.toIndex;
  set toIndex(int v) {
    _wrapped.toIndex = v;
  }
}

class OnSelectionChangedSelectInfo {
  OnSelectionChangedSelectInfo.fromJS(this._wrapped);

  OnSelectionChangedSelectInfo(
      {
      /// The ID of the window the selected tab changed inside of.
      required int windowId})
      : _wrapped = $js.OnSelectionChangedSelectInfo(windowId: windowId);

  final $js.OnSelectionChangedSelectInfo _wrapped;

  $js.OnSelectionChangedSelectInfo get toJS => _wrapped;

  /// The ID of the window the selected tab changed inside of.
  int get windowId => _wrapped.windowId;
  set windowId(int v) {
    _wrapped.windowId = v;
  }
}

class OnActiveChangedSelectInfo {
  OnActiveChangedSelectInfo.fromJS(this._wrapped);

  OnActiveChangedSelectInfo(
      {
      /// The ID of the window the selected tab changed inside of.
      required int windowId})
      : _wrapped = $js.OnActiveChangedSelectInfo(windowId: windowId);

  final $js.OnActiveChangedSelectInfo _wrapped;

  $js.OnActiveChangedSelectInfo get toJS => _wrapped;

  /// The ID of the window the selected tab changed inside of.
  int get windowId => _wrapped.windowId;
  set windowId(int v) {
    _wrapped.windowId = v;
  }
}

class OnActivatedActiveInfo {
  OnActivatedActiveInfo.fromJS(this._wrapped);

  OnActivatedActiveInfo({
    /// The ID of the tab that has become active.
    required int tabId,

    /// The ID of the window the active tab changed inside of.
    required int windowId,
  }) : _wrapped = $js.OnActivatedActiveInfo(
          tabId: tabId,
          windowId: windowId,
        );

  final $js.OnActivatedActiveInfo _wrapped;

  $js.OnActivatedActiveInfo get toJS => _wrapped;

  /// The ID of the tab that has become active.
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }

  /// The ID of the window the active tab changed inside of.
  int get windowId => _wrapped.windowId;
  set windowId(int v) {
    _wrapped.windowId = v;
  }
}

class OnHighlightChangedSelectInfo {
  OnHighlightChangedSelectInfo.fromJS(this._wrapped);

  OnHighlightChangedSelectInfo({
    /// The window whose tabs changed.
    required int windowId,

    /// All highlighted tabs in the window.
    required List<int> tabIds,
  }) : _wrapped = $js.OnHighlightChangedSelectInfo(
          windowId: windowId,
          tabIds: tabIds.toJSArray((e) => e),
        );

  final $js.OnHighlightChangedSelectInfo _wrapped;

  $js.OnHighlightChangedSelectInfo get toJS => _wrapped;

  /// The window whose tabs changed.
  int get windowId => _wrapped.windowId;
  set windowId(int v) {
    _wrapped.windowId = v;
  }

  /// All highlighted tabs in the window.
  List<int> get tabIds =>
      _wrapped.tabIds.toDart.cast<int>().map((e) => e).toList();
  set tabIds(List<int> v) {
    _wrapped.tabIds = v.toJSArray((e) => e);
  }
}

class OnHighlightedHighlightInfo {
  OnHighlightedHighlightInfo.fromJS(this._wrapped);

  OnHighlightedHighlightInfo({
    /// The window whose tabs changed.
    required int windowId,

    /// All highlighted tabs in the window.
    required List<int> tabIds,
  }) : _wrapped = $js.OnHighlightedHighlightInfo(
          windowId: windowId,
          tabIds: tabIds.toJSArray((e) => e),
        );

  final $js.OnHighlightedHighlightInfo _wrapped;

  $js.OnHighlightedHighlightInfo get toJS => _wrapped;

  /// The window whose tabs changed.
  int get windowId => _wrapped.windowId;
  set windowId(int v) {
    _wrapped.windowId = v;
  }

  /// All highlighted tabs in the window.
  List<int> get tabIds =>
      _wrapped.tabIds.toDart.cast<int>().map((e) => e).toList();
  set tabIds(List<int> v) {
    _wrapped.tabIds = v.toJSArray((e) => e);
  }
}

class OnDetachedDetachInfo {
  OnDetachedDetachInfo.fromJS(this._wrapped);

  OnDetachedDetachInfo({
    required int oldWindowId,
    required int oldPosition,
  }) : _wrapped = $js.OnDetachedDetachInfo(
          oldWindowId: oldWindowId,
          oldPosition: oldPosition,
        );

  final $js.OnDetachedDetachInfo _wrapped;

  $js.OnDetachedDetachInfo get toJS => _wrapped;

  int get oldWindowId => _wrapped.oldWindowId;
  set oldWindowId(int v) {
    _wrapped.oldWindowId = v;
  }

  int get oldPosition => _wrapped.oldPosition;
  set oldPosition(int v) {
    _wrapped.oldPosition = v;
  }
}

class OnAttachedAttachInfo {
  OnAttachedAttachInfo.fromJS(this._wrapped);

  OnAttachedAttachInfo({
    required int newWindowId,
    required int newPosition,
  }) : _wrapped = $js.OnAttachedAttachInfo(
          newWindowId: newWindowId,
          newPosition: newPosition,
        );

  final $js.OnAttachedAttachInfo _wrapped;

  $js.OnAttachedAttachInfo get toJS => _wrapped;

  int get newWindowId => _wrapped.newWindowId;
  set newWindowId(int v) {
    _wrapped.newWindowId = v;
  }

  int get newPosition => _wrapped.newPosition;
  set newPosition(int v) {
    _wrapped.newPosition = v;
  }
}

class OnRemovedRemoveInfo {
  OnRemovedRemoveInfo.fromJS(this._wrapped);

  OnRemovedRemoveInfo({
    /// The window whose tab is closed.
    required int windowId,

    /// True when the tab was closed because its parent window was closed.
    required bool isWindowClosing,
  }) : _wrapped = $js.OnRemovedRemoveInfo(
          windowId: windowId,
          isWindowClosing: isWindowClosing,
        );

  final $js.OnRemovedRemoveInfo _wrapped;

  $js.OnRemovedRemoveInfo get toJS => _wrapped;

  /// The window whose tab is closed.
  int get windowId => _wrapped.windowId;
  set windowId(int v) {
    _wrapped.windowId = v;
  }

  /// True when the tab was closed because its parent window was closed.
  bool get isWindowClosing => _wrapped.isWindowClosing;
  set isWindowClosing(bool v) {
    _wrapped.isWindowClosing = v;
  }
}

class OnZoomChangeZoomChangeInfo {
  OnZoomChangeZoomChangeInfo.fromJS(this._wrapped);

  OnZoomChangeZoomChangeInfo({
    required int tabId,
    required double oldZoomFactor,
    required double newZoomFactor,
    required ZoomSettings zoomSettings,
  }) : _wrapped = $js.OnZoomChangeZoomChangeInfo(
          tabId: tabId,
          oldZoomFactor: oldZoomFactor,
          newZoomFactor: newZoomFactor,
          zoomSettings: zoomSettings.toJS,
        );

  final $js.OnZoomChangeZoomChangeInfo _wrapped;

  $js.OnZoomChangeZoomChangeInfo get toJS => _wrapped;

  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }

  double get oldZoomFactor => _wrapped.oldZoomFactor;
  set oldZoomFactor(double v) {
    _wrapped.oldZoomFactor = v;
  }

  double get newZoomFactor => _wrapped.newZoomFactor;
  set newZoomFactor(double v) {
    _wrapped.newZoomFactor = v;
  }

  ZoomSettings get zoomSettings => ZoomSettings.fromJS(_wrapped.zoomSettings);
  set zoomSettings(ZoomSettings v) {
    _wrapped.zoomSettings = v.toJS;
  }
}

class ConnectInfo {
  ConnectInfo.fromJS(this._wrapped);

  ConnectInfo({
    /// Is passed into onConnect for content scripts that are listening for the
    /// connection event.
    String? name,

    /// Open a port to a specific [frame](webNavigation#frame_ids) identified by
    /// `frameId` instead of all frames in the tab.
    int? frameId,

    /// Open a port to a specific [document](webNavigation#document_ids)
    /// identified by `documentId` instead of all frames in the tab.
    String? documentId,
  }) : _wrapped = $js.ConnectInfo(
          name: name,
          frameId: frameId,
          documentId: documentId,
        );

  final $js.ConnectInfo _wrapped;

  $js.ConnectInfo get toJS => _wrapped;

  /// Is passed into onConnect for content scripts that are listening for the
  /// connection event.
  String? get name => _wrapped.name;
  set name(String? v) {
    _wrapped.name = v;
  }

  /// Open a port to a specific [frame](webNavigation#frame_ids) identified by
  /// `frameId` instead of all frames in the tab.
  int? get frameId => _wrapped.frameId;
  set frameId(int? v) {
    _wrapped.frameId = v;
  }

  /// Open a port to a specific [document](webNavigation#document_ids)
  /// identified by `documentId` instead of all frames in the tab.
  String? get documentId => _wrapped.documentId;
  set documentId(String? v) {
    _wrapped.documentId = v;
  }
}

class SendMessageOptions {
  SendMessageOptions.fromJS(this._wrapped);

  SendMessageOptions({
    /// Send a message to a specific [frame](webNavigation#frame_ids) identified
    /// by `frameId` instead of all frames in the tab.
    int? frameId,

    /// Send a message to a specific [document](webNavigation#document_ids)
    /// identified by `documentId` instead of all frames in the tab.
    String? documentId,
  }) : _wrapped = $js.SendMessageOptions(
          frameId: frameId,
          documentId: documentId,
        );

  final $js.SendMessageOptions _wrapped;

  $js.SendMessageOptions get toJS => _wrapped;

  /// Send a message to a specific [frame](webNavigation#frame_ids) identified
  /// by `frameId` instead of all frames in the tab.
  int? get frameId => _wrapped.frameId;
  set frameId(int? v) {
    _wrapped.frameId = v;
  }

  /// Send a message to a specific [document](webNavigation#document_ids)
  /// identified by `documentId` instead of all frames in the tab.
  String? get documentId => _wrapped.documentId;
  set documentId(String? v) {
    _wrapped.documentId = v;
  }
}

class CreateProperties {
  CreateProperties.fromJS(this._wrapped);

  CreateProperties({
    /// The window in which to create the new tab. Defaults to the [current
    /// window](windows#current-window).
    int? windowId,

    /// The position the tab should take in the window. The provided value is
    /// clamped to between zero and the number of tabs in the window.
    int? index,

    /// The URL to initially navigate the tab to. Fully-qualified URLs must
    /// include a scheme (i.e., 'http://www.google.com', not 'www.google.com').
    /// Relative URLs are relative to the current page within the extension.
    /// Defaults to the New Tab Page.
    String? url,

    /// Whether the tab should become the active tab in the window. Does not
    /// affect whether the window is focused (see [windows.update]). Defaults to
    /// [true].
    bool? active,

    /// Whether the tab should become the selected tab in the window. Defaults
    /// to [true]
    bool? selected,

    /// Whether the tab should be pinned. Defaults to [false]
    bool? pinned,

    /// The ID of the tab that opened this tab. If specified, the opener tab
    /// must be in the same window as the newly created tab.
    int? openerTabId,
  }) : _wrapped = $js.CreateProperties(
          windowId: windowId,
          index: index,
          url: url,
          active: active,
          selected: selected,
          pinned: pinned,
          openerTabId: openerTabId,
        );

  final $js.CreateProperties _wrapped;

  $js.CreateProperties get toJS => _wrapped;

  /// The window in which to create the new tab. Defaults to the [current
  /// window](windows#current-window).
  int? get windowId => _wrapped.windowId;
  set windowId(int? v) {
    _wrapped.windowId = v;
  }

  /// The position the tab should take in the window. The provided value is
  /// clamped to between zero and the number of tabs in the window.
  int? get index => _wrapped.index;
  set index(int? v) {
    _wrapped.index = v;
  }

  /// The URL to initially navigate the tab to. Fully-qualified URLs must
  /// include a scheme (i.e., 'http://www.google.com', not 'www.google.com').
  /// Relative URLs are relative to the current page within the extension.
  /// Defaults to the New Tab Page.
  String? get url => _wrapped.url;
  set url(String? v) {
    _wrapped.url = v;
  }

  /// Whether the tab should become the active tab in the window. Does not
  /// affect whether the window is focused (see [windows.update]). Defaults to
  /// [true].
  bool? get active => _wrapped.active;
  set active(bool? v) {
    _wrapped.active = v;
  }

  /// Whether the tab should become the selected tab in the window. Defaults to
  /// [true]
  bool? get selected => _wrapped.selected;
  set selected(bool? v) {
    _wrapped.selected = v;
  }

  /// Whether the tab should be pinned. Defaults to [false]
  bool? get pinned => _wrapped.pinned;
  set pinned(bool? v) {
    _wrapped.pinned = v;
  }

  /// The ID of the tab that opened this tab. If specified, the opener tab must
  /// be in the same window as the newly created tab.
  int? get openerTabId => _wrapped.openerTabId;
  set openerTabId(int? v) {
    _wrapped.openerTabId = v;
  }
}

class QueryInfo {
  QueryInfo.fromJS(this._wrapped);

  QueryInfo({
    /// Whether the tabs are active in their windows.
    bool? active,

    /// Whether the tabs are pinned.
    bool? pinned,

    /// Whether the tabs are audible.
    bool? audible,

    /// Whether the tabs are muted.
    bool? muted,

    /// Whether the tabs are highlighted.
    bool? highlighted,

    /// Whether the tabs are discarded. A discarded tab is one whose content has
    /// been unloaded from memory, but is still visible in the tab strip. Its
    /// content is reloaded the next time it is activated.
    bool? discarded,

    /// Whether the tabs can be discarded automatically by the browser when
    /// resources are low.
    bool? autoDiscardable,

    /// Whether the tabs are in the [current window](windows#current-window).
    bool? currentWindow,

    /// Whether the tabs are in the last focused window.
    bool? lastFocusedWindow,

    /// The tab loading status.
    TabStatus? status,

    /// Match page titles against a pattern. This property is ignored if the
    /// extension does not have the `"tabs"` permission.
    String? title,

    /// Match tabs against one or more [URL patterns](match_patterns). Fragment
    /// identifiers are not matched. This property is ignored if the extension
    /// does not have the `"tabs"` permission.
    Object? url,

    /// The ID of the group that the tabs are in, or
    /// [tabGroups.TAB_GROUP_ID_NONE] for ungrouped tabs.
    int? groupId,

    /// The ID of the parent window, or [windows.WINDOW_ID_CURRENT] for the
    /// [current window](windows#current-window).
    int? windowId,

    /// The type of window the tabs are in.
    WindowType? windowType,

    /// The position of the tabs within their windows.
    int? index,
  }) : _wrapped = $js.QueryInfo(
          active: active,
          pinned: pinned,
          audible: audible,
          muted: muted,
          highlighted: highlighted,
          discarded: discarded,
          autoDiscardable: autoDiscardable,
          currentWindow: currentWindow,
          lastFocusedWindow: lastFocusedWindow,
          status: status?.toJS,
          title: title,
          url: switch (url) {
            String() => url,
            List() => url.toJSArrayString(),
            null => null,
            _ => throw UnsupportedError(
                'Received type: ${url.runtimeType}. Supported types are: String, List<String>')
          },
          groupId: groupId,
          windowId: windowId,
          windowType: windowType?.toJS,
          index: index,
        );

  final $js.QueryInfo _wrapped;

  $js.QueryInfo get toJS => _wrapped;

  /// Whether the tabs are active in their windows.
  bool? get active => _wrapped.active;
  set active(bool? v) {
    _wrapped.active = v;
  }

  /// Whether the tabs are pinned.
  bool? get pinned => _wrapped.pinned;
  set pinned(bool? v) {
    _wrapped.pinned = v;
  }

  /// Whether the tabs are audible.
  bool? get audible => _wrapped.audible;
  set audible(bool? v) {
    _wrapped.audible = v;
  }

  /// Whether the tabs are muted.
  bool? get muted => _wrapped.muted;
  set muted(bool? v) {
    _wrapped.muted = v;
  }

  /// Whether the tabs are highlighted.
  bool? get highlighted => _wrapped.highlighted;
  set highlighted(bool? v) {
    _wrapped.highlighted = v;
  }

  /// Whether the tabs are discarded. A discarded tab is one whose content has
  /// been unloaded from memory, but is still visible in the tab strip. Its
  /// content is reloaded the next time it is activated.
  bool? get discarded => _wrapped.discarded;
  set discarded(bool? v) {
    _wrapped.discarded = v;
  }

  /// Whether the tabs can be discarded automatically by the browser when
  /// resources are low.
  bool? get autoDiscardable => _wrapped.autoDiscardable;
  set autoDiscardable(bool? v) {
    _wrapped.autoDiscardable = v;
  }

  /// Whether the tabs are in the [current window](windows#current-window).
  bool? get currentWindow => _wrapped.currentWindow;
  set currentWindow(bool? v) {
    _wrapped.currentWindow = v;
  }

  /// Whether the tabs are in the last focused window.
  bool? get lastFocusedWindow => _wrapped.lastFocusedWindow;
  set lastFocusedWindow(bool? v) {
    _wrapped.lastFocusedWindow = v;
  }

  /// The tab loading status.
  TabStatus? get status => _wrapped.status?.let(TabStatus.fromJS);
  set status(TabStatus? v) {
    _wrapped.status = v?.toJS;
  }

  /// Match page titles against a pattern. This property is ignored if the
  /// extension does not have the `"tabs"` permission.
  String? get title => _wrapped.title;
  set title(String? v) {
    _wrapped.title = v;
  }

  /// Match tabs against one or more [URL patterns](match_patterns). Fragment
  /// identifiers are not matched. This property is ignored if the extension
  /// does not have the `"tabs"` permission.
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

  /// The ID of the group that the tabs are in, or [tabGroups.TAB_GROUP_ID_NONE]
  /// for ungrouped tabs.
  int? get groupId => _wrapped.groupId;
  set groupId(int? v) {
    _wrapped.groupId = v;
  }

  /// The ID of the parent window, or [windows.WINDOW_ID_CURRENT] for the
  /// [current window](windows#current-window).
  int? get windowId => _wrapped.windowId;
  set windowId(int? v) {
    _wrapped.windowId = v;
  }

  /// The type of window the tabs are in.
  WindowType? get windowType => _wrapped.windowType?.let(WindowType.fromJS);
  set windowType(WindowType? v) {
    _wrapped.windowType = v?.toJS;
  }

  /// The position of the tabs within their windows.
  int? get index => _wrapped.index;
  set index(int? v) {
    _wrapped.index = v;
  }
}

class HighlightInfo {
  HighlightInfo.fromJS(this._wrapped);

  HighlightInfo({
    /// The window that contains the tabs.
    int? windowId,

    /// One or more tab indices to highlight.
    required Object tabs,
  }) : _wrapped = $js.HighlightInfo(
          windowId: windowId,
          tabs: switch (tabs) {
            List<int>() => tabs.toJSArray((e) => e),
            int() => tabs,
            _ => throw UnsupportedError(
                'Received type: ${tabs.runtimeType}. Supported types are: List<int>, int')
          },
        );

  final $js.HighlightInfo _wrapped;

  $js.HighlightInfo get toJS => _wrapped;

  /// The window that contains the tabs.
  int? get windowId => _wrapped.windowId;
  set windowId(int? v) {
    _wrapped.windowId = v;
  }

  /// One or more tab indices to highlight.
  Object get tabs => _wrapped.tabs.when(
        isArray: (v) => v.toDart.cast<int>().map((e) => e).toList(),
        isInt: (v) => v,
      );
  set tabs(Object v) {
    _wrapped.tabs = switch (v) {
      List<int>() => v.toJSArray((e) => e),
      int() => v,
      _ => throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: List<int>, int')
    };
  }
}

class UpdateProperties {
  UpdateProperties.fromJS(this._wrapped);

  UpdateProperties({
    /// A URL to navigate the tab to. JavaScript URLs are not supported; use
    /// [scripting.executeScript] instead.
    String? url,

    /// Whether the tab should be active. Does not affect whether the window is
    /// focused (see [windows.update]).
    bool? active,

    /// Adds or removes the tab from the current selection.
    bool? highlighted,

    /// Whether the tab should be selected.
    bool? selected,

    /// Whether the tab should be pinned.
    bool? pinned,

    /// Whether the tab should be muted.
    bool? muted,

    /// The ID of the tab that opened this tab. If specified, the opener tab
    /// must be in the same window as this tab.
    int? openerTabId,

    /// Whether the tab should be discarded automatically by the browser when
    /// resources are low.
    bool? autoDiscardable,
  }) : _wrapped = $js.UpdateProperties(
          url: url,
          active: active,
          highlighted: highlighted,
          selected: selected,
          pinned: pinned,
          muted: muted,
          openerTabId: openerTabId,
          autoDiscardable: autoDiscardable,
        );

  final $js.UpdateProperties _wrapped;

  $js.UpdateProperties get toJS => _wrapped;

  /// A URL to navigate the tab to. JavaScript URLs are not supported; use
  /// [scripting.executeScript] instead.
  String? get url => _wrapped.url;
  set url(String? v) {
    _wrapped.url = v;
  }

  /// Whether the tab should be active. Does not affect whether the window is
  /// focused (see [windows.update]).
  bool? get active => _wrapped.active;
  set active(bool? v) {
    _wrapped.active = v;
  }

  /// Adds or removes the tab from the current selection.
  bool? get highlighted => _wrapped.highlighted;
  set highlighted(bool? v) {
    _wrapped.highlighted = v;
  }

  /// Whether the tab should be selected.
  bool? get selected => _wrapped.selected;
  set selected(bool? v) {
    _wrapped.selected = v;
  }

  /// Whether the tab should be pinned.
  bool? get pinned => _wrapped.pinned;
  set pinned(bool? v) {
    _wrapped.pinned = v;
  }

  /// Whether the tab should be muted.
  bool? get muted => _wrapped.muted;
  set muted(bool? v) {
    _wrapped.muted = v;
  }

  /// The ID of the tab that opened this tab. If specified, the opener tab must
  /// be in the same window as this tab.
  int? get openerTabId => _wrapped.openerTabId;
  set openerTabId(int? v) {
    _wrapped.openerTabId = v;
  }

  /// Whether the tab should be discarded automatically by the browser when
  /// resources are low.
  bool? get autoDiscardable => _wrapped.autoDiscardable;
  set autoDiscardable(bool? v) {
    _wrapped.autoDiscardable = v;
  }
}

class MoveProperties {
  MoveProperties.fromJS(this._wrapped);

  MoveProperties({
    /// Defaults to the window the tab is currently in.
    int? windowId,

    /// The position to move the window to. Use `-1` to place the tab at the end
    /// of the window.
    required int index,
  }) : _wrapped = $js.MoveProperties(
          windowId: windowId,
          index: index,
        );

  final $js.MoveProperties _wrapped;

  $js.MoveProperties get toJS => _wrapped;

  /// Defaults to the window the tab is currently in.
  int? get windowId => _wrapped.windowId;
  set windowId(int? v) {
    _wrapped.windowId = v;
  }

  /// The position to move the window to. Use `-1` to place the tab at the end
  /// of the window.
  int get index => _wrapped.index;
  set index(int v) {
    _wrapped.index = v;
  }
}

class ReloadProperties {
  ReloadProperties.fromJS(this._wrapped);

  ReloadProperties(
      {
      /// Whether to bypass local caching. Defaults to `false`.
      bool? bypassCache})
      : _wrapped = $js.ReloadProperties(bypassCache: bypassCache);

  final $js.ReloadProperties _wrapped;

  $js.ReloadProperties get toJS => _wrapped;

  /// Whether to bypass local caching. Defaults to `false`.
  bool? get bypassCache => _wrapped.bypassCache;
  set bypassCache(bool? v) {
    _wrapped.bypassCache = v;
  }
}

class GroupOptions {
  GroupOptions.fromJS(this._wrapped);

  GroupOptions({
    /// The tab ID or list of tab IDs to add to the specified group.
    required Object tabIds,

    /// The ID of the group to add the tabs to. If not specified, a new group
    /// will be created.
    int? groupId,

    /// Configurations for creating a group. Cannot be used if groupId is
    /// already specified.
    GroupOptionsCreateProperties? createProperties,
  }) : _wrapped = $js.GroupOptions(
          tabIds: switch (tabIds) {
            int() => tabIds,
            List<int>() => tabIds.toJSArray((e) => e),
            _ => throw UnsupportedError(
                'Received type: ${tabIds.runtimeType}. Supported types are: int, List<int>')
          },
          groupId: groupId,
          createProperties: createProperties?.toJS,
        );

  final $js.GroupOptions _wrapped;

  $js.GroupOptions get toJS => _wrapped;

  /// The tab ID or list of tab IDs to add to the specified group.
  Object get tabIds => _wrapped.tabIds.when(
        isInt: (v) => v,
        isArray: (v) => v.toDart.cast<int>().map((e) => e).toList(),
      );
  set tabIds(Object v) {
    _wrapped.tabIds = switch (v) {
      int() => v,
      List<int>() => v.toJSArray((e) => e),
      _ => throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: int, List<int>')
    };
  }

  /// The ID of the group to add the tabs to. If not specified, a new group will
  /// be created.
  int? get groupId => _wrapped.groupId;
  set groupId(int? v) {
    _wrapped.groupId = v;
  }

  /// Configurations for creating a group. Cannot be used if groupId is already
  /// specified.
  GroupOptionsCreateProperties? get createProperties =>
      _wrapped.createProperties?.let(GroupOptionsCreateProperties.fromJS);
  set createProperties(GroupOptionsCreateProperties? v) {
    _wrapped.createProperties = v?.toJS;
  }
}

class GroupOptionsCreateProperties {
  GroupOptionsCreateProperties.fromJS(this._wrapped);

  GroupOptionsCreateProperties(
      {
      /// The window of the new group. Defaults to the current window.
      int? windowId})
      : _wrapped = $js.GroupOptionsCreateProperties(windowId: windowId);

  final $js.GroupOptionsCreateProperties _wrapped;

  $js.GroupOptionsCreateProperties get toJS => _wrapped;

  /// The window of the new group. Defaults to the current window.
  int? get windowId => _wrapped.windowId;
  set windowId(int? v) {
    _wrapped.windowId = v;
  }
}

class OnUpdatedEvent {
  OnUpdatedEvent({
    required this.tabId,
    required this.changeInfo,
    required this.tab,
  });

  final int tabId;

  /// Lists the changes to the state of the tab that was updated.
  final OnUpdatedChangeInfo changeInfo;

  /// Gives the state of the tab that was updated.
  final Tab tab;
}

class OnMovedEvent {
  OnMovedEvent({
    required this.tabId,
    required this.moveInfo,
  });

  final int tabId;

  final OnMovedMoveInfo moveInfo;
}

class OnSelectionChangedEvent {
  OnSelectionChangedEvent({
    required this.tabId,
    required this.selectInfo,
  });

  /// The ID of the tab that has become active.
  final int tabId;

  final OnSelectionChangedSelectInfo selectInfo;
}

class OnActiveChangedEvent {
  OnActiveChangedEvent({
    required this.tabId,
    required this.selectInfo,
  });

  /// The ID of the tab that has become active.
  final int tabId;

  final OnActiveChangedSelectInfo selectInfo;
}

class OnDetachedEvent {
  OnDetachedEvent({
    required this.tabId,
    required this.detachInfo,
  });

  final int tabId;

  final OnDetachedDetachInfo detachInfo;
}

class OnAttachedEvent {
  OnAttachedEvent({
    required this.tabId,
    required this.attachInfo,
  });

  final int tabId;

  final OnAttachedAttachInfo attachInfo;
}

class OnRemovedEvent {
  OnRemovedEvent({
    required this.tabId,
    required this.removeInfo,
  });

  final int tabId;

  final OnRemovedRemoveInfo removeInfo;
}

class OnReplacedEvent {
  OnReplacedEvent({
    required this.addedTabId,
    required this.removedTabId,
  });

  final int addedTabId;

  final int removedTabId;
}
