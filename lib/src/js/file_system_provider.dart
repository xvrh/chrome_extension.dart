// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSFileSystemProviderExtension on JSChrome {
  @JS('fileSystemProvider')
  external JSFileSystemProvider? get fileSystemProviderNullable;

  /// Use the `chrome.fileSystemProvider` API to create file systems,
  /// that can be accessible from the file manager on Chrome OS.
  JSFileSystemProvider get fileSystemProvider {
    var fileSystemProviderNullable = this.fileSystemProviderNullable;
    if (fileSystemProviderNullable == null) {
      throw ApiNotAvailableException('chrome.fileSystemProvider');
    }
    return fileSystemProviderNullable;
  }
}

@JS()
@staticInterop
class JSFileSystemProvider {}

extension JSFileSystemProviderExtension on JSFileSystemProvider {
  /// Mounts a file system with the given `fileSystemId` and
  /// `displayName`. `displayName` will be shown in the
  /// left panel of the Files app. `displayName` can contain any
  /// characters including '/', but cannot be an empty string.
  /// `displayName` must be descriptive but doesn't have to be
  /// unique. The `fileSystemId` must not be an empty string.
  ///
  /// Depending on the type of the file system being mounted, the
  /// `source` option must be set appropriately.
  ///
  /// In case of an error, [runtime.lastError] will be set with a
  /// corresponding error code.
  external JSPromise mount(MountOptions options);

  /// Unmounts a file system with the given `fileSystemId`. It
  /// must be called after [onUnmountRequested] is invoked. Also,
  /// the providing extension can decide to perform unmounting if not requested
  /// (eg. in case of lost connection, or a file error).
  ///
  /// In case of an error, [runtime.lastError] will be set with a
  /// corresponding error code.
  external JSPromise unmount(UnmountOptions options);

  /// Returns all file systems mounted by the extension.
  external JSPromise getAll();

  /// Returns information about a file system with the passed
  /// `fileSystemId`.
  external JSPromise get(String fileSystemId);

  /// Notifies about changes in the watched directory at
  /// `observedPath` in `recursive` mode. If the file
  /// system is mounted with `supportsNofityTag`, then
  /// `tag` must be provided, and all changes since the last
  /// notification always reported, even if the system was shutdown. The last
  /// tag can be obtained with [getAll].
  ///
  /// To use, the `file_system_provider.notify` manifest option
  /// must be set to true.
  ///
  /// Value of `tag` can be any string which is unique per call,
  /// so it's possible to identify the last registered notification. Eg. if
  /// the providing extension starts after a reboot, and the last registered
  /// notification's tag is equal to "123", then it should call [notify]
  /// for all changes which happened since the change tagged as "123". It
  /// cannot be an empty string.
  ///
  /// Not all providers are able to provide a tag, but if the file system has
  /// a changelog, then the tag can be eg. a change number, or a revision
  /// number.
  ///
  /// Note that if a parent directory is removed, then all descendant entries
  /// are also removed, and if they are watched, then the API must be notified
  /// about the fact. Also, if a directory is renamed, then all descendant
  /// entries are in fact removed, as there is no entry under their original
  /// paths anymore.
  ///
  /// In case of an error, [runtime.lastError] will be set
  /// will a corresponding error code.
  external JSPromise notify(NotifyOptions options);

  /// Raised when unmounting for the file system with the
  /// `fileSystemId` identifier is requested. In the response, the
  /// [unmount] API method must be called together with
  /// `successCallback`. If unmounting is not possible (eg. due to
  /// a pending operation), then `errorCallback` must be called.
  external Event get onUnmountRequested;

  /// Raised when metadata of a file or a directory at `entryPath`
  /// is requested. The metadata must be returned with the
  /// `successCallback` call. In case of an error,
  /// `errorCallback` must be called.
  external Event get onGetMetadataRequested;

  /// Raised when a list of actions for a set of files or directories at
  /// `entryPaths` is requested. All of the returned actions must
  /// be applicable to each entry. If there are no such actions, an empty array
  /// should be returned. The actions must be returned with the
  /// `successCallback` call. In case of an error,
  /// `errorCallback` must be called.
  external Event get onGetActionsRequested;

  /// Raised when contents of a directory at `directoryPath` are
  /// requested. The results must be returned in chunks by calling the
  /// `successCallback` several times. In case of an error,
  /// `errorCallback` must be called.
  external Event get onReadDirectoryRequested;

  /// Raised when opening a file at `filePath` is requested. If the
  /// file does not exist, then the operation must fail. Maximum number of
  /// files opened at once can be specified with `MountOptions`.
  external Event get onOpenFileRequested;

  /// Raised when opening a file previously opened with
  /// `openRequestId` is requested to be closed.
  external Event get onCloseFileRequested;

  /// Raised when reading contents of a file opened previously with
  /// `openRequestId` is requested. The results must be returned in
  /// chunks by calling `successCallback` several times. In case of
  /// an error, `errorCallback` must be called.
  external Event get onReadFileRequested;

  /// Raised when creating a directory is requested. The operation must fail
  /// with the EXISTS error if the target directory already exists.
  /// If `recursive` is true, then all of the missing directories
  /// on the directory path must be created.
  external Event get onCreateDirectoryRequested;

  /// Raised when deleting an entry is requested. If `recursive` is
  /// true, and the entry is a directory, then all of the entries inside
  /// must be recursively deleted as well.
  external Event get onDeleteEntryRequested;

  /// Raised when creating a file is requested. If the file already exists,
  /// then `errorCallback` must be called with the
  /// `"EXISTS"` error code.
  external Event get onCreateFileRequested;

  /// Raised when copying an entry (recursively if a directory) is requested.
  /// If an error occurs, then `errorCallback` must be called.
  external Event get onCopyEntryRequested;

  /// Raised when moving an entry (recursively if a directory) is requested.
  /// If an error occurs, then `errorCallback` must be called.
  external Event get onMoveEntryRequested;

  /// Raised when truncating a file to a desired length is requested.
  /// If an error occurs, then `errorCallback` must be called.
  external Event get onTruncateRequested;

  /// Raised when writing contents to a file opened previously with
  /// `openRequestId` is requested.
  external Event get onWriteFileRequested;

  /// Raised when aborting an operation with `operationRequestId`
  /// is requested. The operation executed with `operationRequestId`
  /// must be immediately stopped and `successCallback` of this
  /// abort request executed. If aborting fails, then
  /// `errorCallback` must be called. Note, that callbacks of the
  /// aborted operation must not be called, as they will be ignored. Despite
  /// calling `errorCallback`, the request may be forcibly aborted.
  external Event get onAbortRequested;

  /// Raised when showing a configuration dialog for `fileSystemId`
  /// is requested. If it's handled, the
  /// `file_system_provider.configurable` manfiest option must be
  /// set to true.
  external Event get onConfigureRequested;

  /// Raised when showing a dialog for mounting a new file system is requested.
  /// If the extension/app is a file handler, then this event shouldn't be
  /// handled. Instead `app.runtime.onLaunched` should be handled in
  /// order to mount new file systems when a file is opened. For multiple
  /// mounts, the `file_system_provider.multiple_mounts` manifest
  /// option must be set to true.
  external Event get onMountRequested;

  /// Raised when setting a new directory watcher is requested. If an error
  /// occurs, then `errorCallback` must be called.
  external Event get onAddWatcherRequested;

  /// Raised when the watcher should be removed. If an error occurs, then
  /// `errorCallback` must be called.
  external Event get onRemoveWatcherRequested;

  /// Raised when executing an action for a set of files or directories is\
  /// requested. After the action is completed, `successCallback`
  /// must be called. On error, `errorCallback` must be called.
  external Event get onExecuteActionRequested;
}

/// Error codes used by providing extensions in response to requests as well
/// as in case of errors when calling methods of the API. For success,
/// `"OK"` must be used.
typedef ProviderError = String;

/// Mode of opening a file. Used by [onOpenFileRequested].
typedef OpenFileMode = String;

/// Type of a change detected on the observed directory.
typedef ChangeType = String;

/// List of common actions. `"SHARE"` is for sharing files with
/// others. `"SAVE_FOR_OFFLINE"` for pinning (saving for offline
/// access). `"OFFLINE_NOT_NECESSARY"` for notifying that the file
/// doesn't need to be stored for offline access anymore.
/// Used by [onGetActionsRequested] and [onExecuteActionRequested].
typedef CommonActionId = String;

/// Callback to be called by the providing extension in case of a success.
typedef ProviderSuccessCallback = JSFunction;

/// Callback to be called by the providing extension in case of an error.
/// Any error code is allowed except `OK`.
typedef ProviderErrorCallback = JSFunction;

/// Success callback for the [onGetMetadataRequested] event.
typedef MetadataCallback = JSFunction;

/// Success callback for the [onGetActionsRequested] event.
typedef ActionsCallback = JSFunction;

/// Success callback for the [onReadDirectoryRequested] event. If more
/// entries will be returned, then `hasMore` must be true, and it
/// has to be called again with additional entries. If no more entries are
/// available, then `hasMore` must be set to false.
typedef EntriesCallback = JSFunction;

/// Success callback for the [onReadFileRequested] event. If more
/// data will be returned, then `hasMore` must be true, and it
/// has to be called again with additional entries. If no more data is
/// available, then `hasMore` must be set to false.
typedef FileDataCallback = JSFunction;

@JS()
@staticInterop
@anonymous
class EntryMetadata {
  external factory EntryMetadata({
    /// True if it is a directory. Must be provided if requested in
    /// `options`.
    bool? isDirectory,

    /// Name of this entry (not full path name). Must not contain '/'. For root
    /// it must be empty. Must be provided if requested in `options`.
    String? name,

    /// File size in bytes. Must be provided if requested in
    /// `options`.
    double? size,

    /// The last modified time of this entry. Must be provided if requested in
    /// `options`.
    JSAny? modificationTime,

    /// Mime type for the entry. Always optional, but should be provided if
    /// requested in `options`.
    String? mimeType,

    /// Thumbnail image as a data URI in either PNG, JPEG or WEBP format, at most
    /// 32 KB in size. Optional, but can be provided only when explicitly
    /// requested by the [onGetMetadataRequested] event.
    String? thumbnail,
  });
}

extension EntryMetadataExtension on EntryMetadata {
  /// True if it is a directory. Must be provided if requested in
  /// `options`.
  external bool? isDirectory;

  /// Name of this entry (not full path name). Must not contain '/'. For root
  /// it must be empty. Must be provided if requested in `options`.
  external String? name;

  /// File size in bytes. Must be provided if requested in
  /// `options`.
  external double? size;

  /// The last modified time of this entry. Must be provided if requested in
  /// `options`.
  external JSAny? modificationTime;

  /// Mime type for the entry. Always optional, but should be provided if
  /// requested in `options`.
  external String? mimeType;

  /// Thumbnail image as a data URI in either PNG, JPEG or WEBP format, at most
  /// 32 KB in size. Optional, but can be provided only when explicitly
  /// requested by the [onGetMetadataRequested] event.
  external String? thumbnail;
}

@JS()
@staticInterop
@anonymous
class Watcher {
  external factory Watcher({
    /// The path of the entry being observed.
    String entryPath,

    /// Whether watching should include all child entries recursively. It can be
    /// true for directories only.
    bool recursive,

    /// Tag used by the last notification for the watcher.
    String? lastTag,
  });
}

extension WatcherExtension on Watcher {
  /// The path of the entry being observed.
  external String entryPath;

  /// Whether watching should include all child entries recursively. It can be
  /// true for directories only.
  external bool recursive;

  /// Tag used by the last notification for the watcher.
  external String? lastTag;
}

@JS()
@staticInterop
@anonymous
class OpenedFile {
  external factory OpenedFile({
    /// A request ID to be be used by consecutive read/write and close requests.
    int openRequestId,

    /// The path of the opened file.
    String filePath,

    /// Whether the file was opened for reading or writing.
    OpenFileMode mode,
  });
}

extension OpenedFileExtension on OpenedFile {
  /// A request ID to be be used by consecutive read/write and close requests.
  external int openRequestId;

  /// The path of the opened file.
  external String filePath;

  /// Whether the file was opened for reading or writing.
  external OpenFileMode mode;
}

@JS()
@staticInterop
@anonymous
class FileSystemInfo {
  external factory FileSystemInfo({
    /// The identifier of the file system.
    String fileSystemId,

    /// A human-readable name for the file system.
    String displayName,

    /// Whether the file system supports operations which may change contents
    /// of the file system (such as creating, deleting or writing to files).
    bool writable,

    /// The maximum number of files that can be opened at once. If 0, then not
    /// limited.
    int openedFilesLimit,

    /// List of currently opened files.
    JSArray openedFiles,

    /// Whether the file system supports the `tag` field for observing
    /// directories.
    bool? supportsNotifyTag,

    /// List of watchers.
    JSArray watchers,
  });
}

extension FileSystemInfoExtension on FileSystemInfo {
  /// The identifier of the file system.
  external String fileSystemId;

  /// A human-readable name for the file system.
  external String displayName;

  /// Whether the file system supports operations which may change contents
  /// of the file system (such as creating, deleting or writing to files).
  external bool writable;

  /// The maximum number of files that can be opened at once. If 0, then not
  /// limited.
  external int openedFilesLimit;

  /// List of currently opened files.
  external JSArray openedFiles;

  /// Whether the file system supports the `tag` field for observing
  /// directories.
  external bool? supportsNotifyTag;

  /// List of watchers.
  external JSArray watchers;
}

@JS()
@staticInterop
@anonymous
class MountOptions {
  external factory MountOptions({
    /// The string indentifier of the file system. Must be unique per each
    /// extension.
    String fileSystemId,

    /// A human-readable name for the file system.
    String displayName,

    /// Whether the file system supports operations which may change contents
    /// of the file system (such as creating, deleting or writing to files).
    bool? writable,

    /// The maximum number of files that can be opened at once. If not specified,
    /// or 0, then not limited.
    int? openedFilesLimit,

    /// Whether the file system supports the `tag` field for observed
    /// directories.
    bool? supportsNotifyTag,

    /// Whether the framework should resume the file system at the next sign-in
    /// session. True by default.
    bool? persistent,
  });
}

extension MountOptionsExtension on MountOptions {
  /// The string indentifier of the file system. Must be unique per each
  /// extension.
  external String fileSystemId;

  /// A human-readable name for the file system.
  external String displayName;

  /// Whether the file system supports operations which may change contents
  /// of the file system (such as creating, deleting or writing to files).
  external bool? writable;

  /// The maximum number of files that can be opened at once. If not specified,
  /// or 0, then not limited.
  external int? openedFilesLimit;

  /// Whether the file system supports the `tag` field for observed
  /// directories.
  external bool? supportsNotifyTag;

  /// Whether the framework should resume the file system at the next sign-in
  /// session. True by default.
  external bool? persistent;
}

@JS()
@staticInterop
@anonymous
class UnmountOptions {
  external factory UnmountOptions(
      {
      /// The identifier of the file system to be unmounted.
      String fileSystemId});
}

extension UnmountOptionsExtension on UnmountOptions {
  /// The identifier of the file system to be unmounted.
  external String fileSystemId;
}

@JS()
@staticInterop
@anonymous
class UnmountRequestedOptions {
  external factory UnmountRequestedOptions({
    /// The identifier of the file system to be unmounted.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,
  });
}

extension UnmountRequestedOptionsExtension on UnmountRequestedOptions {
  /// The identifier of the file system to be unmounted.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;
}

@JS()
@staticInterop
@anonymous
class GetMetadataRequestedOptions {
  external factory GetMetadataRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,

    /// The path of the entry to fetch metadata about.
    String entryPath,

    /// Set to `true` if `is_directory` value is requested.
    bool isDirectory,

    /// Set to `true` if `name` value is requested.
    bool name,

    /// Set to `true` if `size` value is requested.
    bool size,

    /// Set to `true` if `modificationTime` value is
    /// requested.
    bool modificationTime,

    /// Set to `true` if `mimeType` value is requested.
    bool mimeType,

    /// Set to `true` if the thumbnail is requested.
    bool thumbnail,
  });
}

extension GetMetadataRequestedOptionsExtension on GetMetadataRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;

  /// The path of the entry to fetch metadata about.
  external String entryPath;

  /// Set to `true` if `is_directory` value is requested.
  external bool isDirectory;

  /// Set to `true` if `name` value is requested.
  external bool name;

  /// Set to `true` if `size` value is requested.
  external bool size;

  /// Set to `true` if `modificationTime` value is
  /// requested.
  external bool modificationTime;

  /// Set to `true` if `mimeType` value is requested.
  external bool mimeType;

  /// Set to `true` if the thumbnail is requested.
  external bool thumbnail;
}

@JS()
@staticInterop
@anonymous
class GetActionsRequestedOptions {
  external factory GetActionsRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,

    /// List of paths of entries for the list of actions.
    JSArray entryPaths,
  });
}

extension GetActionsRequestedOptionsExtension on GetActionsRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;

  /// List of paths of entries for the list of actions.
  external JSArray entryPaths;
}

@JS()
@staticInterop
@anonymous
class ReadDirectoryRequestedOptions {
  external factory ReadDirectoryRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,

    /// The path of the directory which contents are requested.
    String directoryPath,

    /// Set to `true` if `is_directory` value is requested.
    bool isDirectory,

    /// Set to `true` if `name` value is requested.
    bool name,

    /// Set to `true` if `size` value is requested.
    bool size,

    /// Set to `true` if `modificationTime` value is
    /// requested.
    bool modificationTime,

    /// Set to `true` if `mimeType` value is requested.
    bool mimeType,

    /// Set to `true` if the thumbnail is requested.
    bool thumbnail,
  });
}

extension ReadDirectoryRequestedOptionsExtension
    on ReadDirectoryRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;

  /// The path of the directory which contents are requested.
  external String directoryPath;

  /// Set to `true` if `is_directory` value is requested.
  external bool isDirectory;

  /// Set to `true` if `name` value is requested.
  external bool name;

  /// Set to `true` if `size` value is requested.
  external bool size;

  /// Set to `true` if `modificationTime` value is
  /// requested.
  external bool modificationTime;

  /// Set to `true` if `mimeType` value is requested.
  external bool mimeType;

  /// Set to `true` if the thumbnail is requested.
  external bool thumbnail;
}

@JS()
@staticInterop
@anonymous
class OpenFileRequestedOptions {
  external factory OpenFileRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// A request ID which will be used by consecutive read/write and close
    /// requests.
    int requestId,

    /// The path of the file to be opened.
    String filePath,

    /// Whether the file will be used for reading or writing.
    OpenFileMode mode,
  });
}

extension OpenFileRequestedOptionsExtension on OpenFileRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// A request ID which will be used by consecutive read/write and close
  /// requests.
  external int requestId;

  /// The path of the file to be opened.
  external String filePath;

  /// Whether the file will be used for reading or writing.
  external OpenFileMode mode;
}

@JS()
@staticInterop
@anonymous
class CloseFileRequestedOptions {
  external factory CloseFileRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,

    /// A request ID used to open the file.
    int openRequestId,
  });
}

extension CloseFileRequestedOptionsExtension on CloseFileRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;

  /// A request ID used to open the file.
  external int openRequestId;
}

@JS()
@staticInterop
@anonymous
class ReadFileRequestedOptions {
  external factory ReadFileRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,

    /// A request ID used to open the file.
    int openRequestId,

    /// Position in the file (in bytes) to start reading from.
    double offset,

    /// Number of bytes to be returned.
    double length,
  });
}

extension ReadFileRequestedOptionsExtension on ReadFileRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;

  /// A request ID used to open the file.
  external int openRequestId;

  /// Position in the file (in bytes) to start reading from.
  external double offset;

  /// Number of bytes to be returned.
  external double length;
}

@JS()
@staticInterop
@anonymous
class CreateDirectoryRequestedOptions {
  external factory CreateDirectoryRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,

    /// The path of the directory to be created.
    String directoryPath,

    /// Whether the operation is recursive (for directories only).
    bool recursive,
  });
}

extension CreateDirectoryRequestedOptionsExtension
    on CreateDirectoryRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;

  /// The path of the directory to be created.
  external String directoryPath;

  /// Whether the operation is recursive (for directories only).
  external bool recursive;
}

@JS()
@staticInterop
@anonymous
class DeleteEntryRequestedOptions {
  external factory DeleteEntryRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,

    /// The path of the entry to be deleted.
    String entryPath,

    /// Whether the operation is recursive (for directories only).
    bool recursive,
  });
}

extension DeleteEntryRequestedOptionsExtension on DeleteEntryRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;

  /// The path of the entry to be deleted.
  external String entryPath;

  /// Whether the operation is recursive (for directories only).
  external bool recursive;
}

@JS()
@staticInterop
@anonymous
class CreateFileRequestedOptions {
  external factory CreateFileRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,

    /// The path of the file to be created.
    String filePath,
  });
}

extension CreateFileRequestedOptionsExtension on CreateFileRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;

  /// The path of the file to be created.
  external String filePath;
}

@JS()
@staticInterop
@anonymous
class CopyEntryRequestedOptions {
  external factory CopyEntryRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,

    /// The source path of the entry to be copied.
    String sourcePath,

    /// The destination path for the copy operation.
    String targetPath,
  });
}

extension CopyEntryRequestedOptionsExtension on CopyEntryRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;

  /// The source path of the entry to be copied.
  external String sourcePath;

  /// The destination path for the copy operation.
  external String targetPath;
}

@JS()
@staticInterop
@anonymous
class MoveEntryRequestedOptions {
  external factory MoveEntryRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,

    /// The source path of the entry to be moved into a new place.
    String sourcePath,

    /// The destination path for the copy operation.
    String targetPath,
  });
}

extension MoveEntryRequestedOptionsExtension on MoveEntryRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;

  /// The source path of the entry to be moved into a new place.
  external String sourcePath;

  /// The destination path for the copy operation.
  external String targetPath;
}

@JS()
@staticInterop
@anonymous
class TruncateRequestedOptions {
  external factory TruncateRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,

    /// The path of the file to be truncated.
    String filePath,

    /// Number of bytes to be retained after the operation completes.
    double length,
  });
}

extension TruncateRequestedOptionsExtension on TruncateRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;

  /// The path of the file to be truncated.
  external String filePath;

  /// Number of bytes to be retained after the operation completes.
  external double length;
}

@JS()
@staticInterop
@anonymous
class WriteFileRequestedOptions {
  external factory WriteFileRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,

    /// A request ID used to open the file.
    int openRequestId,

    /// Position in the file (in bytes) to start writing the bytes from.
    double offset,

    /// Buffer of bytes to be written to the file.
    JSArrayBuffer data,
  });
}

extension WriteFileRequestedOptionsExtension on WriteFileRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;

  /// A request ID used to open the file.
  external int openRequestId;

  /// Position in the file (in bytes) to start writing the bytes from.
  external double offset;

  /// Buffer of bytes to be written to the file.
  external JSArrayBuffer data;
}

@JS()
@staticInterop
@anonymous
class AbortRequestedOptions {
  external factory AbortRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,

    /// An ID of the request to be aborted.
    int operationRequestId,
  });
}

extension AbortRequestedOptionsExtension on AbortRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;

  /// An ID of the request to be aborted.
  external int operationRequestId;
}

@JS()
@staticInterop
@anonymous
class AddWatcherRequestedOptions {
  external factory AddWatcherRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,

    /// The path of the entry to be observed.
    String entryPath,

    /// Whether observing should include all child entries recursively. It can be
    /// true for directories only.
    bool recursive,
  });
}

extension AddWatcherRequestedOptionsExtension on AddWatcherRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;

  /// The path of the entry to be observed.
  external String entryPath;

  /// Whether observing should include all child entries recursively. It can be
  /// true for directories only.
  external bool recursive;
}

@JS()
@staticInterop
@anonymous
class RemoveWatcherRequestedOptions {
  external factory RemoveWatcherRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,

    /// The path of the watched entry.
    String entryPath,

    /// Mode of the watcher.
    bool recursive,
  });
}

extension RemoveWatcherRequestedOptionsExtension
    on RemoveWatcherRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;

  /// The path of the watched entry.
  external String entryPath;

  /// Mode of the watcher.
  external bool recursive;
}

@JS()
@staticInterop
@anonymous
class Action {
  external factory Action({
    /// The identifier of the action. Any string or [CommonActionId] for
    /// common actions.
    String id,

    /// The title of the action. It may be ignored for common actions.
    String? title,
  });
}

extension ActionExtension on Action {
  /// The identifier of the action. Any string or [CommonActionId] for
  /// common actions.
  external String id;

  /// The title of the action. It may be ignored for common actions.
  external String? title;
}

@JS()
@staticInterop
@anonymous
class ExecuteActionRequestedOptions {
  external factory ExecuteActionRequestedOptions({
    /// The identifier of the file system related to this operation.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,

    /// The set of paths of the entries to be used for the action.
    JSArray entryPaths,

    /// The identifier of the action to be executed.
    String actionId,
  });
}

extension ExecuteActionRequestedOptionsExtension
    on ExecuteActionRequestedOptions {
  /// The identifier of the file system related to this operation.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;

  /// The set of paths of the entries to be used for the action.
  external JSArray entryPaths;

  /// The identifier of the action to be executed.
  external String actionId;
}

@JS()
@staticInterop
@anonymous
class Change {
  external factory Change({
    /// The path of the changed entry.
    String entryPath,

    /// The type of the change which happened to the entry.
    ChangeType changeType,
  });
}

extension ChangeExtension on Change {
  /// The path of the changed entry.
  external String entryPath;

  /// The type of the change which happened to the entry.
  external ChangeType changeType;
}

@JS()
@staticInterop
@anonymous
class NotifyOptions {
  external factory NotifyOptions({
    /// The identifier of the file system related to this change.
    String fileSystemId,

    /// The path of the observed entry.
    String observedPath,

    /// Mode of the observed entry.
    bool recursive,

    /// The type of the change which happened to the observed entry. If it is
    /// DELETED, then the observed entry will be automatically removed from the
    /// list of observed entries.
    ChangeType changeType,

    /// List of changes to entries within the observed directory (including the
    /// entry itself)
    JSArray? changes,

    /// Tag for the notification. Required if the file system was mounted with
    /// the `supportsNotifyTag` option. Note, that this flag is
    /// necessary to provide notifications about changes which changed even
    /// when the system was shutdown.
    String? tag,
  });
}

extension NotifyOptionsExtension on NotifyOptions {
  /// The identifier of the file system related to this change.
  external String fileSystemId;

  /// The path of the observed entry.
  external String observedPath;

  /// Mode of the observed entry.
  external bool recursive;

  /// The type of the change which happened to the observed entry. If it is
  /// DELETED, then the observed entry will be automatically removed from the
  /// list of observed entries.
  external ChangeType changeType;

  /// List of changes to entries within the observed directory (including the
  /// entry itself)
  external JSArray? changes;

  /// Tag for the notification. Required if the file system was mounted with
  /// the `supportsNotifyTag` option. Note, that this flag is
  /// necessary to provide notifications about changes which changed even
  /// when the system was shutdown.
  external String? tag;
}

@JS()
@staticInterop
@anonymous
class ConfigureRequestedOptions {
  external factory ConfigureRequestedOptions({
    /// The identifier of the file system to be configured.
    String fileSystemId,

    /// The unique identifier of this request.
    int requestId,
  });
}

extension ConfigureRequestedOptionsExtension on ConfigureRequestedOptions {
  /// The identifier of the file system to be configured.
  external String fileSystemId;

  /// The unique identifier of this request.
  external int requestId;
}
