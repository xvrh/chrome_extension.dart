// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSDownloadsExtension on JSChrome {
  @JS('downloads')
  external JSDownloads? get downloadsNullable;

  /// Use the `chrome.downloads` API to programmatically initiate,
  /// monitor, manipulate, and search for downloads.
  JSDownloads get downloads {
    var downloadsNullable = this.downloadsNullable;
    if (downloadsNullable == null) {
      throw ApiNotAvailableException('chrome.downloads');
    }
    return downloadsNullable;
  }
}

@JS()
@staticInterop
class JSDownloads {}

extension JSDownloadsExtension on JSDownloads {
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
  external JSPromise download(DownloadOptions options);

  /// Find [DownloadItem]. Set `query` to the empty object to get
  /// all [DownloadItem]. To get a specific [DownloadItem], set only the
  /// `id` field. To page through a large number of items, set
  /// `orderBy: ['-startTime']`, set `limit` to the
  /// number of items per page, and set `startedAfter` to the
  /// `startTime` of the last item from the last page.
  external JSPromise search(DownloadQuery query);

  /// Pause the download. If the request was successful the download is in a
  /// paused state. Otherwise [runtime.lastError] contains an error message.
  /// The request will fail if the download is not active.
  /// |downloadId|: The id of the download to pause.
  /// |callback|: Called when the pause request is completed.
  external JSPromise pause(int downloadId);

  /// Resume a paused download. If the request was successful the download is
  /// in progress and unpaused. Otherwise [runtime.lastError] contains an
  /// error message. The request will fail if the download is not active.
  /// |downloadId|: The id of the download to resume.
  /// |callback|: Called when the resume request is completed.
  external JSPromise resume(int downloadId);

  /// Cancel a download. When `callback` is run, the download is
  /// cancelled, completed, interrupted or doesn't exist anymore.
  /// |downloadId|: The id of the download to cancel.
  /// |callback|: Called when the cancel request is completed.
  external JSPromise cancel(int downloadId);

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
  external JSPromise getFileIcon(
    int downloadId,
    GetFileIconOptions? options,
  );

  /// Open the downloaded file now if the [DownloadItem] is complete;
  /// otherwise returns an error through [runtime.lastError]. Requires the
  /// `"downloads.open"` permission in addition to the
  /// `"downloads"` permission. An [onChanged] event will fire
  /// when the item is opened for the first time.
  /// |downloadId|: The identifier for the downloaded file.
  external void open(int downloadId);

  /// Show the downloaded file in its folder in a file manager.
  /// |downloadId|: The identifier for the downloaded file.
  external void show(int downloadId);

  /// Show the default Downloads folder in a file manager.
  external void showDefaultFolder();

  /// Erase matching [DownloadItem] from history without deleting the
  /// downloaded file. An [onErased] event will fire for each
  /// [DownloadItem] that matches `query`, then
  /// `callback` will be called.
  external JSPromise erase(DownloadQuery query);

  /// Remove the downloaded file if it exists and the [DownloadItem] is
  /// complete; otherwise return an error through [runtime.lastError].
  external JSPromise removeFile(int downloadId);

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
  external JSPromise acceptDanger(int downloadId);

  /// Enable or disable the gray shelf at the bottom of every window associated
  /// with the current browser profile. The shelf will be disabled as long as
  /// at least one extension has disabled it. Enabling the shelf while at least
  /// one other extension has disabled it will return an error through
  /// [runtime.lastError]. Requires the `"downloads.shelf"`
  /// permission in addition to the `"downloads"` permission.
  external void setShelfEnabled(bool enabled);

  /// Change the download UI of every window associated with the current
  /// browser profile. As long as at least one extension has set
  /// [UiOptions.enabled] to false, the download UI will be hidden.
  /// Setting [UiOptions.enabled] to true while at least one other
  /// extension has disabled it will return an error through
  /// [runtime.lastError]. Requires the `"downloads.ui"`
  /// permission in addition to the `"downloads"` permission.
  /// |options|: Encapsulate a change to the download UI.
  /// |callback|: Called when the UI update is completed.
  external JSPromise setUiOptions(UiOptions options);

  /// This event fires with the [DownloadItem] object when a download
  /// begins.
  external Event get onCreated;

  /// Fires with the `downloadId` when a download is erased from
  /// history.
  /// |downloadId|: The `id` of the [DownloadItem] that was
  /// erased.
  external Event get onErased;

  /// When any of a [DownloadItem]'s properties except
  /// `bytesReceived` and `estimatedEndTime` changes,
  /// this event fires with the `downloadId` and an object
  /// containing the properties that changed.
  external Event get onChanged;

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
  external Event get onDeterminingFilename;
}

/// <dl><dt>uniquify</dt>
///     <dd>To avoid duplication, the `filename` is changed to
///     include a counter before the filename extension.</dd>
///     <dt>overwrite</dt>
///     <dd>The existing file will be overwritten with the new file.</dd>
///     <dt>prompt</dt>
///     <dd>The user will be prompted with a file chooser dialog.</dd>
/// </dl>
typedef FilenameConflictAction = String;

typedef HttpMethod = String;

typedef InterruptReason = String;

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
typedef DangerType = String;

/// <dl><dt>in_progress</dt>
///     <dd>The download is currently receiving data from the server.</dd>
///     <dt>interrupted</dt>
///     <dd>An error broke the connection with the file host.</dd>
///     <dt>complete</dt>
///     <dd>The download completed successfully.</dd>
/// </dl>
typedef State = String;

typedef SuggestFilenameCallback = JSFunction;

@JS()
@staticInterop
@anonymous
class HeaderNameValuePair {
  external factory HeaderNameValuePair({
    /// Name of the HTTP header.
    String name,

    /// Value of the HTTP header.
    String value,
  });
}

extension HeaderNameValuePairExtension on HeaderNameValuePair {
  /// Name of the HTTP header.
  external String name;

  /// Value of the HTTP header.
  external String value;
}

@JS()
@staticInterop
@anonymous
class FilenameSuggestion {
  external factory FilenameSuggestion({
    /// The [DownloadItem]'s new target [DownloadItem.filename], as a path
    /// relative to the user's default Downloads directory, possibly containing
    /// subdirectories. Absolute paths, empty paths, and paths containing
    /// back-references ".." will be ignored. `filename` is ignored if
    /// there are any [onDeterminingFilename] listeners registered by any
    /// extensions.
    String filename,

    /// The action to take if `filename` already exists.
    FilenameConflictAction? conflictAction,
  });
}

extension FilenameSuggestionExtension on FilenameSuggestion {
  /// The [DownloadItem]'s new target [DownloadItem.filename], as a path
  /// relative to the user's default Downloads directory, possibly containing
  /// subdirectories. Absolute paths, empty paths, and paths containing
  /// back-references ".." will be ignored. `filename` is ignored if
  /// there are any [onDeterminingFilename] listeners registered by any
  /// extensions.
  external String filename;

  /// The action to take if `filename` already exists.
  external FilenameConflictAction? conflictAction;
}

@JS()
@staticInterop
@anonymous
class DownloadOptions {
  external factory DownloadOptions({
    /// The URL to download.
    String url,

    /// A file path relative to the Downloads directory to contain the downloaded
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
    JSArray? headers,

    /// Post body.
    String? body,
  });
}

extension DownloadOptionsExtension on DownloadOptions {
  /// The URL to download.
  external String url;

  /// A file path relative to the Downloads directory to contain the downloaded
  /// file, possibly containing subdirectories. Absolute paths, empty paths,
  /// and paths containing back-references ".." will cause an error.
  /// [onDeterminingFilename] allows suggesting a filename after the file's
  /// MIME type and a tentative filename have been determined.
  external String? filename;

  /// The action to take if `filename` already exists.
  external FilenameConflictAction? conflictAction;

  /// Use a file-chooser to allow the user to select a filename regardless of
  /// whether `filename` is set or already exists.
  external bool? saveAs;

  /// The HTTP method to use if the URL uses the HTTP[S] protocol.
  external HttpMethod? method;

  /// Extra HTTP headers to send with the request if the URL uses the HTTP[s]
  /// protocol. Each header is represented as a dictionary containing the keys
  /// `name` and either `value` or
  /// `binaryValue`, restricted to those allowed by XMLHttpRequest.
  external JSArray? headers;

  /// Post body.
  external String? body;
}

@JS()
@staticInterop
@anonymous
class DownloadItem {
  external factory DownloadItem({
    /// An identifier that is persistent across browser sessions.
    int id,

    /// The absolute URL that this download initiated from, before any
    /// redirects.
    String url,

    /// The absolute URL that this download is being made from, after all
    /// redirects.
    String finalUrl,

    /// Absolute URL.
    String referrer,

    /// Absolute local path.
    String filename,

    /// False if this download is recorded in the history, true if it is not
    /// recorded.
    bool incognito,

    /// Indication of whether this download is thought to be safe or known to be
    /// suspicious.
    DangerType danger,

    /// The file's MIME type.
    String mime,

    /// The time when the download began in ISO 8601 format. May be passed
    /// directly to the Date constructor: `chrome.downloads.search({},
    /// function(items){items.forEach(function(item){console.log(new
    /// Date(item.startTime))})})`
    String startTime,

    /// The time when the download ended in ISO 8601 format. May be passed
    /// directly to the Date constructor: `chrome.downloads.search({},
    /// function(items){items.forEach(function(item){if (item.endTime)
    /// console.log(new Date(item.endTime))})})`
    String? endTime,

    /// Estimated time when the download will complete in ISO 8601 format. May be
    /// passed directly to the Date constructor:
    /// `chrome.downloads.search({},
    /// function(items){items.forEach(function(item){if (item.estimatedEndTime)
    /// console.log(new Date(item.estimatedEndTime))})})`
    String? estimatedEndTime,

    /// Indicates whether the download is progressing, interrupted, or complete.
    State state,

    /// True if the download has stopped reading data from the host, but kept the
    /// connection open.
    bool paused,

    /// True if the download is in progress and paused, or else if it is
    /// interrupted and can be resumed starting from where it was interrupted.
    bool canResume,

    /// Why the download was interrupted. Several kinds of HTTP errors may be
    /// grouped under one of the errors beginning with `SERVER_`.
    /// Errors relating to the network begin with `NETWORK_`, errors
    /// relating to the process of writing the file to the file system begin with
    /// `FILE_`, and interruptions initiated by the user begin with
    /// `USER_`.
    InterruptReason? error,

    /// Number of bytes received so far from the host, without considering file
    /// compression.
    double bytesReceived,

    /// Number of bytes in the whole file, without considering file compression,
    /// or -1 if unknown.
    double totalBytes,

    /// Number of bytes in the whole file post-decompression, or -1 if unknown.
    double fileSize,

    /// Whether the downloaded file still exists. This information may be out of
    /// date because Chrome does not automatically watch for file removal. Call
    /// [search]() in order to trigger the check for file existence. When the
    /// existence check completes, if the file has been deleted, then an
    /// [onChanged] event will fire. Note that [search]() does not wait
    /// for the existence check to finish before returning, so results from
    /// [search]() may not accurately reflect the file system. Also,
    /// [search]() may be called as often as necessary, but will not check for
    /// file existence any more frequently than once every 10 seconds.
    bool exists,

    /// The identifier for the extension that initiated this download if this
    /// download was initiated by an extension. Does not change once it is set.
    String? byExtensionId,

    /// The localized name of the extension that initiated this download if this
    /// download was initiated by an extension. May change if the extension
    /// changes its name or if the user changes their locale.
    String? byExtensionName,
  });
}

extension DownloadItemExtension on DownloadItem {
  /// An identifier that is persistent across browser sessions.
  external int id;

  /// The absolute URL that this download initiated from, before any
  /// redirects.
  external String url;

  /// The absolute URL that this download is being made from, after all
  /// redirects.
  external String finalUrl;

  /// Absolute URL.
  external String referrer;

  /// Absolute local path.
  external String filename;

  /// False if this download is recorded in the history, true if it is not
  /// recorded.
  external bool incognito;

  /// Indication of whether this download is thought to be safe or known to be
  /// suspicious.
  external DangerType danger;

  /// The file's MIME type.
  external String mime;

  /// The time when the download began in ISO 8601 format. May be passed
  /// directly to the Date constructor: `chrome.downloads.search({},
  /// function(items){items.forEach(function(item){console.log(new
  /// Date(item.startTime))})})`
  external String startTime;

  /// The time when the download ended in ISO 8601 format. May be passed
  /// directly to the Date constructor: `chrome.downloads.search({},
  /// function(items){items.forEach(function(item){if (item.endTime)
  /// console.log(new Date(item.endTime))})})`
  external String? endTime;

  /// Estimated time when the download will complete in ISO 8601 format. May be
  /// passed directly to the Date constructor:
  /// `chrome.downloads.search({},
  /// function(items){items.forEach(function(item){if (item.estimatedEndTime)
  /// console.log(new Date(item.estimatedEndTime))})})`
  external String? estimatedEndTime;

  /// Indicates whether the download is progressing, interrupted, or complete.
  external State state;

  /// True if the download has stopped reading data from the host, but kept the
  /// connection open.
  external bool paused;

  /// True if the download is in progress and paused, or else if it is
  /// interrupted and can be resumed starting from where it was interrupted.
  external bool canResume;

  /// Why the download was interrupted. Several kinds of HTTP errors may be
  /// grouped under one of the errors beginning with `SERVER_`.
  /// Errors relating to the network begin with `NETWORK_`, errors
  /// relating to the process of writing the file to the file system begin with
  /// `FILE_`, and interruptions initiated by the user begin with
  /// `USER_`.
  external InterruptReason? error;

  /// Number of bytes received so far from the host, without considering file
  /// compression.
  external double bytesReceived;

  /// Number of bytes in the whole file, without considering file compression,
  /// or -1 if unknown.
  external double totalBytes;

  /// Number of bytes in the whole file post-decompression, or -1 if unknown.
  external double fileSize;

  /// Whether the downloaded file still exists. This information may be out of
  /// date because Chrome does not automatically watch for file removal. Call
  /// [search]() in order to trigger the check for file existence. When the
  /// existence check completes, if the file has been deleted, then an
  /// [onChanged] event will fire. Note that [search]() does not wait
  /// for the existence check to finish before returning, so results from
  /// [search]() may not accurately reflect the file system. Also,
  /// [search]() may be called as often as necessary, but will not check for
  /// file existence any more frequently than once every 10 seconds.
  external bool exists;

  /// The identifier for the extension that initiated this download if this
  /// download was initiated by an extension. Does not change once it is set.
  external String? byExtensionId;

  /// The localized name of the extension that initiated this download if this
  /// download was initiated by an extension. May change if the extension
  /// changes its name or if the user changes their locale.
  external String? byExtensionName;
}

@JS()
@staticInterop
@anonymous
class DownloadQuery {
  external factory DownloadQuery({
    /// This array of search terms limits results to [DownloadItem] whose
    /// `filename` or `url` or `finalUrl`
    /// contain all of the search terms that do not begin with a dash '-' and
    /// none of the search terms that do begin with a dash.
    JSArray? query,

    /// Limits results to [DownloadItem] that
    /// started before the given ms since the epoch.
    String? startedBefore,

    /// Limits results to [DownloadItem] that
    /// started after the given ms since the epoch.
    String? startedAfter,

    /// Limits results to [DownloadItem] that ended before the given ms since the
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
    /// start time in ascending order. To specify descending order, prefix with a
    /// hyphen: '-startTime'.
    JSArray? orderBy,

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

    /// True if the download has stopped reading data from the host, but kept the
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
  });
}

extension DownloadQueryExtension on DownloadQuery {
  /// This array of search terms limits results to [DownloadItem] whose
  /// `filename` or `url` or `finalUrl`
  /// contain all of the search terms that do not begin with a dash '-' and
  /// none of the search terms that do begin with a dash.
  external JSArray? query;

  /// Limits results to [DownloadItem] that
  /// started before the given ms since the epoch.
  external String? startedBefore;

  /// Limits results to [DownloadItem] that
  /// started after the given ms since the epoch.
  external String? startedAfter;

  /// Limits results to [DownloadItem] that ended before the given ms since the
  /// epoch.
  external String? endedBefore;

  /// Limits results to [DownloadItem] that ended after the given ms since the
  /// epoch.
  external String? endedAfter;

  /// Limits results to [DownloadItem] whose
  /// `totalBytes` is greater than the given integer.
  external double? totalBytesGreater;

  /// Limits results to [DownloadItem] whose
  /// `totalBytes` is less than the given integer.
  external double? totalBytesLess;

  /// Limits results to [DownloadItem] whose
  /// `filename` matches the given regular expression.
  external String? filenameRegex;

  /// Limits results to [DownloadItem] whose
  /// `url` matches the given regular expression.
  external String? urlRegex;

  /// Limits results to [DownloadItem] whose
  /// `finalUrl` matches the given regular expression.
  external String? finalUrlRegex;

  /// The maximum number of matching [DownloadItem] returned. Defaults to
  /// 1000. Set to 0 in order to return all matching [DownloadItem]. See
  /// [search] for how to page through results.
  external int? limit;

  /// Set elements of this array to [DownloadItem] properties in order to
  /// sort search results. For example, setting
  /// `orderBy=['startTime']` sorts the [DownloadItem] by their
  /// start time in ascending order. To specify descending order, prefix with a
  /// hyphen: '-startTime'.
  external JSArray? orderBy;

  /// The `id` of the [DownloadItem] to query.
  external int? id;

  /// The absolute URL that this download initiated from, before any
  /// redirects.
  external String? url;

  /// The absolute URL that this download is being made from, after all
  /// redirects.
  external String? finalUrl;

  /// Absolute local path.
  external String? filename;

  /// Indication of whether this download is thought to be safe or known to be
  /// suspicious.
  external DangerType? danger;

  /// The file's MIME type.
  external String? mime;

  /// The time when the download began in ISO 8601 format.
  external String? startTime;

  /// The time when the download ended in ISO 8601 format.
  external String? endTime;

  /// Indicates whether the download is progressing, interrupted, or complete.
  external State? state;

  /// True if the download has stopped reading data from the host, but kept the
  /// connection open.
  external bool? paused;

  /// Why a download was interrupted.
  external InterruptReason? error;

  /// Number of bytes received so far from the host, without considering file
  /// compression.
  external double? bytesReceived;

  /// Number of bytes in the whole file, without considering file compression,
  /// or -1 if unknown.
  external double? totalBytes;

  /// Number of bytes in the whole file post-decompression, or -1 if unknown.
  external double? fileSize;

  /// Whether the downloaded file exists;
  external bool? exists;
}

@JS()
@staticInterop
@anonymous
class StringDelta {
  external factory StringDelta({
    String? previous,
    String? current,
  });
}

extension StringDeltaExtension on StringDelta {
  external String? previous;

  external String? current;
}

@JS()
@staticInterop
@anonymous
class DoubleDelta {
  external factory DoubleDelta({
    double? previous,
    double? current,
  });
}

extension DoubleDeltaExtension on DoubleDelta {
  external double? previous;

  external double? current;
}

@JS()
@staticInterop
@anonymous
class BooleanDelta {
  external factory BooleanDelta({
    bool? previous,
    bool? current,
  });
}

extension BooleanDeltaExtension on BooleanDelta {
  external bool? previous;

  external bool? current;
}

@JS()
@staticInterop
@anonymous
class DownloadDelta {
  external factory DownloadDelta({
    /// The `id` of the [DownloadItem]
    /// that changed.
    int id,

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
  });
}

extension DownloadDeltaExtension on DownloadDelta {
  /// The `id` of the [DownloadItem]
  /// that changed.
  external int id;

  /// The change in `url`, if any.
  external StringDelta? url;

  /// The change in `finalUrl`, if any.
  external StringDelta? finalUrl;

  /// The change in `filename`, if any.
  external StringDelta? filename;

  /// The change in `danger`, if any.
  external StringDelta? danger;

  /// The change in `mime`, if any.
  external StringDelta? mime;

  /// The change in `startTime`, if any.
  external StringDelta? startTime;

  /// The change in `endTime`, if any.
  external StringDelta? endTime;

  /// The change in `state`, if any.
  external StringDelta? state;

  /// The change in `canResume`, if any.
  external BooleanDelta? canResume;

  /// The change in `paused`, if any.
  external BooleanDelta? paused;

  /// The change in `error`, if any.
  external StringDelta? error;

  /// The change in `totalBytes`, if any.
  external DoubleDelta? totalBytes;

  /// The change in `fileSize`, if any.
  external DoubleDelta? fileSize;

  /// The change in `exists`, if any.
  external BooleanDelta? exists;
}

@JS()
@staticInterop
@anonymous
class GetFileIconOptions {
  external factory GetFileIconOptions(
      {
      /// The size of the returned icon. The icon will be square with dimensions
      /// size * size pixels. The default and largest size for the icon is 32x32
      /// pixels. The only supported sizes are 16 and 32. It is an error to specify
      /// any other size.
      int? size});
}

extension GetFileIconOptionsExtension on GetFileIconOptions {
  /// The size of the returned icon. The icon will be square with dimensions
  /// size * size pixels. The default and largest size for the icon is 32x32
  /// pixels. The only supported sizes are 16 and 32. It is an error to specify
  /// any other size.
  external int? size;
}

@JS()
@staticInterop
@anonymous
class UiOptions {
  external factory UiOptions(
      {
      /// Enable or disable the download UI.
      bool enabled});
}

extension UiOptionsExtension on UiOptions {
  /// Enable or disable the download UI.
  external bool enabled;
}
