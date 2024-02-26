// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

@JS()
library;

import 'dart:js_interop';
import 'chrome.dart';
import 'devtools.dart';

export 'chrome.dart';
export 'devtools.dart';

extension JSChromeJSDevtoolsPanelsExtension on JSChromeDevtools {
  @JS('panels')
  external JSDevtoolsPanels? get panelsNullable;

  /// Use the `chrome.devtools.panels` API to integrate your extension into
  /// Developer Tools window UI: create your own panels, access existing panels,
  /// and add sidebars.
  JSDevtoolsPanels get panels {
    var panelsNullable = this.panelsNullable;
    if (panelsNullable == null) {
      throw ApiNotAvailableException('chrome.devtools.panels');
    }
    return panelsNullable;
  }
}

extension type JSDevtoolsPanels._(JSObject _) {
  /// Creates an extension panel.
  external void create(
    /// Title that is displayed next to the extension icon in the Developer
    /// Tools toolbar.
    String title,

    /// Path of the panel's icon relative to the extension directory.
    String iconPath,

    /// Path of the panel's HTML page relative to the extension directory.
    String pagePath,

    /// A function that is called when the panel is created.
    JSFunction? callback,
  );

  /// Specifies the function to be called when the user clicks a resource link
  /// in the Developer Tools window. To unset the handler, either call the
  /// method with no parameters or pass null as the parameter.
  external void setOpenResourceHandler(

      /// A function that is called when the user clicks on a valid resource link
      /// in Developer Tools window. Note that if the user clicks an invalid URL
      /// or an XHR, this function is not called.
      JSFunction? callback);

  /// Requests DevTools to open a URL in a Developer Tools panel.
  external void openResource(
    /// The URL of the resource to open.
    String url,

    /// Specifies the line number to scroll to when the resource is loaded.
    int lineNumber,

    /// Specifies the column number to scroll to when the resource is loaded.
    int? columnNumber,

    /// A function that is called when the resource has been successfully
    /// loaded.
    JSFunction? callback,
  );

  /// Elements panel.
  external ElementsPanel get elements;

  /// Sources panel.
  external SourcesPanel get sources;

  /// The name of the color theme set in user's DevTools settings. Possible
  /// values: `default` (the default) and `dark`.
  external String get themeName;
}
extension type ElementsPanel._(JSObject _) implements JSObject {
  external factory ElementsPanel();

  /// Creates a pane within panel's sidebar.
  external void createSidebarPane(
    /// Text that is displayed in sidebar caption.
    String title,

    /// A callback invoked when the sidebar is created.
    JSFunction? callback,
  );

  /// Fired when an object is selected in the panel.
  external Event get onSelectionChanged;
}
extension type SourcesPanel._(JSObject _) implements JSObject {
  external factory SourcesPanel();

  /// Creates a pane within panel's sidebar.
  external void createSidebarPane(
    /// Text that is displayed in sidebar caption.
    String title,

    /// A callback invoked when the sidebar is created.
    JSFunction? callback,
  );

  /// Fired when an object is selected in the panel.
  external Event get onSelectionChanged;
}
extension type ExtensionPanel._(JSObject _) implements JSObject {
  external factory ExtensionPanel();

  /// Appends a button to the status bar of the panel.
  external Button createStatusBarButton(
    /// Path to the icon of the button. The file should contain a 64x24-pixel
    /// image composed of two 32x24 icons. The left icon is used when the button
    /// is inactive; the right icon is displayed when the button is pressed.
    String iconPath,

    /// Text shown as a tooltip when user hovers the mouse over the button.
    String tooltipText,

    /// Whether the button is disabled.
    bool disabled,
  );

  /// Fired upon a search action (start of a new search, search result
  /// navigation, or search being canceled).
  external Event get onSearch;

  /// Fired when the user switches to the panel.
  external Event get onShown;

  /// Fired when the user switches away from the panel.
  external Event get onHidden;
}
extension type ExtensionSidebarPane._(JSObject _) implements JSObject {
  external factory ExtensionSidebarPane();

  /// Sets the height of the sidebar.
  external void setHeight(

      /// A CSS-like size specification, such as `'100px'` or `'12ex'`.
      String height);

  /// Sets an expression that is evaluated within the inspected page. The result
  /// is displayed in the sidebar pane.
  external void setExpression(
    /// An expression to be evaluated in context of the inspected page.
    /// JavaScript objects and DOM nodes are displayed in an expandable tree
    /// similar to the console/watch.
    String expression,

    /// An optional title for the root of the expression tree.
    String? rootTitle,

    /// A callback invoked after the sidebar pane is updated with the expression
    /// evaluation results.
    JSFunction? callback,
  );

  /// Sets a JSON-compliant object to be displayed in the sidebar pane.
  external void setObject(
    /// An object to be displayed in context of the inspected page. Evaluated in
    /// the context of the caller (API client).
    String jsonObject,

    /// An optional title for the root of the expression tree.
    String? rootTitle,

    /// A callback invoked after the sidebar is updated with the object.
    JSFunction? callback,
  );

  /// Sets an HTML page to be displayed in the sidebar pane.
  external void setPage(

      /// Relative path of an extension page to display within the sidebar.
      String path);

  /// Fired when the sidebar pane becomes visible as a result of user switching
  /// to the panel that hosts it.
  external Event get onShown;

  /// Fired when the sidebar pane becomes hidden as a result of the user
  /// switching away from the panel that hosts the sidebar pane.
  external Event get onHidden;
}
extension type Button._(JSObject _) implements JSObject {
  external factory Button();

  /// Updates the attributes of the button. If some of the arguments are omitted
  /// or `null`, the corresponding attributes are not updated.
  external void update(
    /// Path to the new icon of the button.
    String? iconPath,

    /// Text shown as a tooltip when user hovers the mouse over the button.
    String? tooltipText,

    /// Whether the button is disabled.
    bool? disabled,
  );

  /// Fired when the button is clicked.
  external Event get onClicked;
}
