// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSStorageExtension on JSChrome {
  @JS('storage')
  external JSStorage? get storageNullable;

  /// Use the `chrome.storage` API to store, retrieve, and track changes to user
  /// data.
  JSStorage get storage {
    var storageNullable = this.storageNullable;
    if (storageNullable == null) {
      throw ApiNotAvailableException('chrome.storage');
    }
    return storageNullable;
  }
}

@JS()
@staticInterop
class JSStorage {}

extension JSStorageExtension on JSStorage {
  /// Fired when one or more items change.
  external Event get onChanged;

  /// Items in the `sync` storage area are synced using Chrome Sync.
  external StorageSync get sync;

  /// Items in the `local` storage area are local to each machine.
  external StorageLocal get local;

  /// Items in the `managed` storage area are set by the domain administrator,
  /// and are read-only for the extension; trying to modify this namespace
  /// results in an error.
  external StorageArea get managed;

  /// Items in the `session` storage area are stored in-memory and will not be
  /// persisted to disk.
  external StorageSession get session;
}

/// The storage area's access level.
typedef AccessLevel = String;

@JS()
@staticInterop
@anonymous
class StorageChange {
  external factory StorageChange({
    /// The old value of the item, if there was an old value.
    JSAny? oldValue,

    /// The new value of the item, if there is a new value.
    JSAny? newValue,
  });
}

extension StorageChangeExtension on StorageChange {
  /// The old value of the item, if there was an old value.
  external JSAny? oldValue;

  /// The new value of the item, if there is a new value.
  external JSAny? newValue;
}

@JS()
@staticInterop
@anonymous
class StorageArea {
  external factory StorageArea();
}

extension StorageAreaExtension on StorageArea {
  /// Gets one or more items from storage.
  external JSPromise get(

      /// A single key to get, list of keys to get, or a dictionary specifying
      /// default values (see description of the object).  An empty list or object
      /// will return an empty result object.  Pass in `null` to get the entire
      /// contents of storage.
      Object? keys);

  /// Gets the amount of space (in bytes) being used by one or more items.
  external JSPromise getBytesInUse(

      /// A single key or list of keys to get the total usage for. An empty list
      /// will return 0. Pass in `null` to get the total usage of all of storage.
      Object? keys);

  /// Sets multiple items.
  external JSPromise set(

      /// An object which gives each key/value pair to update storage with. Any
      /// other key/value pairs in storage will not be affected.
      ///
      /// Primitive values such as numbers will serialize as expected. Values with
      /// a `typeof` `"object"` and `"function"` will typically serialize to `{}`,
      /// with the exception of `Array` (serializes as expected), `Date`, and
      /// `Regex` (serialize using their `String` representation).
      JSAny items);

  /// Removes one or more items from storage.
  external JSPromise remove(

      /// A single key or a list of keys for items to remove.
      Object keys);

  /// Removes all items from storage.
  external JSPromise clear();

  /// Sets the desired access level for the storage area. The default will be
  /// only trusted contexts.
  external JSPromise setAccessLevel(SetAccessLevelAccessOptions accessOptions);

  /// Fired when one or more items change.
  external Event get onChanged;
}

@JS()
@staticInterop
@anonymous
class StorageSync extends StorageArea {
  external factory StorageSync({
    /// The maximum total amount (in bytes) of data that can be stored in sync
    /// storage, as measured by the JSON stringification of every value plus every
    /// key's length. Updates that would cause this limit to be exceeded fail
    /// immediately and set [runtime.lastError].
    int QUOTA_BYTES,

    /// The maximum size (in bytes) of each individual item in sync storage, as
    /// measured by the JSON stringification of its value plus its key length.
    /// Updates containing items larger than this limit will fail immediately and
    /// set [runtime.lastError].
    int QUOTA_BYTES_PER_ITEM,

    /// The maximum number of items that can be stored in sync storage. Updates
    /// that would cause this limit to be exceeded will fail immediately and set
    /// [runtime.lastError].
    int MAX_ITEMS,

    /// The maximum number of `set`, `remove`, or `clear` operations that can be
    /// performed each hour. This is 1 every 2 seconds, a lower ceiling than the
    /// short term higher writes-per-minute limit.
    ///
    /// Updates that would cause this limit to be exceeded fail immediately and
    /// set [runtime.lastError].
    int MAX_WRITE_OPERATIONS_PER_HOUR,

    /// The maximum number of `set`, `remove`, or `clear` operations that can be
    /// performed each minute. This is 2 per second, providing higher throughput
    /// than writes-per-hour over a shorter period of time.
    ///
    /// Updates that would cause this limit to be exceeded fail immediately and
    /// set [runtime.lastError].
    int MAX_WRITE_OPERATIONS_PER_MINUTE,
    int MAX_SUSTAINED_WRITE_OPERATIONS_PER_MINUTE,
  });
}

extension StorageSyncExtension on StorageSync {
  /// The maximum total amount (in bytes) of data that can be stored in sync
  /// storage, as measured by the JSON stringification of every value plus every
  /// key's length. Updates that would cause this limit to be exceeded fail
  /// immediately and set [runtime.lastError].
  external int QUOTA_BYTES;

  /// The maximum size (in bytes) of each individual item in sync storage, as
  /// measured by the JSON stringification of its value plus its key length.
  /// Updates containing items larger than this limit will fail immediately and
  /// set [runtime.lastError].
  external int QUOTA_BYTES_PER_ITEM;

  /// The maximum number of items that can be stored in sync storage. Updates
  /// that would cause this limit to be exceeded will fail immediately and set
  /// [runtime.lastError].
  external int MAX_ITEMS;

  /// The maximum number of `set`, `remove`, or `clear` operations that can be
  /// performed each hour. This is 1 every 2 seconds, a lower ceiling than the
  /// short term higher writes-per-minute limit.
  ///
  /// Updates that would cause this limit to be exceeded fail immediately and
  /// set [runtime.lastError].
  external int MAX_WRITE_OPERATIONS_PER_HOUR;

  /// The maximum number of `set`, `remove`, or `clear` operations that can be
  /// performed each minute. This is 2 per second, providing higher throughput
  /// than writes-per-hour over a shorter period of time.
  ///
  /// Updates that would cause this limit to be exceeded fail immediately and
  /// set [runtime.lastError].
  external int MAX_WRITE_OPERATIONS_PER_MINUTE;

  external int MAX_SUSTAINED_WRITE_OPERATIONS_PER_MINUTE;
}

@JS()
@staticInterop
@anonymous
class StorageLocal extends StorageArea {
  external factory StorageLocal(
      {
      /// The maximum amount (in bytes) of data that can be stored in local storage,
      /// as measured by the JSON stringification of every value plus every key's
      /// length. This value will be ignored if the extension has the
      /// `unlimitedStorage` permission. Updates that would cause this limit to be
      /// exceeded fail immediately and set [runtime.lastError].
      int QUOTA_BYTES});
}

extension StorageLocalExtension on StorageLocal {
  /// The maximum amount (in bytes) of data that can be stored in local storage,
  /// as measured by the JSON stringification of every value plus every key's
  /// length. This value will be ignored if the extension has the
  /// `unlimitedStorage` permission. Updates that would cause this limit to be
  /// exceeded fail immediately and set [runtime.lastError].
  external int QUOTA_BYTES;
}

@JS()
@staticInterop
@anonymous
class StorageSession extends StorageArea {
  external factory StorageSession(
      {
      /// The maximum amount (in bytes) of data that can be stored in memory, as
      /// measured by estimating the dynamically allocated memory usage of every
      /// value and key. Updates that would cause this limit to be exceeded fail
      /// immediately and set [runtime.lastError].
      int QUOTA_BYTES});
}

extension StorageSessionExtension on StorageSession {
  /// The maximum amount (in bytes) of data that can be stored in memory, as
  /// measured by estimating the dynamically allocated memory usage of every
  /// value and key. Updates that would cause this limit to be exceeded fail
  /// immediately and set [runtime.lastError].
  external int QUOTA_BYTES;
}

@JS()
@staticInterop
@anonymous
class SetAccessLevelAccessOptions {
  external factory SetAccessLevelAccessOptions(
      {
      /// The access level of the storage area.
      AccessLevel accessLevel});
}

extension SetAccessLevelAccessOptionsExtension on SetAccessLevelAccessOptions {
  /// The access level of the storage area.
  external AccessLevel accessLevel;
}
