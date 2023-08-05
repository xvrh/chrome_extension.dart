// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'extension_types.dart';
import 'src/internal_helpers.dart';
import 'src/js/web_navigation.dart' as $js;

export 'src/chrome.dart' show chrome;

final _webNavigation = ChromeWebNavigation._();

extension ChromeWebNavigationExtension on Chrome {
  /// Use the `chrome.webNavigation` API to receive notifications about the
  /// status of navigation requests in-flight.
  ChromeWebNavigation get webNavigation => _webNavigation;
}

class ChromeWebNavigation {
  ChromeWebNavigation._();

  bool get isAvailable =>
      $js.chrome.webNavigationNullable != null && alwaysTrue;

  /// Retrieves information about the given frame. A frame refers to an <iframe>
  /// or a <frame> of a web page and is identified by a tab ID and a frame ID.
  /// [details] Information about the frame to retrieve information about.
  Future<GetFrameCallbackDetails?> getFrame(GetFrameDetails details) async {
    var $res = await promiseToFuture<$js.GetFrameCallbackDetails?>(
        $js.chrome.webNavigation.getFrame(details.toJS));
    return $res?.let(GetFrameCallbackDetails.fromJS);
  }

  /// Retrieves information about all frames of a given tab.
  /// [details] Information about the tab to retrieve all frames from.
  Future<List<GetAllFramesCallbackDetails>?> getAllFrames(
      GetAllFramesDetails details) async {
    var $res = await promiseToFuture<JSArray?>(
        $js.chrome.webNavigation.getAllFrames(details.toJS));
    return $res?.toDart
        .cast<$js.GetAllFramesCallbackDetails>()
        .map((e) => GetAllFramesCallbackDetails.fromJS(e))
        .toList();
  }

  /// Fired when a navigation is about to occur.
  EventStream<OnBeforeNavigateDetails> get onBeforeNavigate =>
      $js.chrome.webNavigation.onBeforeNavigate
          .asStream(($c) => ($js.OnBeforeNavigateDetails details) {
                return $c(OnBeforeNavigateDetails.fromJS(details));
              });

  /// Fired when a navigation is committed. The document (and the resources it
  /// refers to, such as images and subframes) might still be downloading, but
  /// at least part of the document has been received from the server and the
  /// browser has decided to switch to the new document.
  EventStream<OnCommittedDetails> get onCommitted =>
      $js.chrome.webNavigation.onCommitted
          .asStream(($c) => ($js.OnCommittedDetails details) {
                return $c(OnCommittedDetails.fromJS(details));
              });

  /// Fired when the page's DOM is fully constructed, but the referenced
  /// resources may not finish loading.
  EventStream<OnDomContentLoadedDetails> get onDOMContentLoaded =>
      $js.chrome.webNavigation.onDOMContentLoaded
          .asStream(($c) => ($js.OnDomContentLoadedDetails details) {
                return $c(OnDomContentLoadedDetails.fromJS(details));
              });

  /// Fired when a document, including the resources it refers to, is completely
  /// loaded and initialized.
  EventStream<OnCompletedDetails> get onCompleted =>
      $js.chrome.webNavigation.onCompleted
          .asStream(($c) => ($js.OnCompletedDetails details) {
                return $c(OnCompletedDetails.fromJS(details));
              });

  /// Fired when an error occurs and the navigation is aborted. This can happen
  /// if either a network error occurred, or the user aborted the navigation.
  EventStream<OnErrorOccurredDetails> get onErrorOccurred =>
      $js.chrome.webNavigation.onErrorOccurred
          .asStream(($c) => ($js.OnErrorOccurredDetails details) {
                return $c(OnErrorOccurredDetails.fromJS(details));
              });

  /// Fired when a new window, or a new tab in an existing window, is created to
  /// host a navigation.
  EventStream<OnCreatedNavigationTargetDetails> get onCreatedNavigationTarget =>
      $js.chrome.webNavigation.onCreatedNavigationTarget
          .asStream(($c) => ($js.OnCreatedNavigationTargetDetails details) {
                return $c(OnCreatedNavigationTargetDetails.fromJS(details));
              });

  /// Fired when the reference fragment of a frame was updated. All future
  /// events for that frame will use the updated URL.
  EventStream<OnReferenceFragmentUpdatedDetails>
      get onReferenceFragmentUpdated => $js
          .chrome.webNavigation.onReferenceFragmentUpdated
          .asStream(($c) => ($js.OnReferenceFragmentUpdatedDetails details) {
                return $c(OnReferenceFragmentUpdatedDetails.fromJS(details));
              });

  /// Fired when the contents of the tab is replaced by a different (usually
  /// previously pre-rendered) tab.
  EventStream<OnTabReplacedDetails> get onTabReplaced =>
      $js.chrome.webNavigation.onTabReplaced
          .asStream(($c) => ($js.OnTabReplacedDetails details) {
                return $c(OnTabReplacedDetails.fromJS(details));
              });

  /// Fired when the frame's history was updated to a new URL. All future events
  /// for that frame will use the updated URL.
  EventStream<OnHistoryStateUpdatedDetails> get onHistoryStateUpdated =>
      $js.chrome.webNavigation.onHistoryStateUpdated
          .asStream(($c) => ($js.OnHistoryStateUpdatedDetails details) {
                return $c(OnHistoryStateUpdatedDetails.fromJS(details));
              });
}

/// Cause of the navigation. The same transition types as defined in the history
/// API are used. These are the same transition types as defined in the [history
/// API](history#transition_types) except with `"start_page"` in place of
/// `"auto_toplevel"` (for backwards compatibility).
enum TransitionType {
  link('link'),
  typed('typed'),
  autoBookmark('auto_bookmark'),
  autoSubframe('auto_subframe'),
  manualSubframe('manual_subframe'),
  generated('generated'),
  startPage('start_page'),
  formSubmit('form_submit'),
  reload('reload'),
  keyword('keyword'),
  keywordGenerated('keyword_generated');

  const TransitionType(this.value);

  final String value;

  String get toJS => value;
  static TransitionType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum TransitionQualifier {
  clientRedirect('client_redirect'),
  serverRedirect('server_redirect'),
  forwardBack('forward_back'),
  fromAddressBar('from_address_bar');

  const TransitionQualifier(this.value);

  final String value;

  String get toJS => value;
  static TransitionQualifier fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class OnBeforeNavigateDetails {
  OnBeforeNavigateDetails.fromJS(this._wrapped);

  OnBeforeNavigateDetails({
    /// The ID of the tab in which the navigation is about to occur.
    required int tabId,
    required String url,

    /// The value of -1.
    required int processId,

    /// 0 indicates the navigation happens in the tab content window; a positive
    /// value indicates navigation in a subframe. Frame IDs are unique for a
    /// given tab and process.
    required int frameId,

    /// The ID of the parent frame, or `-1` if this is the main frame.
    required int parentFrameId,

    /// The time when the browser was about to start the navigation, in
    /// milliseconds since the epoch.
    required double timeStamp,

    /// A UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    required DocumentLifecycle documentLifecycle,

    /// The type of frame the navigation occurred in.
    required FrameType frameType,
  }) : _wrapped = $js.OnBeforeNavigateDetails(
          tabId: tabId,
          url: url,
          processId: processId,
          frameId: frameId,
          parentFrameId: parentFrameId,
          timeStamp: timeStamp,
          parentDocumentId: parentDocumentId,
          documentLifecycle: documentLifecycle.toJS,
          frameType: frameType.toJS,
        );

  final $js.OnBeforeNavigateDetails _wrapped;

  $js.OnBeforeNavigateDetails get toJS => _wrapped;

  /// The ID of the tab in which the navigation is about to occur.
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }

  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// The value of -1.
  int get processId => _wrapped.processId;
  set processId(int v) {
    _wrapped.processId = v;
  }

  /// 0 indicates the navigation happens in the tab content window; a positive
  /// value indicates navigation in a subframe. Frame IDs are unique for a given
  /// tab and process.
  int get frameId => _wrapped.frameId;
  set frameId(int v) {
    _wrapped.frameId = v;
  }

  /// The ID of the parent frame, or `-1` if this is the main frame.
  int get parentFrameId => _wrapped.parentFrameId;
  set parentFrameId(int v) {
    _wrapped.parentFrameId = v;
  }

  /// The time when the browser was about to start the navigation, in
  /// milliseconds since the epoch.
  double get timeStamp => _wrapped.timeStamp;
  set timeStamp(double v) {
    _wrapped.timeStamp = v;
  }

  /// A UUID of the parent document owning this frame. This is not set if there
  /// is no parent.
  String? get parentDocumentId => _wrapped.parentDocumentId;
  set parentDocumentId(String? v) {
    _wrapped.parentDocumentId = v;
  }

  /// The lifecycle the document is in.
  DocumentLifecycle get documentLifecycle =>
      DocumentLifecycle.fromJS(_wrapped.documentLifecycle);
  set documentLifecycle(DocumentLifecycle v) {
    _wrapped.documentLifecycle = v.toJS;
  }

  /// The type of frame the navigation occurred in.
  FrameType get frameType => FrameType.fromJS(_wrapped.frameType);
  set frameType(FrameType v) {
    _wrapped.frameType = v.toJS;
  }
}

class OnCommittedDetails {
  OnCommittedDetails.fromJS(this._wrapped);

  OnCommittedDetails({
    /// The ID of the tab in which the navigation occurs.
    required int tabId,
    required String url,

    /// The ID of the process that runs the renderer for this frame.
    required int processId,

    /// 0 indicates the navigation happens in the tab content window; a positive
    /// value indicates navigation in a subframe. Frame IDs are unique within a
    /// tab.
    required int frameId,

    /// The ID of the parent frame, or `-1` if this is the main frame.
    required int parentFrameId,

    /// Cause of the navigation.
    required TransitionType transitionType,

    /// A list of transition qualifiers.
    required List<TransitionQualifier> transitionQualifiers,

    /// The time when the navigation was committed, in milliseconds since the
    /// epoch.
    required double timeStamp,

    /// A UUID of the document loaded.
    required String documentId,

    /// A UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    required DocumentLifecycle documentLifecycle,

    /// The type of frame the navigation occurred in.
    required FrameType frameType,
  }) : _wrapped = $js.OnCommittedDetails(
          tabId: tabId,
          url: url,
          processId: processId,
          frameId: frameId,
          parentFrameId: parentFrameId,
          transitionType: transitionType.toJS,
          transitionQualifiers: transitionQualifiers.toJSArray((e) => e.toJS),
          timeStamp: timeStamp,
          documentId: documentId,
          parentDocumentId: parentDocumentId,
          documentLifecycle: documentLifecycle.toJS,
          frameType: frameType.toJS,
        );

  final $js.OnCommittedDetails _wrapped;

  $js.OnCommittedDetails get toJS => _wrapped;

  /// The ID of the tab in which the navigation occurs.
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }

  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// The ID of the process that runs the renderer for this frame.
  int get processId => _wrapped.processId;
  set processId(int v) {
    _wrapped.processId = v;
  }

  /// 0 indicates the navigation happens in the tab content window; a positive
  /// value indicates navigation in a subframe. Frame IDs are unique within a
  /// tab.
  int get frameId => _wrapped.frameId;
  set frameId(int v) {
    _wrapped.frameId = v;
  }

  /// The ID of the parent frame, or `-1` if this is the main frame.
  int get parentFrameId => _wrapped.parentFrameId;
  set parentFrameId(int v) {
    _wrapped.parentFrameId = v;
  }

  /// Cause of the navigation.
  TransitionType get transitionType =>
      TransitionType.fromJS(_wrapped.transitionType);
  set transitionType(TransitionType v) {
    _wrapped.transitionType = v.toJS;
  }

  /// A list of transition qualifiers.
  List<TransitionQualifier> get transitionQualifiers =>
      _wrapped.transitionQualifiers.toDart
          .cast<$js.TransitionQualifier>()
          .map((e) => TransitionQualifier.fromJS(e))
          .toList();
  set transitionQualifiers(List<TransitionQualifier> v) {
    _wrapped.transitionQualifiers = v.toJSArray((e) => e.toJS);
  }

  /// The time when the navigation was committed, in milliseconds since the
  /// epoch.
  double get timeStamp => _wrapped.timeStamp;
  set timeStamp(double v) {
    _wrapped.timeStamp = v;
  }

  /// A UUID of the document loaded.
  String get documentId => _wrapped.documentId;
  set documentId(String v) {
    _wrapped.documentId = v;
  }

  /// A UUID of the parent document owning this frame. This is not set if there
  /// is no parent.
  String? get parentDocumentId => _wrapped.parentDocumentId;
  set parentDocumentId(String? v) {
    _wrapped.parentDocumentId = v;
  }

  /// The lifecycle the document is in.
  DocumentLifecycle get documentLifecycle =>
      DocumentLifecycle.fromJS(_wrapped.documentLifecycle);
  set documentLifecycle(DocumentLifecycle v) {
    _wrapped.documentLifecycle = v.toJS;
  }

  /// The type of frame the navigation occurred in.
  FrameType get frameType => FrameType.fromJS(_wrapped.frameType);
  set frameType(FrameType v) {
    _wrapped.frameType = v.toJS;
  }
}

class OnDomContentLoadedDetails {
  OnDomContentLoadedDetails.fromJS(this._wrapped);

  OnDomContentLoadedDetails({
    /// The ID of the tab in which the navigation occurs.
    required int tabId,
    required String url,

    /// The ID of the process that runs the renderer for this frame.
    required int processId,

    /// 0 indicates the navigation happens in the tab content window; a positive
    /// value indicates navigation in a subframe. Frame IDs are unique within a
    /// tab.
    required int frameId,

    /// The ID of the parent frame, or `-1` if this is the main frame.
    required int parentFrameId,

    /// The time when the page's DOM was fully constructed, in milliseconds
    /// since the epoch.
    required double timeStamp,

    /// A UUID of the document loaded.
    required String documentId,

    /// A UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    required DocumentLifecycle documentLifecycle,

    /// The type of frame the navigation occurred in.
    required FrameType frameType,
  }) : _wrapped = $js.OnDomContentLoadedDetails(
          tabId: tabId,
          url: url,
          processId: processId,
          frameId: frameId,
          parentFrameId: parentFrameId,
          timeStamp: timeStamp,
          documentId: documentId,
          parentDocumentId: parentDocumentId,
          documentLifecycle: documentLifecycle.toJS,
          frameType: frameType.toJS,
        );

  final $js.OnDomContentLoadedDetails _wrapped;

  $js.OnDomContentLoadedDetails get toJS => _wrapped;

  /// The ID of the tab in which the navigation occurs.
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }

  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// The ID of the process that runs the renderer for this frame.
  int get processId => _wrapped.processId;
  set processId(int v) {
    _wrapped.processId = v;
  }

  /// 0 indicates the navigation happens in the tab content window; a positive
  /// value indicates navigation in a subframe. Frame IDs are unique within a
  /// tab.
  int get frameId => _wrapped.frameId;
  set frameId(int v) {
    _wrapped.frameId = v;
  }

  /// The ID of the parent frame, or `-1` if this is the main frame.
  int get parentFrameId => _wrapped.parentFrameId;
  set parentFrameId(int v) {
    _wrapped.parentFrameId = v;
  }

  /// The time when the page's DOM was fully constructed, in milliseconds since
  /// the epoch.
  double get timeStamp => _wrapped.timeStamp;
  set timeStamp(double v) {
    _wrapped.timeStamp = v;
  }

  /// A UUID of the document loaded.
  String get documentId => _wrapped.documentId;
  set documentId(String v) {
    _wrapped.documentId = v;
  }

  /// A UUID of the parent document owning this frame. This is not set if there
  /// is no parent.
  String? get parentDocumentId => _wrapped.parentDocumentId;
  set parentDocumentId(String? v) {
    _wrapped.parentDocumentId = v;
  }

  /// The lifecycle the document is in.
  DocumentLifecycle get documentLifecycle =>
      DocumentLifecycle.fromJS(_wrapped.documentLifecycle);
  set documentLifecycle(DocumentLifecycle v) {
    _wrapped.documentLifecycle = v.toJS;
  }

  /// The type of frame the navigation occurred in.
  FrameType get frameType => FrameType.fromJS(_wrapped.frameType);
  set frameType(FrameType v) {
    _wrapped.frameType = v.toJS;
  }
}

class OnCompletedDetails {
  OnCompletedDetails.fromJS(this._wrapped);

  OnCompletedDetails({
    /// The ID of the tab in which the navigation occurs.
    required int tabId,
    required String url,

    /// The ID of the process that runs the renderer for this frame.
    required int processId,

    /// 0 indicates the navigation happens in the tab content window; a positive
    /// value indicates navigation in a subframe. Frame IDs are unique within a
    /// tab.
    required int frameId,

    /// The ID of the parent frame, or `-1` if this is the main frame.
    required int parentFrameId,

    /// The time when the document finished loading, in milliseconds since the
    /// epoch.
    required double timeStamp,

    /// A UUID of the document loaded.
    required String documentId,

    /// A UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    required DocumentLifecycle documentLifecycle,

    /// The type of frame the navigation occurred in.
    required FrameType frameType,
  }) : _wrapped = $js.OnCompletedDetails(
          tabId: tabId,
          url: url,
          processId: processId,
          frameId: frameId,
          parentFrameId: parentFrameId,
          timeStamp: timeStamp,
          documentId: documentId,
          parentDocumentId: parentDocumentId,
          documentLifecycle: documentLifecycle.toJS,
          frameType: frameType.toJS,
        );

  final $js.OnCompletedDetails _wrapped;

  $js.OnCompletedDetails get toJS => _wrapped;

  /// The ID of the tab in which the navigation occurs.
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }

  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// The ID of the process that runs the renderer for this frame.
  int get processId => _wrapped.processId;
  set processId(int v) {
    _wrapped.processId = v;
  }

  /// 0 indicates the navigation happens in the tab content window; a positive
  /// value indicates navigation in a subframe. Frame IDs are unique within a
  /// tab.
  int get frameId => _wrapped.frameId;
  set frameId(int v) {
    _wrapped.frameId = v;
  }

  /// The ID of the parent frame, or `-1` if this is the main frame.
  int get parentFrameId => _wrapped.parentFrameId;
  set parentFrameId(int v) {
    _wrapped.parentFrameId = v;
  }

  /// The time when the document finished loading, in milliseconds since the
  /// epoch.
  double get timeStamp => _wrapped.timeStamp;
  set timeStamp(double v) {
    _wrapped.timeStamp = v;
  }

  /// A UUID of the document loaded.
  String get documentId => _wrapped.documentId;
  set documentId(String v) {
    _wrapped.documentId = v;
  }

  /// A UUID of the parent document owning this frame. This is not set if there
  /// is no parent.
  String? get parentDocumentId => _wrapped.parentDocumentId;
  set parentDocumentId(String? v) {
    _wrapped.parentDocumentId = v;
  }

  /// The lifecycle the document is in.
  DocumentLifecycle get documentLifecycle =>
      DocumentLifecycle.fromJS(_wrapped.documentLifecycle);
  set documentLifecycle(DocumentLifecycle v) {
    _wrapped.documentLifecycle = v.toJS;
  }

  /// The type of frame the navigation occurred in.
  FrameType get frameType => FrameType.fromJS(_wrapped.frameType);
  set frameType(FrameType v) {
    _wrapped.frameType = v.toJS;
  }
}

class OnErrorOccurredDetails {
  OnErrorOccurredDetails.fromJS(this._wrapped);

  OnErrorOccurredDetails({
    /// The ID of the tab in which the navigation occurs.
    required int tabId,
    required String url,

    /// The value of -1.
    required int processId,

    /// 0 indicates the navigation happens in the tab content window; a positive
    /// value indicates navigation in a subframe. Frame IDs are unique within a
    /// tab.
    required int frameId,

    /// The ID of the parent frame, or `-1` if this is the main frame.
    required int parentFrameId,

    /// The error description.
    required String error,

    /// The time when the error occurred, in milliseconds since the epoch.
    required double timeStamp,

    /// A UUID of the document loaded.
    required String documentId,

    /// A UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    required DocumentLifecycle documentLifecycle,

    /// The type of frame the navigation occurred in.
    required FrameType frameType,
  }) : _wrapped = $js.OnErrorOccurredDetails(
          tabId: tabId,
          url: url,
          processId: processId,
          frameId: frameId,
          parentFrameId: parentFrameId,
          error: error,
          timeStamp: timeStamp,
          documentId: documentId,
          parentDocumentId: parentDocumentId,
          documentLifecycle: documentLifecycle.toJS,
          frameType: frameType.toJS,
        );

  final $js.OnErrorOccurredDetails _wrapped;

  $js.OnErrorOccurredDetails get toJS => _wrapped;

  /// The ID of the tab in which the navigation occurs.
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }

  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// The value of -1.
  int get processId => _wrapped.processId;
  set processId(int v) {
    _wrapped.processId = v;
  }

  /// 0 indicates the navigation happens in the tab content window; a positive
  /// value indicates navigation in a subframe. Frame IDs are unique within a
  /// tab.
  int get frameId => _wrapped.frameId;
  set frameId(int v) {
    _wrapped.frameId = v;
  }

  /// The ID of the parent frame, or `-1` if this is the main frame.
  int get parentFrameId => _wrapped.parentFrameId;
  set parentFrameId(int v) {
    _wrapped.parentFrameId = v;
  }

  /// The error description.
  String get error => _wrapped.error;
  set error(String v) {
    _wrapped.error = v;
  }

  /// The time when the error occurred, in milliseconds since the epoch.
  double get timeStamp => _wrapped.timeStamp;
  set timeStamp(double v) {
    _wrapped.timeStamp = v;
  }

  /// A UUID of the document loaded.
  String get documentId => _wrapped.documentId;
  set documentId(String v) {
    _wrapped.documentId = v;
  }

  /// A UUID of the parent document owning this frame. This is not set if there
  /// is no parent.
  String? get parentDocumentId => _wrapped.parentDocumentId;
  set parentDocumentId(String? v) {
    _wrapped.parentDocumentId = v;
  }

  /// The lifecycle the document is in.
  DocumentLifecycle get documentLifecycle =>
      DocumentLifecycle.fromJS(_wrapped.documentLifecycle);
  set documentLifecycle(DocumentLifecycle v) {
    _wrapped.documentLifecycle = v.toJS;
  }

  /// The type of frame the navigation occurred in.
  FrameType get frameType => FrameType.fromJS(_wrapped.frameType);
  set frameType(FrameType v) {
    _wrapped.frameType = v.toJS;
  }
}

class OnCreatedNavigationTargetDetails {
  OnCreatedNavigationTargetDetails.fromJS(this._wrapped);

  OnCreatedNavigationTargetDetails({
    /// The ID of the tab in which the navigation is triggered.
    required int sourceTabId,

    /// The ID of the process that runs the renderer for the source frame.
    required int sourceProcessId,

    /// The ID of the frame with sourceTabId in which the navigation is
    /// triggered. 0 indicates the main frame.
    required int sourceFrameId,

    /// The URL to be opened in the new window.
    required String url,

    /// The ID of the tab in which the url is opened
    required int tabId,

    /// The time when the browser was about to create a new view, in
    /// milliseconds since the epoch.
    required double timeStamp,
  }) : _wrapped = $js.OnCreatedNavigationTargetDetails(
          sourceTabId: sourceTabId,
          sourceProcessId: sourceProcessId,
          sourceFrameId: sourceFrameId,
          url: url,
          tabId: tabId,
          timeStamp: timeStamp,
        );

  final $js.OnCreatedNavigationTargetDetails _wrapped;

  $js.OnCreatedNavigationTargetDetails get toJS => _wrapped;

  /// The ID of the tab in which the navigation is triggered.
  int get sourceTabId => _wrapped.sourceTabId;
  set sourceTabId(int v) {
    _wrapped.sourceTabId = v;
  }

  /// The ID of the process that runs the renderer for the source frame.
  int get sourceProcessId => _wrapped.sourceProcessId;
  set sourceProcessId(int v) {
    _wrapped.sourceProcessId = v;
  }

  /// The ID of the frame with sourceTabId in which the navigation is triggered.
  /// 0 indicates the main frame.
  int get sourceFrameId => _wrapped.sourceFrameId;
  set sourceFrameId(int v) {
    _wrapped.sourceFrameId = v;
  }

  /// The URL to be opened in the new window.
  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// The ID of the tab in which the url is opened
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }

  /// The time when the browser was about to create a new view, in milliseconds
  /// since the epoch.
  double get timeStamp => _wrapped.timeStamp;
  set timeStamp(double v) {
    _wrapped.timeStamp = v;
  }
}

class OnReferenceFragmentUpdatedDetails {
  OnReferenceFragmentUpdatedDetails.fromJS(this._wrapped);

  OnReferenceFragmentUpdatedDetails({
    /// The ID of the tab in which the navigation occurs.
    required int tabId,
    required String url,

    /// The ID of the process that runs the renderer for this frame.
    required int processId,

    /// 0 indicates the navigation happens in the tab content window; a positive
    /// value indicates navigation in a subframe. Frame IDs are unique within a
    /// tab.
    required int frameId,

    /// The ID of the parent frame, or `-1` if this is the main frame.
    required int parentFrameId,

    /// Cause of the navigation.
    required TransitionType transitionType,

    /// A list of transition qualifiers.
    required List<TransitionQualifier> transitionQualifiers,

    /// The time when the navigation was committed, in milliseconds since the
    /// epoch.
    required double timeStamp,

    /// A UUID of the document loaded.
    required String documentId,

    /// A UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    required DocumentLifecycle documentLifecycle,

    /// The type of frame the navigation occurred in.
    required FrameType frameType,
  }) : _wrapped = $js.OnReferenceFragmentUpdatedDetails(
          tabId: tabId,
          url: url,
          processId: processId,
          frameId: frameId,
          parentFrameId: parentFrameId,
          transitionType: transitionType.toJS,
          transitionQualifiers: transitionQualifiers.toJSArray((e) => e.toJS),
          timeStamp: timeStamp,
          documentId: documentId,
          parentDocumentId: parentDocumentId,
          documentLifecycle: documentLifecycle.toJS,
          frameType: frameType.toJS,
        );

  final $js.OnReferenceFragmentUpdatedDetails _wrapped;

  $js.OnReferenceFragmentUpdatedDetails get toJS => _wrapped;

  /// The ID of the tab in which the navigation occurs.
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }

  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// The ID of the process that runs the renderer for this frame.
  int get processId => _wrapped.processId;
  set processId(int v) {
    _wrapped.processId = v;
  }

  /// 0 indicates the navigation happens in the tab content window; a positive
  /// value indicates navigation in a subframe. Frame IDs are unique within a
  /// tab.
  int get frameId => _wrapped.frameId;
  set frameId(int v) {
    _wrapped.frameId = v;
  }

  /// The ID of the parent frame, or `-1` if this is the main frame.
  int get parentFrameId => _wrapped.parentFrameId;
  set parentFrameId(int v) {
    _wrapped.parentFrameId = v;
  }

  /// Cause of the navigation.
  TransitionType get transitionType =>
      TransitionType.fromJS(_wrapped.transitionType);
  set transitionType(TransitionType v) {
    _wrapped.transitionType = v.toJS;
  }

  /// A list of transition qualifiers.
  List<TransitionQualifier> get transitionQualifiers =>
      _wrapped.transitionQualifiers.toDart
          .cast<$js.TransitionQualifier>()
          .map((e) => TransitionQualifier.fromJS(e))
          .toList();
  set transitionQualifiers(List<TransitionQualifier> v) {
    _wrapped.transitionQualifiers = v.toJSArray((e) => e.toJS);
  }

  /// The time when the navigation was committed, in milliseconds since the
  /// epoch.
  double get timeStamp => _wrapped.timeStamp;
  set timeStamp(double v) {
    _wrapped.timeStamp = v;
  }

  /// A UUID of the document loaded.
  String get documentId => _wrapped.documentId;
  set documentId(String v) {
    _wrapped.documentId = v;
  }

  /// A UUID of the parent document owning this frame. This is not set if there
  /// is no parent.
  String? get parentDocumentId => _wrapped.parentDocumentId;
  set parentDocumentId(String? v) {
    _wrapped.parentDocumentId = v;
  }

  /// The lifecycle the document is in.
  DocumentLifecycle get documentLifecycle =>
      DocumentLifecycle.fromJS(_wrapped.documentLifecycle);
  set documentLifecycle(DocumentLifecycle v) {
    _wrapped.documentLifecycle = v.toJS;
  }

  /// The type of frame the navigation occurred in.
  FrameType get frameType => FrameType.fromJS(_wrapped.frameType);
  set frameType(FrameType v) {
    _wrapped.frameType = v.toJS;
  }
}

class OnTabReplacedDetails {
  OnTabReplacedDetails.fromJS(this._wrapped);

  OnTabReplacedDetails({
    /// The ID of the tab that was replaced.
    required int replacedTabId,

    /// The ID of the tab that replaced the old tab.
    required int tabId,

    /// The time when the replacement happened, in milliseconds since the epoch.
    required double timeStamp,
  }) : _wrapped = $js.OnTabReplacedDetails(
          replacedTabId: replacedTabId,
          tabId: tabId,
          timeStamp: timeStamp,
        );

  final $js.OnTabReplacedDetails _wrapped;

  $js.OnTabReplacedDetails get toJS => _wrapped;

  /// The ID of the tab that was replaced.
  int get replacedTabId => _wrapped.replacedTabId;
  set replacedTabId(int v) {
    _wrapped.replacedTabId = v;
  }

  /// The ID of the tab that replaced the old tab.
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }

  /// The time when the replacement happened, in milliseconds since the epoch.
  double get timeStamp => _wrapped.timeStamp;
  set timeStamp(double v) {
    _wrapped.timeStamp = v;
  }
}

class OnHistoryStateUpdatedDetails {
  OnHistoryStateUpdatedDetails.fromJS(this._wrapped);

  OnHistoryStateUpdatedDetails({
    /// The ID of the tab in which the navigation occurs.
    required int tabId,
    required String url,

    /// The ID of the process that runs the renderer for this frame.
    required int processId,

    /// 0 indicates the navigation happens in the tab content window; a positive
    /// value indicates navigation in a subframe. Frame IDs are unique within a
    /// tab.
    required int frameId,

    /// The ID of the parent frame, or `-1` if this is the main frame.
    required int parentFrameId,

    /// Cause of the navigation.
    required TransitionType transitionType,

    /// A list of transition qualifiers.
    required List<TransitionQualifier> transitionQualifiers,

    /// The time when the navigation was committed, in milliseconds since the
    /// epoch.
    required double timeStamp,

    /// A UUID of the document loaded.
    required String documentId,

    /// A UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    required DocumentLifecycle documentLifecycle,

    /// The type of frame the navigation occurred in.
    required FrameType frameType,
  }) : _wrapped = $js.OnHistoryStateUpdatedDetails(
          tabId: tabId,
          url: url,
          processId: processId,
          frameId: frameId,
          parentFrameId: parentFrameId,
          transitionType: transitionType.toJS,
          transitionQualifiers: transitionQualifiers.toJSArray((e) => e.toJS),
          timeStamp: timeStamp,
          documentId: documentId,
          parentDocumentId: parentDocumentId,
          documentLifecycle: documentLifecycle.toJS,
          frameType: frameType.toJS,
        );

  final $js.OnHistoryStateUpdatedDetails _wrapped;

  $js.OnHistoryStateUpdatedDetails get toJS => _wrapped;

  /// The ID of the tab in which the navigation occurs.
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }

  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// The ID of the process that runs the renderer for this frame.
  int get processId => _wrapped.processId;
  set processId(int v) {
    _wrapped.processId = v;
  }

  /// 0 indicates the navigation happens in the tab content window; a positive
  /// value indicates navigation in a subframe. Frame IDs are unique within a
  /// tab.
  int get frameId => _wrapped.frameId;
  set frameId(int v) {
    _wrapped.frameId = v;
  }

  /// The ID of the parent frame, or `-1` if this is the main frame.
  int get parentFrameId => _wrapped.parentFrameId;
  set parentFrameId(int v) {
    _wrapped.parentFrameId = v;
  }

  /// Cause of the navigation.
  TransitionType get transitionType =>
      TransitionType.fromJS(_wrapped.transitionType);
  set transitionType(TransitionType v) {
    _wrapped.transitionType = v.toJS;
  }

  /// A list of transition qualifiers.
  List<TransitionQualifier> get transitionQualifiers =>
      _wrapped.transitionQualifiers.toDart
          .cast<$js.TransitionQualifier>()
          .map((e) => TransitionQualifier.fromJS(e))
          .toList();
  set transitionQualifiers(List<TransitionQualifier> v) {
    _wrapped.transitionQualifiers = v.toJSArray((e) => e.toJS);
  }

  /// The time when the navigation was committed, in milliseconds since the
  /// epoch.
  double get timeStamp => _wrapped.timeStamp;
  set timeStamp(double v) {
    _wrapped.timeStamp = v;
  }

  /// A UUID of the document loaded.
  String get documentId => _wrapped.documentId;
  set documentId(String v) {
    _wrapped.documentId = v;
  }

  /// A UUID of the parent document owning this frame. This is not set if there
  /// is no parent.
  String? get parentDocumentId => _wrapped.parentDocumentId;
  set parentDocumentId(String? v) {
    _wrapped.parentDocumentId = v;
  }

  /// The lifecycle the document is in.
  DocumentLifecycle get documentLifecycle =>
      DocumentLifecycle.fromJS(_wrapped.documentLifecycle);
  set documentLifecycle(DocumentLifecycle v) {
    _wrapped.documentLifecycle = v.toJS;
  }

  /// The type of frame the navigation occurred in.
  FrameType get frameType => FrameType.fromJS(_wrapped.frameType);
  set frameType(FrameType v) {
    _wrapped.frameType = v.toJS;
  }
}

class GetFrameCallbackDetails {
  GetFrameCallbackDetails.fromJS(this._wrapped);

  GetFrameCallbackDetails({
    /// True if the last navigation in this frame was interrupted by an error,
    /// i.e. the onErrorOccurred event fired.
    required bool errorOccurred,

    /// The URL currently associated with this frame, if the frame identified by
    /// the frameId existed at one point in the given tab. The fact that an URL
    /// is associated with a given frameId does not imply that the corresponding
    /// frame still exists.
    required String url,

    /// The ID of the parent frame, or `-1` if this is the main frame.
    required int parentFrameId,

    /// A UUID of the document loaded.
    required String documentId,

    /// A UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    required DocumentLifecycle documentLifecycle,

    /// The type of frame the navigation occurred in.
    required FrameType frameType,
  }) : _wrapped = $js.GetFrameCallbackDetails(
          errorOccurred: errorOccurred,
          url: url,
          parentFrameId: parentFrameId,
          documentId: documentId,
          parentDocumentId: parentDocumentId,
          documentLifecycle: documentLifecycle.toJS,
          frameType: frameType.toJS,
        );

  final $js.GetFrameCallbackDetails _wrapped;

  $js.GetFrameCallbackDetails get toJS => _wrapped;

  /// True if the last navigation in this frame was interrupted by an error,
  /// i.e. the onErrorOccurred event fired.
  bool get errorOccurred => _wrapped.errorOccurred;
  set errorOccurred(bool v) {
    _wrapped.errorOccurred = v;
  }

  /// The URL currently associated with this frame, if the frame identified by
  /// the frameId existed at one point in the given tab. The fact that an URL is
  /// associated with a given frameId does not imply that the corresponding
  /// frame still exists.
  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// The ID of the parent frame, or `-1` if this is the main frame.
  int get parentFrameId => _wrapped.parentFrameId;
  set parentFrameId(int v) {
    _wrapped.parentFrameId = v;
  }

  /// A UUID of the document loaded.
  String get documentId => _wrapped.documentId;
  set documentId(String v) {
    _wrapped.documentId = v;
  }

  /// A UUID of the parent document owning this frame. This is not set if there
  /// is no parent.
  String? get parentDocumentId => _wrapped.parentDocumentId;
  set parentDocumentId(String? v) {
    _wrapped.parentDocumentId = v;
  }

  /// The lifecycle the document is in.
  DocumentLifecycle get documentLifecycle =>
      DocumentLifecycle.fromJS(_wrapped.documentLifecycle);
  set documentLifecycle(DocumentLifecycle v) {
    _wrapped.documentLifecycle = v.toJS;
  }

  /// The type of frame the navigation occurred in.
  FrameType get frameType => FrameType.fromJS(_wrapped.frameType);
  set frameType(FrameType v) {
    _wrapped.frameType = v.toJS;
  }
}

class GetFrameDetails {
  GetFrameDetails.fromJS(this._wrapped);

  GetFrameDetails({
    /// The ID of the tab in which the frame is.
    int? tabId,

    /// The ID of the process that runs the renderer for this tab.
    int? processId,

    /// The ID of the frame in the given tab.
    int? frameId,

    /// The UUID of the document. If the frameId and/or tabId are provided they
    /// will be validated to match the document found by provided document ID.
    String? documentId,
  }) : _wrapped = $js.GetFrameDetails(
          tabId: tabId,
          processId: processId,
          frameId: frameId,
          documentId: documentId,
        );

  final $js.GetFrameDetails _wrapped;

  $js.GetFrameDetails get toJS => _wrapped;

  /// The ID of the tab in which the frame is.
  int? get tabId => _wrapped.tabId;
  set tabId(int? v) {
    _wrapped.tabId = v;
  }

  /// The ID of the process that runs the renderer for this tab.
  int? get processId => _wrapped.processId;
  set processId(int? v) {
    _wrapped.processId = v;
  }

  /// The ID of the frame in the given tab.
  int? get frameId => _wrapped.frameId;
  set frameId(int? v) {
    _wrapped.frameId = v;
  }

  /// The UUID of the document. If the frameId and/or tabId are provided they
  /// will be validated to match the document found by provided document ID.
  String? get documentId => _wrapped.documentId;
  set documentId(String? v) {
    _wrapped.documentId = v;
  }
}

class GetAllFramesCallbackDetails {
  GetAllFramesCallbackDetails.fromJS(this._wrapped);

  GetAllFramesCallbackDetails({
    /// True if the last navigation in this frame was interrupted by an error,
    /// i.e. the onErrorOccurred event fired.
    required bool errorOccurred,

    /// The ID of the process that runs the renderer for this frame.
    required int processId,

    /// The ID of the frame. 0 indicates that this is the main frame; a positive
    /// value indicates the ID of a subframe.
    required int frameId,

    /// The ID of the parent frame, or `-1` if this is the main frame.
    required int parentFrameId,

    /// The URL currently associated with this frame.
    required String url,

    /// A UUID of the document loaded.
    required String documentId,

    /// A UUID of the parent document owning this frame. This is not set if
    /// there is no parent.
    String? parentDocumentId,

    /// The lifecycle the document is in.
    required DocumentLifecycle documentLifecycle,

    /// The type of frame the navigation occurred in.
    required FrameType frameType,
  }) : _wrapped = $js.GetAllFramesCallbackDetails(
          errorOccurred: errorOccurred,
          processId: processId,
          frameId: frameId,
          parentFrameId: parentFrameId,
          url: url,
          documentId: documentId,
          parentDocumentId: parentDocumentId,
          documentLifecycle: documentLifecycle.toJS,
          frameType: frameType.toJS,
        );

  final $js.GetAllFramesCallbackDetails _wrapped;

  $js.GetAllFramesCallbackDetails get toJS => _wrapped;

  /// True if the last navigation in this frame was interrupted by an error,
  /// i.e. the onErrorOccurred event fired.
  bool get errorOccurred => _wrapped.errorOccurred;
  set errorOccurred(bool v) {
    _wrapped.errorOccurred = v;
  }

  /// The ID of the process that runs the renderer for this frame.
  int get processId => _wrapped.processId;
  set processId(int v) {
    _wrapped.processId = v;
  }

  /// The ID of the frame. 0 indicates that this is the main frame; a positive
  /// value indicates the ID of a subframe.
  int get frameId => _wrapped.frameId;
  set frameId(int v) {
    _wrapped.frameId = v;
  }

  /// The ID of the parent frame, or `-1` if this is the main frame.
  int get parentFrameId => _wrapped.parentFrameId;
  set parentFrameId(int v) {
    _wrapped.parentFrameId = v;
  }

  /// The URL currently associated with this frame.
  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// A UUID of the document loaded.
  String get documentId => _wrapped.documentId;
  set documentId(String v) {
    _wrapped.documentId = v;
  }

  /// A UUID of the parent document owning this frame. This is not set if there
  /// is no parent.
  String? get parentDocumentId => _wrapped.parentDocumentId;
  set parentDocumentId(String? v) {
    _wrapped.parentDocumentId = v;
  }

  /// The lifecycle the document is in.
  DocumentLifecycle get documentLifecycle =>
      DocumentLifecycle.fromJS(_wrapped.documentLifecycle);
  set documentLifecycle(DocumentLifecycle v) {
    _wrapped.documentLifecycle = v.toJS;
  }

  /// The type of frame the navigation occurred in.
  FrameType get frameType => FrameType.fromJS(_wrapped.frameType);
  set frameType(FrameType v) {
    _wrapped.frameType = v.toJS;
  }
}

class GetAllFramesDetails {
  GetAllFramesDetails.fromJS(this._wrapped);

  GetAllFramesDetails(
      {
      /// The ID of the tab.
      required int tabId})
      : _wrapped = $js.GetAllFramesDetails(tabId: tabId);

  final $js.GetAllFramesDetails _wrapped;

  $js.GetAllFramesDetails get toJS => _wrapped;

  /// The ID of the tab.
  int get tabId => _wrapped.tabId;
  set tabId(int v) {
    _wrapped.tabId = v;
  }
}
