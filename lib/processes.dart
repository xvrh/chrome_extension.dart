// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/processes.dart' as $js;

export 'src/chrome.dart' show chrome;

final _processes = ChromeProcesses._();

extension ChromeProcessesExtension on Chrome {
  /// Use the `chrome.processes` API to interact with the browser's
  /// processes.
  ChromeProcesses get processes => _processes;
}

class ChromeProcesses {
  ChromeProcesses._();

  bool get isAvailable => $js.chrome.processesNullable != null && alwaysTrue;

  /// Returns the ID of the renderer process for the specified tab.
  /// |tabId|: The ID of the tab for which the renderer process ID is to be
  /// returned.
  Future<int> getProcessIdForTab(int tabId) async {
    var $res = await promiseToFuture<int>(
        $js.chrome.processes.getProcessIdForTab(tabId));
    return $res;
  }

  /// Terminates the specified renderer process. Equivalent to visiting
  /// about:crash, but without changing the tab's URL.
  /// |processId|: The ID of the process to be terminated.
  Future<bool> terminate(int processId) async {
    var $res =
        await promiseToFuture<bool>($js.chrome.processes.terminate(processId));
    return $res;
  }

  /// Retrieves the process information for each process ID specified.
  /// |processIds|: The list of process IDs or single process ID for which
  /// to return the process information. An empty list indicates all processes
  /// are requested.
  /// |includeMemory|: True if detailed memory usage is required. Note,
  /// collecting memory usage information incurs extra CPU usage and should
  /// only be queried for when needed.
  Future<Map> getProcessInfo(
    Object processIds,
    bool includeMemory,
  ) async {
    var $res = await promiseToFuture<JSAny>($js.chrome.processes.getProcessInfo(
      switch (processIds) {
        int() => processIds,
        List<int>() => processIds.toJSArray((e) => e),
        _ => throw UnsupportedError(
            'Received type: ${processIds.runtimeType}. Supported types are: int, List<int>')
      },
      includeMemory,
    ));
    return $res.toDartMap();
  }

  /// Fired each time the Task Manager updates its process statistics,
  /// providing the dictionary of updated Process objects, indexed by process
  /// ID.
  /// |processes|: A dictionary of updated [Process] objects for each live
  /// process in the browser, indexed by process ID.  Metrics requiring
  /// aggregation over time will be populated in each Process object.
  EventStream<Map> get onUpdated =>
      $js.chrome.processes.onUpdated.asStream(($c) => (JSAny processes) {
            return $c(processes.toDartMap());
          });

  /// Fired each time the Task Manager updates its process statistics,
  /// providing the dictionary of updated Process objects, indexed by process
  /// ID. Identical to onUpdate, with the addition of memory usage details
  /// included in each Process object. Note, collecting memory usage
  /// information incurs extra CPU usage and should only be listened for when
  /// needed.
  /// |processes|: A dictionary of updated [Process] objects for each live
  /// process in the browser, indexed by process ID.  Memory usage details will
  /// be included in each Process object.
  EventStream<Map> get onUpdatedWithMemory =>
      $js.chrome.processes.onUpdatedWithMemory
          .asStream(($c) => (JSAny processes) {
                return $c(processes.toDartMap());
              });

  /// Fired each time a process is created, providing the corrseponding Process
  /// object.
  /// |process|: Details of the process that was created. Metrics requiring
  /// aggregation over time will not be populated in the object.
  EventStream<Process> get onCreated =>
      $js.chrome.processes.onCreated.asStream(($c) => ($js.Process process) {
            return $c(Process.fromJS(process));
          });

  /// Fired each time a process becomes unresponsive, providing the
  /// corrseponding Process object.
  /// |process|: Details of the unresponsive process. Metrics requiring
  /// aggregation over time will not be populated in the object. Only available
  /// for renderer processes.
  EventStream<Process> get onUnresponsive => $js.chrome.processes.onUnresponsive
      .asStream(($c) => ($js.Process process) {
            return $c(Process.fromJS(process));
          });

  /// Fired each time a process is terminated, providing the type of exit.
  /// |processId|: The ID of the process that exited.
  /// |exitType|: The type of exit that occurred for the process - normal,
  /// abnormal, killed, crashed. Only available for renderer processes.
  /// |exitCode|: The exit code if the process exited abnormally. Only
  /// available for renderer processes.
  EventStream<OnExitedEvent> get onExited =>
      $js.chrome.processes.onExited.asStream(($c) => (
            int processId,
            int exitType,
            int exitCode,
          ) {
            return $c(OnExitedEvent(
              processId: processId,
              exitType: exitType,
              exitCode: exitCode,
            ));
          });
}

/// The types of the browser processes.
enum ProcessType {
  browser('browser'),
  renderer('renderer'),
  extension('extension'),
  notification('notification'),
  plugin('plugin'),
  worker('worker'),
  nacl('nacl'),
  serviceWorker('service_worker'),
  utility('utility'),
  gpu('gpu'),
  other('other');

  const ProcessType(this.value);

  final String value;

  String get toJS => value;
  static ProcessType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class TaskInfo {
  TaskInfo.fromJS(this._wrapped);

  TaskInfo({
    /// The title of the task.
    required String title,

    /// Optional tab ID, if this task represents a tab running on a renderer
    /// process.
    int? tabId,
  }) : _wrapped = $js.TaskInfo(
          title: title,
          tabId: tabId,
        );

  final $js.TaskInfo _wrapped;

  $js.TaskInfo get toJS => _wrapped;

  /// The title of the task.
  String get title => _wrapped.title;
  set title(String v) {
    _wrapped.title = v;
  }

  /// Optional tab ID, if this task represents a tab running on a renderer
  /// process.
  int? get tabId => _wrapped.tabId;
  set tabId(int? v) {
    _wrapped.tabId = v;
  }
}

class Cache {
  Cache.fromJS(this._wrapped);

  Cache({
    /// The size of the cache, in bytes.
    required double size,

    /// The part of the cache that is utilized, in bytes.
    required double liveSize,
  }) : _wrapped = $js.Cache(
          size: size,
          liveSize: liveSize,
        );

  final $js.Cache _wrapped;

  $js.Cache get toJS => _wrapped;

  /// The size of the cache, in bytes.
  double get size => _wrapped.size;
  set size(double v) {
    _wrapped.size = v;
  }

  /// The part of the cache that is utilized, in bytes.
  double get liveSize => _wrapped.liveSize;
  set liveSize(double v) {
    _wrapped.liveSize = v;
  }
}

class Process {
  Process.fromJS(this._wrapped);

  Process({
    /// Unique ID of the process provided by the browser.
    required int id,

    /// The ID of the process, as provided by the OS.
    required int osProcessId,

    /// The type of process.
    required ProcessType type,

    /// The profile which the process is associated with.
    required String profile,

    /// The debugging port for Native Client processes. Zero for other process
    /// types and for NaCl processes that do not have debugging enabled.
    required int naclDebugPort,

    /// Array of TaskInfos representing the tasks running on this process.
    required List<TaskInfo> tasks,

    /// The most recent measurement of the process's CPU usage, expressed as the
    /// percentage of a single CPU core used in total, by all of the process's
    /// threads. This gives a value from zero to CpuInfo.numOfProcessors*100,
    /// which can exceed 100% in multi-threaded processes.
    /// Only available when receiving the object as part of a callback from
    /// onUpdated or onUpdatedWithMemory.
    double? cpu,

    /// The most recent measurement of the process network usage, in bytes per
    /// second. Only available when receiving the object as part of a callback
    /// from onUpdated or onUpdatedWithMemory.
    double? network,

    /// The most recent measurement of the process private memory usage, in
    /// bytes. Only available when receiving the object as part of a callback
    /// from onUpdatedWithMemory or getProcessInfo with the includeMemory flag.
    double? privateMemory,

    /// The most recent measurement of the process JavaScript allocated memory,
    /// in bytes. Only available when receiving the object as part of a callback
    /// from onUpdated or onUpdatedWithMemory.
    double? jsMemoryAllocated,

    /// The most recent measurement of the process JavaScript memory used, in
    /// bytes. Only available when receiving the object as part of a callback
    /// from onUpdated or onUpdatedWithMemory.
    double? jsMemoryUsed,

    /// The most recent measurement of the process's SQLite memory usage, in
    /// bytes. Only available when receiving the object as part of a callback
    /// from onUpdated or onUpdatedWithMemory.
    double? sqliteMemory,

    /// The most recent information about the image cache for the process. Only
    /// available when receiving the object as part of a callback from onUpdated
    /// or onUpdatedWithMemory.
    Cache? imageCache,

    /// The most recent information about the script cache for the process. Only
    /// available when receiving the object as part of a callback from onUpdated
    /// or onUpdatedWithMemory.
    Cache? scriptCache,

    /// The most recent information about the CSS cache for the process. Only
    /// available when receiving the object as part of a callback from onUpdated
    /// or onUpdatedWithMemory.
    Cache? cssCache,
  }) : _wrapped = $js.Process(
          id: id,
          osProcessId: osProcessId,
          type: type.toJS,
          profile: profile,
          naclDebugPort: naclDebugPort,
          tasks: tasks.toJSArray((e) => e.toJS),
          cpu: cpu,
          network: network,
          privateMemory: privateMemory,
          jsMemoryAllocated: jsMemoryAllocated,
          jsMemoryUsed: jsMemoryUsed,
          sqliteMemory: sqliteMemory,
          imageCache: imageCache?.toJS,
          scriptCache: scriptCache?.toJS,
          cssCache: cssCache?.toJS,
        );

  final $js.Process _wrapped;

  $js.Process get toJS => _wrapped;

  /// Unique ID of the process provided by the browser.
  int get id => _wrapped.id;
  set id(int v) {
    _wrapped.id = v;
  }

  /// The ID of the process, as provided by the OS.
  int get osProcessId => _wrapped.osProcessId;
  set osProcessId(int v) {
    _wrapped.osProcessId = v;
  }

  /// The type of process.
  ProcessType get type => ProcessType.fromJS(_wrapped.type);
  set type(ProcessType v) {
    _wrapped.type = v.toJS;
  }

  /// The profile which the process is associated with.
  String get profile => _wrapped.profile;
  set profile(String v) {
    _wrapped.profile = v;
  }

  /// The debugging port for Native Client processes. Zero for other process
  /// types and for NaCl processes that do not have debugging enabled.
  int get naclDebugPort => _wrapped.naclDebugPort;
  set naclDebugPort(int v) {
    _wrapped.naclDebugPort = v;
  }

  /// Array of TaskInfos representing the tasks running on this process.
  List<TaskInfo> get tasks => _wrapped.tasks.toDart
      .cast<$js.TaskInfo>()
      .map((e) => TaskInfo.fromJS(e))
      .toList();
  set tasks(List<TaskInfo> v) {
    _wrapped.tasks = v.toJSArray((e) => e.toJS);
  }

  /// The most recent measurement of the process's CPU usage, expressed as the
  /// percentage of a single CPU core used in total, by all of the process's
  /// threads. This gives a value from zero to CpuInfo.numOfProcessors*100,
  /// which can exceed 100% in multi-threaded processes.
  /// Only available when receiving the object as part of a callback from
  /// onUpdated or onUpdatedWithMemory.
  double? get cpu => _wrapped.cpu;
  set cpu(double? v) {
    _wrapped.cpu = v;
  }

  /// The most recent measurement of the process network usage, in bytes per
  /// second. Only available when receiving the object as part of a callback
  /// from onUpdated or onUpdatedWithMemory.
  double? get network => _wrapped.network;
  set network(double? v) {
    _wrapped.network = v;
  }

  /// The most recent measurement of the process private memory usage, in
  /// bytes. Only available when receiving the object as part of a callback
  /// from onUpdatedWithMemory or getProcessInfo with the includeMemory flag.
  double? get privateMemory => _wrapped.privateMemory;
  set privateMemory(double? v) {
    _wrapped.privateMemory = v;
  }

  /// The most recent measurement of the process JavaScript allocated memory,
  /// in bytes. Only available when receiving the object as part of a callback
  /// from onUpdated or onUpdatedWithMemory.
  double? get jsMemoryAllocated => _wrapped.jsMemoryAllocated;
  set jsMemoryAllocated(double? v) {
    _wrapped.jsMemoryAllocated = v;
  }

  /// The most recent measurement of the process JavaScript memory used, in
  /// bytes. Only available when receiving the object as part of a callback
  /// from onUpdated or onUpdatedWithMemory.
  double? get jsMemoryUsed => _wrapped.jsMemoryUsed;
  set jsMemoryUsed(double? v) {
    _wrapped.jsMemoryUsed = v;
  }

  /// The most recent measurement of the process's SQLite memory usage, in
  /// bytes. Only available when receiving the object as part of a callback
  /// from onUpdated or onUpdatedWithMemory.
  double? get sqliteMemory => _wrapped.sqliteMemory;
  set sqliteMemory(double? v) {
    _wrapped.sqliteMemory = v;
  }

  /// The most recent information about the image cache for the process. Only
  /// available when receiving the object as part of a callback from onUpdated
  /// or onUpdatedWithMemory.
  Cache? get imageCache => _wrapped.imageCache?.let(Cache.fromJS);
  set imageCache(Cache? v) {
    _wrapped.imageCache = v?.toJS;
  }

  /// The most recent information about the script cache for the process. Only
  /// available when receiving the object as part of a callback from onUpdated
  /// or onUpdatedWithMemory.
  Cache? get scriptCache => _wrapped.scriptCache?.let(Cache.fromJS);
  set scriptCache(Cache? v) {
    _wrapped.scriptCache = v?.toJS;
  }

  /// The most recent information about the CSS cache for the process. Only
  /// available when receiving the object as part of a callback from onUpdated
  /// or onUpdatedWithMemory.
  Cache? get cssCache => _wrapped.cssCache?.let(Cache.fromJS);
  set cssCache(Cache? v) {
    _wrapped.cssCache = v?.toJS;
  }
}

class OnExitedEvent {
  OnExitedEvent({
    required this.processId,
    required this.exitType,
    required this.exitCode,
  });

  final int processId;

  final int exitType;

  final int exitCode;
}
