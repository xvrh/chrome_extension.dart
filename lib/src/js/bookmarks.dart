// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import
// ignore_for_file: unintended_html_in_doc_comment

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSBookmarksExtension on JSChrome {
  @JS('bookmarks')
  external JSBookmarks? get bookmarksNullable;

  /// Use the `chrome.bookmarks` API to create, organize, and otherwise
  /// manipulate bookmarks. Also see [Override Pages](override), which you can
  /// use to create a custom Bookmark Manager page.
  JSBookmarks get bookmarks {
    var bookmarksNullable = this.bookmarksNullable;
    if (bookmarksNullable == null) {
      throw ApiNotAvailableException('chrome.bookmarks');
    }
    return bookmarksNullable;
  }
}

extension type JSBookmarks._(JSObject _) {
  /// Retrieves the specified BookmarkTreeNode(s).
  external JSPromise<JSArray> get(

      /// A single string-valued id, or an array of string-valued ids
      JSAny idOrIdList);

  /// Retrieves the children of the specified BookmarkTreeNode id.
  external JSPromise<JSArray> getChildren(String id);

  /// Retrieves the recently added bookmarks.
  external JSPromise<JSArray> getRecent(

      /// The maximum number of items to return.
      int numberOfItems);

  /// Retrieves the entire Bookmarks hierarchy.
  external JSPromise<JSArray> getTree();

  /// Retrieves part of the Bookmarks hierarchy, starting at the specified node.
  external JSPromise<JSArray> getSubTree(

      /// The ID of the root of the subtree to retrieve.
      String id);

  /// Searches for BookmarkTreeNodes matching the given query. Queries specified
  /// with an object produce BookmarkTreeNodes matching all specified
  /// properties.
  external JSPromise<JSArray> search(

      /// Either a string of words and quoted phrases that are matched against
      /// bookmark URLs and titles, or an object. If an object, the properties
      /// `query`, `url`, and `title` may be specified and bookmarks matching all
      /// specified properties will be produced.
      JSAny query);

  /// Creates a bookmark or folder under the specified parentId.  If url is NULL
  /// or missing, it will be a folder.
  external JSPromise<BookmarkTreeNode> create(CreateDetails bookmark);

  /// Moves the specified BookmarkTreeNode to the provided location.
  external JSPromise<BookmarkTreeNode> move(
    String id,
    MoveDestination destination,
  );

  /// Updates the properties of a bookmark or folder. Specify only the
  /// properties that you want to change; unspecified properties will be left
  /// unchanged.  **Note:** Currently, only 'title' and 'url' are supported.
  external JSPromise<BookmarkTreeNode> update(
    String id,
    UpdateChanges changes,
  );

  /// Removes a bookmark or an empty bookmark folder.
  external JSPromise remove(String id);

  /// Recursively removes a bookmark folder.
  external JSPromise removeTree(String id);

  /// Fired when a bookmark or folder is created.
  external Event get onCreated;

  /// Fired when a bookmark or folder is removed.  When a folder is removed
  /// recursively, a single notification is fired for the folder, and none for
  /// its contents.
  external Event get onRemoved;

  /// Fired when a bookmark or folder changes.  **Note:** Currently, only title
  /// and url changes trigger this.
  external Event get onChanged;

  /// Fired when a bookmark or folder is moved to a different parent folder.
  external Event get onMoved;

  /// Fired when the children of a folder have changed their order due to the
  /// order being sorted in the UI.  This is not called as a result of a move().
  external Event get onChildrenReordered;

  /// Fired when a bookmark import session is begun.  Expensive observers should
  /// ignore onCreated updates until onImportEnded is fired.  Observers should
  /// still handle other notifications immediately.
  external Event get onImportBegan;

  /// Fired when a bookmark import session is ended.
  external Event get onImportEnded;

  external int get MAX_WRITE_OPERATIONS_PER_HOUR;

  external int get MAX_SUSTAINED_WRITE_OPERATIONS_PER_MINUTE;

  /// The `id` associated with the root level node.
  external String get ROOT_NODE_ID;
}

/// Indicates the type of folder.
typedef FolderType = JSString;

/// Indicates the reason why this node is unmodifiable. The [managed] value
/// indicates that this node was configured by the system administrator. Omitted
/// if the node can be modified by the user and the extension (default).
typedef BookmarkTreeNodeUnmodifiable = JSString;
extension type BookmarkTreeNode._(JSObject _) implements JSObject {
  external factory BookmarkTreeNode({
    /// The unique identifier for the node. IDs are unique within the current
    /// profile, and they remain valid even after the browser is restarted.
    String id,

    /// The `id` of the parent folder.  Omitted for the root node.
    String? parentId,

    /// The 0-based position of this node within its parent folder.
    int? index,

    /// The URL navigated to when a user clicks the bookmark. Omitted for folders.
    String? url,

    /// The text displayed for the node.
    String title,

    /// When this node was created, in milliseconds since the epoch (`new
    /// Date(dateAdded)`).
    double? dateAdded,

    /// When this node was last opened, in milliseconds since the epoch. Not set
    /// for folders.
    double? dateLastUsed,

    /// When the contents of this folder last changed, in milliseconds since the
    /// epoch.
    double? dateGroupModified,

    /// If present, this is a folder that is added by the browser and that cannot
    /// be modified by the user or the extension. Child nodes may be modified, if
    /// this node does not have the `unmodifiable` property set. Omitted if the
    /// node can be modified by the user and the extension (default).There may be
    /// zero, one or multiple nodes of each folder type. A folder may be added or
    /// removed by the browser, but not via the extensions API.
    FolderType? folderType,

    /// Indicates the reason why this node is unmodifiable. The [managed] value
    /// indicates that this node was configured by the system administrator or by
    /// the custodian of a supervised user. Omitted if the node can be modified by
    /// the user and the extension (default).
    BookmarkTreeNodeUnmodifiable? unmodifiable,

    /// Whether this node is synced with the user's remote account storage by the
    /// browser. This can be used to distinguish between account and local-only
    /// versions of the same [FolderType]. The value of this property may change
    /// for an existing node, for example as a result of user action.Note: this
    /// reflects whether the node is saved to the browser's built-in account
    /// provider. It is possible that a node could be synced via a third-party,
    /// even if this value is false.
    ///
    /// For managed nodes (nodes where `unmodifiable` is set to `true`), this
    /// property will always be `false`.
    bool syncing,

    /// An ordered list of children of this node.
    JSArray? children,
  });

  /// The unique identifier for the node. IDs are unique within the current
  /// profile, and they remain valid even after the browser is restarted.
  external String id;

  /// The `id` of the parent folder.  Omitted for the root node.
  external String? parentId;

  /// The 0-based position of this node within its parent folder.
  external int? index;

  /// The URL navigated to when a user clicks the bookmark. Omitted for folders.
  external String? url;

  /// The text displayed for the node.
  external String title;

  /// When this node was created, in milliseconds since the epoch (`new
  /// Date(dateAdded)`).
  external double? dateAdded;

  /// When this node was last opened, in milliseconds since the epoch. Not set
  /// for folders.
  external double? dateLastUsed;

  /// When the contents of this folder last changed, in milliseconds since the
  /// epoch.
  external double? dateGroupModified;

  /// If present, this is a folder that is added by the browser and that cannot
  /// be modified by the user or the extension. Child nodes may be modified, if
  /// this node does not have the `unmodifiable` property set. Omitted if the
  /// node can be modified by the user and the extension (default).There may be
  /// zero, one or multiple nodes of each folder type. A folder may be added or
  /// removed by the browser, but not via the extensions API.
  external FolderType? folderType;

  /// Indicates the reason why this node is unmodifiable. The [managed] value
  /// indicates that this node was configured by the system administrator or by
  /// the custodian of a supervised user. Omitted if the node can be modified by
  /// the user and the extension (default).
  external BookmarkTreeNodeUnmodifiable? unmodifiable;

  /// Whether this node is synced with the user's remote account storage by the
  /// browser. This can be used to distinguish between account and local-only
  /// versions of the same [FolderType]. The value of this property may change
  /// for an existing node, for example as a result of user action.Note: this
  /// reflects whether the node is saved to the browser's built-in account
  /// provider. It is possible that a node could be synced via a third-party,
  /// even if this value is false.
  ///
  /// For managed nodes (nodes where `unmodifiable` is set to `true`), this
  /// property will always be `false`.
  external bool syncing;

  /// An ordered list of children of this node.
  external JSArray? children;
}
extension type CreateDetails._(JSObject _) implements JSObject {
  external factory CreateDetails({
    /// Defaults to the Other Bookmarks folder.
    String? parentId,
    int? index,
    String? title,
    String? url,
  });

  /// Defaults to the Other Bookmarks folder.
  external String? parentId;

  external int? index;

  external String? title;

  external String? url;
}
extension type OnRemovedRemoveInfo._(JSObject _) implements JSObject {
  external factory OnRemovedRemoveInfo({
    String parentId,
    int index,
    BookmarkTreeNode node,
  });

  external String parentId;

  external int index;

  external BookmarkTreeNode node;
}
extension type OnChangedChangeInfo._(JSObject _) implements JSObject {
  external factory OnChangedChangeInfo({
    String title,
    String? url,
  });

  external String title;

  external String? url;
}
extension type OnMovedMoveInfo._(JSObject _) implements JSObject {
  external factory OnMovedMoveInfo({
    String parentId,
    int index,
    String oldParentId,
    int oldIndex,
  });

  external String parentId;

  external int index;

  external String oldParentId;

  external int oldIndex;
}
extension type OnChildrenReorderedReorderInfo._(JSObject _)
    implements JSObject {
  external factory OnChildrenReorderedReorderInfo({JSArray childIds});

  external JSArray childIds;
}
extension type SearchQuery._(JSObject _) implements JSObject {
  external factory SearchQuery({
    /// A string of words and quoted phrases that are matched against bookmark
    /// URLs and titles.
    String? query,

    /// The URL of the bookmark; matches verbatim. Note that folders have no URL.
    String? url,

    /// The title of the bookmark; matches verbatim.
    String? title,
  });

  /// A string of words and quoted phrases that are matched against bookmark
  /// URLs and titles.
  external String? query;

  /// The URL of the bookmark; matches verbatim. Note that folders have no URL.
  external String? url;

  /// The title of the bookmark; matches verbatim.
  external String? title;
}
extension type MoveDestination._(JSObject _) implements JSObject {
  external factory MoveDestination({
    String? parentId,
    int? index,
  });

  external String? parentId;

  external int? index;
}
extension type UpdateChanges._(JSObject _) implements JSObject {
  external factory UpdateChanges({
    String? title,
    String? url,
  });

  external String? title;

  external String? url;
}
