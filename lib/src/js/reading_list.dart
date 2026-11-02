// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import
// ignore_for_file: unintended_html_in_doc_comment

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSReadingListExtension on JSChrome {
  @JS('readingList')
  external JSReadingList? get readingListNullable;

  /// Use the `chrome.readingList` API to read from and modify
  /// the items in the
  /// [Reading List](https://support.google.com/chrome/answer/7343019).
  JSReadingList get readingList {
    var readingListNullable = this.readingListNullable;
    if (readingListNullable == null) {
      throw ApiNotAvailableException('chrome.readingList');
    }
    return readingListNullable;
  }
}

extension type JSReadingList._(JSObject _) {
  /// Adds an entry to the reading list if it does not exist.
  /// |entry|: The entry to add to the reading list.
  /// |Returns|: Resolves once the entry has been added.
  external JSPromise addEntry(AddEntryOptions entry);

  /// Removes an entry from the reading list if it exists.
  /// |info|: The entry to remove from the reading list.
  /// |Returns|: Resolves once the entry has been removed.
  external JSPromise removeEntry(RemoveOptions info);

  /// Updates a reading list entry if it exists.
  /// |info|: The entry to update.
  /// |Returns|: Resolves once the matched entries have been updated.
  external JSPromise updateEntry(UpdateEntryOptions info);

  /// Retrieves all entries that match the `QueryInfo` properties.
  /// Properties that are not provided will not be matched.
  /// |info|: The properties to search for.
  /// |Returns|: Resolves once the entries have been matched.
  external JSPromise<JSArray> query(QueryInfo info);

  /// Triggered when a `ReadingListEntry` is added to the reading
  /// list.
  external Event get onEntryAdded;

  /// Triggered when a `ReadingListEntry` is removed from the reading
  /// list.
  external Event get onEntryRemoved;

  /// Triggered when a `ReadingListEntry` is updated in the reading
  /// list.
  external Event get onEntryUpdated;
}
extension type ReadingListEntry._(JSObject _) implements JSObject {
  external factory ReadingListEntry({
    /// The url of the entry.
    String url,

    /// The title of the entry.
    String title,

    /// Will be `true` if the entry has been read.
    bool hasBeenRead,

    /// The last time the entry was updated.
    /// This value is in milliseconds since Jan 1, 1970.
    double lastUpdateTime,

    /// The time the entry was created.
    /// Recorded in milliseconds since Jan 1, 1970.
    double creationTime,
  });

  /// The url of the entry.
  external String url;

  /// The title of the entry.
  external String title;

  /// Will be `true` if the entry has been read.
  external bool hasBeenRead;

  /// The last time the entry was updated.
  /// This value is in milliseconds since Jan 1, 1970.
  external double lastUpdateTime;

  /// The time the entry was created.
  /// Recorded in milliseconds since Jan 1, 1970.
  external double creationTime;
}
extension type AddEntryOptions._(JSObject _) implements JSObject {
  external factory AddEntryOptions({
    /// The url of the entry.
    String url,

    /// The title of the entry.
    String title,

    /// Will be `true` if the entry has been read.
    bool hasBeenRead,
  });

  /// The url of the entry.
  external String url;

  /// The title of the entry.
  external String title;

  /// Will be `true` if the entry has been read.
  external bool hasBeenRead;
}
extension type RemoveOptions._(JSObject _) implements JSObject {
  external factory RemoveOptions(
      {
      /// The url to remove.
      String url});

  /// The url to remove.
  external String url;
}
extension type UpdateEntryOptions._(JSObject _) implements JSObject {
  external factory UpdateEntryOptions({
    /// The url that will be updated.
    String url,

    /// The new title. The existing tile remains if a value isn't provided.
    String? title,

    /// The updated read status. The existing status remains if a value
    /// isn't provided.
    bool? hasBeenRead,
  });

  /// The url that will be updated.
  external String url;

  /// The new title. The existing tile remains if a value isn't provided.
  external String? title;

  /// The updated read status. The existing status remains if a value
  /// isn't provided.
  external bool? hasBeenRead;
}
extension type QueryInfo._(JSObject _) implements JSObject {
  external factory QueryInfo({
    /// A url to search for.
    String? url,

    /// A title to search for.
    String? title,

    /// Indicates whether to search for read (`true`) or unread
    /// (`false`) items.
    bool? hasBeenRead,
  });

  /// A url to search for.
  external String? url;

  /// A title to search for.
  external String? title;

  /// Indicates whether to search for read (`true`) or unread
  /// (`false`) items.
  external bool? hasBeenRead;
}
