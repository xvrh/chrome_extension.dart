// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'printer_provider.dart';

export 'chrome.dart';

extension JSChromeJSPrintingExtension on JSChrome {
  @JS('printing')
  external JSPrinting? get printingNullable;

  /// Use the `chrome.printing` API to send print jobs to printers
  /// installed on Chromebook.
  JSPrinting get printing {
    var printingNullable = this.printingNullable;
    if (printingNullable == null) {
      throw ApiNotAvailableException('chrome.printing');
    }
    return printingNullable;
  }
}

@JS()
@staticInterop
class JSPrinting {}

extension JSPrintingExtension on JSPrinting {
  /// Submits the job for print.
  /// If the extension is not listed in PrintingAPIExtensionsAllowlist policy,
  /// the user will be prompted to accept the print job.
  external JSPromise submitJob(SubmitJobRequest request);

  /// Cancels previously submitted job.
  /// |jobId|: The id of the print job to cancel. This should be the same id
  /// received in a [SubmitJobResponse].
  external JSPromise cancelJob(String jobId);

  /// Returns the list of available printers on the device. This includes
  /// manually added, enterprise and discovered printers.
  external JSPromise getPrinters();

  /// Returns the status and capabilities of the printer in
  /// <a href="https://developers.google.com/cloud-print/docs/cdd#cdd">
  /// CDD format</a>.
  /// This call will fail with a runtime error if no printers with given id are
  /// installed.
  external JSPromise getPrinterInfo(String printerId);

  /// Event fired when the status of the job is changed.
  /// This is only fired for the jobs created by this extension.
  external Event get onJobStatusChanged;

  /// The maximum number of times that [submitJob] can be called per
  /// minute.
  external int get MAX_SUBMIT_JOB_CALLS_PER_MINUTE;

  /// The maximum number of times that [getPrinterInfo] can be called per
  /// minute.
  external int get MAX_GET_PRINTER_INFO_CALLS_PER_MINUTE;
}

/// The status of [submitJob] request.
typedef SubmitJobStatus = String;

/// The source of the printer.
typedef PrinterSource = String;

/// The status of the printer.
typedef PrinterStatus = String;

/// Status of the print job.
typedef JobStatus = String;

@JS()
@staticInterop
@anonymous
class SubmitJobRequest {
  external factory SubmitJobRequest({
    /// The print job to be submitted.
    /// The only supported content type is "application/pdf", and the CJT ticket
    /// shouldn't include FitToPageTicketItem, PageRangeTicketItem,
    /// ReverseOrderTicketItem and VendorTicketItem fields since they are
    /// irrelevant for native printing. All other fields must be present.
    PrintJob job,

    /// Used internally to store the blob uuid after parameter customization and
    /// shouldn't be populated by the extension.
    String? documentBlobUuid,
  });
}

extension SubmitJobRequestExtension on SubmitJobRequest {
  /// The print job to be submitted.
  /// The only supported content type is "application/pdf", and the CJT ticket
  /// shouldn't include FitToPageTicketItem, PageRangeTicketItem,
  /// ReverseOrderTicketItem and VendorTicketItem fields since they are
  /// irrelevant for native printing. All other fields must be present.
  external PrintJob job;

  /// Used internally to store the blob uuid after parameter customization and
  /// shouldn't be populated by the extension.
  external String? documentBlobUuid;
}

@JS()
@staticInterop
@anonymous
class SubmitJobResponse {
  external factory SubmitJobResponse({
    /// The status of the request.
    SubmitJobStatus status,

    /// The id of created print job. This is a unique identifier among all print
    /// jobs on the device. If status is not OK, jobId will be null.
    String? jobId,
  });
}

extension SubmitJobResponseExtension on SubmitJobResponse {
  /// The status of the request.
  external SubmitJobStatus status;

  /// The id of created print job. This is a unique identifier among all print
  /// jobs on the device. If status is not OK, jobId will be null.
  external String? jobId;
}

@JS()
@staticInterop
@anonymous
class Printer {
  external factory Printer({
    /// The printer's identifier; guaranteed to be unique among printers on the
    /// device.
    String id,

    /// The name of the printer.
    String name,

    /// The human-readable description of the printer.
    String description,

    /// The printer URI. This can be used by extensions to choose the printer for
    /// the user.
    String uri,

    /// The source of the printer (user or policy configured).
    PrinterSource source,

    /// The flag which shows whether the printer fits
    /// <a
    /// href="https://chromium.org/administrators/policy-list-3#DefaultPrinterSelection">
    /// DefaultPrinterSelection</a> rules.
    /// Note that several printers could be flagged.
    bool isDefault,

    /// The value showing how recent the printer was used for printing from
    /// Chrome. The lower the value is the more recent the printer was used. The
    /// minimum value is 0. Missing value indicates that the printer wasn't used
    /// recently. This value is guaranteed to be unique amongst printers.
    int? recentlyUsedRank,
  });
}

extension PrinterExtension on Printer {
  /// The printer's identifier; guaranteed to be unique among printers on the
  /// device.
  external String id;

  /// The name of the printer.
  external String name;

  /// The human-readable description of the printer.
  external String description;

  /// The printer URI. This can be used by extensions to choose the printer for
  /// the user.
  external String uri;

  /// The source of the printer (user or policy configured).
  external PrinterSource source;

  /// The flag which shows whether the printer fits
  /// <a
  /// href="https://chromium.org/administrators/policy-list-3#DefaultPrinterSelection">
  /// DefaultPrinterSelection</a> rules.
  /// Note that several printers could be flagged.
  external bool isDefault;

  /// The value showing how recent the printer was used for printing from
  /// Chrome. The lower the value is the more recent the printer was used. The
  /// minimum value is 0. Missing value indicates that the printer wasn't used
  /// recently. This value is guaranteed to be unique amongst printers.
  external int? recentlyUsedRank;
}

@JS()
@staticInterop
@anonymous
class GetPrinterInfoResponse {
  external factory GetPrinterInfoResponse({
    /// Printer capabilities in
    /// <a href="https://developers.google.com/cloud-print/docs/cdd#cdd">
    /// CDD format</a>.
    /// The property may be missing.
    JSAny? capabilities,

    /// The status of the printer.
    PrinterStatus status,
  });
}

extension GetPrinterInfoResponseExtension on GetPrinterInfoResponse {
  /// Printer capabilities in
  /// <a href="https://developers.google.com/cloud-print/docs/cdd#cdd">
  /// CDD format</a>.
  /// The property may be missing.
  external JSAny? capabilities;

  /// The status of the printer.
  external PrinterStatus status;
}
