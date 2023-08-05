// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/system_cpu.dart' as $js;
import 'system.dart';

export 'src/chrome.dart' show chrome;
export 'system.dart' show ChromeSystem, ChromeSystemExtension;

final _systemCpu = ChromeSystemCpu._();

extension ChromeSystemCpuExtension on ChromeSystem {
  /// Use the `system.cpu` API to query CPU metadata.
  ChromeSystemCpu get cpu => _systemCpu;
}

class ChromeSystemCpu {
  ChromeSystemCpu._();

  bool get isAvailable =>
      $js.chrome.systemNullable?.cpuNullable != null && alwaysTrue;

  /// Queries basic CPU information of the system.
  Future<CpuInfo> getInfo() async {
    var $res =
        await promiseToFuture<$js.CpuInfo>($js.chrome.system.cpu.getInfo());
    return CpuInfo.fromJS($res);
  }
}

class CpuTime {
  CpuTime.fromJS(this._wrapped);

  CpuTime({
    /// The cumulative time used by userspace programs on this processor.
    required double user,

    /// The cumulative time used by kernel programs on this processor.
    required double kernel,

    /// The cumulative time spent idle by this processor.
    required double idle,

    /// The total cumulative time for this processor.  This value is equal to
    /// user + kernel + idle.
    required double total,
  }) : _wrapped = $js.CpuTime(
          user: user,
          kernel: kernel,
          idle: idle,
          total: total,
        );

  final $js.CpuTime _wrapped;

  $js.CpuTime get toJS => _wrapped;

  /// The cumulative time used by userspace programs on this processor.
  double get user => _wrapped.user;
  set user(double v) {
    _wrapped.user = v;
  }

  /// The cumulative time used by kernel programs on this processor.
  double get kernel => _wrapped.kernel;
  set kernel(double v) {
    _wrapped.kernel = v;
  }

  /// The cumulative time spent idle by this processor.
  double get idle => _wrapped.idle;
  set idle(double v) {
    _wrapped.idle = v;
  }

  /// The total cumulative time for this processor.  This value is equal to
  /// user + kernel + idle.
  double get total => _wrapped.total;
  set total(double v) {
    _wrapped.total = v;
  }
}

class ProcessorInfo {
  ProcessorInfo.fromJS(this._wrapped);

  ProcessorInfo(
      {
      /// Cumulative usage info for this logical processor.
      required CpuTime usage})
      : _wrapped = $js.ProcessorInfo(usage: usage.toJS);

  final $js.ProcessorInfo _wrapped;

  $js.ProcessorInfo get toJS => _wrapped;

  /// Cumulative usage info for this logical processor.
  CpuTime get usage => CpuTime.fromJS(_wrapped.usage);
  set usage(CpuTime v) {
    _wrapped.usage = v.toJS;
  }
}

class CpuInfo {
  CpuInfo.fromJS(this._wrapped);

  CpuInfo({
    /// The number of logical processors.
    required int numOfProcessors,

    /// The architecture name of the processors.
    required String archName,

    /// The model name of the processors.
    required String modelName,

    /// A set of feature codes indicating some of the processor's capabilities.
    /// The currently supported codes are "mmx", "sse", "sse2", "sse3", "ssse3",
    /// "sse4_1", "sse4_2", and "avx".
    required List<String> features,

    /// Information about each logical processor.
    required List<ProcessorInfo> processors,

    /// List of CPU temperature readings from each thermal zone of the CPU.
    /// Temperatures are in degrees Celsius.
    ///
    /// **Currently supported on Chrome OS only.**
    required List<double> temperatures,
  }) : _wrapped = $js.CpuInfo(
          numOfProcessors: numOfProcessors,
          archName: archName,
          modelName: modelName,
          features: features.toJSArray((e) => e),
          processors: processors.toJSArray((e) => e.toJS),
          temperatures: temperatures.toJSArray((e) => e),
        );

  final $js.CpuInfo _wrapped;

  $js.CpuInfo get toJS => _wrapped;

  /// The number of logical processors.
  int get numOfProcessors => _wrapped.numOfProcessors;
  set numOfProcessors(int v) {
    _wrapped.numOfProcessors = v;
  }

  /// The architecture name of the processors.
  String get archName => _wrapped.archName;
  set archName(String v) {
    _wrapped.archName = v;
  }

  /// The model name of the processors.
  String get modelName => _wrapped.modelName;
  set modelName(String v) {
    _wrapped.modelName = v;
  }

  /// A set of feature codes indicating some of the processor's capabilities.
  /// The currently supported codes are "mmx", "sse", "sse2", "sse3", "ssse3",
  /// "sse4_1", "sse4_2", and "avx".
  List<String> get features =>
      _wrapped.features.toDart.cast<String>().map((e) => e).toList();
  set features(List<String> v) {
    _wrapped.features = v.toJSArray((e) => e);
  }

  /// Information about each logical processor.
  List<ProcessorInfo> get processors => _wrapped.processors.toDart
      .cast<$js.ProcessorInfo>()
      .map((e) => ProcessorInfo.fromJS(e))
      .toList();
  set processors(List<ProcessorInfo> v) {
    _wrapped.processors = v.toJSArray((e) => e.toJS);
  }

  /// List of CPU temperature readings from each thermal zone of the CPU.
  /// Temperatures are in degrees Celsius.
  ///
  /// **Currently supported on Chrome OS only.**
  List<double> get temperatures =>
      _wrapped.temperatures.toDart.cast<double>().map((e) => e).toList();
  set temperatures(List<double> v) {
    _wrapped.temperatures = v.toJSArray((e) => e);
  }
}
