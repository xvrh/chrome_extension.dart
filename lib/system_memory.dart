// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/system_memory.dart' as $js;
import 'system.dart';

export 'src/chrome.dart' show chrome;
export 'system.dart' show ChromeSystem, ChromeSystemExtension;

final _systemMemory = ChromeSystemMemory._();

extension ChromeSystemMemoryExtension on ChromeSystem {
  /// The `chrome.system.memory` API.
  ChromeSystemMemory get memory => _systemMemory;
}

class ChromeSystemMemory {
  ChromeSystemMemory._();

  bool get isAvailable =>
      $js.chrome.systemNullable?.memoryNullable != null && alwaysTrue;

  /// Get physical memory information.
  Future<MemoryInfo> getInfo() async {
    var $res = await promiseToFuture<$js.MemoryInfo>(
        $js.chrome.system.memory.getInfo());
    return MemoryInfo.fromJS($res);
  }
}

class MemoryInfo {
  MemoryInfo.fromJS(this._wrapped);

  MemoryInfo({
    /// The total amount of physical memory capacity, in bytes.
    required double capacity,

    /// The amount of available capacity, in bytes.
    required double availableCapacity,
  }) : _wrapped = $js.MemoryInfo(
          capacity: capacity,
          availableCapacity: availableCapacity,
        );

  final $js.MemoryInfo _wrapped;

  $js.MemoryInfo get toJS => _wrapped;

  /// The total amount of physical memory capacity, in bytes.
  double get capacity => _wrapped.capacity;
  set capacity(double v) {
    _wrapped.capacity = v;
  }

  /// The amount of available capacity, in bytes.
  double get availableCapacity => _wrapped.availableCapacity;
  set availableCapacity(double v) {
    _wrapped.availableCapacity = v;
  }
}
