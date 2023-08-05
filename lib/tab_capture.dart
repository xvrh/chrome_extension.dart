// ignore_for_file: unnecessary_parenthesis

library;

import 'src/internal_helpers.dart';
import 'src/js/tab_capture.dart' as $js;

export 'src/chrome.dart' show chrome;

final _tabCapture = ChromeTabCapture._();

extension ChromeTabCaptureExtension on Chrome {
  /// Use the `chrome.tabCapture` API to interact with tab media
  /// streams.
  ChromeTabCapture get tabCapture => _tabCapture;
}

class ChromeTabCapture {
  ChromeTabCapture._();

  bool get isAvailable => $js.chrome.tabCaptureNullable != null && alwaysTrue;

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
  Future<JSObject> capture(CaptureOptions options) {
    var $completer = Completer<JSObject>();
    $js.chrome.tabCapture.capture(
      options.toJS,
      (JSObject stream) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(stream);
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Returns a list of tabs that have requested capture or are being
  /// captured, i.e. status != stopped and status != error.
  /// This allows extensions to inform the user that there is an existing
  /// tab capture that would prevent a new tab capture from succeeding (or
  /// to prevent redundant requests for the same tab).
  /// |callback| : Callback invoked with CaptureInfo[] for captured tabs.
  Future<List<CaptureInfo>> getCapturedTabs() {
    var $completer = Completer<List<CaptureInfo>>();
    $js.chrome.tabCapture.getCapturedTabs((JSArray result) {
      if (checkRuntimeLastError($completer)) {
        $completer.complete(result.toDart
            .cast<$js.CaptureInfo>()
            .map((e) => CaptureInfo.fromJS(e))
            .toList());
      }
    }.toJS);
    return $completer.future;
  }

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
  Future<String> getMediaStreamId(GetMediaStreamOptions? options) {
    var $completer = Completer<String>();
    $js.chrome.tabCapture.getMediaStreamId(
      options?.toJS,
      (String streamId) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(streamId);
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Event fired when the capture status of a tab changes.
  /// This allows extension authors to keep track of the capture status of
  /// tabs to keep UI elements like page actions in sync.
  /// |info| : CaptureInfo with new capture status for the tab.
  EventStream<CaptureInfo> get onStatusChanged =>
      $js.chrome.tabCapture.onStatusChanged
          .asStream(($c) => ($js.CaptureInfo info) {
                return $c(CaptureInfo.fromJS(info));
              });
}

enum TabCaptureState {
  pending('pending'),
  active('active'),
  stopped('stopped'),
  error('error');

  const TabCaptureState(this.value);

  final String value;

  String get toJS => value;
  static TabCaptureState fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class CaptureInfo {
  CaptureInfo.fromJS(this._wrapped);

  CaptureInfo({
    /// The id of the tab whose status changed.
    required int tabId,

    /// The new capture status of the tab.
    required TabCaptureState status,

    /// Whether an element in the tab being captured is in fullscreen mode.
    required bool fullscreen,
  }) : _wrapped = $js.CaptureInfo(
          tabId: tabId,
          status: status.toJS,
          fullscreen: fullscreen,
        );

  final $js.CaptureInfo _wrapped;

  $js.CaptureInfo get toJS => _wrapped;

  /// The id of the tab whose status changed.
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }

  /// The new capture status of the tab.
  TabCaptureState get status => TabCaptureState.fromJS(_wrapped.status);
  set status(TabCaptureState v) {
    _wrapped.status = v.toJS;
  }

  /// Whether an element in the tab being captured is in fullscreen mode.
  bool get fullscreen => _wrapped.fullscreen;
  set fullscreen(bool v) {
    _wrapped.fullscreen = v;
  }
}

class MediaStreamConstraint {
  MediaStreamConstraint.fromJS(this._wrapped);

  MediaStreamConstraint({required Map mandatory})
      : _wrapped = $js.MediaStreamConstraint(mandatory: mandatory.jsify()!);

  final $js.MediaStreamConstraint _wrapped;

  $js.MediaStreamConstraint get toJS => _wrapped;

  Map get mandatory => _wrapped.mandatory.toDartMap();
  set mandatory(Map v) {
    _wrapped.mandatory = v.jsify()!;
  }
}

class CaptureOptions {
  CaptureOptions.fromJS(this._wrapped);

  CaptureOptions({
    bool? audio,
    bool? video,
    MediaStreamConstraint? audioConstraints,
    MediaStreamConstraint? videoConstraints,
    String? presentationId,
  }) : _wrapped = $js.CaptureOptions(
          audio: audio,
          video: video,
          audioConstraints: audioConstraints?.toJS,
          videoConstraints: videoConstraints?.toJS,
          presentationId: presentationId,
        );

  final $js.CaptureOptions _wrapped;

  $js.CaptureOptions get toJS => _wrapped;

  bool? get audio => _wrapped.audio;
  set audio(bool? v) {
    _wrapped.audio = v;
  }

  bool? get video => _wrapped.video;
  set video(bool? v) {
    _wrapped.video = v;
  }

  MediaStreamConstraint? get audioConstraints =>
      _wrapped.audioConstraints?.let(MediaStreamConstraint.fromJS);
  set audioConstraints(MediaStreamConstraint? v) {
    _wrapped.audioConstraints = v?.toJS;
  }

  MediaStreamConstraint? get videoConstraints =>
      _wrapped.videoConstraints?.let(MediaStreamConstraint.fromJS);
  set videoConstraints(MediaStreamConstraint? v) {
    _wrapped.videoConstraints = v?.toJS;
  }

  String? get presentationId => _wrapped.presentationId;
  set presentationId(String? v) {
    _wrapped.presentationId = v;
  }
}

class GetMediaStreamOptions {
  GetMediaStreamOptions.fromJS(this._wrapped);

  GetMediaStreamOptions({
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
  }) : _wrapped = $js.GetMediaStreamOptions(
          consumerTabId: consumerTabId,
          targetTabId: targetTabId,
        );

  final $js.GetMediaStreamOptions _wrapped;

  $js.GetMediaStreamOptions get toJS => _wrapped;

  /// Optional tab id of the tab which will later invoke
  /// `getUserMedia()` to consume the stream. If not specified
  /// then the resulting stream can be used only by the calling extension.
  /// The stream can only be used by frames in the given tab whose security
  /// origin matches the consumber tab's origin. The tab's origin must be a
  /// secure origin, e.g. HTTPS.
  int? get consumerTabId => _wrapped.consumerTabId;
  set consumerTabId(int? v) {
    _wrapped.consumerTabId = v;
  }

  /// Optional tab id of the tab which will be captured. If not specified
  /// then the current active tab will be selected. Only tabs for which the
  /// extension has been granted the `activeTab` permission can be
  /// used as the target tab.
  int? get targetTabId => _wrapped.targetTabId;
  set targetTabId(int? v) {
    _wrapped.targetTabId = v;
  }
}
