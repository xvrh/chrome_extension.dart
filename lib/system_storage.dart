// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'src/internal_helpers.dart';
import 'src/js/system_storage.dart' as $js;
import 'system.dart';

export 'src/chrome.dart' show chrome, EventStream;
export 'system.dart' show ChromeSystem, ChromeSystemExtension;

final _systemStorage = ChromeSystemStorage._();

extension ChromeSystemStorageExtension on ChromeSystem {
  /// Use the `system.storage` API to query storage device information and be
  /// notified when a removable storage device is attached and detached.
  ChromeSystemStorage get storage => _systemStorage;
}

class ChromeSystemStorage {
  ChromeSystemStorage._();

  bool get isAvailable =>
      $js.chrome.systemNullable?.storageNullable != null && alwaysTrue;

  /// Get the storage information from the system. The argument passed to the
  /// callback is an array of StorageUnitInfo objects.
  Future<List<StorageUnitInfo>> getInfo() async {
    var $res = await $js.chrome.system.storage.getInfo().toDart;

    // Handle the response properly regardless of its type
    final dartRes = $res.dartify();
    final dartified = dartRes is List ? dartRes : [];

    // Convert each element to a StorageUnitInfo using Map data
    return dartified.map<StorageUnitInfo>((e) {
      if (e is Map) {
        // Create StorageUnitInfo from Map data
        return StorageUnitInfo(
          id: e['id'] as String? ?? '',
          name: e['name'] as String? ?? '',
          type:
              e['type'] != null
                  ? StorageUnitType.fromJS((e['type'] as String).toJS)
                  : StorageUnitType.unknown,
          capacity: (e['capacity'] as num?)?.toDouble() ?? 0,
        );
      } else {
        // Fallback for unexpected types
        return StorageUnitInfo(
          id: '',
          name: '',
          type: StorageUnitType.unknown,
          capacity: 0,
        );
      }
    }).toList();
  }

  /// Ejects a removable storage device.
  Future<EjectDeviceResultCode> ejectDevice(String id) async {
    var $res = await $js.chrome.system.storage.ejectDevice(id).toDart;
    return EjectDeviceResultCode.fromJS($res! as JSString);
  }

  /// Get the available capacity of a specified |id| storage device. The
  /// |id| is the transient device ID from StorageUnitInfo.
  Future<StorageAvailableCapacityInfo> getAvailableCapacity(String id) async {
    var $res = await $js.chrome.system.storage.getAvailableCapacity(id).toDart;

    // Handle the response properly
    final dartRes = $res.dartify();
    if (dartRes is Map) {
      // Create StorageAvailableCapacityInfo from Map data
      return StorageAvailableCapacityInfo(
        id: dartRes['id'] as String? ?? '',
        availableCapacity:
            (dartRes['availableCapacity'] as num?)?.toDouble() ?? 0,
      );
    } else {
      // Fallback for unexpected types
      return StorageAvailableCapacityInfo(id: id, availableCapacity: 0);
    }
  }

  /// Fired when a new removable storage is attached to the system.
  EventStream<StorageUnitInfo> get onAttached =>
      $js.chrome.system.storage.onAttached.asStream(
        ($c) =>
            ((JSAny e) {
              return $c(StorageUnitInfo.fromJS(e as $js.StorageUnitInfo));
            }).toJS,
      );

  /// Fired when a removable storage is detached from the system.
  EventStream<StorageUnitInfo> get onDetached =>
      $js.chrome.system.storage.onDetached.asStream(
        ($c) =>
            ((JSAny e) {
              return $c(StorageUnitInfo.fromJS(e as $js.StorageUnitInfo));
            }).toJS,
      );
}

enum StorageUnitType {
  /// The storage has fixed media, e.g. hard disk or SSD.
  fixed('fixed'),

  /// The storage is removable, e.g. USB flash drive.
  removable('removable'),

  /// The storage type is unknown.
  unknown('unknown');

  const StorageUnitType(this.value);

  final String value;

  JSString get toJS => value.toJS;
  static StorageUnitType fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

enum EjectDeviceResultCode {
  /// The ejection command is successful -- the application can prompt the user
  /// to remove the device.
  success('success'),

  /// The device is in use by another application. The ejection did not
  /// succeed; the user should not remove the device until the other
  /// application is done with the device.
  inUse('in_use'),

  /// There is no such device known.
  noSuchDevice('no_such_device'),

  /// The ejection command failed.
  failure('failure');

  const EjectDeviceResultCode(this.value);

  final String value;

  JSString get toJS => value.toJS;
  static EjectDeviceResultCode fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

class StorageUnitInfo {
  StorageUnitInfo.fromJS(this._wrapped);

  StorageUnitInfo({
    /// The transient ID that uniquely identifies the storage device.
    /// This ID will be persistent within the same run of a single application.
    /// It will not be a persistent identifier between different runs of an
    /// application, or between different applications.
    required String id,

    /// The name of the storage unit.
    required String name,

    /// The media type of the storage unit.
    required StorageUnitType type,

    /// The total amount of the storage space, in bytes.
    required double capacity,
  }) : _wrapped = $js.StorageUnitInfo(
         id: id,
         name: name,
         type: type.toJS,
         capacity: capacity,
       );

  final $js.StorageUnitInfo _wrapped;

  $js.StorageUnitInfo get toJS => _wrapped;

  /// The transient ID that uniquely identifies the storage device.
  /// This ID will be persistent within the same run of a single application.
  /// It will not be a persistent identifier between different runs of an
  /// application, or between different applications.
  String get id => _wrapped.id;

  set id(String v) {
    _wrapped.id = v;
  }

  /// The name of the storage unit.
  String get name => _wrapped.name;

  set name(String v) {
    _wrapped.name = v;
  }

  /// The media type of the storage unit.
  StorageUnitType get type => StorageUnitType.fromJS(_wrapped.type);

  set type(StorageUnitType v) {
    _wrapped.type = v.toJS;
  }

  /// The total amount of the storage space, in bytes.
  double get capacity => _wrapped.capacity;

  set capacity(double v) {
    _wrapped.capacity = v;
  }
}

class StorageAvailableCapacityInfo {
  StorageAvailableCapacityInfo.fromJS(this._wrapped);

  StorageAvailableCapacityInfo({
    /// A copied |id| of getAvailableCapacity function parameter |id|.
    required String id,

    /// The available capacity of the storage device, in bytes.
    required double availableCapacity,
  }) : _wrapped = $js.StorageAvailableCapacityInfo(
         id: id,
         availableCapacity: availableCapacity,
       );

  final $js.StorageAvailableCapacityInfo _wrapped;

  $js.StorageAvailableCapacityInfo get toJS => _wrapped;

  /// A copied |id| of getAvailableCapacity function parameter |id|.
  String get id => _wrapped.id;

  set id(String v) {
    _wrapped.id = v;
  }

  /// The available capacity of the storage device, in bytes.
  double get availableCapacity => _wrapped.availableCapacity;

  set availableCapacity(double v) {
    _wrapped.availableCapacity = v;
  }
}
