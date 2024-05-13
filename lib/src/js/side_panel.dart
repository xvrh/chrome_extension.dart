// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSSidePanelExtension on JSChrome {
  @JS('sidePanel')
  external JSSidePanel? get sidePanelNullable;

  /// Use the `chrome.sidePanel` API to host content in the browser's side panel
  /// alongside the main content of a webpage.
  JSSidePanel get sidePanel {
    var sidePanelNullable = this.sidePanelNullable;
    if (sidePanelNullable == null) {
      throw ApiNotAvailableException('chrome.sidePanel');
    }
    return sidePanelNullable;
  }
}

extension type JSSidePanel._(JSObject _) {
  /// Configures the side panel.
  /// |options|: The configuration options to apply to the panel.
  /// |callback|: Invoked when the options have been set.
  external JSPromise setOptions(PanelOptions options);

  /// Returns the active panel configuration.
  /// |options|: Specifies the context to return the configuration for.
  /// |callback|: Called with the active panel configuration.
  external JSPromise getOptions(GetPanelOptions options);

  /// Configures the extension's side panel behavior. This is an upsert
  /// operation.
  /// |behavior|: The new behavior to be set.
  /// |callback|: Called when the new behavior has been set.
  external JSPromise setPanelBehavior(PanelBehavior behavior);

  /// Returns the extension's current side panel behavior.
  /// |callback|: Called with the extension's side panel behavior.
  external JSPromise getPanelBehavior();

  /// Opens the side panel for the extension.
  /// This may only be called in response to a user action.
  /// |options|: Specifies the context in which to open the side panel.
  /// |callback|: Called when the side panel has been opened.
  external JSPromise open(OpenOptions options);
}
extension type SidePanel._(JSObject _) implements JSObject {
  external factory SidePanel(
      {
      /// Developer specified path for side panel display.
      String default_path});

  /// Developer specified path for side panel display.
  external String default_path;
}
extension type ManifestKeys._(JSObject _) implements JSObject {
  external factory ManifestKeys({SidePanel side_panel});

  external SidePanel side_panel;
}
extension type PanelOptions._(JSObject _) implements JSObject {
  external factory PanelOptions({
    /// If specified, the side panel options will only apply to the tab with
    /// this id. If omitted, these options set the default behavior (used for any
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
  });

  /// If specified, the side panel options will only apply to the tab with
  /// this id. If omitted, these options set the default behavior (used for any
  /// tab that doesn't have specific settings). Note: if the same path is set
  /// for this tabId and the default tabId, then the panel for this tabId will
  /// be a different instance than the panel for the default tabId.
  external int? tabId;

  /// The path to the side panel HTML file to use. This must be a local
  /// resource within the extension package.
  external String? path;

  /// Whether the side panel should be enabled. This is optional. The default
  /// value is true.
  external bool? enabled;
}
extension type PanelBehavior._(JSObject _) implements JSObject {
  external factory PanelBehavior(
      {
      /// Whether clicking the extension's icon will toggle showing the extension's
      /// entry in the side panel. Defaults to false.
      bool? openPanelOnActionClick});

  /// Whether clicking the extension's icon will toggle showing the extension's
  /// entry in the side panel. Defaults to false.
  external bool? openPanelOnActionClick;
}
extension type GetPanelOptions._(JSObject _) implements JSObject {
  external factory GetPanelOptions(
      {
      /// If specified, the side panel options for the given tab will be returned.
      /// Otherwise, returns the default side panel options (used for any tab that
      /// doesn't have specific settings).
      int? tabId});

  /// If specified, the side panel options for the given tab will be returned.
  /// Otherwise, returns the default side panel options (used for any tab that
  /// doesn't have specific settings).
  external int? tabId;
}
extension type OpenOptions._(JSObject _) implements JSObject {
  external factory OpenOptions({
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
  });

  /// The window in which to open the side panel. This is only applicable if
  /// the extension has a global (non-tab-specific) side panel or
  /// `tabId` is also specified. This will override any
  /// currently-active global side panel the user has open in the given
  /// window. At least one of this or `tabId` must be provided.
  external int? windowId;

  /// The tab in which to open the side panel. If the corresponding tab has
  /// a tab-specific side panel, the panel will only be open for that tab.
  /// If there is not a tab-specific panel, the global panel will be open in
  /// the specified tab and any other tabs without a currently-open tab-
  /// specific panel. This will override any currently-active side panel
  /// (global or tab-specific) in the corresponding tab. At least one of this
  /// or `windowId` must be provided.
  external int? tabId;
}
