// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'src/internal_helpers.dart';
import 'src/js/printer_provider.dart' as $js;
import 'src/js/usb.dart' as $js_usb;
import 'usb.dart';

export 'src/chrome.dart' show chrome, EventStream;

final _printerProvider = ChromePrinterProvider._();

extension ChromePrinterProviderExtension on Chrome {
  /// The `chrome.printerProvider` API exposes events used by print
  /// manager to query printers controlled by extensions, to query their
  /// capabilities and to submit print jobs to these printers.
  ChromePrinterProvider get printerProvider => _printerProvider;
}

class ChromePrinterProvider {
  ChromePrinterProvider._();

  bool get isAvailable =>
      $js.chrome.printerProviderNullable != null && alwaysTrue;

  /// Event fired when print manager requests printers provided by extensions.
  /// |resultCallback|: Callback to return printer list. Every listener must
  /// call callback exactly once.
  EventStream<void Function(List<PrinterInfo>)> get onGetPrintersRequested =>
      $js.chrome.printerProvider.onGetPrintersRequested
          .asStream(($c) => ($js.PrintersCallback resultCallback) {
                return $c((List<PrinterInfo> printerInfo) {
                  resultCallback.callAsFunction(
                      null, printerInfo.toJSArray((e) => e.toJS));
                });
              }.toJS);

  /// Event fired when print manager requests information about a USB device
  /// that may be a printer.
  /// _Note:_ An application should not rely on this event being
  /// fired more than once per device. If a connected device is supported it
  /// should be returned in the [onGetPrintersRequested] event.
  /// |device|: The USB device.
  /// |resultCallback|: Callback to return printer info. The receiving listener
  /// must call callback exactly once. If the parameter to this callback is
  /// undefined that indicates that the application has determined that the
  /// device is not supported.
  EventStream<OnGetUsbPrinterInfoRequestedEvent>
      get onGetUsbPrinterInfoRequested =>
          $js.chrome.printerProvider.onGetUsbPrinterInfoRequested
              .asStream(($c) => (
                    $js_usb.Device device,
                    $js.PrinterInfoCallback resultCallback,
                  ) {
                    return $c(OnGetUsbPrinterInfoRequestedEvent(
                      device: Device.fromJS(device),
                      resultCallback: (PrinterInfo? printerInfo) {
                        resultCallback.callAsFunction(null, printerInfo?.toJS);
                      },
                    ));
                  }.toJS);

  /// Event fired when print manager requests printer capabilities.
  /// |printerId|: Unique ID of the printer whose capabilities are requested.
  /// |resultCallback|: Callback to return device capabilities in
  /// <a href="https://developers.google.com/cloud-print/docs/cdd#cdd">CDD
  /// format</a>.
  /// The receiving listener must call callback exectly once.
  EventStream<OnGetCapabilityRequestedEvent> get onGetCapabilityRequested =>
      $js.chrome.printerProvider.onGetCapabilityRequested.asStream(($c) => (
            String printerId,
            $js.CapabilitiesCallback resultCallback,
          ) {
            return $c(OnGetCapabilityRequestedEvent(
              printerId: printerId,
              resultCallback: (Map capabilities) {
                resultCallback.callAsFunction(null, capabilities.jsify()!);
              },
            ));
          }.toJS);

  /// Event fired when print manager requests printing.
  /// |printJob|: The printing request parameters.
  /// |resultCallback|: Callback that should be called when the printing
  /// request is completed.
  EventStream<OnPrintRequestedEvent> get onPrintRequested =>
      $js.chrome.printerProvider.onPrintRequested.asStream(($c) => (
            $js.PrintJob printJob,
            $js.PrintCallback resultCallback,
          ) {
            return $c(OnPrintRequestedEvent(
              printJob: PrintJob.fromJS(printJob),
              resultCallback: (PrintError result) {
                resultCallback.callAsFunction(null, result.toJS);
              },
            ));
          }.toJS);
}

/// Error codes returned in response to [onPrintRequested] event.
enum PrintError {
  /// Specifies that the operation was completed successfully.
  ok('OK'),

  /// Specifies that a general failure occured.
  failed('FAILED'),

  /// Specifies that the print ticket is invalid. For example, the ticket is
  /// inconsistent with some capabilities, or the extension is not able to
  /// handle all settings from the ticket.
  invalidTicket('INVALID_TICKET'),

  /// Specifies that the document is invalid. For example, data may be
  /// corrupted or the format is incompatible with the extension.
  invalidData('INVALID_DATA');

  const PrintError(this.value);

  final String value;

  JSString get toJS => value.toJS;
  static PrintError fromJS(JSString value) =>
      values.firstWhere((e) => e.value == value.toDart);
}

typedef PrintersCallback = void Function(List<PrinterInfo>);

typedef PrinterInfoCallback = void Function(PrinterInfo?);

/// |capabilities|: Device capabilities in
/// <a href="https://developers.google.com/cloud-print/docs/cdd#cdd">CDD
/// format</a>.
typedef CapabilitiesCallback = void Function(Map);

typedef PrintCallback = void Function(PrintError);

class PrinterInfo {
  PrinterInfo.fromJS(this._wrapped);

  PrinterInfo({
    /// Unique printer ID.
    required String id,

    /// Printer's human readable name.
    required String name,

    /// Printer's human readable description.
    String? description,
  }) : _wrapped = $js.PrinterInfo(
          id: id,
          name: name,
          description: description,
        );

  final $js.PrinterInfo _wrapped;

  $js.PrinterInfo get toJS => _wrapped;

  /// Unique printer ID.
  String get id => _wrapped.id;

  set id(String v) {
    _wrapped.id = v;
  }

  /// Printer's human readable name.
  String get name => _wrapped.name;

  set name(String v) {
    _wrapped.name = v;
  }

  /// Printer's human readable description.
  String? get description => _wrapped.description;

  set description(String? v) {
    _wrapped.description = v;
  }
}

class PrintJob {
  PrintJob.fromJS(this._wrapped);

  PrintJob({
    /// ID of the printer which should handle the job.
    required String printerId,

    /// The print job title.
    required String title,

    /// Print ticket in
    /// <a href="https://developers.google.com/cloud-print/docs/cdd#cjt">
    /// CJT format</a>.
    /// <aside class="aside flow bg-state-info-bg color-state-info-text">
    /// <div class="flow">The CJT reference is marked as deprecated. It is
    /// deprecated for Google Cloud Print only. is not deprecated for
    /// ChromeOS printing.
    /// </div>
    /// </aside>
    required Map ticket,

    /// The document content type. Supported formats are
    /// `"application/pdf"` and `"image/pwg-raster"`.
    required String contentType,

    /// Blob containing the document data to print. Format must match
    /// |contentType|.
    required JSObject document,
  }) : _wrapped = $js.PrintJob(
          printerId: printerId,
          title: title,
          ticket: ticket.jsify()!,
          contentType: contentType,
          document: document,
        );

  final $js.PrintJob _wrapped;

  $js.PrintJob get toJS => _wrapped;

  /// ID of the printer which should handle the job.
  String get printerId => _wrapped.printerId;

  set printerId(String v) {
    _wrapped.printerId = v;
  }

  /// The print job title.
  String get title => _wrapped.title;

  set title(String v) {
    _wrapped.title = v;
  }

  /// Print ticket in
  /// <a href="https://developers.google.com/cloud-print/docs/cdd#cjt">
  /// CJT format</a>.
  /// <aside class="aside flow bg-state-info-bg color-state-info-text">
  /// <div class="flow">The CJT reference is marked as deprecated. It is
  /// deprecated for Google Cloud Print only. is not deprecated for
  /// ChromeOS printing.
  /// </div>
  /// </aside>
  Map get ticket => _wrapped.ticket.toDartMap();

  set ticket(Map v) {
    _wrapped.ticket = v.jsify()!;
  }

  /// The document content type. Supported formats are
  /// `"application/pdf"` and `"image/pwg-raster"`.
  String get contentType => _wrapped.contentType;

  set contentType(String v) {
    _wrapped.contentType = v;
  }

  /// Blob containing the document data to print. Format must match
  /// |contentType|.
  JSObject get document => _wrapped.document;

  set document(JSObject v) {
    _wrapped.document = v;
  }
}

class OnGetUsbPrinterInfoRequestedEvent {
  OnGetUsbPrinterInfoRequestedEvent({
    required this.device,
    required this.resultCallback,
  });

  final Device device;

  final void Function(PrinterInfo?) resultCallback;
}

class OnGetCapabilityRequestedEvent {
  OnGetCapabilityRequestedEvent({
    required this.printerId,
    required this.resultCallback,
  });

  final String printerId;

  final void Function(Map) resultCallback;
}

class OnPrintRequestedEvent {
  OnPrintRequestedEvent({
    required this.printJob,
    required this.resultCallback,
  });

  final PrintJob printJob;

  final void Function(PrintError) resultCallback;
}
