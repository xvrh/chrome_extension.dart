// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/storage.dart' as $js;

export 'src/chrome.dart' show chrome;

final _storage = ChromeStorage._();

extension ChromeStorageExtension on Chrome {
  /// Use the `chrome.storage` API to store, retrieve, and track changes to user
  /// data.
  ChromeStorage get storage => _storage;
}

class ChromeStorage {
  ChromeStorage._();

  bool get isAvailable => $js.chrome.storageNullable != null && alwaysTrue;

  /// Items in the `sync` storage area are synced using Chrome Sync.
  StorageSync get sync => StorageSync.fromJS($js.chrome.storage.sync);

  /// Items in the `local` storage area are local to each machine.
  StorageLocal get local => StorageLocal.fromJS($js.chrome.storage.local);

  /// Items in the `managed` storage area are set by the domain administrator,
  /// and are read-only for the extension; trying to modify this namespace
  /// results in an error.
  StorageArea get managed => StorageArea.fromJS($js.chrome.storage.managed);

  /// Items in the `session` storage area are stored in-memory and will not be
  /// persisted to disk.
  StorageSession get session =>
      StorageSession.fromJS($js.chrome.storage.session);

  /// Fired when one or more items change.
  EventStream<OnChangedEvent> get onChanged =>
      $js.chrome.storage.onChanged.asStream(($c) => (
            JSAny changes,
            String areaName,
          ) {
            return $c(OnChangedEvent(
              changes: changes.toDartMap(),
              areaName: areaName,
            ));
          });
}

/// The storage area's access level.
enum AccessLevel {
  trustedContexts('TRUSTED_CONTEXTS'),
  trustedAndUntrustedContexts('TRUSTED_AND_UNTRUSTED_CONTEXTS');

  const AccessLevel(this.value);

  final String value;

  String get toJS => value;
  static AccessLevel fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class StorageChange {
  StorageChange.fromJS(this._wrapped);

  StorageChange({
    /// The old value of the item, if there was an old value.
    Object? oldValue,

    /// The new value of the item, if there is a new value.
    Object? newValue,
  }) : _wrapped = $js.StorageChange(
          oldValue: oldValue?.jsify(),
          newValue: newValue?.jsify(),
        );

  final $js.StorageChange _wrapped;

  $js.StorageChange get toJS => _wrapped;

  /// The old value of the item, if there was an old value.
  Object? get oldValue => _wrapped.oldValue?.dartify();
  set oldValue(Object? v) {
    _wrapped.oldValue = v?.jsify();
  }

  /// The new value of the item, if there is a new value.
  Object? get newValue => _wrapped.newValue?.dartify();
  set newValue(Object? v) {
    _wrapped.newValue = v?.jsify();
  }
}

class StorageArea {
  StorageArea.fromJS(this._wrapped);

  StorageArea() : _wrapped = $js.StorageArea();

  final $js.StorageArea _wrapped;

  $js.StorageArea get toJS => _wrapped;

  /// Gets one or more items from storage.
  /// [keys] A single key to get, list of keys to get, or a dictionary
  /// specifying default values (see description of the object).  An empty
  /// list or object will return an empty result object.  Pass in `null` to
  /// get the entire contents of storage.
  /// [returns] Callback with storage items, or on failure (in which case
  /// [runtime.lastError] will be set).
  Future<Map> get(Object? keys) async {
    var $res = await promiseToFuture<JSAny>(_wrapped.get(switch (keys) {
      String() => keys,
      List() => keys.toJSArrayString(),
      Map() => keys.jsify()!,
      null => null,
      _ => throw UnsupportedError(
          'Received type: ${keys.runtimeType}. Supported types are: String, List<String>, Map')
    }));
    return $res.toDartMap();
  }

  /// Gets the amount of space (in bytes) being used by one or more items.
  /// [keys] A single key or list of keys to get the total usage for. An empty
  /// list will return 0. Pass in `null` to get the total usage of all of
  /// storage.
  /// [returns] Callback with the amount of space being used by storage, or on
  /// failure (in which case [runtime.lastError] will be set).
  Future<int> getBytesInUse(Object? keys) async {
    var $res = await promiseToFuture<int>(_wrapped.getBytesInUse(switch (keys) {
      String() => keys,
      List() => keys.toJSArrayString(),
      null => null,
      _ => throw UnsupportedError(
          'Received type: ${keys.runtimeType}. Supported types are: String, List<String>')
    }));
    return $res;
  }

  /// Sets multiple items.
  /// [items] An object which gives each key/value pair to update storage
  /// with. Any other key/value pairs in storage will not be affected.
  ///
  /// Primitive values such as numbers will serialize as expected. Values with
  /// a `typeof` `"object"` and `"function"` will typically serialize to `{}`,
  /// with the exception of `Array` (serializes as expected), `Date`, and
  /// `Regex` (serialize using their `String` representation).
  /// [returns] Callback on success, or on failure (in which case
  /// [runtime.lastError] will be set).
  Future<void> set(Map items) async {
    await promiseToFuture<void>(_wrapped.set(items.jsify()!));
  }

  /// Removes one or more items from storage.
  /// [keys] A single key or a list of keys for items to remove.
  /// [returns] Callback on success, or on failure (in which case
  /// [runtime.lastError] will be set).
  Future<void> remove(Object keys) async {
    await promiseToFuture<void>(_wrapped.remove(switch (keys) {
      String() => keys,
      List() => keys.toJSArrayString(),
      _ => throw UnsupportedError(
          'Received type: ${keys.runtimeType}. Supported types are: String, List<String>')
    }));
  }

  /// Removes all items from storage.
  /// [returns] Callback on success, or on failure (in which case
  /// [runtime.lastError] will be set).
  Future<void> clear() async {
    await promiseToFuture<void>(_wrapped.clear());
  }

  /// Sets the desired access level for the storage area. The default will be
  /// only trusted contexts.
  /// [returns] Callback on success, or on failure (in which case
  /// [runtime.lastError] will be set).
  Future<void> setAccessLevel(SetAccessLevelAccessOptions accessOptions) async {
    await promiseToFuture<void>(_wrapped.setAccessLevel(accessOptions.toJS));
  }

  /// Fired when one or more items change.
  EventStream<Map> get onChanged =>
      _wrapped.onChanged.asStream(($c) => (JSAny changes) {
            return $c(changes.toDartMap());
          });
}

class StorageSync extends StorageArea {
  StorageSync.fromJS($js.StorageSync wrapped) : super.fromJS(wrapped);

  @override
  $js.StorageSync get _wrapped => super._wrapped as $js.StorageSync;

  /// The maximum total amount (in bytes) of data that can be stored in sync
  /// storage, as measured by the JSON stringification of every value plus every
  /// key's length. Updates that would cause this limit to be exceeded fail
  /// immediately and set [runtime.lastError].
  int get quotaBytes => _wrapped.QUOTA_BYTES;
  set quotaBytes(int v) {
    _wrapped.QUOTA_BYTES = v;
  }

  /// The maximum size (in bytes) of each individual item in sync storage, as
  /// measured by the JSON stringification of its value plus its key length.
  /// Updates containing items larger than this limit will fail immediately and
  /// set [runtime.lastError].
  int get quotaBytesPerItem => _wrapped.QUOTA_BYTES_PER_ITEM;
  set quotaBytesPerItem(int v) {
    _wrapped.QUOTA_BYTES_PER_ITEM = v;
  }

  /// The maximum number of items that can be stored in sync storage. Updates
  /// that would cause this limit to be exceeded will fail immediately and set
  /// [runtime.lastError].
  int get maxItems => _wrapped.MAX_ITEMS;
  set maxItems(int v) {
    _wrapped.MAX_ITEMS = v;
  }

  /// The maximum number of `set`, `remove`, or `clear` operations that can be
  /// performed each hour. This is 1 every 2 seconds, a lower ceiling than the
  /// short term higher writes-per-minute limit.
  ///
  /// Updates that would cause this limit to be exceeded fail immediately and
  /// set [runtime.lastError].
  int get maxWriteOperationsPerHour => _wrapped.MAX_WRITE_OPERATIONS_PER_HOUR;
  set maxWriteOperationsPerHour(int v) {
    _wrapped.MAX_WRITE_OPERATIONS_PER_HOUR = v;
  }

  /// The maximum number of `set`, `remove`, or `clear` operations that can be
  /// performed each minute. This is 2 per second, providing higher throughput
  /// than writes-per-hour over a shorter period of time.
  ///
  /// Updates that would cause this limit to be exceeded fail immediately and
  /// set [runtime.lastError].
  int get maxWriteOperationsPerMinute =>
      _wrapped.MAX_WRITE_OPERATIONS_PER_MINUTE;
  set maxWriteOperationsPerMinute(int v) {
    _wrapped.MAX_WRITE_OPERATIONS_PER_MINUTE = v;
  }

  int get maxSustainedWriteOperationsPerMinute =>
      _wrapped.MAX_SUSTAINED_WRITE_OPERATIONS_PER_MINUTE;
  set maxSustainedWriteOperationsPerMinute(int v) {
    _wrapped.MAX_SUSTAINED_WRITE_OPERATIONS_PER_MINUTE = v;
  }
}

class StorageLocal extends StorageArea {
  StorageLocal.fromJS($js.StorageLocal wrapped) : super.fromJS(wrapped);

  @override
  $js.StorageLocal get _wrapped => super._wrapped as $js.StorageLocal;

  /// The maximum amount (in bytes) of data that can be stored in local storage,
  /// as measured by the JSON stringification of every value plus every key's
  /// length. This value will be ignored if the extension has the
  /// `unlimitedStorage` permission. Updates that would cause this limit to be
  /// exceeded fail immediately and set [runtime.lastError].
  int get quotaBytes => _wrapped.QUOTA_BYTES;
  set quotaBytes(int v) {
    _wrapped.QUOTA_BYTES = v;
  }
}

class StorageSession extends StorageArea {
  StorageSession.fromJS($js.StorageSession wrapped) : super.fromJS(wrapped);

  @override
  $js.StorageSession get _wrapped => super._wrapped as $js.StorageSession;

  /// The maximum amount (in bytes) of data that can be stored in memory, as
  /// measured by estimating the dynamically allocated memory usage of every
  /// value and key. Updates that would cause this limit to be exceeded fail
  /// immediately and set [runtime.lastError].
  int get quotaBytes => _wrapped.QUOTA_BYTES;
  set quotaBytes(int v) {
    _wrapped.QUOTA_BYTES = v;
  }
}

class SetAccessLevelAccessOptions {
  SetAccessLevelAccessOptions.fromJS(this._wrapped);

  SetAccessLevelAccessOptions(
      {
      /// The access level of the storage area.
      required AccessLevel accessLevel})
      : _wrapped =
            $js.SetAccessLevelAccessOptions(accessLevel: accessLevel.toJS);

  final $js.SetAccessLevelAccessOptions _wrapped;

  $js.SetAccessLevelAccessOptions get toJS => _wrapped;

  /// The access level of the storage area.
  AccessLevel get accessLevel => AccessLevel.fromJS(_wrapped.accessLevel);
  set accessLevel(AccessLevel v) {
    _wrapped.accessLevel = v.toJS;
  }
}

class OnChangedEvent {
  OnChangedEvent({
    required this.changes,
    required this.areaName,
  });

  /// Object mapping each key that changed to its corresponding
  /// [storage.StorageChange] for that item.
  final Map changes;

  /// The name of the storage area (`"sync"`, `"local"` or `"managed"`) the
  /// changes are for.
  final String areaName;
}
