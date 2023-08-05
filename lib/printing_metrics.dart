// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'printing.dart';
import 'src/internal_helpers.dart';
import 'src/js/printing_metrics.dart' as $js;

export 'src/chrome.dart' show chrome;

final _printingMetrics = ChromePrintingMetrics._();

extension ChromePrintingMetricsExtension on Chrome {
  /// Use the `chrome.printingMetrics` API to fetch data about
  /// printing usage.
  ChromePrintingMetrics get printingMetrics => _printingMetrics;
}

class ChromePrintingMetrics {
  ChromePrintingMetrics._();

  bool get isAvailable =>
      $js.chrome.printingMetricsNullable != null && alwaysTrue;

  /// Returns the list of the finished print jobs.
  Future<List<PrintJobInfo>> getPrintJobs() async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.printingMetrics.getPrintJobs());
    return $res.toDart
        .cast<$js.PrintJobInfo>()
        .map((e) => PrintJobInfo.fromJS(e))
        .toList();
  }

  /// Event fired when the print job is finished.
  /// This includes any of termination statuses: FAILED, CANCELED and PRINTED.
  EventStream<PrintJobInfo> get onPrintJobFinished =>
      $js.chrome.printingMetrics.onPrintJobFinished
          .asStream(($c) => ($js.PrintJobInfo jobInfo) {
                return $c(PrintJobInfo.fromJS(jobInfo));
              });
}

/// The source of the print job.
enum PrintJobSource {
  /// The job was created from the Print Preview page initiated by the user.
  printPreview('PRINT_PREVIEW'),

  /// The job was created from an Android App.
  androidApp('ANDROID_APP'),

  /// The job was created by extension via Chrome API.
  extension('EXTENSION');

  const PrintJobSource(this.value);

  final String value;

  String get toJS => value;
  static PrintJobSource fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The final status of the print job.
enum PrintJobStatus {
  /// Print job was interrupted due to some error.
  failed('FAILED'),

  /// Print job was canceled by the user or via API.
  canceled('CANCELED'),

  /// Print job was printed without any errors.
  printed('PRINTED');

  const PrintJobStatus(this.value);

  final String value;

  String get toJS => value;
  static PrintJobStatus fromJS(String value) =>
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

enum ColorMode {
  /// Black and white mode was used.
  blackAndWhite('BLACK_AND_WHITE'),

  /// Color mode was used.
  color('COLOR');

  const ColorMode(this.value);

  final String value;

  String get toJS => value;
  static ColorMode fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum DuplexMode {
  /// One-sided printing was used.
  oneSided('ONE_SIDED'),

  /// Two-sided printing was used, flipping on long edge.
  twoSidedLongEdge('TWO_SIDED_LONG_EDGE'),

  /// Two-sided printing was used, flipping on short edge.
  twoSidedShortEdge('TWO_SIDED_SHORT_EDGE');

  const DuplexMode(this.value);

  final String value;

  String get toJS => value;
  static DuplexMode fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class MediaSize {
  MediaSize.fromJS(this._wrapped);

  MediaSize({
    /// Width (in micrometers) of the media used for printing.
    required int width,

    /// Height (in micrometers) of the media used for printing.
    required int height,

    /// Vendor-provided ID, e.g. "iso_a3_297x420mm" or "na_index-3x5_3x5in".
    /// Possible values are values of "media" IPP attribute and can be found on
    /// <a
    /// href="https://www.iana.org/assignments/ipp-registrations/ipp-registrations.xhtml">
    /// IANA page</a> .
    required String vendorId,
  }) : _wrapped = $js.MediaSize(
          width: width,
          height: height,
          vendorId: vendorId,
        );

  final $js.MediaSize _wrapped;

  $js.MediaSize get toJS => _wrapped;

  /// Width (in micrometers) of the media used for printing.
  int get width => _wrapped.width;
  set width(int v) {
    _wrapped.width = v;
  }

  /// Height (in micrometers) of the media used for printing.
  int get height => _wrapped.height;
  set height(int v) {
    _wrapped.height = v;
  }

  /// Vendor-provided ID, e.g. "iso_a3_297x420mm" or "na_index-3x5_3x5in".
  /// Possible values are values of "media" IPP attribute and can be found on
  /// <a
  /// href="https://www.iana.org/assignments/ipp-registrations/ipp-registrations.xhtml">
  /// IANA page</a> .
  String get vendorId => _wrapped.vendorId;
  set vendorId(String v) {
    _wrapped.vendorId = v;
  }
}

class PrintSettings {
  PrintSettings.fromJS(this._wrapped);

  PrintSettings({
    /// The requested color mode.
    required ColorMode color,

    /// The requested duplex mode.
    required DuplexMode duplex,

    /// The requested media size.
    required MediaSize mediaSize,

    /// The requested number of copies.
    required int copies,
  }) : _wrapped = $js.PrintSettings(
          color: color.toJS,
          duplex: duplex.toJS,
          mediaSize: mediaSize.toJS,
          copies: copies,
        );

  final $js.PrintSettings _wrapped;

  $js.PrintSettings get toJS => _wrapped;

  /// The requested color mode.
  ColorMode get color => ColorMode.fromJS(_wrapped.color);
  set color(ColorMode v) {
    _wrapped.color = v.toJS;
  }

  /// The requested duplex mode.
  DuplexMode get duplex => DuplexMode.fromJS(_wrapped.duplex);
  set duplex(DuplexMode v) {
    _wrapped.duplex = v.toJS;
  }

  /// The requested media size.
  MediaSize get mediaSize => MediaSize.fromJS(_wrapped.mediaSize);
  set mediaSize(MediaSize v) {
    _wrapped.mediaSize = v.toJS;
  }

  /// The requested number of copies.
  int get copies => _wrapped.copies;
  set copies(int v) {
    _wrapped.copies = v;
  }
}

class Printer {
  Printer.fromJS(this._wrapped);

  Printer({
    /// Displayed name of the printer.
    required String name,

    /// The full path for the printer.
    /// Contains protocol, hostname, port, and queue.
    required String uri,

    /// The source of the printer.
    required PrinterSource source,
  }) : _wrapped = $js.Printer(
          name: name,
          uri: uri,
          source: source.toJS,
        );

  final $js.Printer _wrapped;

  $js.Printer get toJS => _wrapped;

  /// Displayed name of the printer.
  String get name => _wrapped.name;
  set name(String v) {
    _wrapped.name = v;
  }

  /// The full path for the printer.
  /// Contains protocol, hostname, port, and queue.
  String get uri => _wrapped.uri;
  set uri(String v) {
    _wrapped.uri = v;
  }

  /// The source of the printer.
  PrinterSource get source => PrinterSource.fromJS(_wrapped.source);
  set source(PrinterSource v) {
    _wrapped.source = v.toJS;
  }
}

class PrintJobInfo {
  PrintJobInfo.fromJS(this._wrapped);

  PrintJobInfo({
    /// The ID of the job.
    required String id,

    /// The title of the document which was printed.
    required String title,

    /// Source showing who initiated the print job.
    required PrintJobSource source,

    /// ID of source. Null if source is PRINT_PREVIEW or ANDROID_APP.
    String? sourceId,

    /// The final status of the job.
    required PrintJobStatus status,

    /// The job creation time (in milliseconds past the Unix epoch).
    required double creationTime,

    /// The job completion time (in milliseconds past the Unix epoch).
    required double completionTime,

    /// The info about the printer which printed the document.
    required Printer printer,

    /// The settings of the print job.
    required PrintSettings settings,

    /// The number of pages in the document.
    required int numberOfPages,

    /// The status of the printer.
    required PrinterStatus printerStatus,
  }) : _wrapped = $js.PrintJobInfo(
          id: id,
          title: title,
          source: source.toJS,
          sourceId: sourceId,
          status: status.toJS,
          creationTime: creationTime,
          completionTime: completionTime,
          printer: printer.toJS,
          settings: settings.toJS,
          numberOfPages: numberOfPages,
          printer_status: printerStatus.toJS,
        );

  final $js.PrintJobInfo _wrapped;

  $js.PrintJobInfo get toJS => _wrapped;

  /// The ID of the job.
  String get id => _wrapped.id;
  set id(String v) {
    _wrapped.id = v;
  }

  /// The title of the document which was printed.
  String get title => _wrapped.title;
  set title(String v) {
    _wrapped.title = v;
  }

  /// Source showing who initiated the print job.
  PrintJobSource get source => PrintJobSource.fromJS(_wrapped.source);
  set source(PrintJobSource v) {
    _wrapped.source = v.toJS;
  }

  /// ID of source. Null if source is PRINT_PREVIEW or ANDROID_APP.
  String? get sourceId => _wrapped.sourceId;
  set sourceId(String? v) {
    _wrapped.sourceId = v;
  }

  /// The final status of the job.
  PrintJobStatus get status => PrintJobStatus.fromJS(_wrapped.status);
  set status(PrintJobStatus v) {
    _wrapped.status = v.toJS;
  }

  /// The job creation time (in milliseconds past the Unix epoch).
  double get creationTime => _wrapped.creationTime;
  set creationTime(double v) {
    _wrapped.creationTime = v;
  }

  /// The job completion time (in milliseconds past the Unix epoch).
  double get completionTime => _wrapped.completionTime;
  set completionTime(double v) {
    _wrapped.completionTime = v;
  }

  /// The info about the printer which printed the document.
  Printer get printer => Printer.fromJS(_wrapped.printer);
  set printer(Printer v) {
    _wrapped.printer = v.toJS;
  }

  /// The settings of the print job.
  PrintSettings get settings => PrintSettings.fromJS(_wrapped.settings);
  set settings(PrintSettings v) {
    _wrapped.settings = v.toJS;
  }

  /// The number of pages in the document.
  int get numberOfPages => _wrapped.numberOfPages;
  set numberOfPages(int v) {
    _wrapped.numberOfPages = v;
  }

  /// The status of the printer.
  PrinterStatus get printerStatus =>
      PrinterStatus.fromJS(_wrapped.printer_status);
  set printerStatus(PrinterStatus v) {
    _wrapped.printer_status = v.toJS;
  }
}
