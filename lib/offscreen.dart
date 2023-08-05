// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/offscreen.dart' as $js;

export 'src/chrome.dart' show chrome;

final _offscreen = ChromeOffscreen._();

extension ChromeOffscreenExtension on Chrome {
  /// Use the `offscreen` API to create and manage offscreen documents.
  ChromeOffscreen get offscreen => _offscreen;
}

class ChromeOffscreen {
  ChromeOffscreen._();

  bool get isAvailable => $js.chrome.offscreenNullable != null && alwaysTrue;

  /// Creates a new offscreen document for the extension.
  /// |parameters|: The parameters describing the offscreen document to create.
  /// |callback|: Invoked when the offscreen document is created and has
  /// completed its initial page load.
  Future<void> createDocument(CreateParameters parameters) async {
    await promiseToFuture<void>(
        $js.chrome.offscreen.createDocument(parameters.toJS));
  }

  /// Closes the currently-open offscreen document for the extension.
  /// |callback|: Invoked when the offscreen document has been closed.
  Future<void> closeDocument() async {
    await promiseToFuture<void>($js.chrome.offscreen.closeDocument());
  }

  /// Determines whether the extension has an active document.
  /// TODO(https://crbug.com/1339382): This probably isn't something we want to
  /// ship in its current form (hence the nodoc). Instead of this, we should
  /// integrate offscreen documents into a service worker-compatible getViews()
  /// alternative. But this is pretty useful in testing environments.
  /// |callback|: Invoked with the result of whether the extension has an
  /// active offscreen document.
  Future<bool> hasDocument() async {
    var $res = await promiseToFuture<bool>($js.chrome.offscreen.hasDocument());
    return $res;
  }
}

enum Reason {
  /// A reason used for testing purposes only.
  testing('TESTING'),

  /// The offscreen document is responsible for playing audio.
  audioPlayback('AUDIO_PLAYBACK'),

  /// The offscreen document needs to embed and script an iframe in order to
  /// modify the iframe's content.
  iframeScripting('IFRAME_SCRIPTING'),

  /// The offscreen document needs to embed an iframe and scrape its DOM to
  /// extract information.
  domScraping('DOM_SCRAPING'),

  /// The offscreen document needs to interact with Blob objects (including
  /// `URL.createObjectURL()`).
  blobs('BLOBS'),

  /// The offscreen document needs to use the `DOMParser` API.
  domParser('DOM_PARSER'),

  /// The offscreen document needs to interact with media streams from user
  /// media (e.g. `getUserMedia()`).
  userMedia('USER_MEDIA'),

  /// The offscreen document needs to interact with media streams from display
  /// media (e.g. `getDisplayMedia()</code).
  displayMedia('DISPLAY_MEDIA'),

  /// The offscreen document needs to use WebRTC APIs.
  webRtc('WEB_RTC'),

  /// The offscreen document needs to interact with the clipboard APIs
  /// (e.g. `Navigator.clipboard`).
  clipboard('CLIPBOARD'),

  /// The offscreen document needs access to
  /// [localStorage](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage).
  localStorage('LOCAL_STORAGE'),

  /// The offscreen document needs to spawn workers.
  workers('WORKERS');

  const Reason(this.value);

  final String value;

  String get toJS => value;
  static Reason fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class CreateParameters {
  CreateParameters.fromJS(this._wrapped);

  CreateParameters({
    /// The reason(s) the extension is creating the offscreen document.
    required List<Reason> reasons,

    /// The (relative) URL to load in the document.
    required String url,

    /// A developer-provided string that explains, in more detail, the need for
    /// the background context. The user agent _may_ use this in display to the
    /// user.
    required String justification,
  }) : _wrapped = $js.CreateParameters(
          reasons: reasons.toJSArray((e) => e.toJS),
          url: url,
          justification: justification,
        );

  final $js.CreateParameters _wrapped;

  $js.CreateParameters get toJS => _wrapped;

  /// The reason(s) the extension is creating the offscreen document.
  List<Reason> get reasons => _wrapped.reasons.toDart
      .cast<$js.Reason>()
      .map((e) => Reason.fromJS(e))
      .toList();
  set reasons(List<Reason> v) {
    _wrapped.reasons = v.toJSArray((e) => e.toJS);
  }

  /// The (relative) URL to load in the document.
  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// A developer-provided string that explains, in more detail, the need for
  /// the background context. The user agent _may_ use this in display to the
  /// user.
  String get justification => _wrapped.justification;
  set justification(String v) {
    _wrapped.justification = v;
  }
}
