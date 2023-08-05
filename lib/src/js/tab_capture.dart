// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSTabCaptureExtension on JSChrome {
  @JS('tabCapture')
  external JSTabCapture? get tabCaptureNullable;

  /// Use the `chrome.tabCapture` API to interact with tab media
  /// streams.
  JSTabCapture get tabCapture {
    var tabCaptureNullable = this.tabCaptureNullable;
    if (tabCaptureNullable == null) {
      throw ApiNotAvailableException('chrome.tabCapture');
    }
    return tabCaptureNullable;
  }
}

@JS()
@staticInterop
class JSTabCapture {}

extension JSTabCaptureExtension on JSTabCapture {
  /// Captures the visible area of the currently active tab.  Capture can
  /// only be started on the currently active tab after the extension has been
  /// _invoked_, similar to the way that
  /// [activeTab](activeTab#invoking-activeTab) works.
  ///  Capture is maintained across page navigations within
  /// the tab, and stops when the tab is closed, or the media stream is closed
  /// by the extension.
  ///
  /// |options| : Configures the returned media stream.
  /// |callback| : Callback with either the tab capture MediaStream or
  ///   `null`.  `null` indicates an error has occurred
  ///   and the client may query [runtime.lastError] to access the error
  ///   details.
  external void capture(
    CaptureOptions options,
    JSFunction callback,
  );

  /// Returns a list of tabs that have requested capture or are being
  /// captured, i.e. status != stopped and status != error.
  /// This allows extensions to inform the user that there is an existing
  /// tab capture that would prevent a new tab capture from succeeding (or
  /// to prevent redundant requests for the same tab).
  /// |callback| : Callback invoked with CaptureInfo[] for captured tabs.
  external void getCapturedTabs(JSFunction callback);

  /// Creates a stream ID to capture the target tab.
  /// Similar to chrome.tabCapture.capture() method, but returns a media
  /// stream ID, instead of a media stream, to the consumer tab.
  ///
  /// |GetMediaStreamOptions| : Options for the media stream id to retrieve.
  /// |callback| : Callback to invoke with the result. If successful, the
  /// result is an opaque string that can be passed to the
  /// `getUserMedia()` API to generate a media stream that
  /// corresponds to the target tab. The created `streamId` can
  /// only be used once and expires after a few seconds if it is not used.
  external void getMediaStreamId(
    GetMediaStreamOptions? options,
    JSFunction callback,
  );

  /// Event fired when the capture status of a tab changes.
  /// This allows extension authors to keep track of the capture status of
  /// tabs to keep UI elements like page actions in sync.
  /// |info| : CaptureInfo with new capture status for the tab.
  external Event get onStatusChanged;
}

typedef TabCaptureState = String;

@JS()
@staticInterop
@anonymous
class CaptureInfo {
  external factory CaptureInfo({
    /// The id of the tab whose status changed.
    int tabId,

    /// The new capture status of the tab.
    TabCaptureState status,

    /// Whether an element in the tab being captured is in fullscreen mode.
    bool fullscreen,
  });
}

extension CaptureInfoExtension on CaptureInfo {
  /// The id of the tab whose status changed.
  external int tabId;

  /// The new capture status of the tab.
  external TabCaptureState status;

  /// Whether an element in the tab being captured is in fullscreen mode.
  external bool fullscreen;
}

@JS()
@staticInterop
@anonymous
class MediaStreamConstraint {
  external factory MediaStreamConstraint({JSAny mandatory});
}

extension MediaStreamConstraintExtension on MediaStreamConstraint {
  external JSAny mandatory;
}

@JS()
@staticInterop
@anonymous
class CaptureOptions {
  external factory CaptureOptions({
    bool? audio,
    bool? video,
    MediaStreamConstraint? audioConstraints,
    MediaStreamConstraint? videoConstraints,
    String? presentationId,
  });
}

extension CaptureOptionsExtension on CaptureOptions {
  external bool? audio;

  external bool? video;

  external MediaStreamConstraint? audioConstraints;

  external MediaStreamConstraint? videoConstraints;

  external String? presentationId;
}

@JS()
@staticInterop
@anonymous
class GetMediaStreamOptions {
  external factory GetMediaStreamOptions({
    /// Optional tab id of the tab which will later invoke
    /// `getUserMedia()` to consume the stream. If not specified
    /// then the resulting stream can be used only by the calling extension.
    /// The stream can only be used by frames in the given tab whose security
    /// origin matches the consumber tab's origin. The tab's origin must be a
    /// secure origin, e.g. HTTPS.
    int? consumerTabId,

    /// Optional tab id of the tab which will be captured. If not specified
    /// then the current active tab will be selected. Only tabs for which the
    /// extension has been granted the `activeTab` permission can be
    /// used as the target tab.
    int? targetTabId,
  });
}

extension GetMediaStreamOptionsExtension on GetMediaStreamOptions {
  /// Optional tab id of the tab which will later invoke
  /// `getUserMedia()` to consume the stream. If not specified
  /// then the resulting stream can be used only by the calling extension.
  /// The stream can only be used by frames in the given tab whose security
  /// origin matches the consumber tab's origin. The tab's origin must be a
  /// secure origin, e.g. HTTPS.
  external int? consumerTabId;

  /// Optional tab id of the tab which will be captured. If not specified
  /// then the current active tab will be selected. Only tabs for which the
  /// extension has been granted the `activeTab` permission can be
  /// used as the target tab.
  external int? targetTabId;
}
