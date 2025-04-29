// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'src/internal_helpers.dart';
import 'src/js/tab_groups.dart' as $js;

export 'src/chrome.dart' show chrome, EventStream;

final _tabGroups = ChromeTabGroups._();

extension ChromeTabGroupsExtension on Chrome {
  /// Use the `chrome.tabGroups` API to interact with the browser's tab grouping
  /// system. You can use this API to modify and rearrange tab groups in the
  /// browser. To group and ungroup tabs, or to query what tabs are in groups,
  /// use the `chrome.tabs` API.
  ChromeTabGroups get tabGroups => _tabGroups;
}

class ChromeTabGroups {
  ChromeTabGroups._();

  bool get isAvailable => $js.chrome.tabGroupsNullable != null && alwaysTrue;

  /// Retrieves details about the specified group.
  Future<TabGroup> get(int groupId) async {
    var $res = await $js.chrome.tabGroups.get(groupId).toDart;
    return TabGroup.fromJS($res! as $js.TabGroup);
  }

  /// Gets all groups that have the specified properties, or all groups if no
  /// properties are specified.
  Future<List<TabGroup>> query(QueryInfo queryInfo) async {
    var $res = await $js.chrome.tabGroups.query(queryInfo.toJS).toDart;
    final dartified = $res.dartify() as List? ?? [];
    return dartified
        .map<TabGroup>((e) => TabGroup.fromJS(e as $js.TabGroup))
        .toList();
  }

  /// Modifies the properties of a group. Properties that are not specified in
  /// [updateProperties] are not modified.
  /// [groupId] The ID of the group to modify.
  Future<TabGroup?> update(
    int groupId,
    UpdateProperties updateProperties,
  ) async {
    var $res =
        await $js.chrome.tabGroups
            .update(groupId, updateProperties.toJS)
            .toDart;
    return ($res as $js.TabGroup?)?.let(TabGroup.fromJS);
  }

  /// Moves the group and all its tabs within its window, or to a new window.
  /// [groupId] The ID of the group to move.
  Future<TabGroup?> move(int groupId, MoveProperties moveProperties) async {
    var $res =
        await $js.chrome.tabGroups.move(groupId, moveProperties.toJS).toDart;
    return ($res as $js.TabGroup?)?.let(TabGroup.fromJS);
  }

  /// An ID that represents the absence of a group.
  int get tabGroupIdNone => $js.chrome.tabGroups.TAB_GROUP_ID_NONE;

  /// Fired when a group is created.
  EventStream<TabGroup> get onCreated =>
      $js.chrome.tabGroups.onCreated.asStream(
        ($c) =>
            ($js.TabGroup group) {
              return $c(TabGroup.fromJS(group));
            }.toJS,
      );

  /// Fired when a group is updated.
  EventStream<TabGroup> get onUpdated =>
      $js.chrome.tabGroups.onUpdated.asStream(
        ($c) =>
            ($js.TabGroup group) {
              return $c(TabGroup.fromJS(group));
            }.toJS,
      );

  /// Fired when a group is moved within a window. Move events are still fired
  /// for the individual tabs within the group, as well as for the group itself.
  /// This event is not fired when a group is moved between windows; instead, it
  /// will be removed from one window and created in another.
  EventStream<TabGroup> get onMoved => $js.chrome.tabGroups.onMoved.asStream(
    ($c) =>
        ($js.TabGroup group) {
          return $c(TabGroup.fromJS(group));
        }.toJS,
  );

  /// Fired when a group is closed, either directly by the user or automatically
  /// because it contained zero tabs.
  EventStream<TabGroup> get onRemoved =>
      $js.chrome.tabGroups.onRemoved.asStream(
        ($c) =>
            ($js.TabGroup group) {
              return $c(TabGroup.fromJS(group));
            }.toJS,
      );
}

/// The group's color.
enum Color {
  grey('grey'),
  blue('blue'),
  red('red'),
  yellow('yellow'),
  green('green'),
  pink('pink'),
  purple('purple'),
  cyan('cyan'),
  orange('orange');

  const Color(this.value);

  final String value;

  JSString get toJS => value.toJS;
  static Color fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

class TabGroup {
  TabGroup.fromJS(this._wrapped);

  TabGroup({
    /// The ID of the group. Group IDs are unique within a browser session.
    required int id,

    /// Whether the group is collapsed. A collapsed group is one whose tabs are
    /// hidden.
    required bool collapsed,

    /// The group's color.
    required Color color,

    /// The title of the group.
    String? title,

    /// The ID of the window that contains the group.
    required int windowId,
  }) : _wrapped = $js.TabGroup(
         id: id,
         collapsed: collapsed,
         color: color.toJS,
         title: title,
         windowId: windowId,
       );

  final $js.TabGroup _wrapped;

  $js.TabGroup get toJS => _wrapped;

  /// The ID of the group. Group IDs are unique within a browser session.
  int get id => _wrapped.id;

  set id(int v) {
    _wrapped.id = v;
  }

  /// Whether the group is collapsed. A collapsed group is one whose tabs are
  /// hidden.
  bool get collapsed => _wrapped.collapsed;

  set collapsed(bool v) {
    _wrapped.collapsed = v;
  }

  /// The group's color.
  Color get color => Color.fromJS(_wrapped.color);

  set color(Color v) {
    _wrapped.color = v.toJS;
  }

  /// The title of the group.
  String? get title => _wrapped.title;

  set title(String? v) {
    _wrapped.title = v;
  }

  /// The ID of the window that contains the group.
  int get windowId => _wrapped.windowId;

  set windowId(int v) {
    _wrapped.windowId = v;
  }
}

class QueryInfo {
  QueryInfo.fromJS(this._wrapped);

  QueryInfo({
    /// Whether the groups are collapsed.
    bool? collapsed,

    /// The color of the groups.
    Color? color,

    /// Match group titles against a pattern.
    String? title,

    /// The ID of the parent window, or [windows.WINDOW_ID_CURRENT] for the
    /// [current window](windows#current-window).
    int? windowId,
  }) : _wrapped = $js.QueryInfo(
         collapsed: collapsed,
         color: color?.toJS,
         title: title,
         windowId: windowId,
       );

  final $js.QueryInfo _wrapped;

  $js.QueryInfo get toJS => _wrapped;

  /// Whether the groups are collapsed.
  bool? get collapsed => _wrapped.collapsed;

  set collapsed(bool? v) {
    _wrapped.collapsed = v;
  }

  /// The color of the groups.
  Color? get color => _wrapped.color?.let(Color.fromJS);

  set color(Color? v) {
    _wrapped.color = v?.toJS;
  }

  /// Match group titles against a pattern.
  String? get title => _wrapped.title;

  set title(String? v) {
    _wrapped.title = v;
  }

  /// The ID of the parent window, or [windows.WINDOW_ID_CURRENT] for the
  /// [current window](windows#current-window).
  int? get windowId => _wrapped.windowId;

  set windowId(int? v) {
    _wrapped.windowId = v;
  }
}

class UpdateProperties {
  UpdateProperties.fromJS(this._wrapped);

  UpdateProperties({
    /// Whether the group should be collapsed.
    bool? collapsed,

    /// The color of the group.
    Color? color,

    /// The title of the group.
    String? title,
  }) : _wrapped = $js.UpdateProperties(
         collapsed: collapsed,
         color: color?.toJS,
         title: title,
       );

  final $js.UpdateProperties _wrapped;

  $js.UpdateProperties get toJS => _wrapped;

  /// Whether the group should be collapsed.
  bool? get collapsed => _wrapped.collapsed;

  set collapsed(bool? v) {
    _wrapped.collapsed = v;
  }

  /// The color of the group.
  Color? get color => _wrapped.color?.let(Color.fromJS);

  set color(Color? v) {
    _wrapped.color = v?.toJS;
  }

  /// The title of the group.
  String? get title => _wrapped.title;

  set title(String? v) {
    _wrapped.title = v;
  }
}

class MoveProperties {
  MoveProperties.fromJS(this._wrapped);

  MoveProperties({
    /// The window to move the group to. Defaults to the window the group is
    /// currently in. Note that groups can only be moved to and from windows
    /// with [windows.WindowType] type `"normal"`.
    int? windowId,

    /// The position to move the group to. Use `-1` to place the group at the
    /// end of the window.
    required int index,
  }) : _wrapped = $js.MoveProperties(windowId: windowId, index: index);

  final $js.MoveProperties _wrapped;

  $js.MoveProperties get toJS => _wrapped;

  /// The window to move the group to. Defaults to the window the group is
  /// currently in. Note that groups can only be moved to and from windows with
  /// [windows.WindowType] type `"normal"`.
  int? get windowId => _wrapped.windowId;

  set windowId(int? v) {
    _wrapped.windowId = v;
  }

  /// The position to move the group to. Use `-1` to place the group at the end
  /// of the window.
  int get index => _wrapped.index;

  set index(int v) {
    _wrapped.index = v;
  }
}
