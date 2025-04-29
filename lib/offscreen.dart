// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'src/internal_helpers.dart';
import 'src/js/offscreen.dart' as $js;

export 'src/chrome.dart' show chrome, EventStream;

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
    await $js.chrome.offscreen.createDocument(parameters.toJS).toDart;
  }

  /// Closes the currently-open offscreen document for the extension.
  /// |callback|: Invoked when the offscreen document has been closed.
  Future<void> closeDocument() async {
    await $js.chrome.offscreen.closeDocument().toDart;
  }

  /// Determines whether the extension has an active document.
  /// TODO(https://crbug.com/1339382): This probably isn't something we want to
  /// ship in its current form (hence the nodoc). Instead of this, we should
  /// integrate offscreen documents into a service worker-compatible getViews()
  /// alternative. But this is pretty useful in testing environments.
  /// |callback|: Invoked with the result of whether the extension has an
  /// active offscreen document.
  Future<bool> hasDocument() async {
    var $res = await $js.chrome.offscreen.hasDocument().toDart;
    return ($res).dartify() as bool? ?? false;
  }
}

enum Reason {
  /// A reason used for testing purposes only.
  testing('TESTING'),

  /// Specifies that the offscreen document is responsible for playing audio.
  audioPlayback('AUDIO_PLAYBACK'),

  /// Specifies that the offscreen document needs to embed and script an
  /// iframe in order to modify the iframe's content.
  iframeScripting('IFRAME_SCRIPTING'),

  /// Specifies that the offscreen document needs to embed an iframe and
  /// scrape its DOM to extract information.
  domScraping('DOM_SCRAPING'),

  /// Specifies that the offscreen document needs to interact with Blob
  /// objects (including `URL.createObjectURL()`).
  blobs('BLOBS'),

  /// Specifies that the offscreen document needs to use the
  /// <a
  /// href="https://developer.mozilla.org/en-US/docs/Web/API/DOMParser>DOMParser
  /// API</a>.
  domParser('DOM_PARSER'),

  /// Specifies that the offscreen document needs to interact with
  /// media streams from user media (e.g. `getUserMedia()`).
  userMedia('USER_MEDIA'),

  /// Specifies that the offscreen document needs to interact with
  /// media streams from display media (e.g. `getDisplayMedia()`).
  displayMedia('DISPLAY_MEDIA'),

  /// Specifies that the offscreen document needs to use
  /// <a
  /// href="https://developer.mozilla.org/en-US/docs/Web/API/WebRTC_API>WebRTC
  /// APIs</a>.
  webRtc('WEB_RTC'),

  /// Specifies that the offscreen document needs to interact with the
  /// <a
  /// href="https://developer.mozilla.org/en-US/docs/Web/API/Clipboard_API>Clipboard
  /// API</a>.
  clipboard('CLIPBOARD'),

  /// Specifies that the offscreen document needs access to
  /// [localStorage](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage).
  localStorage('LOCAL_STORAGE'),

  /// Specifies that the offscreen document needs to spawn workers.
  workers('WORKERS'),

  /// Specifies that the offscreen document needs to use
  /// <a
  /// href="https://developer.mozilla.org/en-US/docs/Web/API/Battery_Status_API">navigator.getBattery</a>.
  batteryStatus('BATTERY_STATUS'),

  /// Specifies that the offscreen document needs to use
  /// <a
  /// href="https://developer.mozilla.org/en-US/docs/Web/API/Window/matchMedia">window.matchMedia</a>.
  matchMedia('MATCH_MEDIA'),

  /// Specifies that the offscreen document needs to use
  /// <a
  /// href="https://developer.mozilla.org/en-US/docs/Web/API/Navigator/geolocation">navigator.geolocation</a>.
  geolocation('GEOLOCATION');

  const Reason(this.value);

  final String value;

  JSString get toJS => value.toJS;
  static Reason fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
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
  List<Reason> get reasons =>
      _wrapped.reasons.toDart
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
