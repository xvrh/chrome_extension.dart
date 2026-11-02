// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'src/internal_helpers.dart';
import 'src/js/reading_list.dart' as $js;

export 'src/chrome.dart' show chrome, EventStream;

final _readingList = ChromeReadingList._();

extension ChromeReadingListExtension on Chrome {
  /// Use the `chrome.readingList` API to read from and modify
  /// the items in the
  /// [Reading List](https://support.google.com/chrome/answer/7343019).
  ChromeReadingList get readingList => _readingList;
}

class ChromeReadingList {
  ChromeReadingList._();

  bool get isAvailable => $js.chrome.readingListNullable != null && alwaysTrue;

  /// Adds an entry to the reading list if it does not exist.
  /// |entry|: The entry to add to the reading list.
  /// |Returns|: Resolves once the entry has been added.
  Future<void> addEntry(AddEntryOptions entry) async {
    await $js.chrome.readingList.addEntry(entry.toJS).toDart;
  }

  /// Removes an entry from the reading list if it exists.
  /// |info|: The entry to remove from the reading list.
  /// |Returns|: Resolves once the entry has been removed.
  Future<void> removeEntry(RemoveOptions info) async {
    await $js.chrome.readingList.removeEntry(info.toJS).toDart;
  }

  /// Updates a reading list entry if it exists.
  /// |info|: The entry to update.
  /// |Returns|: Resolves once the matched entries have been updated.
  Future<void> updateEntry(UpdateEntryOptions info) async {
    await $js.chrome.readingList.updateEntry(info.toJS).toDart;
  }

  /// Retrieves all entries that match the `QueryInfo` properties.
  /// Properties that are not provided will not be matched.
  /// |info|: The properties to search for.
  /// |Returns|: Resolves once the entries have been matched.
  Future<List<ReadingListEntry>> query(QueryInfo info) async {
    var $res = await $js.chrome.readingList.query(info.toJS).toDart;
    return $res.toDart
        .cast<$js.ReadingListEntry>()
        .map((e) => ReadingListEntry.fromJS(e))
        .toList();
  }

  /// Triggered when a `ReadingListEntry` is added to the reading
  /// list.
  EventStream<ReadingListEntry> get onEntryAdded =>
      $js.chrome.readingList.onEntryAdded
          .asStream(($c) => ($js.ReadingListEntry entry) {
                return $c(ReadingListEntry.fromJS(entry));
              }.toJS);

  /// Triggered when a `ReadingListEntry` is removed from the reading
  /// list.
  EventStream<ReadingListEntry> get onEntryRemoved =>
      $js.chrome.readingList.onEntryRemoved
          .asStream(($c) => ($js.ReadingListEntry entry) {
                return $c(ReadingListEntry.fromJS(entry));
              }.toJS);

  /// Triggered when a `ReadingListEntry` is updated in the reading
  /// list.
  EventStream<ReadingListEntry> get onEntryUpdated =>
      $js.chrome.readingList.onEntryUpdated
          .asStream(($c) => ($js.ReadingListEntry entry) {
                return $c(ReadingListEntry.fromJS(entry));
              }.toJS);
}

class ReadingListEntry {
  ReadingListEntry.fromJS(this._wrapped);

  ReadingListEntry({
    /// The url of the entry.
    required String url,

    /// The title of the entry.
    required String title,

    /// Will be `true` if the entry has been read.
    required bool hasBeenRead,

    /// The last time the entry was updated.
    /// This value is in milliseconds since Jan 1, 1970.
    required double lastUpdateTime,

    /// The time the entry was created.
    /// Recorded in milliseconds since Jan 1, 1970.
    required double creationTime,
  }) : _wrapped = $js.ReadingListEntry(
          url: url,
          title: title,
          hasBeenRead: hasBeenRead,
          lastUpdateTime: lastUpdateTime,
          creationTime: creationTime,
        );

  final $js.ReadingListEntry _wrapped;

  $js.ReadingListEntry get toJS => _wrapped;

  /// The url of the entry.
  String get url => _wrapped.url;

  set url(String v) {
    _wrapped.url = v;
  }

  /// The title of the entry.
  String get title => _wrapped.title;

  set title(String v) {
    _wrapped.title = v;
  }

  /// Will be `true` if the entry has been read.
  bool get hasBeenRead => _wrapped.hasBeenRead;

  set hasBeenRead(bool v) {
    _wrapped.hasBeenRead = v;
  }

  /// The last time the entry was updated.
  /// This value is in milliseconds since Jan 1, 1970.
  double get lastUpdateTime => _wrapped.lastUpdateTime;

  set lastUpdateTime(double v) {
    _wrapped.lastUpdateTime = v;
  }

  /// The time the entry was created.
  /// Recorded in milliseconds since Jan 1, 1970.
  double get creationTime => _wrapped.creationTime;

  set creationTime(double v) {
    _wrapped.creationTime = v;
  }
}

class AddEntryOptions {
  AddEntryOptions.fromJS(this._wrapped);

  AddEntryOptions({
    /// The url of the entry.
    required String url,

    /// The title of the entry.
    required String title,

    /// Will be `true` if the entry has been read.
    required bool hasBeenRead,
  }) : _wrapped = $js.AddEntryOptions(
          url: url,
          title: title,
          hasBeenRead: hasBeenRead,
        );

  final $js.AddEntryOptions _wrapped;

  $js.AddEntryOptions get toJS => _wrapped;

  /// The url of the entry.
  String get url => _wrapped.url;

  set url(String v) {
    _wrapped.url = v;
  }

  /// The title of the entry.
  String get title => _wrapped.title;

  set title(String v) {
    _wrapped.title = v;
  }

  /// Will be `true` if the entry has been read.
  bool get hasBeenRead => _wrapped.hasBeenRead;

  set hasBeenRead(bool v) {
    _wrapped.hasBeenRead = v;
  }
}

class RemoveOptions {
  RemoveOptions.fromJS(this._wrapped);

  RemoveOptions(
      {
      /// The url to remove.
      required String url})
      : _wrapped = $js.RemoveOptions(url: url);

  final $js.RemoveOptions _wrapped;

  $js.RemoveOptions get toJS => _wrapped;

  /// The url to remove.
  String get url => _wrapped.url;

  set url(String v) {
    _wrapped.url = v;
  }
}

class UpdateEntryOptions {
  UpdateEntryOptions.fromJS(this._wrapped);

  UpdateEntryOptions({
    /// The url that will be updated.
    required String url,

    /// The new title. The existing tile remains if a value isn't provided.
    String? title,

    /// The updated read status. The existing status remains if a value
    /// isn't provided.
    bool? hasBeenRead,
  }) : _wrapped = $js.UpdateEntryOptions(
          url: url,
          title: title,
          hasBeenRead: hasBeenRead,
        );

  final $js.UpdateEntryOptions _wrapped;

  $js.UpdateEntryOptions get toJS => _wrapped;

  /// The url that will be updated.
  String get url => _wrapped.url;

  set url(String v) {
    _wrapped.url = v;
  }

  /// The new title. The existing tile remains if a value isn't provided.
  String? get title => _wrapped.title;

  set title(String? v) {
    _wrapped.title = v;
  }

  /// The updated read status. The existing status remains if a value
  /// isn't provided.
  bool? get hasBeenRead => _wrapped.hasBeenRead;

  set hasBeenRead(bool? v) {
    _wrapped.hasBeenRead = v;
  }
}

class QueryInfo {
  QueryInfo.fromJS(this._wrapped);

  QueryInfo({
    /// A url to search for.
    String? url,

    /// A title to search for.
    String? title,

    /// Indicates whether to search for read (`true`) or unread
    /// (`false`) items.
    bool? hasBeenRead,
  }) : _wrapped = $js.QueryInfo(
          url: url,
          title: title,
          hasBeenRead: hasBeenRead,
        );

  final $js.QueryInfo _wrapped;

  $js.QueryInfo get toJS => _wrapped;

  /// A url to search for.
  String? get url => _wrapped.url;

  set url(String? v) {
    _wrapped.url = v;
  }

  /// A title to search for.
  String? get title => _wrapped.title;

  set title(String? v) {
    _wrapped.title = v;
  }

  /// Indicates whether to search for read (`true`) or unread
  /// (`false`) items.
  bool? get hasBeenRead => _wrapped.hasBeenRead;

  set hasBeenRead(bool? v) {
    _wrapped.hasBeenRead = v;
  }
}
