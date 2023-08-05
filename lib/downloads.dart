// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/downloads.dart' as $js;

export 'src/chrome.dart' show chrome;

final _downloads = ChromeDownloads._();

extension ChromeDownloadsExtension on Chrome {
  /// Use the `chrome.downloads` API to programmatically initiate,
  /// monitor, manipulate, and search for downloads.
  ChromeDownloads get downloads => _downloads;
}

class ChromeDownloads {
  ChromeDownloads._();

  bool get isAvailable => $js.chrome.downloadsNullable != null && alwaysTrue;

  /// Download a URL. If the URL uses the HTTP[S] protocol, then the request
  /// will include all cookies currently set for its hostname. If both
  /// `filename` and `saveAs` are specified, then the
  /// Save As dialog will be displayed, pre-populated with the specified
  /// `filename`. If the download started successfully,
  /// `callback` will be called with the new [DownloadItem]'s
  /// `downloadId`. If there was an error starting the download,
  /// then `callback` will be called with
  /// `downloadId=undefined` and [runtime.lastError] will contain
  /// a descriptive string. The error strings are not guaranteed to remain
  /// backwards compatible between releases. Extensions must not parse it.
  /// |options|: What to download and how.
  /// |callback|: Called with the id of the new [DownloadItem].
  Future<int> download(DownloadOptions options) async {
    var $res =
        await promiseToFuture<int>($js.chrome.downloads.download(options.toJS));
    return $res;
  }

  /// Find [DownloadItem]. Set `query` to the empty object to get
  /// all [DownloadItem]. To get a specific [DownloadItem], set only the
  /// `id` field. To page through a large number of items, set
  /// `orderBy: ['-startTime']`, set `limit` to the
  /// number of items per page, and set `startedAfter` to the
  /// `startTime` of the last item from the last page.
  Future<List<DownloadItem>> search(DownloadQuery query) async {
    var $res =
        await promiseToFuture<JSArray>($js.chrome.downloads.search(query.toJS));
    return $res.toDart
        .cast<$js.DownloadItem>()
        .map((e) => DownloadItem.fromJS(e))
        .toList();
  }

  /// Pause the download. If the request was successful the download is in a
  /// paused state. Otherwise [runtime.lastError] contains an error message.
  /// The request will fail if the download is not active.
  /// |downloadId|: The id of the download to pause.
  /// |callback|: Called when the pause request is completed.
  Future<void> pause(int downloadId) async {
    await promiseToFuture<void>($js.chrome.downloads.pause(downloadId));
  }

  /// Resume a paused download. If the request was successful the download is
  /// in progress and unpaused. Otherwise [runtime.lastError] contains an
  /// error message. The request will fail if the download is not active.
  /// |downloadId|: The id of the download to resume.
  /// |callback|: Called when the resume request is completed.
  Future<void> resume(int downloadId) async {
    await promiseToFuture<void>($js.chrome.downloads.resume(downloadId));
  }

  /// Cancel a download. When `callback` is run, the download is
  /// cancelled, completed, interrupted or doesn't exist anymore.
  /// |downloadId|: The id of the download to cancel.
  /// |callback|: Called when the cancel request is completed.
  Future<void> cancel(int downloadId) async {
    await promiseToFuture<void>($js.chrome.downloads.cancel(downloadId));
  }

  /// Retrieve an icon for the specified download. For new downloads, file
  /// icons are available after the [onCreated] event has been received. The
  /// image returned by this function while a download is in progress may be
  /// different from the image returned after the download is complete. Icon
  /// retrieval is done by querying the underlying operating system or toolkit
  /// depending on the platform. The icon that is returned will therefore
  /// depend on a number of factors including state of the download, platform,
  /// registered file types and visual theme. If a file icon cannot be
  /// determined, [runtime.lastError] will contain an error message.
  /// |downloadId|: The identifier for the download.
  /// |callback|: A URL to an image that represents the download.
  Future<String?> getFileIcon(
    int downloadId,
    GetFileIconOptions? options,
  ) async {
    var $res = await promiseToFuture<String?>($js.chrome.downloads.getFileIcon(
      downloadId,
      options?.toJS,
    ));
    return $res;
  }

  /// Open the downloaded file now if the [DownloadItem] is complete;
  /// otherwise returns an error through [runtime.lastError]. Requires the
  /// `"downloads.open"` permission in addition to the
  /// `"downloads"` permission. An [onChanged] event will fire
  /// when the item is opened for the first time.
  /// |downloadId|: The identifier for the downloaded file.
  void open(int downloadId) {
    $js.chrome.downloads.open(downloadId);
  }

  /// Show the downloaded file in its folder in a file manager.
  /// |downloadId|: The identifier for the downloaded file.
  void show(int downloadId) {
    $js.chrome.downloads.show(downloadId);
  }

  /// Show the default Downloads folder in a file manager.
  void showDefaultFolder() {
    $js.chrome.downloads.showDefaultFolder();
  }

  /// Erase matching [DownloadItem] from history without deleting the
  /// downloaded file. An [onErased] event will fire for each
  /// [DownloadItem] that matches `query`, then
  /// `callback` will be called.
  Future<List<int>> erase(DownloadQuery query) async {
    var $res =
        await promiseToFuture<JSArray>($js.chrome.downloads.erase(query.toJS));
    return $res.toDart.cast<int>().map((e) => e).toList();
  }

  /// Remove the downloaded file if it exists and the [DownloadItem] is
  /// complete; otherwise return an error through [runtime.lastError].
  Future<void> removeFile(int downloadId) async {
    await promiseToFuture<void>($js.chrome.downloads.removeFile(downloadId));
  }

  /// Prompt the user to accept a dangerous download. Can only be called from a
  /// visible context (tab, window, or page/browser action popup). Does not
  /// automatically accept dangerous downloads. If the download is accepted,
  /// then an [onChanged] event will fire, otherwise nothing will happen.
  /// When all the data is fetched into a temporary file and either the
  /// download is not dangerous or the danger has been accepted, then the
  /// temporary file is renamed to the target filename, the |state| changes to
  /// 'complete', and [onChanged] fires.
  /// |downloadId|: The identifier for the [DownloadItem].
  /// |callback|: Called when the danger prompt dialog closes.
  Future<void> acceptDanger(int downloadId) async {
    await promiseToFuture<void>($js.chrome.downloads.acceptDanger(downloadId));
  }

  /// Enable or disable the gray shelf at the bottom of every window associated
  /// with the current browser profile. The shelf will be disabled as long as
  /// at least one extension has disabled it. Enabling the shelf while at least
  /// one other extension has disabled it will return an error through
  /// [runtime.lastError]. Requires the `"downloads.shelf"`
  /// permission in addition to the `"downloads"` permission.
  void setShelfEnabled(bool enabled) {
    $js.chrome.downloads.setShelfEnabled(enabled);
  }

  /// Change the download UI of every window associated with the current
  /// browser profile. As long as at least one extension has set
  /// [UiOptions.enabled] to false, the download UI will be hidden.
  /// Setting [UiOptions.enabled] to true while at least one other
  /// extension has disabled it will return an error through
  /// [runtime.lastError]. Requires the `"downloads.ui"`
  /// permission in addition to the `"downloads"` permission.
  /// |options|: Encapsulate a change to the download UI.
  /// |callback|: Called when the UI update is completed.
  Future<void> setUiOptions(UiOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.downloads.setUiOptions(options.toJS));
  }

  /// This event fires with the [DownloadItem] object when a download
  /// begins.
  EventStream<DownloadItem> get onCreated => $js.chrome.downloads.onCreated
      .asStream(($c) => ($js.DownloadItem downloadItem) {
            return $c(DownloadItem.fromJS(downloadItem));
          });

  /// Fires with the `downloadId` when a download is erased from
  /// history.
  /// |downloadId|: The `id` of the [DownloadItem] that was
  /// erased.
  EventStream<int> get onErased =>
      $js.chrome.downloads.onErased.asStream(($c) => (int downloadId) {
            return $c(downloadId);
          });

  /// When any of a [DownloadItem]'s properties except
  /// `bytesReceived` and `estimatedEndTime` changes,
  /// this event fires with the `downloadId` and an object
  /// containing the properties that changed.
  EventStream<DownloadDelta> get onChanged => $js.chrome.downloads.onChanged
      .asStream(($c) => ($js.DownloadDelta downloadDelta) {
            return $c(DownloadDelta.fromJS(downloadDelta));
          });

  /// During the filename determination process, extensions will be given the
  /// opportunity to override the target [DownloadItem.filename]. Each
  /// extension may not register more than one listener for this event. Each
  /// listener must call `suggest` exactly once, either
  /// synchronously or asynchronously. If the listener calls
  /// `suggest` asynchronously, then it must return
  /// `true`. If the listener neither calls `suggest`
  /// synchronously nor returns `true`, then `suggest`
  /// will be called automatically. The [DownloadItem] will not complete
  /// until all listeners have called `suggest`. Listeners may call
  /// `suggest` without any arguments in order to allow the download
  /// to use `downloadItem.filename` for its filename, or pass a
  /// `suggestion` object to `suggest` in order to
  /// override the target filename. If more than one extension overrides the
  /// filename, then the last extension installed whose listener passes a
  /// `suggestion` object to `suggest` wins. In order to
  /// avoid confusion regarding which extension will win, users should not
  /// install extensions that may conflict. If the download is initiated by
  /// [download] and the target filename is known before the MIME type and
  /// tentative filename have been determined, pass `filename` to
  /// [download] instead.
  EventStream<OnDeterminingFilenameEvent> get onDeterminingFilename =>
      $js.chrome.downloads.onDeterminingFilename.asStream(($c) => (
            $js.DownloadItem downloadItem,
            $js.SuggestFilenameCallback suggest,
          ) {
            return $c(OnDeterminingFilenameEvent(
              downloadItem: DownloadItem.fromJS(downloadItem),
              suggest: (FilenameSuggestion? suggestion) {
                //ignore: avoid_dynamic_calls
                (suggest as Function)(suggestion?.toJS);
              },
            ));
          });
}

/// <dl><dt>uniquify</dt>
///     <dd>To avoid duplication, the `filename` is changed to
///     include a counter before the filename extension.</dd>
///     <dt>overwrite</dt>
///     <dd>The existing file will be overwritten with the new file.</dd>
///     <dt>prompt</dt>
///     <dd>The user will be prompted with a file chooser dialog.</dd>
/// </dl>
enum FilenameConflictAction {
  uniquify('uniquify'),
  overwrite('overwrite'),
  prompt('prompt');

  const FilenameConflictAction(this.value);

  final String value;

  String get toJS => value;
  static FilenameConflictAction fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum HttpMethod {
  get('GET'),
  post('POST');

  const HttpMethod(this.value);

  final String value;

  String get toJS => value;
  static HttpMethod fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum InterruptReason {
  fileFailed('FILE_FAILED'),
  fileAccessDenied('FILE_ACCESS_DENIED'),
  fileNoSpace('FILE_NO_SPACE'),
  fileNameTooLong('FILE_NAME_TOO_LONG'),
  fileTooLarge('FILE_TOO_LARGE'),
  fileVirusInfected('FILE_VIRUS_INFECTED'),
  fileTransientError('FILE_TRANSIENT_ERROR'),
  fileBlocked('FILE_BLOCKED'),
  fileSecurityCheckFailed('FILE_SECURITY_CHECK_FAILED'),
  fileTooShort('FILE_TOO_SHORT'),
  fileHashMismatch('FILE_HASH_MISMATCH'),
  fileSameAsSource('FILE_SAME_AS_SOURCE'),
  networkFailed('NETWORK_FAILED'),
  networkTimeout('NETWORK_TIMEOUT'),
  networkDisconnected('NETWORK_DISCONNECTED'),
  networkServerDown('NETWORK_SERVER_DOWN'),
  networkInvalidRequest('NETWORK_INVALID_REQUEST'),
  serverFailed('SERVER_FAILED'),
  serverNoRange('SERVER_NO_RANGE'),
  serverBadContent('SERVER_BAD_CONTENT'),
  serverUnauthorized('SERVER_UNAUTHORIZED'),
  serverCertProblem('SERVER_CERT_PROBLEM'),
  serverForbidden('SERVER_FORBIDDEN'),
  serverUnreachable('SERVER_UNREACHABLE'),
  serverContentLengthMismatch('SERVER_CONTENT_LENGTH_MISMATCH'),
  serverCrossOriginRedirect('SERVER_CROSS_ORIGIN_REDIRECT'),
  userCanceled('USER_CANCELED'),
  userShutdown('USER_SHUTDOWN'),
  crash('CRASH');

  const InterruptReason(this.value);

  final String value;

  String get toJS => value;
  static InterruptReason fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// <dl><dt>file</dt>
///     <dd>The download's filename is suspicious.</dd>
///     <dt>url</dt>
///     <dd>The download's URL is known to be malicious.</dd>
///     <dt>content</dt>
///     <dd>The downloaded file is known to be malicious.</dd>
///     <dt>uncommon</dt>
///     <dd>The download's URL is not commonly downloaded and could be
///     dangerous.</dd>
///     <dt>host</dt>
///     <dd>The download came from a host known to distribute malicious
///     binaries and is likely dangerous.</dd>
///     <dt>unwanted</dt>
///     <dd>The download is potentially unwanted or unsafe. E.g. it could make
///     changes to browser or computer settings.</dd>
///     <dt>safe</dt>
///     <dd>The download presents no known danger to the user's computer.</dd>
///     <dt>accepted</dt>
///     <dd>The user has accepted the dangerous download.</dd>
/// </dl>
enum DangerType {
  file('file'),
  url('url'),
  content('content'),
  uncommon('uncommon'),
  host('host'),
  unwanted('unwanted'),
  safe('safe'),
  accepted('accepted'),
  allowlistedByPolicy('allowlistedByPolicy'),
  asyncScanning('asyncScanning'),
  passwordProtected('passwordProtected'),
  blockedTooLarge('blockedTooLarge'),
  sensitiveContentWarning('sensitiveContentWarning'),
  sensitiveContentBlock('sensitiveContentBlock'),
  unsupportedFileType('unsupportedFileType'),
  deepScannedSafe('deepScannedSafe'),
  deepScannedOpenedDangerous('deepScannedOpenedDangerous'),
  promptForScaning('promptForScaning'),
  accountCompromise('accountCompromise');

  const DangerType(this.value);

  final String value;

  String get toJS => value;
  static DangerType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// <dl><dt>in_progress</dt>
///     <dd>The download is currently receiving data from the server.</dd>
///     <dt>interrupted</dt>
///     <dd>An error broke the connection with the file host.</dd>
///     <dt>complete</dt>
///     <dd>The download completed successfully.</dd>
/// </dl>
enum State {
  inProgress('in_progress'),
  interrupted('interrupted'),
  complete('complete');

  const State(this.value);

  final String value;

  String get toJS => value;
  static State fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

typedef SuggestFilenameCallback = void Function(FilenameSuggestion?);

class HeaderNameValuePair {
  HeaderNameValuePair.fromJS(this._wrapped);

  HeaderNameValuePair({
    /// Name of the HTTP header.
    required String name,

    /// Value of the HTTP header.
    required String value,
  }) : _wrapped = $js.HeaderNameValuePair(
          name: name,
          value: value,
        );

  final $js.HeaderNameValuePair _wrapped;

  $js.HeaderNameValuePair get toJS => _wrapped;

  /// Name of the HTTP header.
  String get name => _wrapped.name;
  set name(String v) {
    _wrapped.name = v;
  }

  /// Value of the HTTP header.
  String get value => _wrapped.value;
  set value(String v) {
    _wrapped.value = v;
  }
}

class FilenameSuggestion {
  FilenameSuggestion.fromJS(this._wrapped);

  FilenameSuggestion({
    /// The [DownloadItem]'s new target [DownloadItem.filename], as a path
    /// relative to the user's default Downloads directory, possibly containing
    /// subdirectories. Absolute paths, empty paths, and paths containing
    /// back-references ".." will be ignored. `filename` is ignored if
    /// there are any [onDeterminingFilename] listeners registered by any
    /// extensions.
    required String filename,

    /// The action to take if `filename` already exists.
    FilenameConflictAction? conflictAction,
  }) : _wrapped = $js.FilenameSuggestion(
          filename: filename,
          conflictAction: conflictAction?.toJS,
        );

  final $js.FilenameSuggestion _wrapped;

  $js.FilenameSuggestion get toJS => _wrapped;

  /// The [DownloadItem]'s new target [DownloadItem.filename], as a path
  /// relative to the user's default Downloads directory, possibly containing
  /// subdirectories. Absolute paths, empty paths, and paths containing
  /// back-references ".." will be ignored. `filename` is ignored if
  /// there are any [onDeterminingFilename] listeners registered by any
  /// extensions.
  String get filename => _wrapped.filename;
  set filename(String v) {
    _wrapped.filename = v;
  }

  /// The action to take if `filename` already exists.
  FilenameConflictAction? get conflictAction =>
      _wrapped.conflictAction?.let(FilenameConflictAction.fromJS);
  set conflictAction(FilenameConflictAction? v) {
    _wrapped.conflictAction = v?.toJS;
  }
}

class DownloadOptions {
  DownloadOptions.fromJS(this._wrapped);

  DownloadOptions({
    /// The URL to download.
    required String url,

    /// A file path relative to the Downloads directory to contain the
    /// downloaded
    /// file, possibly containing subdirectories. Absolute paths, empty paths,
    /// and paths containing back-references ".." will cause an error.
    /// [onDeterminingFilename] allows suggesting a filename after the file's
    /// MIME type and a tentative filename have been determined.
    String? filename,

    /// The action to take if `filename` already exists.
    FilenameConflictAction? conflictAction,

    /// Use a file-chooser to allow the user to select a filename regardless of
    /// whether `filename` is set or already exists.
    bool? saveAs,

    /// The HTTP method to use if the URL uses the HTTP[S] protocol.
    HttpMethod? method,

    /// Extra HTTP headers to send with the request if the URL uses the HTTP[s]
    /// protocol. Each header is represented as a dictionary containing the keys
    /// `name` and either `value` or
    /// `binaryValue`, restricted to those allowed by XMLHttpRequest.
    List<HeaderNameValuePair>? headers,

    /// Post body.
    String? body,
  }) : _wrapped = $js.DownloadOptions(
          url: url,
          filename: filename,
          conflictAction: conflictAction?.toJS,
          saveAs: saveAs,
          method: method?.toJS,
          headers: headers?.toJSArray((e) => e.toJS),
          body: body,
        );

  final $js.DownloadOptions _wrapped;

  $js.DownloadOptions get toJS => _wrapped;

  /// The URL to download.
  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// A file path relative to the Downloads directory to contain the downloaded
  /// file, possibly containing subdirectories. Absolute paths, empty paths,
  /// and paths containing back-references ".." will cause an error.
  /// [onDeterminingFilename] allows suggesting a filename after the file's
  /// MIME type and a tentative filename have been determined.
  String? get filename => _wrapped.filename;
  set filename(String? v) {
    _wrapped.filename = v;
  }

  /// The action to take if `filename` already exists.
  FilenameConflictAction? get conflictAction =>
      _wrapped.conflictAction?.let(FilenameConflictAction.fromJS);
  set conflictAction(FilenameConflictAction? v) {
    _wrapped.conflictAction = v?.toJS;
  }

  /// Use a file-chooser to allow the user to select a filename regardless of
  /// whether `filename` is set or already exists.
  bool? get saveAs => _wrapped.saveAs;
  set saveAs(bool? v) {
    _wrapped.saveAs = v;
  }

  /// The HTTP method to use if the URL uses the HTTP[S] protocol.
  HttpMethod? get method => _wrapped.method?.let(HttpMethod.fromJS);
  set method(HttpMethod? v) {
    _wrapped.method = v?.toJS;
  }

  /// Extra HTTP headers to send with the request if the URL uses the HTTP[s]
  /// protocol. Each header is represented as a dictionary containing the keys
  /// `name` and either `value` or
  /// `binaryValue`, restricted to those allowed by XMLHttpRequest.
  List<HeaderNameValuePair>? get headers => _wrapped.headers?.toDart
      .cast<$js.HeaderNameValuePair>()
      .map((e) => HeaderNameValuePair.fromJS(e))
      .toList();
  set headers(List<HeaderNameValuePair>? v) {
    _wrapped.headers = v?.toJSArray((e) => e.toJS);
  }

  /// Post body.
  String? get body => _wrapped.body;
  set body(String? v) {
    _wrapped.body = v;
  }
}

class DownloadItem {
  DownloadItem.fromJS(this._wrapped);

  DownloadItem({
    /// An identifier that is persistent across browser sessions.
    required int id,

    /// The absolute URL that this download initiated from, before any
    /// redirects.
    required String url,

    /// The absolute URL that this download is being made from, after all
    /// redirects.
    required String finalUrl,

    /// Absolute URL.
    required String referrer,

    /// Absolute local path.
    required String filename,

    /// False if this download is recorded in the history, true if it is not
    /// recorded.
    required bool incognito,

    /// Indication of whether this download is thought to be safe or known to be
    /// suspicious.
    required DangerType danger,

    /// The file's MIME type.
    required String mime,

    /// The time when the download began in ISO 8601 format. May be passed
    /// directly to the Date constructor: `chrome.downloads.search({},
    /// function(items){items.forEach(function(item){console.log(new
    /// Date(item.startTime))})})`
    required String startTime,

    /// The time when the download ended in ISO 8601 format. May be passed
    /// directly to the Date constructor: `chrome.downloads.search({},
    /// function(items){items.forEach(function(item){if (item.endTime)
    /// console.log(new Date(item.endTime))})})`
    String? endTime,

    /// Estimated time when the download will complete in ISO 8601 format. May
    /// be
    /// passed directly to the Date constructor:
    /// `chrome.downloads.search({},
    /// function(items){items.forEach(function(item){if (item.estimatedEndTime)
    /// console.log(new Date(item.estimatedEndTime))})})`
    String? estimatedEndTime,

    /// Indicates whether the download is progressing, interrupted, or complete.
    required State state,

    /// True if the download has stopped reading data from the host, but kept
    /// the
    /// connection open.
    required bool paused,

    /// True if the download is in progress and paused, or else if it is
    /// interrupted and can be resumed starting from where it was interrupted.
    required bool canResume,

    /// Why the download was interrupted. Several kinds of HTTP errors may be
    /// grouped under one of the errors beginning with `SERVER_`.
    /// Errors relating to the network begin with `NETWORK_`, errors
    /// relating to the process of writing the file to the file system begin
    /// with
    /// `FILE_`, and interruptions initiated by the user begin with
    /// `USER_`.
    InterruptReason? error,

    /// Number of bytes received so far from the host, without considering file
    /// compression.
    required double bytesReceived,

    /// Number of bytes in the whole file, without considering file compression,
    /// or -1 if unknown.
    required double totalBytes,

    /// Number of bytes in the whole file post-decompression, or -1 if unknown.
    required double fileSize,

    /// Whether the downloaded file still exists. This information may be out of
    /// date because Chrome does not automatically watch for file removal. Call
    /// [search]() in order to trigger the check for file existence. When the
    /// existence check completes, if the file has been deleted, then an
    /// [onChanged] event will fire. Note that [search]() does not wait
    /// for the existence check to finish before returning, so results from
    /// [search]() may not accurately reflect the file system. Also,
    /// [search]() may be called as often as necessary, but will not check for
    /// file existence any more frequently than once every 10 seconds.
    required bool exists,

    /// The identifier for the extension that initiated this download if this
    /// download was initiated by an extension. Does not change once it is set.
    String? byExtensionId,

    /// The localized name of the extension that initiated this download if this
    /// download was initiated by an extension. May change if the extension
    /// changes its name or if the user changes their locale.
    String? byExtensionName,
  }) : _wrapped = $js.DownloadItem(
          id: id,
          url: url,
          finalUrl: finalUrl,
          referrer: referrer,
          filename: filename,
          incognito: incognito,
          danger: danger.toJS,
          mime: mime,
          startTime: startTime,
          endTime: endTime,
          estimatedEndTime: estimatedEndTime,
          state: state.toJS,
          paused: paused,
          canResume: canResume,
          error: error?.toJS,
          bytesReceived: bytesReceived,
          totalBytes: totalBytes,
          fileSize: fileSize,
          exists: exists,
          byExtensionId: byExtensionId,
          byExtensionName: byExtensionName,
        );

  final $js.DownloadItem _wrapped;

  $js.DownloadItem get toJS => _wrapped;

  /// An identifier that is persistent across browser sessions.
  int get id => _wrapped.id;
  set id(int v) {
    _wrapped.id = v;
  }

  /// The absolute URL that this download initiated from, before any
  /// redirects.
  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// The absolute URL that this download is being made from, after all
  /// redirects.
  String get finalUrl => _wrapped.finalUrl;
  set finalUrl(String v) {
    _wrapped.finalUrl = v;
  }

  /// Absolute URL.
  String get referrer => _wrapped.referrer;
  set referrer(String v) {
    _wrapped.referrer = v;
  }

  /// Absolute local path.
  String get filename => _wrapped.filename;
  set filename(String v) {
    _wrapped.filename = v;
  }

  /// False if this download is recorded in the history, true if it is not
  /// recorded.
  bool get incognito => _wrapped.incognito;
  set incognito(bool v) {
    _wrapped.incognito = v;
  }

  /// Indication of whether this download is thought to be safe or known to be
  /// suspicious.
  DangerType get danger => DangerType.fromJS(_wrapped.danger);
  set danger(DangerType v) {
    _wrapped.danger = v.toJS;
  }

  /// The file's MIME type.
  String get mime => _wrapped.mime;
  set mime(String v) {
    _wrapped.mime = v;
  }

  /// The time when the download began in ISO 8601 format. May be passed
  /// directly to the Date constructor: `chrome.downloads.search({},
  /// function(items){items.forEach(function(item){console.log(new
  /// Date(item.startTime))})})`
  String get startTime => _wrapped.startTime;
  set startTime(String v) {
    _wrapped.startTime = v;
  }

  /// The time when the download ended in ISO 8601 format. May be passed
  /// directly to the Date constructor: `chrome.downloads.search({},
  /// function(items){items.forEach(function(item){if (item.endTime)
  /// console.log(new Date(item.endTime))})})`
  String? get endTime => _wrapped.endTime;
  set endTime(String? v) {
    _wrapped.endTime = v;
  }

  /// Estimated time when the download will complete in ISO 8601 format. May be
  /// passed directly to the Date constructor:
  /// `chrome.downloads.search({},
  /// function(items){items.forEach(function(item){if (item.estimatedEndTime)
  /// console.log(new Date(item.estimatedEndTime))})})`
  String? get estimatedEndTime => _wrapped.estimatedEndTime;
  set estimatedEndTime(String? v) {
    _wrapped.estimatedEndTime = v;
  }

  /// Indicates whether the download is progressing, interrupted, or complete.
  State get state => State.fromJS(_wrapped.state);
  set state(State v) {
    _wrapped.state = v.toJS;
  }

  /// True if the download has stopped reading data from the host, but kept the
  /// connection open.
  bool get paused => _wrapped.paused;
  set paused(bool v) {
    _wrapped.paused = v;
  }

  /// True if the download is in progress and paused, or else if it is
  /// interrupted and can be resumed starting from where it was interrupted.
  bool get canResume => _wrapped.canResume;
  set canResume(bool v) {
    _wrapped.canResume = v;
  }

  /// Why the download was interrupted. Several kinds of HTTP errors may be
  /// grouped under one of the errors beginning with `SERVER_`.
  /// Errors relating to the network begin with `NETWORK_`, errors
  /// relating to the process of writing the file to the file system begin with
  /// `FILE_`, and interruptions initiated by the user begin with
  /// `USER_`.
  InterruptReason? get error => _wrapped.error?.let(InterruptReason.fromJS);
  set error(InterruptReason? v) {
    _wrapped.error = v?.toJS;
  }

  /// Number of bytes received so far from the host, without considering file
  /// compression.
  double get bytesReceived => _wrapped.bytesReceived;
  set bytesReceived(double v) {
    _wrapped.bytesReceived = v;
  }

  /// Number of bytes in the whole file, without considering file compression,
  /// or -1 if unknown.
  double get totalBytes => _wrapped.totalBytes;
  set totalBytes(double v) {
    _wrapped.totalBytes = v;
  }

  /// Number of bytes in the whole file post-decompression, or -1 if unknown.
  double get fileSize => _wrapped.fileSize;
  set fileSize(double v) {
    _wrapped.fileSize = v;
  }

  /// Whether the downloaded file still exists. This information may be out of
  /// date because Chrome does not automatically watch for file removal. Call
  /// [search]() in order to trigger the check for file existence. When the
  /// existence check completes, if the file has been deleted, then an
  /// [onChanged] event will fire. Note that [search]() does not wait
  /// for the existence check to finish before returning, so results from
  /// [search]() may not accurately reflect the file system. Also,
  /// [search]() may be called as often as necessary, but will not check for
  /// file existence any more frequently than once every 10 seconds.
  bool get exists => _wrapped.exists;
  set exists(bool v) {
    _wrapped.exists = v;
  }

  /// The identifier for the extension that initiated this download if this
  /// download was initiated by an extension. Does not change once it is set.
  String? get byExtensionId => _wrapped.byExtensionId;
  set byExtensionId(String? v) {
    _wrapped.byExtensionId = v;
  }

  /// The localized name of the extension that initiated this download if this
  /// download was initiated by an extension. May change if the extension
  /// changes its name or if the user changes their locale.
  String? get byExtensionName => _wrapped.byExtensionName;
  set byExtensionName(String? v) {
    _wrapped.byExtensionName = v;
  }
}

class DownloadQuery {
  DownloadQuery.fromJS(this._wrapped);

  DownloadQuery({
    /// This array of search terms limits results to [DownloadItem] whose
    /// `filename` or `url` or `finalUrl`
    /// contain all of the search terms that do not begin with a dash '-' and
    /// none of the search terms that do begin with a dash.
    List<String>? query,

    /// Limits results to [DownloadItem] that
    /// started before the given ms since the epoch.
    String? startedBefore,

    /// Limits results to [DownloadItem] that
    /// started after the given ms since the epoch.
    String? startedAfter,

    /// Limits results to [DownloadItem] that ended before the given ms since
    /// the
    /// epoch.
    String? endedBefore,

    /// Limits results to [DownloadItem] that ended after the given ms since the
    /// epoch.
    String? endedAfter,

    /// Limits results to [DownloadItem] whose
    /// `totalBytes` is greater than the given integer.
    double? totalBytesGreater,

    /// Limits results to [DownloadItem] whose
    /// `totalBytes` is less than the given integer.
    double? totalBytesLess,

    /// Limits results to [DownloadItem] whose
    /// `filename` matches the given regular expression.
    String? filenameRegex,

    /// Limits results to [DownloadItem] whose
    /// `url` matches the given regular expression.
    String? urlRegex,

    /// Limits results to [DownloadItem] whose
    /// `finalUrl` matches the given regular expression.
    String? finalUrlRegex,

    /// The maximum number of matching [DownloadItem] returned. Defaults to
    /// 1000. Set to 0 in order to return all matching [DownloadItem]. See
    /// [search] for how to page through results.
    int? limit,

    /// Set elements of this array to [DownloadItem] properties in order to
    /// sort search results. For example, setting
    /// `orderBy=['startTime']` sorts the [DownloadItem] by their
    /// start time in ascending order. To specify descending order, prefix with
    /// a
    /// hyphen: '-startTime'.
    List<String>? orderBy,

    /// The `id` of the [DownloadItem] to query.
    int? id,

    /// The absolute URL that this download initiated from, before any
    /// redirects.
    String? url,

    /// The absolute URL that this download is being made from, after all
    /// redirects.
    String? finalUrl,

    /// Absolute local path.
    String? filename,

    /// Indication of whether this download is thought to be safe or known to be
    /// suspicious.
    DangerType? danger,

    /// The file's MIME type.
    String? mime,

    /// The time when the download began in ISO 8601 format.
    String? startTime,

    /// The time when the download ended in ISO 8601 format.
    String? endTime,

    /// Indicates whether the download is progressing, interrupted, or complete.
    State? state,

    /// True if the download has stopped reading data from the host, but kept
    /// the
    /// connection open.
    bool? paused,

    /// Why a download was interrupted.
    InterruptReason? error,

    /// Number of bytes received so far from the host, without considering file
    /// compression.
    double? bytesReceived,

    /// Number of bytes in the whole file, without considering file compression,
    /// or -1 if unknown.
    double? totalBytes,

    /// Number of bytes in the whole file post-decompression, or -1 if unknown.
    double? fileSize,

    /// Whether the downloaded file exists;
    bool? exists,
  }) : _wrapped = $js.DownloadQuery(
          query: query?.toJSArray((e) => e),
          startedBefore: startedBefore,
          startedAfter: startedAfter,
          endedBefore: endedBefore,
          endedAfter: endedAfter,
          totalBytesGreater: totalBytesGreater,
          totalBytesLess: totalBytesLess,
          filenameRegex: filenameRegex,
          urlRegex: urlRegex,
          finalUrlRegex: finalUrlRegex,
          limit: limit,
          orderBy: orderBy?.toJSArray((e) => e),
          id: id,
          url: url,
          finalUrl: finalUrl,
          filename: filename,
          danger: danger?.toJS,
          mime: mime,
          startTime: startTime,
          endTime: endTime,
          state: state?.toJS,
          paused: paused,
          error: error?.toJS,
          bytesReceived: bytesReceived,
          totalBytes: totalBytes,
          fileSize: fileSize,
          exists: exists,
        );

  final $js.DownloadQuery _wrapped;

  $js.DownloadQuery get toJS => _wrapped;

  /// This array of search terms limits results to [DownloadItem] whose
  /// `filename` or `url` or `finalUrl`
  /// contain all of the search terms that do not begin with a dash '-' and
  /// none of the search terms that do begin with a dash.
  List<String>? get query =>
      _wrapped.query?.toDart.cast<String>().map((e) => e).toList();
  set query(List<String>? v) {
    _wrapped.query = v?.toJSArray((e) => e);
  }

  /// Limits results to [DownloadItem] that
  /// started before the given ms since the epoch.
  String? get startedBefore => _wrapped.startedBefore;
  set startedBefore(String? v) {
    _wrapped.startedBefore = v;
  }

  /// Limits results to [DownloadItem] that
  /// started after the given ms since the epoch.
  String? get startedAfter => _wrapped.startedAfter;
  set startedAfter(String? v) {
    _wrapped.startedAfter = v;
  }

  /// Limits results to [DownloadItem] that ended before the given ms since the
  /// epoch.
  String? get endedBefore => _wrapped.endedBefore;
  set endedBefore(String? v) {
    _wrapped.endedBefore = v;
  }

  /// Limits results to [DownloadItem] that ended after the given ms since the
  /// epoch.
  String? get endedAfter => _wrapped.endedAfter;
  set endedAfter(String? v) {
    _wrapped.endedAfter = v;
  }

  /// Limits results to [DownloadItem] whose
  /// `totalBytes` is greater than the given integer.
  double? get totalBytesGreater => _wrapped.totalBytesGreater;
  set totalBytesGreater(double? v) {
    _wrapped.totalBytesGreater = v;
  }

  /// Limits results to [DownloadItem] whose
  /// `totalBytes` is less than the given integer.
  double? get totalBytesLess => _wrapped.totalBytesLess;
  set totalBytesLess(double? v) {
    _wrapped.totalBytesLess = v;
  }

  /// Limits results to [DownloadItem] whose
  /// `filename` matches the given regular expression.
  String? get filenameRegex => _wrapped.filenameRegex;
  set filenameRegex(String? v) {
    _wrapped.filenameRegex = v;
  }

  /// Limits results to [DownloadItem] whose
  /// `url` matches the given regular expression.
  String? get urlRegex => _wrapped.urlRegex;
  set urlRegex(String? v) {
    _wrapped.urlRegex = v;
  }

  /// Limits results to [DownloadItem] whose
  /// `finalUrl` matches the given regular expression.
  String? get finalUrlRegex => _wrapped.finalUrlRegex;
  set finalUrlRegex(String? v) {
    _wrapped.finalUrlRegex = v;
  }

  /// The maximum number of matching [DownloadItem] returned. Defaults to
  /// 1000. Set to 0 in order to return all matching [DownloadItem]. See
  /// [search] for how to page through results.
  int? get limit => _wrapped.limit;
  set limit(int? v) {
    _wrapped.limit = v;
  }

  /// Set elements of this array to [DownloadItem] properties in order to
  /// sort search results. For example, setting
  /// `orderBy=['startTime']` sorts the [DownloadItem] by their
  /// start time in ascending order. To specify descending order, prefix with a
  /// hyphen: '-startTime'.
  List<String>? get orderBy =>
      _wrapped.orderBy?.toDart.cast<String>().map((e) => e).toList();
  set orderBy(List<String>? v) {
    _wrapped.orderBy = v?.toJSArray((e) => e);
  }

  /// The `id` of the [DownloadItem] to query.
  int? get id => _wrapped.id;
  set id(int? v) {
    _wrapped.id = v;
  }

  /// The absolute URL that this download initiated from, before any
  /// redirects.
  String? get url => _wrapped.url;
  set url(String? v) {
    _wrapped.url = v;
  }

  /// The absolute URL that this download is being made from, after all
  /// redirects.
  String? get finalUrl => _wrapped.finalUrl;
  set finalUrl(String? v) {
    _wrapped.finalUrl = v;
  }

  /// Absolute local path.
  String? get filename => _wrapped.filename;
  set filename(String? v) {
    _wrapped.filename = v;
  }

  /// Indication of whether this download is thought to be safe or known to be
  /// suspicious.
  DangerType? get danger => _wrapped.danger?.let(DangerType.fromJS);
  set danger(DangerType? v) {
    _wrapped.danger = v?.toJS;
  }

  /// The file's MIME type.
  String? get mime => _wrapped.mime;
  set mime(String? v) {
    _wrapped.mime = v;
  }

  /// The time when the download began in ISO 8601 format.
  String? get startTime => _wrapped.startTime;
  set startTime(String? v) {
    _wrapped.startTime = v;
  }

  /// The time when the download ended in ISO 8601 format.
  String? get endTime => _wrapped.endTime;
  set endTime(String? v) {
    _wrapped.endTime = v;
  }

  /// Indicates whether the download is progressing, interrupted, or complete.
  State? get state => _wrapped.state?.let(State.fromJS);
  set state(State? v) {
    _wrapped.state = v?.toJS;
  }

  /// True if the download has stopped reading data from the host, but kept the
  /// connection open.
  bool? get paused => _wrapped.paused;
  set paused(bool? v) {
    _wrapped.paused = v;
  }

  /// Why a download was interrupted.
  InterruptReason? get error => _wrapped.error?.let(InterruptReason.fromJS);
  set error(InterruptReason? v) {
    _wrapped.error = v?.toJS;
  }

  /// Number of bytes received so far from the host, without considering file
  /// compression.
  double? get bytesReceived => _wrapped.bytesReceived;
  set bytesReceived(double? v) {
    _wrapped.bytesReceived = v;
  }

  /// Number of bytes in the whole file, without considering file compression,
  /// or -1 if unknown.
  double? get totalBytes => _wrapped.totalBytes;
  set totalBytes(double? v) {
    _wrapped.totalBytes = v;
  }

  /// Number of bytes in the whole file post-decompression, or -1 if unknown.
  double? get fileSize => _wrapped.fileSize;
  set fileSize(double? v) {
    _wrapped.fileSize = v;
  }

  /// Whether the downloaded file exists;
  bool? get exists => _wrapped.exists;
  set exists(bool? v) {
    _wrapped.exists = v;
  }
}

class StringDelta {
  StringDelta.fromJS(this._wrapped);

  StringDelta({
    String? previous,
    String? current,
  }) : _wrapped = $js.StringDelta(
          previous: previous,
          current: current,
        );

  final $js.StringDelta _wrapped;

  $js.StringDelta get toJS => _wrapped;

  String? get previous => _wrapped.previous;
  set previous(String? v) {
    _wrapped.previous = v;
  }

  String? get current => _wrapped.current;
  set current(String? v) {
    _wrapped.current = v;
  }
}

class DoubleDelta {
  DoubleDelta.fromJS(this._wrapped);

  DoubleDelta({
    double? previous,
    double? current,
  }) : _wrapped = $js.DoubleDelta(
          previous: previous,
          current: current,
        );

  final $js.DoubleDelta _wrapped;

  $js.DoubleDelta get toJS => _wrapped;

  double? get previous => _wrapped.previous;
  set previous(double? v) {
    _wrapped.previous = v;
  }

  double? get current => _wrapped.current;
  set current(double? v) {
    _wrapped.current = v;
  }
}

class BooleanDelta {
  BooleanDelta.fromJS(this._wrapped);

  BooleanDelta({
    bool? previous,
    bool? current,
  }) : _wrapped = $js.BooleanDelta(
          previous: previous,
          current: current,
        );

  final $js.BooleanDelta _wrapped;

  $js.BooleanDelta get toJS => _wrapped;

  bool? get previous => _wrapped.previous;
  set previous(bool? v) {
    _wrapped.previous = v;
  }

  bool? get current => _wrapped.current;
  set current(bool? v) {
    _wrapped.current = v;
  }
}

class DownloadDelta {
  DownloadDelta.fromJS(this._wrapped);

  DownloadDelta({
    /// The `id` of the [DownloadItem]
    /// that changed.
    required int id,

    /// The change in `url`, if any.
    StringDelta? url,

    /// The change in `finalUrl`, if any.
    StringDelta? finalUrl,

    /// The change in `filename`, if any.
    StringDelta? filename,

    /// The change in `danger`, if any.
    StringDelta? danger,

    /// The change in `mime`, if any.
    StringDelta? mime,

    /// The change in `startTime`, if any.
    StringDelta? startTime,

    /// The change in `endTime`, if any.
    StringDelta? endTime,

    /// The change in `state`, if any.
    StringDelta? state,

    /// The change in `canResume`, if any.
    BooleanDelta? canResume,

    /// The change in `paused`, if any.
    BooleanDelta? paused,

    /// The change in `error`, if any.
    StringDelta? error,

    /// The change in `totalBytes`, if any.
    DoubleDelta? totalBytes,

    /// The change in `fileSize`, if any.
    DoubleDelta? fileSize,

    /// The change in `exists`, if any.
    BooleanDelta? exists,
  }) : _wrapped = $js.DownloadDelta(
          id: id,
          url: url?.toJS,
          finalUrl: finalUrl?.toJS,
          filename: filename?.toJS,
          danger: danger?.toJS,
          mime: mime?.toJS,
          startTime: startTime?.toJS,
          endTime: endTime?.toJS,
          state: state?.toJS,
          canResume: canResume?.toJS,
          paused: paused?.toJS,
          error: error?.toJS,
          totalBytes: totalBytes?.toJS,
          fileSize: fileSize?.toJS,
          exists: exists?.toJS,
        );

  final $js.DownloadDelta _wrapped;

  $js.DownloadDelta get toJS => _wrapped;

  /// The `id` of the [DownloadItem]
  /// that changed.
  int get id => _wrapped.id;
  set id(int v) {
    _wrapped.id = v;
  }

  /// The change in `url`, if any.
  StringDelta? get url => _wrapped.url?.let(StringDelta.fromJS);
  set url(StringDelta? v) {
    _wrapped.url = v?.toJS;
  }

  /// The change in `finalUrl`, if any.
  StringDelta? get finalUrl => _wrapped.finalUrl?.let(StringDelta.fromJS);
  set finalUrl(StringDelta? v) {
    _wrapped.finalUrl = v?.toJS;
  }

  /// The change in `filename`, if any.
  StringDelta? get filename => _wrapped.filename?.let(StringDelta.fromJS);
  set filename(StringDelta? v) {
    _wrapped.filename = v?.toJS;
  }

  /// The change in `danger`, if any.
  StringDelta? get danger => _wrapped.danger?.let(StringDelta.fromJS);
  set danger(StringDelta? v) {
    _wrapped.danger = v?.toJS;
  }

  /// The change in `mime`, if any.
  StringDelta? get mime => _wrapped.mime?.let(StringDelta.fromJS);
  set mime(StringDelta? v) {
    _wrapped.mime = v?.toJS;
  }

  /// The change in `startTime`, if any.
  StringDelta? get startTime => _wrapped.startTime?.let(StringDelta.fromJS);
  set startTime(StringDelta? v) {
    _wrapped.startTime = v?.toJS;
  }

  /// The change in `endTime`, if any.
  StringDelta? get endTime => _wrapped.endTime?.let(StringDelta.fromJS);
  set endTime(StringDelta? v) {
    _wrapped.endTime = v?.toJS;
  }

  /// The change in `state`, if any.
  StringDelta? get state => _wrapped.state?.let(StringDelta.fromJS);
  set state(StringDelta? v) {
    _wrapped.state = v?.toJS;
  }

  /// The change in `canResume`, if any.
  BooleanDelta? get canResume => _wrapped.canResume?.let(BooleanDelta.fromJS);
  set canResume(BooleanDelta? v) {
    _wrapped.canResume = v?.toJS;
  }

  /// The change in `paused`, if any.
  BooleanDelta? get paused => _wrapped.paused?.let(BooleanDelta.fromJS);
  set paused(BooleanDelta? v) {
    _wrapped.paused = v?.toJS;
  }

  /// The change in `error`, if any.
  StringDelta? get error => _wrapped.error?.let(StringDelta.fromJS);
  set error(StringDelta? v) {
    _wrapped.error = v?.toJS;
  }

  /// The change in `totalBytes`, if any.
  DoubleDelta? get totalBytes => _wrapped.totalBytes?.let(DoubleDelta.fromJS);
  set totalBytes(DoubleDelta? v) {
    _wrapped.totalBytes = v?.toJS;
  }

  /// The change in `fileSize`, if any.
  DoubleDelta? get fileSize => _wrapped.fileSize?.let(DoubleDelta.fromJS);
  set fileSize(DoubleDelta? v) {
    _wrapped.fileSize = v?.toJS;
  }

  /// The change in `exists`, if any.
  BooleanDelta? get exists => _wrapped.exists?.let(BooleanDelta.fromJS);
  set exists(BooleanDelta? v) {
    _wrapped.exists = v?.toJS;
  }
}

class GetFileIconOptions {
  GetFileIconOptions.fromJS(this._wrapped);

  GetFileIconOptions(
      {
      /// The size of the returned icon. The icon will be square with dimensions
      /// size * size pixels. The default and largest size for the icon is 32x32
      /// pixels. The only supported sizes are 16 and 32. It is an error to
      /// specify
      /// any other size.
      int? size})
      : _wrapped = $js.GetFileIconOptions(size: size);

  final $js.GetFileIconOptions _wrapped;

  $js.GetFileIconOptions get toJS => _wrapped;

  /// The size of the returned icon. The icon will be square with dimensions
  /// size * size pixels. The default and largest size for the icon is 32x32
  /// pixels. The only supported sizes are 16 and 32. It is an error to specify
  /// any other size.
  int? get size => _wrapped.size;
  set size(int? v) {
    _wrapped.size = v;
  }
}

class UiOptions {
  UiOptions.fromJS(this._wrapped);

  UiOptions(
      {
      /// Enable or disable the download UI.
      required bool enabled})
      : _wrapped = $js.UiOptions(enabled: enabled);

  final $js.UiOptions _wrapped;

  $js.UiOptions get toJS => _wrapped;

  /// Enable or disable the download UI.
  bool get enabled => _wrapped.enabled;
  set enabled(bool v) {
    _wrapped.enabled = v;
  }
}

class OnDeterminingFilenameEvent {
  OnDeterminingFilenameEvent({
    required this.downloadItem,
    required this.suggest,
  });

  final DownloadItem downloadItem;

  final void Function(FilenameSuggestion?) suggest;
}
