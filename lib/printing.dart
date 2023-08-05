// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'printer_provider.dart';
import 'src/internal_helpers.dart';
import 'src/js/printing.dart' as $js;

export 'src/chrome.dart' show chrome;

final _printing = ChromePrinting._();

extension ChromePrintingExtension on Chrome {
  /// Use the `chrome.printing` API to send print jobs to printers
  /// installed on Chromebook.
  ChromePrinting get printing => _printing;
}

class ChromePrinting {
  ChromePrinting._();

  bool get isAvailable => $js.chrome.printingNullable != null && alwaysTrue;

  /// Submits the job for print.
  /// If the extension is not listed in PrintingAPIExtensionsAllowlist policy,
  /// the user will be prompted to accept the print job.
  Future<SubmitJobResponse> submitJob(SubmitJobRequest request) async {
    var $res = await promiseToFuture<$js.SubmitJobResponse>(
        $js.chrome.printing.submitJob(request.toJS));
    return SubmitJobResponse.fromJS($res);
  }

  /// Cancels previously submitted job.
  /// |jobId|: The id of the print job to cancel. This should be the same id
  /// received in a [SubmitJobResponse].
  Future<void> cancelJob(String jobId) async {
    await promiseToFuture<void>($js.chrome.printing.cancelJob(jobId));
  }

  /// Returns the list of available printers on the device. This includes
  /// manually added, enterprise and discovered printers.
  Future<List<Printer>> getPrinters() async {
    var $res =
        await promiseToFuture<JSArray>($js.chrome.printing.getPrinters());
    return $res.toDart
        .cast<$js.Printer>()
        .map((e) => Printer.fromJS(e))
        .toList();
  }

  /// Returns the status and capabilities of the printer in
  /// <a href="https://developers.google.com/cloud-print/docs/cdd#cdd">
  /// CDD format</a>.
  /// This call will fail with a runtime error if no printers with given id are
  /// installed.
  Future<GetPrinterInfoResponse> getPrinterInfo(String printerId) async {
    var $res = await promiseToFuture<$js.GetPrinterInfoResponse>(
        $js.chrome.printing.getPrinterInfo(printerId));
    return GetPrinterInfoResponse.fromJS($res);
  }

  /// The maximum number of times that [submitJob] can be called per
  /// minute.
  int get maxSubmitJobCallsPerMinute =>
      $js.chrome.printing.MAX_SUBMIT_JOB_CALLS_PER_MINUTE;

  /// The maximum number of times that [getPrinterInfo] can be called per
  /// minute.
  int get maxGetPrinterInfoCallsPerMinute =>
      $js.chrome.printing.MAX_GET_PRINTER_INFO_CALLS_PER_MINUTE;

  /// Event fired when the status of the job is changed.
  /// This is only fired for the jobs created by this extension.
  EventStream<OnJobStatusChangedEvent> get onJobStatusChanged =>
      $js.chrome.printing.onJobStatusChanged.asStream(($c) => (
            String jobId,
            $js.JobStatus status,
          ) {
            return $c(OnJobStatusChangedEvent(
              jobId: jobId,
              status: JobStatus.fromJS(status),
            ));
          });
}

/// The status of [submitJob] request.
enum SubmitJobStatus {
  /// Sent print job request is accepted.
  ok('OK'),

  /// Sent print job request is rejected by the user.
  userRejected('USER_REJECTED');

  const SubmitJobStatus(this.value);

  final String value;

  String get toJS => value;
  static SubmitJobStatus fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The source of the printer.
enum PrinterSource {
  /// Printer was added by user.
  user('USER'),

  /// Printer was added via policy.
  policy('POLICY');

  const PrinterSource(this.value);

  final String value;

  String get toJS => value;
  static PrinterSource fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The status of the printer.
enum PrinterStatus {
  /// The door of the printer is open. Printer still accepts print jobs.
  doorOpen('DOOR_OPEN'),

  /// The tray of the printer is missing. Printer still accepts print jobs.
  trayMissing('TRAY_MISSING'),

  /// The printer is out of ink. Printer still accepts print jobs.
  outOfInk('OUT_OF_INK'),

  /// The printer is out of paper. Printer still accepts print jobs.
  outOfPaper('OUT_OF_PAPER'),

  /// The output area of the printer (e.g. tray) is full. Printer still accepts
  /// print jobs.
  outputFull('OUTPUT_FULL'),

  /// The printer has a paper jam. Printer still accepts print jobs.
  paperJam('PAPER_JAM'),

  /// Some generic issue. Printer still accepts print jobs.
  genericIssue('GENERIC_ISSUE'),

  /// The printer is stopped and doesn't print but still accepts print jobs.
  stopped('STOPPED'),

  /// The printer is unreachable and doesn't accept print jobs.
  unreachable('UNREACHABLE'),

  /// The printer is available.
  available('AVAILABLE');

  const PrinterStatus(this.value);

  final String value;

  String get toJS => value;
  static PrinterStatus fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Status of the print job.
enum JobStatus {
  /// Print job is received on Chrome side but was not processed yet.
  pending('PENDING'),

  /// Print job is sent for printing.
  inProgress('IN_PROGRESS'),

  /// Print job was interrupted due to some error.
  failed('FAILED'),

  /// Print job was canceled by the user or via API.
  canceled('CANCELED'),

  /// Print job was printed without any errors.
  printed('PRINTED');

  const JobStatus(this.value);

  final String value;

  String get toJS => value;
  static JobStatus fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class SubmitJobRequest {
  SubmitJobRequest.fromJS(this._wrapped);

  SubmitJobRequest({
    /// The print job to be submitted.
    /// The only supported content type is "application/pdf", and the CJT ticket
    /// shouldn't include FitToPageTicketItem, PageRangeTicketItem,
    /// ReverseOrderTicketItem and VendorTicketItem fields since they are
    /// irrelevant for native printing. All other fields must be present.
    required PrintJob job,

    /// Used internally to store the blob uuid after parameter customization and
    /// shouldn't be populated by the extension.
    String? documentBlobUuid,
  }) : _wrapped = $js.SubmitJobRequest(
          job: job.toJS,
          documentBlobUuid: documentBlobUuid,
        );

  final $js.SubmitJobRequest _wrapped;

  $js.SubmitJobRequest get toJS => _wrapped;

  /// The print job to be submitted.
  /// The only supported content type is "application/pdf", and the CJT ticket
  /// shouldn't include FitToPageTicketItem, PageRangeTicketItem,
  /// ReverseOrderTicketItem and VendorTicketItem fields since they are
  /// irrelevant for native printing. All other fields must be present.
  PrintJob get job => PrintJob.fromJS(_wrapped.job);
  set job(PrintJob v) {
    _wrapped.job = v.toJS;
  }

  /// Used internally to store the blob uuid after parameter customization and
  /// shouldn't be populated by the extension.
  String? get documentBlobUuid => _wrapped.documentBlobUuid;
  set documentBlobUuid(String? v) {
    _wrapped.documentBlobUuid = v;
  }
}

class SubmitJobResponse {
  SubmitJobResponse.fromJS(this._wrapped);

  SubmitJobResponse({
    /// The status of the request.
    required SubmitJobStatus status,

    /// The id of created print job. This is a unique identifier among all print
    /// jobs on the device. If status is not OK, jobId will be null.
    String? jobId,
  }) : _wrapped = $js.SubmitJobResponse(
          status: status.toJS,
          jobId: jobId,
        );

  final $js.SubmitJobResponse _wrapped;

  $js.SubmitJobResponse get toJS => _wrapped;

  /// The status of the request.
  SubmitJobStatus get status => SubmitJobStatus.fromJS(_wrapped.status);
  set status(SubmitJobStatus v) {
    _wrapped.status = v.toJS;
  }

  /// The id of created print job. This is a unique identifier among all print
  /// jobs on the device. If status is not OK, jobId will be null.
  String? get jobId => _wrapped.jobId;
  set jobId(String? v) {
    _wrapped.jobId = v;
  }
}

class Printer {
  Printer.fromJS(this._wrapped);

  Printer({
    /// The printer's identifier; guaranteed to be unique among printers on the
    /// device.
    required String id,

    /// The name of the printer.
    required String name,

    /// The human-readable description of the printer.
    required String description,

    /// The printer URI. This can be used by extensions to choose the printer
    /// for
    /// the user.
    required String uri,

    /// The source of the printer (user or policy configured).
    required PrinterSource source,

    /// The flag which shows whether the printer fits
    /// <a
    /// href="https://chromium.org/administrators/policy-list-3#DefaultPrinterSelection">
    /// DefaultPrinterSelection</a> rules.
    /// Note that several printers could be flagged.
    required bool isDefault,

    /// The value showing how recent the printer was used for printing from
    /// Chrome. The lower the value is the more recent the printer was used. The
    /// minimum value is 0. Missing value indicates that the printer wasn't used
    /// recently. This value is guaranteed to be unique amongst printers.
    int? recentlyUsedRank,
  }) : _wrapped = $js.Printer(
          id: id,
          name: name,
          description: description,
          uri: uri,
          source: source.toJS,
          isDefault: isDefault,
          recentlyUsedRank: recentlyUsedRank,
        );

  final $js.Printer _wrapped;

  $js.Printer get toJS => _wrapped;

  /// The printer's identifier; guaranteed to be unique among printers on the
  /// device.
  String get id => _wrapped.id;
  set id(String v) {
    _wrapped.id = v;
  }

  /// The name of the printer.
  String get name => _wrapped.name;
  set name(String v) {
    _wrapped.name = v;
  }

  /// The human-readable description of the printer.
  String get description => _wrapped.description;
  set description(String v) {
    _wrapped.description = v;
  }

  /// The printer URI. This can be used by extensions to choose the printer for
  /// the user.
  String get uri => _wrapped.uri;
  set uri(String v) {
    _wrapped.uri = v;
  }

  /// The source of the printer (user or policy configured).
  PrinterSource get source => PrinterSource.fromJS(_wrapped.source);
  set source(PrinterSource v) {
    _wrapped.source = v.toJS;
  }

  /// The flag which shows whether the printer fits
  /// <a
  /// href="https://chromium.org/administrators/policy-list-3#DefaultPrinterSelection">
  /// DefaultPrinterSelection</a> rules.
  /// Note that several printers could be flagged.
  bool get isDefault => _wrapped.isDefault;
  set isDefault(bool v) {
    _wrapped.isDefault = v;
  }

  /// The value showing how recent the printer was used for printing from
  /// Chrome. The lower the value is the more recent the printer was used. The
  /// minimum value is 0. Missing value indicates that the printer wasn't used
  /// recently. This value is guaranteed to be unique amongst printers.
  int? get recentlyUsedRank => _wrapped.recentlyUsedRank;
  set recentlyUsedRank(int? v) {
    _wrapped.recentlyUsedRank = v;
  }
}

class GetPrinterInfoResponse {
  GetPrinterInfoResponse.fromJS(this._wrapped);

  GetPrinterInfoResponse({
    /// Printer capabilities in
    /// <a href="https://developers.google.com/cloud-print/docs/cdd#cdd">
    /// CDD format</a>.
    /// The property may be missing.
    Map? capabilities,

    /// The status of the printer.
    required PrinterStatus status,
  }) : _wrapped = $js.GetPrinterInfoResponse(
          capabilities: capabilities?.jsify(),
          status: status.toJS,
        );

  final $js.GetPrinterInfoResponse _wrapped;

  $js.GetPrinterInfoResponse get toJS => _wrapped;

  /// Printer capabilities in
  /// <a href="https://developers.google.com/cloud-print/docs/cdd#cdd">
  /// CDD format</a>.
  /// The property may be missing.
  Map? get capabilities => _wrapped.capabilities?.toDartMap();
  set capabilities(Map? v) {
    _wrapped.capabilities = v?.jsify();
  }

  /// The status of the printer.
  PrinterStatus get status => PrinterStatus.fromJS(_wrapped.status);
  set status(PrinterStatus v) {
    _wrapped.status = v.toJS;
  }
}

class OnJobStatusChangedEvent {
  OnJobStatusChangedEvent({
    required this.jobId,
    required this.status,
  });

  final String jobId;

  final JobStatus status;
}
