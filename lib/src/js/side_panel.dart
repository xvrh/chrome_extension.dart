// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSSidePanelExtension on JSChrome {
  @JS('sidePanel')
  external JSSidePanel? get sidePanelNullable;

  /// chrome.sidePanel API
  JSSidePanel get sidePanel {
    var sidePanelNullable = this.sidePanelNullable;
    if (sidePanelNullable == null) {
      throw ApiNotAvailableException('chrome.sidePanel');
    }
    return sidePanelNullable;
  }
}

@JS()
@staticInterop
class JSSidePanel {}

extension JSSidePanelExtension on JSSidePanel {
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
}

@JS()
@staticInterop
@anonymous
class SidePanel {
  external factory SidePanel(
      {
      /// Developer specified path for side panel display.
      String default_path});
}

extension SidePanelExtension on SidePanel {
  /// Developer specified path for side panel display.
  external String default_path;
}

@JS()
@staticInterop
@anonymous
class ManifestKeys {
  external factory ManifestKeys({SidePanel side_panel});
}

extension ManifestKeysExtension on ManifestKeys {
  external SidePanel side_panel;
}

@JS()
@staticInterop
@anonymous
class PanelOptions {
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
}

extension PanelOptionsExtension on PanelOptions {
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

@JS()
@staticInterop
@anonymous
class PanelBehavior {
  external factory PanelBehavior(
      {
      /// Whether clicking the extension's icon will toggle showing the extension's
      /// entry in the side panel. Defaults to false.
      bool? openPanelOnActionClick});
}

extension PanelBehaviorExtension on PanelBehavior {
  /// Whether clicking the extension's icon will toggle showing the extension's
  /// entry in the side panel. Defaults to false.
  external bool? openPanelOnActionClick;
}

@JS()
@staticInterop
@anonymous
class GetPanelOptions {
  external factory GetPanelOptions(
      {
      /// If specified, the side panel options for the given tab will be returned.
      /// Otherwise, returns the default side panel options (used for any tab that
      /// doesn't have specific settings).
      int? tabId});
}

extension GetPanelOptionsExtension on GetPanelOptions {
  /// If specified, the side panel options for the given tab will be returned.
  /// Otherwise, returns the default side panel options (used for any tab that
  /// doesn't have specific settings).
  external int? tabId;
}
