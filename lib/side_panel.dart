// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'src/internal_helpers.dart';
import 'src/js/side_panel.dart' as $js;

export 'src/chrome.dart' show chrome, EventStream;

final _sidePanel = ChromeSidePanel._();

extension ChromeSidePanelExtension on Chrome {
  /// Use the `chrome.sidePanel` API to host content in the browser's side panel
  /// alongside the main content of a webpage.
  ChromeSidePanel get sidePanel => _sidePanel;
}

class ChromeSidePanel {
  ChromeSidePanel._();

  bool get isAvailable => $js.chrome.sidePanelNullable != null && alwaysTrue;

  /// Configures the side panel.
  /// |options|: The configuration options to apply to the panel.
  /// |callback|: Returns a Promise which resolves when the options have been
  /// set.
  Future<void> setOptions(PanelOptions options) async {
    await $js.chrome.sidePanel.setOptions(options.toJS).toDart;
  }

  /// Returns the active panel configuration.
  /// |options|: Specifies the context to return the configuration for.
  /// |callback|: Returns a Promise which resolves with the active panel
  /// configuration.
  Future<PanelOptions> getOptions(GetPanelOptions options) async {
    var $res = await $js.chrome.sidePanel.getOptions(options.toJS).toDart;
    return PanelOptions.fromJS($res);
  }

  /// Configures the extension's side panel behavior. This is an upsert
  /// operation.
  /// |behavior|: The new behavior to be set.
  /// |callback|: Returns a Promise which resolves when the new behavior has
  /// been set.
  Future<void> setPanelBehavior(PanelBehavior behavior) async {
    await $js.chrome.sidePanel.setPanelBehavior(behavior.toJS).toDart;
  }

  /// Returns the extension's current side panel behavior.
  /// |callback|: Returns a Promise which resolves with the extension's side
  /// panel behavior.
  Future<PanelBehavior> getPanelBehavior() async {
    var $res = await $js.chrome.sidePanel.getPanelBehavior().toDart;
    return PanelBehavior.fromJS($res);
  }

  /// Opens the side panel for the extension.
  /// This may only be called in response to a user action.
  /// |options|: Specifies the context in which to open the side panel.
  /// |callback|: Returns a Promise which resolves when the side panel has been
  /// opened.
  Future<void> open(OpenOptions options) async {
    await $js.chrome.sidePanel.open(options.toJS).toDart;
  }

  /// Returns the side panel's current layout.
  /// |callback|: Returns a Promise which resolves with a [PanelLayout].
  Future<PanelLayout> getLayout() async {
    var $res = await $js.chrome.sidePanel.getLayout().toDart;
    return PanelLayout.fromJS($res);
  }

  /// Closes the extension's side panel.
  /// This is a no-op if the panel is already closed.
  /// |options|: Specifies the context in which to close the side panel.
  /// |callback|: Returns a Promise which resolves when the side panel has been
  /// closed.
  Future<void> close(CloseOptions options) async {
    await $js.chrome.sidePanel.close(options.toJS).toDart;
  }

  /// Fired when the extension's side panel is opened.
  EventStream<PanelOpenedInfo> get onOpened => $js.chrome.sidePanel.onOpened
      .asStream(($c) => ($js.PanelOpenedInfo info) {
            return $c(PanelOpenedInfo.fromJS(info));
          }.toJS);

  /// Fired when the extension's side panel is closed.
  EventStream<PanelClosedInfo> get onClosed => $js.chrome.sidePanel.onClosed
      .asStream(($c) => ($js.PanelClosedInfo info) {
            return $c(PanelClosedInfo.fromJS(info));
          }.toJS);
}

/// Defines the possible alignment for the side panel in the browser UI.
enum Side {
  left('left'),
  right('right');

  const Side(this.value);

  final String value;

  JSString get toJS => value.toJS;

  static Side fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

class SidePanel {
  SidePanel.fromJS(this._wrapped);

  SidePanel(
      {
      /// Developer specified path for side panel display.
      required String defaultPath})
      : _wrapped = $js.SidePanel(default_path: defaultPath);

  final $js.SidePanel _wrapped;

  $js.SidePanel get toJS => _wrapped;

  /// Developer specified path for side panel display.
  String get defaultPath => _wrapped.default_path;

  set defaultPath(String v) {
    _wrapped.default_path = v;
  }
}

class ManifestKeys {
  ManifestKeys.fromJS(this._wrapped);

  ManifestKeys({SidePanel? sidePanel})
      : _wrapped = $js.ManifestKeys(side_panel: sidePanel?.toJS);

  final $js.ManifestKeys _wrapped;

  $js.ManifestKeys get toJS => _wrapped;

  SidePanel? get sidePanel => _wrapped.side_panel?.let(SidePanel.fromJS);

  set sidePanel(SidePanel? v) {
    _wrapped.side_panel = v?.toJS;
  }
}

class PanelLayout {
  PanelLayout.fromJS(this._wrapped);

  PanelLayout({required Side side})
      : _wrapped = $js.PanelLayout(side: side.toJS);

  final $js.PanelLayout _wrapped;

  $js.PanelLayout get toJS => _wrapped;

  Side get side => Side.fromJS(_wrapped.side);

  set side(Side v) {
    _wrapped.side = v.toJS;
  }
}

class PanelOptions {
  PanelOptions.fromJS(this._wrapped);

  PanelOptions({
    /// If specified, the side panel options will only apply to the tab with
    /// this id. If omitted, these options set the default behavior (used for
    /// any
    /// tab that doesn't have specific settings). Note: if the same path is set
    /// for this tabId and the default tabId, then the panel for this tabId will
    /// be a different instance than the panel for the default tabId.
    int? tabId,

    /// The path to the side panel HTML file to use. This must be a local
    /// resource within the extension package.
    String? path,

    /// Whether the side panel should be enabled. This is optional. The default
    /// value is true.
    bool? enabled,
  }) : _wrapped = $js.PanelOptions(
          tabId: tabId,
          path: path,
          enabled: enabled,
        );

  final $js.PanelOptions _wrapped;

  $js.PanelOptions get toJS => _wrapped;

  /// If specified, the side panel options will only apply to the tab with
  /// this id. If omitted, these options set the default behavior (used for any
  /// tab that doesn't have specific settings). Note: if the same path is set
  /// for this tabId and the default tabId, then the panel for this tabId will
  /// be a different instance than the panel for the default tabId.
  int? get tabId => _wrapped.tabId;

  set tabId(int? v) {
    _wrapped.tabId = v;
  }

  /// The path to the side panel HTML file to use. This must be a local
  /// resource within the extension package.
  String? get path => _wrapped.path;

  set path(String? v) {
    _wrapped.path = v;
  }

  /// Whether the side panel should be enabled. This is optional. The default
  /// value is true.
  bool? get enabled => _wrapped.enabled;

  set enabled(bool? v) {
    _wrapped.enabled = v;
  }
}

class PanelBehavior {
  PanelBehavior.fromJS(this._wrapped);

  PanelBehavior(
      {
      /// Whether clicking the extension's icon will toggle showing the
      /// extension's
      /// entry in the side panel. Defaults to false.
      bool? openPanelOnActionClick})
      : _wrapped =
            $js.PanelBehavior(openPanelOnActionClick: openPanelOnActionClick);

  final $js.PanelBehavior _wrapped;

  $js.PanelBehavior get toJS => _wrapped;

  /// Whether clicking the extension's icon will toggle showing the extension's
  /// entry in the side panel. Defaults to false.
  bool? get openPanelOnActionClick => _wrapped.openPanelOnActionClick;

  set openPanelOnActionClick(bool? v) {
    _wrapped.openPanelOnActionClick = v;
  }
}

class GetPanelOptions {
  GetPanelOptions.fromJS(this._wrapped);

  GetPanelOptions(
      {
      /// If specified, the side panel options for the given tab will be returned.
      /// Otherwise, returns the default side panel options (used for any tab that
      /// doesn't have specific settings).
      int? tabId})
      : _wrapped = $js.GetPanelOptions(tabId: tabId);

  final $js.GetPanelOptions _wrapped;

  $js.GetPanelOptions get toJS => _wrapped;

  /// If specified, the side panel options for the given tab will be returned.
  /// Otherwise, returns the default side panel options (used for any tab that
  /// doesn't have specific settings).
  int? get tabId => _wrapped.tabId;

  set tabId(int? v) {
    _wrapped.tabId = v;
  }
}

class OpenOptions {
  OpenOptions.fromJS(this._wrapped);

  OpenOptions({
    /// The window in which to open the side panel. This is only applicable if
    /// the extension has a global (non-tab-specific) side panel or
    /// `tabId` is also specified. This will override any
    /// currently-active global side panel the user has open in the given
    /// window. At least one of this or `tabId` must be provided.
    int? windowId,

    /// The tab in which to open the side panel. If the corresponding tab has
    /// a tab-specific side panel, the panel will only be open for that tab.
    /// If there is not a tab-specific panel, the global panel will be open in
    /// the specified tab and any other tabs without a currently-open tab-
    /// specific panel. This will override any currently-active side panel
    /// (global or tab-specific) in the corresponding tab. At least one of this
    /// or `windowId` must be provided.
    int? tabId,
  }) : _wrapped = $js.OpenOptions(
          windowId: windowId,
          tabId: tabId,
        );

  final $js.OpenOptions _wrapped;

  $js.OpenOptions get toJS => _wrapped;

  /// The window in which to open the side panel. This is only applicable if
  /// the extension has a global (non-tab-specific) side panel or
  /// `tabId` is also specified. This will override any
  /// currently-active global side panel the user has open in the given
  /// window. At least one of this or `tabId` must be provided.
  int? get windowId => _wrapped.windowId;

  set windowId(int? v) {
    _wrapped.windowId = v;
  }

  /// The tab in which to open the side panel. If the corresponding tab has
  /// a tab-specific side panel, the panel will only be open for that tab.
  /// If there is not a tab-specific panel, the global panel will be open in
  /// the specified tab and any other tabs without a currently-open tab-
  /// specific panel. This will override any currently-active side panel
  /// (global or tab-specific) in the corresponding tab. At least one of this
  /// or `windowId` must be provided.
  int? get tabId => _wrapped.tabId;

  set tabId(int? v) {
    _wrapped.tabId = v;
  }
}

class CloseOptions {
  CloseOptions.fromJS(this._wrapped);

  CloseOptions({
    /// The window in which to close the side panel. If a global side panel is
    /// open in the specified window, it will be closed for all tabs in that
    /// window where no tab-specific panel is active. At least one of this or
    /// `tabId` must be provided.
    int? windowId,

    /// The tab in which to close the side panel. If a tab-specific side panel
    /// is open in the specified tab, it will be closed for that tab. If only
    /// the
    /// global side panel is open, the promise returned by the call to
    /// `close()` will reject with an error. This behavior was changed
    /// in Chrome 145, with prior versions falling back to closing the global
    /// panel. At least one of this or `windowId` must be provided.
    int? tabId,
  }) : _wrapped = $js.CloseOptions(
          windowId: windowId,
          tabId: tabId,
        );

  final $js.CloseOptions _wrapped;

  $js.CloseOptions get toJS => _wrapped;

  /// The window in which to close the side panel. If a global side panel is
  /// open in the specified window, it will be closed for all tabs in that
  /// window where no tab-specific panel is active. At least one of this or
  /// `tabId` must be provided.
  int? get windowId => _wrapped.windowId;

  set windowId(int? v) {
    _wrapped.windowId = v;
  }

  /// The tab in which to close the side panel. If a tab-specific side panel
  /// is open in the specified tab, it will be closed for that tab. If only the
  /// global side panel is open, the promise returned by the call to
  /// `close()` will reject with an error. This behavior was changed
  /// in Chrome 145, with prior versions falling back to closing the global
  /// panel. At least one of this or `windowId` must be provided.
  int? get tabId => _wrapped.tabId;

  set tabId(int? v) {
    _wrapped.tabId = v;
  }
}

class PanelOpenedInfo {
  PanelOpenedInfo.fromJS(this._wrapped);

  PanelOpenedInfo({
    /// The ID of the window where the side panel is opened. This is available
    /// for both global and tab-specific panels.
    required int windowId,

    /// The optional ID of the tab where the side panel is opened. This is
    /// provided only when the panel is tab-specific.
    int? tabId,

    /// The path of the local resource within the extension package whose
    /// content
    /// is displayed in the panel.
    required String path,
  }) : _wrapped = $js.PanelOpenedInfo(
          windowId: windowId,
          tabId: tabId,
          path: path,
        );

  final $js.PanelOpenedInfo _wrapped;

  $js.PanelOpenedInfo get toJS => _wrapped;

  /// The ID of the window where the side panel is opened. This is available
  /// for both global and tab-specific panels.
  int get windowId => _wrapped.windowId;

  set windowId(int v) {
    _wrapped.windowId = v;
  }

  /// The optional ID of the tab where the side panel is opened. This is
  /// provided only when the panel is tab-specific.
  int? get tabId => _wrapped.tabId;

  set tabId(int? v) {
    _wrapped.tabId = v;
  }

  /// The path of the local resource within the extension package whose content
  /// is displayed in the panel.
  String get path => _wrapped.path;

  set path(String v) {
    _wrapped.path = v;
  }
}

class PanelClosedInfo {
  PanelClosedInfo.fromJS(this._wrapped);

  PanelClosedInfo({
    /// The ID of the window where the side panel was closed. This is available
    /// for both global and tab-specific panels.
    required int windowId,

    /// The optional ID of the tab where the side panel was closed. This is
    /// provided only when the panel is tab-specific.
    int? tabId,

    /// The path of the local resource within the extension package whose
    /// content
    /// is displayed in the panel.
    required String path,
  }) : _wrapped = $js.PanelClosedInfo(
          windowId: windowId,
          tabId: tabId,
          path: path,
        );

  final $js.PanelClosedInfo _wrapped;

  $js.PanelClosedInfo get toJS => _wrapped;

  /// The ID of the window where the side panel was closed. This is available
  /// for both global and tab-specific panels.
  int get windowId => _wrapped.windowId;

  set windowId(int v) {
    _wrapped.windowId = v;
  }

  /// The optional ID of the tab where the side panel was closed. This is
  /// provided only when the panel is tab-specific.
  int? get tabId => _wrapped.tabId;

  set tabId(int? v) {
    _wrapped.tabId = v;
  }

  /// The path of the local resource within the extension package whose content
  /// is displayed in the panel.
  String get path => _wrapped.path;

  set path(String v) {
    _wrapped.path = v;
  }
}
