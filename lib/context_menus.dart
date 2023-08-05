// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/context_menus.dart' as $js;
import 'src/js/tabs.dart' as $js_tabs;
import 'tabs.dart';

export 'src/chrome.dart' show chrome;

final _contextMenus = ChromeContextMenus._();

extension ChromeContextMenusExtension on Chrome {
  /// Use the `chrome.contextMenus` API to add items to Google Chrome's context
  /// menu. You can choose what types of objects your context menu additions
  /// apply to, such as images, hyperlinks, and pages.
  ChromeContextMenus get contextMenus => _contextMenus;
}

class ChromeContextMenus {
  ChromeContextMenus._();

  bool get isAvailable => $js.chrome.contextMenusNullable != null && alwaysTrue;

  /// Creates a new context menu item. If an error occurs during creation, it
  /// may not be detected until the creation callback fires; details will be in
  /// [runtime.lastError].
  /// [callback] Called when the item has been created in the browser. If an
  /// error occurs during creation, details will be available in
  /// [runtime.lastError].
  /// [returns] The ID of the newly created item.
  Object create(
    CreateProperties createProperties,
    Function? callback,
  ) {
    return $js.chrome.contextMenus
        .create(
          createProperties.toJS,
          callback?.let(allowInterop),
        )
        .when(
          isInt: (v) => v,
          isString: (v) => v,
        );
  }

  /// Updates a previously created context menu item.
  /// [id] The ID of the item to update.
  /// [updateProperties] The properties to update. Accepts the same values as
  /// the [contextMenus.create] function.
  /// [returns] Called when the context menu has been updated.
  Future<void> update(
    Object id,
    UpdateProperties updateProperties,
  ) {
    var $completer = Completer<void>();
    $js.chrome.contextMenus.update(
      switch (id) {
        int() => id,
        String() => id,
        _ => throw UnsupportedError(
            'Received type: ${id.runtimeType}. Supported types are: int, String')
      },
      updateProperties.toJS,
      () {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(null);
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Removes a context menu item.
  /// [menuItemId] The ID of the context menu item to remove.
  /// [returns] Called when the context menu has been removed.
  Future<void> remove(Object menuItemId) {
    var $completer = Completer<void>();
    $js.chrome.contextMenus.remove(
      switch (menuItemId) {
        int() => menuItemId,
        String() => menuItemId,
        _ => throw UnsupportedError(
            'Received type: ${menuItemId.runtimeType}. Supported types are: int, String')
      },
      () {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(null);
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Removes all context menu items added by this extension.
  /// [returns] Called when removal is complete.
  Future<void> removeAll() {
    var $completer = Completer<void>();
    $js.chrome.contextMenus.removeAll(() {
      if (checkRuntimeLastError($completer)) {
        $completer.complete(null);
      }
    }.toJS);
    return $completer.future;
  }

  /// The maximum number of top level extension items that can be added to an
  /// extension action context menu. Any items beyond this limit will be
  /// ignored.
  int get actionMenuTopLevelLimit =>
      $js.chrome.contextMenus.ACTION_MENU_TOP_LEVEL_LIMIT;

  /// Fired when a context menu item is clicked.
  EventStream<OnClickedEvent> get onClicked =>
      $js.chrome.contextMenus.onClicked.asStream(($c) => (
            $js.OnClickData info,
            $js_tabs.Tab? tab,
          ) {
            return $c(OnClickedEvent(
              info: OnClickData.fromJS(info),
              tab: tab?.let(Tab.fromJS),
            ));
          });
}

/// The different contexts a menu can appear in. Specifying 'all' is equivalent
/// to the combination of all other contexts except for 'launcher'. The
/// 'launcher' context is only supported by apps and is used to add menu items
/// to the context menu that appears when clicking the app icon in the
/// launcher/taskbar/dock/etc. Different platforms might put limitations on what
/// is actually supported in a launcher context menu.
enum ContextType {
  all('all'),
  page('page'),
  frame('frame'),
  selection('selection'),
  link('link'),
  editable('editable'),
  image('image'),
  video('video'),
  audio('audio'),
  launcher('launcher'),
  browserAction('browser_action'),
  pageAction('page_action'),
  action('action');

  const ContextType(this.value);

  final String value;

  String get toJS => value;
  static ContextType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The type of menu item.
enum ItemType {
  normal('normal'),
  checkbox('checkbox'),
  radio('radio'),
  separator('separator');

  const ItemType(this.value);

  final String value;

  String get toJS => value;
  static ItemType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class OnClickData {
  OnClickData.fromJS(this._wrapped);

  OnClickData({
    /// The ID of the menu item that was clicked.
    required Object menuItemId,

    /// The parent ID, if any, for the item clicked.
    Object? parentMenuItemId,

    /// One of 'image', 'video', or 'audio' if the context menu was activated on
    /// one of these types of elements.
    String? mediaType,

    /// If the element is a link, the URL it points to.
    String? linkUrl,

    /// Will be present for elements with a 'src' URL.
    String? srcUrl,

    /// The URL of the page where the menu item was clicked. This property is
    /// not set if the click occured in a context where there is no current
    /// page, such as in a launcher context menu.
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
    required bool editable,

    /// A flag indicating the state of a checkbox or radio item before it was
    /// clicked.
    bool? wasChecked,

    /// A flag indicating the state of a checkbox or radio item after it is
    /// clicked.
    bool? checked,
  }) : _wrapped = $js.OnClickData(
          menuItemId: switch (menuItemId) {
            int() => menuItemId,
            String() => menuItemId,
            _ => throw UnsupportedError(
                'Received type: ${menuItemId.runtimeType}. Supported types are: int, String')
          },
          parentMenuItemId: switch (parentMenuItemId) {
            int() => parentMenuItemId,
            String() => parentMenuItemId,
            null => null,
            _ => throw UnsupportedError(
                'Received type: ${parentMenuItemId.runtimeType}. Supported types are: int, String')
          },
          mediaType: mediaType,
          linkUrl: linkUrl,
          srcUrl: srcUrl,
          pageUrl: pageUrl,
          frameUrl: frameUrl,
          frameId: frameId,
          selectionText: selectionText,
          editable: editable,
          wasChecked: wasChecked,
          checked: checked,
        );

  final $js.OnClickData _wrapped;

  $js.OnClickData get toJS => _wrapped;

  /// The ID of the menu item that was clicked.
  Object get menuItemId => _wrapped.menuItemId.when(
        isInt: (v) => v,
        isString: (v) => v,
      );
  set menuItemId(Object v) {
    _wrapped.menuItemId = switch (v) {
      int() => v,
      String() => v,
      _ => throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: int, String')
    };
  }

  /// The parent ID, if any, for the item clicked.
  Object? get parentMenuItemId => _wrapped.parentMenuItemId?.when(
        isInt: (v) => v,
        isString: (v) => v,
      );
  set parentMenuItemId(Object? v) {
    _wrapped.parentMenuItemId = switch (v) {
      int() => v,
      String() => v,
      null => null,
      _ => throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: int, String')
    };
  }

  /// One of 'image', 'video', or 'audio' if the context menu was activated on
  /// one of these types of elements.
  String? get mediaType => _wrapped.mediaType;
  set mediaType(String? v) {
    _wrapped.mediaType = v;
  }

  /// If the element is a link, the URL it points to.
  String? get linkUrl => _wrapped.linkUrl;
  set linkUrl(String? v) {
    _wrapped.linkUrl = v;
  }

  /// Will be present for elements with a 'src' URL.
  String? get srcUrl => _wrapped.srcUrl;
  set srcUrl(String? v) {
    _wrapped.srcUrl = v;
  }

  /// The URL of the page where the menu item was clicked. This property is not
  /// set if the click occured in a context where there is no current page, such
  /// as in a launcher context menu.
  String? get pageUrl => _wrapped.pageUrl;
  set pageUrl(String? v) {
    _wrapped.pageUrl = v;
  }

  ///  The URL of the frame of the element where the context menu was clicked,
  /// if it was in a frame.
  String? get frameUrl => _wrapped.frameUrl;
  set frameUrl(String? v) {
    _wrapped.frameUrl = v;
  }

  ///  The [ID of the frame](webNavigation#frame_ids) of the element where the
  /// context menu was clicked, if it was in a frame.
  int? get frameId => _wrapped.frameId;
  set frameId(int? v) {
    _wrapped.frameId = v;
  }

  /// The text for the context selection, if any.
  String? get selectionText => _wrapped.selectionText;
  set selectionText(String? v) {
    _wrapped.selectionText = v;
  }

  /// A flag indicating whether the element is editable (text input, textarea,
  /// etc.).
  bool get editable => _wrapped.editable;
  set editable(bool v) {
    _wrapped.editable = v;
  }

  /// A flag indicating the state of a checkbox or radio item before it was
  /// clicked.
  bool? get wasChecked => _wrapped.wasChecked;
  set wasChecked(bool? v) {
    _wrapped.wasChecked = v;
  }

  /// A flag indicating the state of a checkbox or radio item after it is
  /// clicked.
  bool? get checked => _wrapped.checked;
  set checked(bool? v) {
    _wrapped.checked = v;
  }
}

class CreateProperties {
  CreateProperties.fromJS(this._wrapped);

  CreateProperties({
    /// The type of menu item. Defaults to `normal`.
    ItemType? type,

    /// The unique ID to assign to this item. Mandatory for event pages. Cannot
    /// be the same as another ID for this extension.
    String? id,

    /// The text to display in the item; this is _required_ unless `type` is
    /// `separator`. When the context is `selection`, use `%s` within the string
    /// to show the selected text. For example, if this parameter's value is
    /// "Translate '%s' to Pig Latin" and the user selects the word "cool", the
    /// context menu item for the selection is "Translate 'cool' to Pig Latin".
    String? title,

    /// The initial state of a checkbox or radio button: `true` for selected,
    /// `false` for unselected. Only one radio button can be selected at a time
    /// in a given group.
    bool? checked,

    /// List of contexts this menu item will appear in. Defaults to `['page']`.
    List<ContextType>? contexts,

    /// Whether the item is visible in the menu.
    bool? visible,

    /// A function that is called back when the menu item is clicked. Event
    /// pages cannot use this; instead, they should register a listener for
    /// [contextMenus.onClicked].
    Function? onclick,

    /// The ID of a parent menu item; this makes the item a child of a
    /// previously added item.
    Object? parentId,

    /// Restricts the item to apply only to documents or frames whose URL
    /// matches one of the given patterns. For details on pattern formats, see
    /// [Match Patterns](match_patterns).
    List<String>? documentUrlPatterns,

    /// Similar to `documentUrlPatterns`, filters based on the `src` attribute
    /// of `img`, `audio`, and `video` tags and the `href` attribute of `a`
    /// tags.
    List<String>? targetUrlPatterns,

    /// Whether this context menu item is enabled or disabled. Defaults to
    /// `true`.
    bool? enabled,
  }) : _wrapped = $js.CreateProperties(
          type: type?.toJS,
          id: id,
          title: title,
          checked: checked,
          contexts: contexts?.toJSArray((e) => e.toJS),
          visible: visible,
          onclick: onclick?.let(allowInterop),
          parentId: switch (parentId) {
            int() => parentId,
            String() => parentId,
            null => null,
            _ => throw UnsupportedError(
                'Received type: ${parentId.runtimeType}. Supported types are: int, String')
          },
          documentUrlPatterns: documentUrlPatterns?.toJSArray((e) => e),
          targetUrlPatterns: targetUrlPatterns?.toJSArray((e) => e),
          enabled: enabled,
        );

  final $js.CreateProperties _wrapped;

  $js.CreateProperties get toJS => _wrapped;

  /// The type of menu item. Defaults to `normal`.
  ItemType? get type => _wrapped.type?.let(ItemType.fromJS);
  set type(ItemType? v) {
    _wrapped.type = v?.toJS;
  }

  /// The unique ID to assign to this item. Mandatory for event pages. Cannot be
  /// the same as another ID for this extension.
  String? get id => _wrapped.id;
  set id(String? v) {
    _wrapped.id = v;
  }

  /// The text to display in the item; this is _required_ unless `type` is
  /// `separator`. When the context is `selection`, use `%s` within the string
  /// to show the selected text. For example, if this parameter's value is
  /// "Translate '%s' to Pig Latin" and the user selects the word "cool", the
  /// context menu item for the selection is "Translate 'cool' to Pig Latin".
  String? get title => _wrapped.title;
  set title(String? v) {
    _wrapped.title = v;
  }

  /// The initial state of a checkbox or radio button: `true` for selected,
  /// `false` for unselected. Only one radio button can be selected at a time in
  /// a given group.
  bool? get checked => _wrapped.checked;
  set checked(bool? v) {
    _wrapped.checked = v;
  }

  /// List of contexts this menu item will appear in. Defaults to `['page']`.
  List<ContextType>? get contexts => _wrapped.contexts?.toDart
      .cast<$js.ContextType>()
      .map((e) => ContextType.fromJS(e))
      .toList();
  set contexts(List<ContextType>? v) {
    _wrapped.contexts = v?.toJSArray((e) => e.toJS);
  }

  /// Whether the item is visible in the menu.
  bool? get visible => _wrapped.visible;
  set visible(bool? v) {
    _wrapped.visible = v;
  }

  /// A function that is called back when the menu item is clicked. Event pages
  /// cannot use this; instead, they should register a listener for
  /// [contextMenus.onClicked].
  Function? get onclick => ([Object? p1, Object? p2]) {
        return (_wrapped.onclick as JSAny? Function(JSAny?, JSAny?)?)
            ?.call(p1?.jsify(), p2?.jsify())
            ?.dartify();
      };
  set onclick(Function? v) {
    _wrapped.onclick = v?.let(allowInterop);
  }

  /// The ID of a parent menu item; this makes the item a child of a previously
  /// added item.
  Object? get parentId => _wrapped.parentId?.when(
        isInt: (v) => v,
        isString: (v) => v,
      );
  set parentId(Object? v) {
    _wrapped.parentId = switch (v) {
      int() => v,
      String() => v,
      null => null,
      _ => throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: int, String')
    };
  }

  /// Restricts the item to apply only to documents or frames whose URL matches
  /// one of the given patterns. For details on pattern formats, see [Match
  /// Patterns](match_patterns).
  List<String>? get documentUrlPatterns => _wrapped.documentUrlPatterns?.toDart
      .cast<String>()
      .map((e) => e)
      .toList();
  set documentUrlPatterns(List<String>? v) {
    _wrapped.documentUrlPatterns = v?.toJSArray((e) => e);
  }

  /// Similar to `documentUrlPatterns`, filters based on the `src` attribute of
  /// `img`, `audio`, and `video` tags and the `href` attribute of `a` tags.
  List<String>? get targetUrlPatterns =>
      _wrapped.targetUrlPatterns?.toDart.cast<String>().map((e) => e).toList();
  set targetUrlPatterns(List<String>? v) {
    _wrapped.targetUrlPatterns = v?.toJSArray((e) => e);
  }

  /// Whether this context menu item is enabled or disabled. Defaults to `true`.
  bool? get enabled => _wrapped.enabled;
  set enabled(bool? v) {
    _wrapped.enabled = v;
  }
}

class UpdateProperties {
  UpdateProperties.fromJS(this._wrapped);

  UpdateProperties({
    ItemType? type,
    String? title,
    bool? checked,
    List<ContextType>? contexts,

    /// Whether the item is visible in the menu.
    bool? visible,
    Function? onclick,

    /// The ID of the item to be made this item's parent. Note: You cannot set
    /// an item to become a child of its own descendant.
    Object? parentId,
    List<String>? documentUrlPatterns,
    List<String>? targetUrlPatterns,
    bool? enabled,
  }) : _wrapped = $js.UpdateProperties(
          type: type?.toJS,
          title: title,
          checked: checked,
          contexts: contexts?.toJSArray((e) => e.toJS),
          visible: visible,
          onclick: onclick?.let(allowInterop),
          parentId: switch (parentId) {
            int() => parentId,
            String() => parentId,
            null => null,
            _ => throw UnsupportedError(
                'Received type: ${parentId.runtimeType}. Supported types are: int, String')
          },
          documentUrlPatterns: documentUrlPatterns?.toJSArray((e) => e),
          targetUrlPatterns: targetUrlPatterns?.toJSArray((e) => e),
          enabled: enabled,
        );

  final $js.UpdateProperties _wrapped;

  $js.UpdateProperties get toJS => _wrapped;

  ItemType? get type => _wrapped.type?.let(ItemType.fromJS);
  set type(ItemType? v) {
    _wrapped.type = v?.toJS;
  }

  String? get title => _wrapped.title;
  set title(String? v) {
    _wrapped.title = v;
  }

  bool? get checked => _wrapped.checked;
  set checked(bool? v) {
    _wrapped.checked = v;
  }

  List<ContextType>? get contexts => _wrapped.contexts?.toDart
      .cast<$js.ContextType>()
      .map((e) => ContextType.fromJS(e))
      .toList();
  set contexts(List<ContextType>? v) {
    _wrapped.contexts = v?.toJSArray((e) => e.toJS);
  }

  /// Whether the item is visible in the menu.
  bool? get visible => _wrapped.visible;
  set visible(bool? v) {
    _wrapped.visible = v;
  }

  Function? get onclick => ([Object? p1, Object? p2]) {
        return (_wrapped.onclick as JSAny? Function(JSAny?, JSAny?)?)
            ?.call(p1?.jsify(), p2?.jsify())
            ?.dartify();
      };
  set onclick(Function? v) {
    _wrapped.onclick = v?.let(allowInterop);
  }

  /// The ID of the item to be made this item's parent. Note: You cannot set an
  /// item to become a child of its own descendant.
  Object? get parentId => _wrapped.parentId?.when(
        isInt: (v) => v,
        isString: (v) => v,
      );
  set parentId(Object? v) {
    _wrapped.parentId = switch (v) {
      int() => v,
      String() => v,
      null => null,
      _ => throw UnsupportedError(
          'Received type: ${v.runtimeType}. Supported types are: int, String')
    };
  }

  List<String>? get documentUrlPatterns => _wrapped.documentUrlPatterns?.toDart
      .cast<String>()
      .map((e) => e)
      .toList();
  set documentUrlPatterns(List<String>? v) {
    _wrapped.documentUrlPatterns = v?.toJSArray((e) => e);
  }

  List<String>? get targetUrlPatterns =>
      _wrapped.targetUrlPatterns?.toDart.cast<String>().map((e) => e).toList();
  set targetUrlPatterns(List<String>? v) {
    _wrapped.targetUrlPatterns = v?.toJSArray((e) => e);
  }

  bool? get enabled => _wrapped.enabled;
  set enabled(bool? v) {
    _wrapped.enabled = v;
  }
}

class OnClickedEvent {
  OnClickedEvent({
    required this.info,
    required this.tab,
  });

  /// Information about the item clicked and the context where the click
  /// happened.
  final OnClickData info;

  /// The details of the tab where the click took place. If the click did not
  /// take place in a tab, this parameter will be missing.
  final Tab? tab;
}
