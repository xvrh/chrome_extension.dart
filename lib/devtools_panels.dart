// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'devtools.dart';
import 'src/internal_helpers.dart';
import 'src/js/devtools_panels.dart' as $js;

export 'devtools.dart' show ChromeDevtools, ChromeDevtoolsExtension;
export 'src/chrome.dart' show chrome;

final _devtoolsPanels = ChromeDevtoolsPanels._();

extension ChromeDevtoolsPanelsExtension on ChromeDevtools {
  /// Use the `chrome.devtools.panels` API to integrate your extension into
  /// Developer Tools window UI: create your own panels, access existing panels,
  /// and add sidebars.
  ChromeDevtoolsPanels get panels => _devtoolsPanels;
}

class ChromeDevtoolsPanels {
  ChromeDevtoolsPanels._();

  bool get isAvailable =>
      $js.chrome.devtoolsNullable?.panelsNullable != null && alwaysTrue;

  /// Creates an extension panel.
  /// [title] Title that is displayed next to the extension icon in the
  /// Developer Tools toolbar.
  /// [iconPath] Path of the panel's icon relative to the extension directory.
  /// [pagePath] Path of the panel's HTML page relative to the extension
  /// directory.
  /// [returns] A function that is called when the panel is created.
  Future<ExtensionPanel> create(
    String title,
    String iconPath,
    String pagePath,
  ) {
    var $completer = Completer<ExtensionPanel>();
    $js.chrome.devtools.panels.create(
      title,
      iconPath,
      pagePath,
      ($js.ExtensionPanel panel) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(ExtensionPanel.fromJS(panel));
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Specifies the function to be called when the user clicks a resource link
  /// in the Developer Tools window. To unset the handler, either call the
  /// method with no parameters or pass null as the parameter.
  /// [callback] A function that is called when the user clicks on a valid
  /// resource link in Developer Tools window. Note that if the user clicks an
  /// invalid URL or an XHR, this function is not called.
  void setOpenResourceHandler(Function? callback) {
    $js.chrome.devtools.panels
        .setOpenResourceHandler(callback?.let(allowInterop));
  }

  /// Requests DevTools to open a URL in a Developer Tools panel.
  /// [url] The URL of the resource to open.
  /// [lineNumber] Specifies the line number to scroll to when the resource is
  /// loaded.
  /// [columnNumber] Specifies the column number to scroll to when the
  /// resource is loaded.
  /// [callback] A function that is called when the resource has been
  /// successfully loaded.
  void openResource(
    String url,
    int lineNumber,
    int? columnNumber,
    Function? callback,
  ) {
    $js.chrome.devtools.panels.openResource(
      url,
      lineNumber,
      columnNumber,
      callback?.let(allowInterop),
    );
  }

  /// Elements panel.
  ElementsPanel get elements =>
      ElementsPanel.fromJS($js.chrome.devtools.panels.elements);

  /// Sources panel.
  SourcesPanel get sources =>
      SourcesPanel.fromJS($js.chrome.devtools.panels.sources);

  /// The name of the color theme set in user's DevTools settings. Possible
  /// values: `default` (the default) and `dark`.
  String get themeName => $js.chrome.devtools.panels.themeName;
}

class ElementsPanel {
  ElementsPanel.fromJS(this._wrapped);

  ElementsPanel() : _wrapped = $js.ElementsPanel();

  final $js.ElementsPanel _wrapped;

  $js.ElementsPanel get toJS => _wrapped;

  /// Creates a pane within panel's sidebar.
  /// [title] Text that is displayed in sidebar caption.
  /// [returns] A callback invoked when the sidebar is created.
  Future<ExtensionSidebarPane> createSidebarPane(String title) {
    var $completer = Completer<ExtensionSidebarPane>();
    _wrapped.createSidebarPane(
      title,
      ($js.ExtensionSidebarPane result) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(ExtensionSidebarPane.fromJS(result));
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Fired when an object is selected in the panel.
  EventStream<void> get onSelectionChanged =>
      _wrapped.onSelectionChanged.asStream(($c) => () {
            return $c(null);
          });
}

class SourcesPanel {
  SourcesPanel.fromJS(this._wrapped);

  SourcesPanel() : _wrapped = $js.SourcesPanel();

  final $js.SourcesPanel _wrapped;

  $js.SourcesPanel get toJS => _wrapped;

  /// Creates a pane within panel's sidebar.
  /// [title] Text that is displayed in sidebar caption.
  /// [returns] A callback invoked when the sidebar is created.
  Future<ExtensionSidebarPane> createSidebarPane(String title) {
    var $completer = Completer<ExtensionSidebarPane>();
    _wrapped.createSidebarPane(
      title,
      ($js.ExtensionSidebarPane result) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(ExtensionSidebarPane.fromJS(result));
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Fired when an object is selected in the panel.
  EventStream<void> get onSelectionChanged =>
      _wrapped.onSelectionChanged.asStream(($c) => () {
            return $c(null);
          });
}

class ExtensionPanel {
  ExtensionPanel.fromJS(this._wrapped);

  ExtensionPanel() : _wrapped = $js.ExtensionPanel();

  final $js.ExtensionPanel _wrapped;

  $js.ExtensionPanel get toJS => _wrapped;

  /// Appends a button to the status bar of the panel.
  /// [iconPath] Path to the icon of the button. The file should contain a
  /// 64x24-pixel image composed of two 32x24 icons. The left icon is used
  /// when the button is inactive; the right icon is displayed when the button
  /// is pressed.
  /// [tooltipText] Text shown as a tooltip when user hovers the mouse over
  /// the button.
  /// [disabled] Whether the button is disabled.
  Button createStatusBarButton(
    String iconPath,
    String tooltipText,
    bool disabled,
  ) {
    return Button.fromJS(_wrapped.createStatusBarButton(
      iconPath,
      tooltipText,
      disabled,
    ));
  }

  /// Fired upon a search action (start of a new search, search result
  /// navigation, or search being canceled).
  EventStream<ExtensionPanelOnSearchEvent> get onSearch =>
      _wrapped.onSearch.asStream(($c) => (
            String action,
            String? queryString,
          ) {
            return $c(ExtensionPanelOnSearchEvent(
              action: action,
              queryString: queryString,
            ));
          });

  /// Fired when the user switches to the panel.
  EventStream<JSObject> get onShown =>
      _wrapped.onShown.asStream(($c) => (JSObject window) {
            return $c(window);
          });

  /// Fired when the user switches away from the panel.
  EventStream<void> get onHidden => _wrapped.onHidden.asStream(($c) => () {
        return $c(null);
      });
}

class ExtensionSidebarPane {
  ExtensionSidebarPane.fromJS(this._wrapped);

  ExtensionSidebarPane() : _wrapped = $js.ExtensionSidebarPane();

  final $js.ExtensionSidebarPane _wrapped;

  $js.ExtensionSidebarPane get toJS => _wrapped;

  /// Sets the height of the sidebar.
  /// [height] A CSS-like size specification, such as `'100px'` or `'12ex'`.
  void setHeight(String height) {
    _wrapped.setHeight(height);
  }

  /// Sets an expression that is evaluated within the inspected page. The result
  /// is displayed in the sidebar pane.
  /// [expression] An expression to be evaluated in context of the inspected
  /// page. JavaScript objects and DOM nodes are displayed in an expandable
  /// tree similar to the console/watch.
  /// [rootTitle] An optional title for the root of the expression tree.
  /// [callback] A callback invoked after the sidebar pane is updated with the
  /// expression evaluation results.
  void setExpression(
    String expression,
    String? rootTitle,
    Function? callback,
  ) {
    _wrapped.setExpression(
      expression,
      rootTitle,
      callback?.let(allowInterop),
    );
  }

  /// Sets a JSON-compliant object to be displayed in the sidebar pane.
  /// [jsonObject] An object to be displayed in context of the inspected page.
  /// Evaluated in the context of the caller (API client).
  /// [rootTitle] An optional title for the root of the expression tree.
  /// [callback] A callback invoked after the sidebar is updated with the
  /// object.
  void setObject(
    String jsonObject,
    String? rootTitle,
    Function? callback,
  ) {
    _wrapped.setObject(
      jsonObject,
      rootTitle,
      callback?.let(allowInterop),
    );
  }

  /// Sets an HTML page to be displayed in the sidebar pane.
  /// [path] Relative path of an extension page to display within the sidebar.
  void setPage(String path) {
    _wrapped.setPage(path);
  }

  /// Fired when the sidebar pane becomes visible as a result of user switching
  /// to the panel that hosts it.
  EventStream<JSObject> get onShown =>
      _wrapped.onShown.asStream(($c) => (JSObject window) {
            return $c(window);
          });

  /// Fired when the sidebar pane becomes hidden as a result of the user
  /// switching away from the panel that hosts the sidebar pane.
  EventStream<void> get onHidden => _wrapped.onHidden.asStream(($c) => () {
        return $c(null);
      });
}

class Button {
  Button.fromJS(this._wrapped);

  Button() : _wrapped = $js.Button();

  final $js.Button _wrapped;

  $js.Button get toJS => _wrapped;

  /// Updates the attributes of the button. If some of the arguments are omitted
  /// or `null`, the corresponding attributes are not updated.
  /// [iconPath] Path to the new icon of the button.
  /// [tooltipText] Text shown as a tooltip when user hovers the mouse over
  /// the button.
  /// [disabled] Whether the button is disabled.
  void update(
    String? iconPath,
    String? tooltipText,
    bool? disabled,
  ) {
    _wrapped.update(
      iconPath,
      tooltipText,
      disabled,
    );
  }

  /// Fired when the button is clicked.
  EventStream<void> get onClicked => _wrapped.onClicked.asStream(($c) => () {
        return $c(null);
      });
}

class ExtensionPanelOnSearchEvent {
  ExtensionPanelOnSearchEvent({
    required this.action,
    required this.queryString,
  });

  /// Type of search action being performed.
  final String action;

  /// Query string (only for 'performSearch').
  final String? queryString;
}
