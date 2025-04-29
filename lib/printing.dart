// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'src/internal_helpers.dart';
import 'src/js/printing.dart' as $js;
import 'printer_provider.dart' show PrintJob;

export 'src/chrome.dart' show chrome, EventStream;

final _printing = ChromePrinting._();

extension ChromePrintingExtension on Chrome {
  /// Use the `chrome.printing` API to send print jobs to printers
  /// installed on Chromebook.
  ChromePrinting get printing => _printing;
}

class ChromePrinting {
  ChromePrinting._();

  bool get isAvailable => $js.chrome.printingNullable != null && alwaysTrue;

  /// Submits the job for printing. If the extension/app doesn't have the
  /// [printingJobTitle.print] permission, the user will be presented with
  /// a native printer dialog. The extension can still specify the default
  /// job parameters, but the user will have a chance to change them. If
  /// the extension/app has the [printingJobTitle.print] permission, the
  /// job will be sent directly to the printer without user interaction.
  Future<String> submitJob($js.SubmitJobRequest request) async {
    var $res = await $js.chrome.printing.submitJob(request).toDart;
    return ($res).dartify() as String? ?? '';
  }

  /// Cancels a previously submitted print job.
  Future<void> cancelJob(String jobId) async {
    await $js.chrome.printing.cancelJob(jobId).toDart;
  }

  /// Returns the list of available printers on the device, including
  /// the save to Drive printer. If the extension has the
  /// [printingPrinters.allTypes] permission, it will receive all printer types. If
  /// the extension has the [printingPrinters.extension] permission, it will
  /// only receive extension managed printers. Otherwise, the extension will
  /// only receive its own printers.
  Future<List<$js.Printer>> getPrinters() async {
    var $res = await $js.chrome.printing.getPrinters().toDart;
    final dartified = $res.dartify() as List? ?? [];
    return dartified.map<$js.Printer>((e) => e as $js.Printer).toList();
  }

  /// Returns the status and capabilities of a printer as a [GetPrinterInfoResponse].
  Future<$js.GetPrinterInfoResponse> getPrinterInfo(String printerId) async {
    var $res = await $js.chrome.printing.getPrinterInfo(printerId).toDart;
    return $res! as $js.GetPrinterInfoResponse;
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
      $js.chrome.printing.onJobStatusChanged.asStream(
        ($c) =>
            (String jobId, $js.JobStatus status) {
              return $c(
                OnJobStatusChangedEvent(
                  jobId: jobId,
                  status: JobStatus.fromJS(status),
                ),
              );
            }.toJS,
      );
}

/// The status of [submitJob] request.
enum SubmitJobStatus {
  /// Sent print job request is accepted.
  ok('OK'),

  /// Sent print job request is rejected by the user.
  userRejected('USER_REJECTED');

  const SubmitJobStatus(this.value);

  final String value;

  JSString get toJS => value.toJS;
  static SubmitJobStatus fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

/// The source of the printer.
enum PrinterSource {
  /// Printer was added by user.
  user('USER'),

  /// Printer was added via policy.
  policy('POLICY');

  const PrinterSource(this.value);

  final String value;

  JSString get toJS => value.toJS;
  static PrinterSource fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
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

  /// The SSL certificate is expired. Printer accepts jobs but they fail.
  expiredCertificate('EXPIRED_CERTIFICATE'),

  /// The printer is available.
  available('AVAILABLE');

  const PrinterStatus(this.value);

  final String value;

  JSString get toJS => value.toJS;
  static PrinterStatus fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
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

  JSString get toJS => value.toJS;
  static JobStatus fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

class SubmitJobRequest {
  SubmitJobRequest.fromJS(this._wrapped);

  SubmitJobRequest({
    /// The print job to be submitted.
    /// The only supported content type is "application/pdf", and the
    /// [Cloud Job
    /// Ticket](https://developers.google.com/cloud-print/docs/cdd#cjt)
    /// shouldn't include `FitToPageTicketItem`,
    /// `PageRangeTicketItem`, `ReverseOrderTicketItem`
    /// and `VendorTicketItem` fields since they are
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
  /// The only supported content type is "application/pdf", and the
  /// [Cloud Job Ticket](https://developers.google.com/cloud-print/docs/cdd#cjt)
  /// shouldn't include `FitToPageTicketItem`,
  /// `PageRangeTicketItem`, `ReverseOrderTicketItem`
  /// and `VendorTicketItem` fields since they are
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
  }) : _wrapped = $js.SubmitJobResponse(status: status.toJS, jobId: jobId);

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
  OnJobStatusChangedEvent({required this.jobId, required this.status});

  final String jobId;

  final JobStatus status;
}
