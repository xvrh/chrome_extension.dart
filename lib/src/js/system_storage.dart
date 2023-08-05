// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'system.dart';

export 'chrome.dart';
export 'system.dart';

extension JSChromeJSSystemStorageExtension on JSChromeSystem {
  @JS('storage')
  external JSSystemStorage? get storageNullable;

  /// Use the `chrome.system.storage` API to query storage device
  /// information and be notified when a removable storage device is attached
  /// and
  /// detached.
  JSSystemStorage get storage {
    var storageNullable = this.storageNullable;
    if (storageNullable == null) {
      throw ApiNotAvailableException('chrome.system.storage');
    }
    return storageNullable;
  }
}

@JS()
@staticInterop
class JSSystemStorage {}

extension JSSystemStorageExtension on JSSystemStorage {
  /// Get the storage information from the system. The argument passed to the
  /// callback is an array of StorageUnitInfo objects.
  external JSPromise getInfo();

  /// Ejects a removable storage device.
  external JSPromise ejectDevice(String id);

  /// Get the available capacity of a specified |id| storage device.
  /// The |id| is the transient device ID from StorageUnitInfo.
  external JSPromise getAvailableCapacity(String id);

  /// Fired when a new removable storage is attached to the system.
  external Event get onAttached;

  /// Fired when a removable storage is detached from the system.
  external Event get onDetached;
}

typedef StorageUnitType = String;

typedef EjectDeviceResultCode = String;

@JS()
@staticInterop
@anonymous
class StorageUnitInfo {
  external factory StorageUnitInfo({
    /// The transient ID that uniquely identifies the storage device.
    /// This ID will be persistent within the same run of a single application.
    /// It will not be a persistent identifier between different runs of an
    /// application, or between different applications.
    String id,

    /// The name of the storage unit.
    String name,

    /// The media type of the storage unit.
    StorageUnitType type,

    /// The total amount of the storage space, in bytes.
    double capacity,
  });
}

extension StorageUnitInfoExtension on StorageUnitInfo {
  /// The transient ID that uniquely identifies the storage device.
  /// This ID will be persistent within the same run of a single application.
  /// It will not be a persistent identifier between different runs of an
  /// application, or between different applications.
  external String id;

  /// The name of the storage unit.
  external String name;

  /// The media type of the storage unit.
  external StorageUnitType type;

  /// The total amount of the storage space, in bytes.
  external double capacity;
}

@JS()
@staticInterop
@anonymous
class StorageAvailableCapacityInfo {
  external factory StorageAvailableCapacityInfo({
    /// A copied |id| of getAvailableCapacity function parameter |id|.
    String id,

    /// The available capacity of the storage device, in bytes.
    double availableCapacity,
  });
}

extension StorageAvailableCapacityInfoExtension
    on StorageAvailableCapacityInfo {
  /// A copied |id| of getAvailableCapacity function parameter |id|.
  external String id;

  /// The available capacity of the storage device, in bytes.
  external double availableCapacity;
}
