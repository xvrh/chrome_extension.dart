// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'system.dart';

export 'chrome.dart';
export 'system.dart';

extension JSChromeJSSystemCpuExtension on JSChromeSystem {
  @JS('cpu')
  external JSSystemCpu? get cpuNullable;

  /// Use the `system.cpu` API to query CPU metadata.
  JSSystemCpu get cpu {
    var cpuNullable = this.cpuNullable;
    if (cpuNullable == null) {
      throw ApiNotAvailableException('chrome.system.cpu');
    }
    return cpuNullable;
  }
}

@JS()
@staticInterop
class JSSystemCpu {}

extension JSSystemCpuExtension on JSSystemCpu {
  /// Queries basic CPU information of the system.
  external JSPromise getInfo();
}

@JS()
@staticInterop
@anonymous
class CpuTime {
  external factory CpuTime({
    /// The cumulative time used by userspace programs on this processor.
    double user,

    /// The cumulative time used by kernel programs on this processor.
    double kernel,

    /// The cumulative time spent idle by this processor.
    double idle,

    /// The total cumulative time for this processor.  This value is equal to
    /// user + kernel + idle.
    double total,
  });
}

extension CpuTimeExtension on CpuTime {
  /// The cumulative time used by userspace programs on this processor.
  external double user;

  /// The cumulative time used by kernel programs on this processor.
  external double kernel;

  /// The cumulative time spent idle by this processor.
  external double idle;

  /// The total cumulative time for this processor.  This value is equal to
  /// user + kernel + idle.
  external double total;
}

@JS()
@staticInterop
@anonymous
class ProcessorInfo {
  external factory ProcessorInfo(
      {
      /// Cumulative usage info for this logical processor.
      CpuTime usage});
}

extension ProcessorInfoExtension on ProcessorInfo {
  /// Cumulative usage info for this logical processor.
  external CpuTime usage;
}

@JS()
@staticInterop
@anonymous
class CpuInfo {
  external factory CpuInfo({
    /// The number of logical processors.
    int numOfProcessors,

    /// The architecture name of the processors.
    String archName,

    /// The model name of the processors.
    String modelName,

    /// A set of feature codes indicating some of the processor's capabilities.
    /// The currently supported codes are "mmx", "sse", "sse2", "sse3", "ssse3",
    /// "sse4_1", "sse4_2", and "avx".
    JSArray features,

    /// Information about each logical processor.
    JSArray processors,

    /// List of CPU temperature readings from each thermal zone of the CPU.
    /// Temperatures are in degrees Celsius.
    ///
    /// **Currently supported on Chrome OS only.**
    JSArray temperatures,
  });
}

extension CpuInfoExtension on CpuInfo {
  /// The number of logical processors.
  external int numOfProcessors;

  /// The architecture name of the processors.
  external String archName;

  /// The model name of the processors.
  external String modelName;

  /// A set of feature codes indicating some of the processor's capabilities.
  /// The currently supported codes are "mmx", "sse", "sse2", "sse3", "ssse3",
  /// "sse4_1", "sse4_2", and "avx".
  external JSArray features;

  /// Information about each logical processor.
  external JSArray processors;

  /// List of CPU temperature readings from each thermal zone of the CPU.
  /// Temperatures are in degrees Celsius.
  ///
  /// **Currently supported on Chrome OS only.**
  external JSArray temperatures;
}
