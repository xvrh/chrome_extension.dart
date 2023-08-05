// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/tts.dart' as $js;

export 'src/chrome.dart' show chrome;

final _tts = ChromeTts._();

extension ChromeTtsExtension on Chrome {
  /// Use the `chrome.tts` API to play synthesized text-to-speech (TTS). See
  /// also the related
  /// [ttsEngine](http://developer.chrome.com/extensions/ttsEngine) API, which
  /// allows an extension to implement a speech engine.
  ChromeTts get tts => _tts;
}

class ChromeTts {
  ChromeTts._();

  bool get isAvailable => $js.chrome.ttsNullable != null && alwaysTrue;

  /// Speaks text using a text-to-speech engine.
  /// [utterance] The text to speak, either plain text or a complete,
  /// well-formed SSML document. Speech engines that do not support SSML will
  /// strip away the tags and speak the text. The maximum length of the text
  /// is 32,768 characters.
  /// [options] The speech options.
  /// [returns] Called right away, before speech finishes. Check
  /// [runtime.lastError] to make sure there were no errors. Use
  /// options.onEvent to get more detailed feedback.
  Future<void> speak(
    String utterance,
    TtsOptions? options,
  ) async {
    await promiseToFuture<void>($js.chrome.tts.speak(
      utterance,
      options?.toJS,
    ));
  }

  /// Stops any current speech and flushes the queue of any pending utterances.
  /// In addition, if speech was paused, it will now be un-paused for the next
  /// call to speak.
  void stop() {
    $js.chrome.tts.stop();
  }

  /// Pauses speech synthesis, potentially in the middle of an utterance. A call
  /// to resume or stop will un-pause speech.
  void pause() {
    $js.chrome.tts.pause();
  }

  /// If speech was paused, resumes speaking where it left off.
  void resume() {
    $js.chrome.tts.resume();
  }

  /// Checks whether the engine is currently speaking. On Mac OS X, the result
  /// is true whenever the system speech engine is speaking, even if the speech
  /// wasn't initiated by Chrome.
  Future<bool> isSpeaking() async {
    var $res = await promiseToFuture<bool>($js.chrome.tts.isSpeaking());
    return $res;
  }

  /// Gets an array of all available voices.
  Future<List<TtsVoice>> getVoices() async {
    var $res = await promiseToFuture<JSArray>($js.chrome.tts.getVoices());
    return $res.toDart
        .cast<$js.TtsVoice>()
        .map((e) => TtsVoice.fromJS(e))
        .toList();
  }

  /// Used to pass events back to the function calling speak().
  EventStream<TtsEvent> get onEvent =>
      $js.chrome.tts.onEvent.asStream(($c) => ($js.TtsEvent event) {
            return $c(TtsEvent.fromJS(event));
          });
}

enum EventType {
  start('start'),
  end('end'),
  word('word'),
  sentence('sentence'),
  marker('marker'),
  interrupted('interrupted'),
  cancelled('cancelled'),
  error('error'),
  pause('pause'),
  resume('resume');

  const EventType(this.value);

  final String value;

  String get toJS => value;
  static EventType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum VoiceGender {
  male('male'),
  female('female');

  const VoiceGender(this.value);

  final String value;

  String get toJS => value;
  static VoiceGender fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class TtsOptions {
  TtsOptions.fromJS(this._wrapped);

  TtsOptions({
    /// If true, enqueues this utterance if TTS is already in progress. If false
    /// (the default), interrupts any current speech and flushes the speech
    /// queue before speaking this new utterance.
    bool? enqueue,

    /// The name of the voice to use for synthesis. If empty, uses any available
    /// voice.
    String? voiceName,

    /// The extension ID of the speech engine to use, if known.
    String? extensionId,

    /// The language to be used for synthesis, in the form _language_-_region_.
    /// Examples: 'en', 'en-US', 'en-GB', 'zh-CN'.
    String? lang,

    /// Gender of voice for synthesized speech.
    VoiceGender? gender,

    /// Speaking rate relative to the default rate for this voice. 1.0 is the
    /// default rate, normally around 180 to 220 words per minute. 2.0 is twice
    /// as fast, and 0.5 is half as fast. Values below 0.1 or above 10.0 are
    /// strictly disallowed, but many voices will constrain the minimum and
    /// maximum rates further-for example a particular voice may not actually
    /// speak faster than 3 times normal even if you specify a value larger than
    /// 3.0.
    double? rate,

    /// Speaking pitch between 0 and 2 inclusive, with 0 being lowest and 2
    /// being highest. 1.0 corresponds to a voice's default pitch.
    double? pitch,

    /// Speaking volume between 0 and 1 inclusive, with 0 being lowest and 1
    /// being highest, with a default of 1.0.
    double? volume,

    /// The TTS event types the voice must support.
    List<String>? requiredEventTypes,

    /// The TTS event types that you are interested in listening to. If missing,
    /// all event types may be sent.
    List<String>? desiredEventTypes,

    /// This function is called with events that occur in the process of
    /// speaking the utterance.
    Function? onEvent,
  }) : _wrapped = $js.TtsOptions(
          enqueue: enqueue,
          voiceName: voiceName,
          extensionId: extensionId,
          lang: lang,
          gender: gender?.toJS,
          rate: rate,
          pitch: pitch,
          volume: volume,
          requiredEventTypes: requiredEventTypes?.toJSArray((e) => e),
          desiredEventTypes: desiredEventTypes?.toJSArray((e) => e),
          onEvent: onEvent?.let(allowInterop),
        );

  final $js.TtsOptions _wrapped;

  $js.TtsOptions get toJS => _wrapped;

  /// If true, enqueues this utterance if TTS is already in progress. If false
  /// (the default), interrupts any current speech and flushes the speech queue
  /// before speaking this new utterance.
  bool? get enqueue => _wrapped.enqueue;
  set enqueue(bool? v) {
    _wrapped.enqueue = v;
  }

  /// The name of the voice to use for synthesis. If empty, uses any available
  /// voice.
  String? get voiceName => _wrapped.voiceName;
  set voiceName(String? v) {
    _wrapped.voiceName = v;
  }

  /// The extension ID of the speech engine to use, if known.
  String? get extensionId => _wrapped.extensionId;
  set extensionId(String? v) {
    _wrapped.extensionId = v;
  }

  /// The language to be used for synthesis, in the form _language_-_region_.
  /// Examples: 'en', 'en-US', 'en-GB', 'zh-CN'.
  String? get lang => _wrapped.lang;
  set lang(String? v) {
    _wrapped.lang = v;
  }

  /// Gender of voice for synthesized speech.
  VoiceGender? get gender => _wrapped.gender?.let(VoiceGender.fromJS);
  set gender(VoiceGender? v) {
    _wrapped.gender = v?.toJS;
  }

  /// Speaking rate relative to the default rate for this voice. 1.0 is the
  /// default rate, normally around 180 to 220 words per minute. 2.0 is twice as
  /// fast, and 0.5 is half as fast. Values below 0.1 or above 10.0 are strictly
  /// disallowed, but many voices will constrain the minimum and maximum rates
  /// further-for example a particular voice may not actually speak faster than
  /// 3 times normal even if you specify a value larger than 3.0.
  double? get rate => _wrapped.rate;
  set rate(double? v) {
    _wrapped.rate = v;
  }

  /// Speaking pitch between 0 and 2 inclusive, with 0 being lowest and 2 being
  /// highest. 1.0 corresponds to a voice's default pitch.
  double? get pitch => _wrapped.pitch;
  set pitch(double? v) {
    _wrapped.pitch = v;
  }

  /// Speaking volume between 0 and 1 inclusive, with 0 being lowest and 1 being
  /// highest, with a default of 1.0.
  double? get volume => _wrapped.volume;
  set volume(double? v) {
    _wrapped.volume = v;
  }

  /// The TTS event types the voice must support.
  List<String>? get requiredEventTypes =>
      _wrapped.requiredEventTypes?.toDart.cast<String>().map((e) => e).toList();
  set requiredEventTypes(List<String>? v) {
    _wrapped.requiredEventTypes = v?.toJSArray((e) => e);
  }

  /// The TTS event types that you are interested in listening to. If missing,
  /// all event types may be sent.
  List<String>? get desiredEventTypes =>
      _wrapped.desiredEventTypes?.toDart.cast<String>().map((e) => e).toList();
  set desiredEventTypes(List<String>? v) {
    _wrapped.desiredEventTypes = v?.toJSArray((e) => e);
  }

  /// This function is called with events that occur in the process of speaking
  /// the utterance.
  Function? get onEvent => ([Object? p1, Object? p2]) {
        return (_wrapped.onEvent as JSAny? Function(JSAny?, JSAny?)?)
            ?.call(p1?.jsify(), p2?.jsify())
            ?.dartify();
      };
  set onEvent(Function? v) {
    _wrapped.onEvent = v?.let(allowInterop);
  }
}

class TtsEvent {
  TtsEvent.fromJS(this._wrapped);

  TtsEvent({
    /// The type can be `start` as soon as speech has started, `word` when a
    /// word boundary is reached, `sentence` when a sentence boundary is
    /// reached, `marker` when an SSML mark element is reached, `end` when the
    /// end of the utterance is reached, `interrupted` when the utterance is
    /// stopped or interrupted before reaching the end, `cancelled` when it's
    /// removed from the queue before ever being synthesized, or `error` when
    /// any other error occurs. When pausing speech, a `pause` event is fired if
    /// a particular utterance is paused in the middle, and `resume` if an
    /// utterance resumes speech. Note that pause and resume events may not fire
    /// if speech is paused in-between utterances.
    required EventType type,

    /// The index of the current character in the utterance. For word events,
    /// the event fires at the end of one word and before the beginning of the
    /// next. The `charIndex` represents a point in the text at the beginning of
    /// the next word to be spoken.
    int? charIndex,

    /// The error description, if the event type is `error`.
    String? errorMessage,

    /// An ID unique to the calling function's context so that events can get
    /// routed back to the correct tts.speak call.
    double? srcId,

    /// True if this is the final event that will be sent to this handler.
    bool? isFinalEvent,

    /// The length of the next part of the utterance. For example, in a `word`
    /// event, this is the length of the word which will be spoken next. It will
    /// be set to -1 if not set by the speech engine.
    int? length,
  }) : _wrapped = $js.TtsEvent(
          type: type.toJS,
          charIndex: charIndex,
          errorMessage: errorMessage,
          srcId: srcId,
          isFinalEvent: isFinalEvent,
          length: length,
        );

  final $js.TtsEvent _wrapped;

  $js.TtsEvent get toJS => _wrapped;

  /// The type can be `start` as soon as speech has started, `word` when a word
  /// boundary is reached, `sentence` when a sentence boundary is reached,
  /// `marker` when an SSML mark element is reached, `end` when the end of the
  /// utterance is reached, `interrupted` when the utterance is stopped or
  /// interrupted before reaching the end, `cancelled` when it's removed from
  /// the queue before ever being synthesized, or `error` when any other error
  /// occurs. When pausing speech, a `pause` event is fired if a particular
  /// utterance is paused in the middle, and `resume` if an utterance resumes
  /// speech. Note that pause and resume events may not fire if speech is paused
  /// in-between utterances.
  EventType get type => EventType.fromJS(_wrapped.type);
  set type(EventType v) {
    _wrapped.type = v.toJS;
  }

  /// The index of the current character in the utterance. For word events, the
  /// event fires at the end of one word and before the beginning of the next.
  /// The `charIndex` represents a point in the text at the beginning of the
  /// next word to be spoken.
  int? get charIndex => _wrapped.charIndex;
  set charIndex(int? v) {
    _wrapped.charIndex = v;
  }

  /// The error description, if the event type is `error`.
  String? get errorMessage => _wrapped.errorMessage;
  set errorMessage(String? v) {
    _wrapped.errorMessage = v;
  }

  /// An ID unique to the calling function's context so that events can get
  /// routed back to the correct tts.speak call.
  double? get srcId => _wrapped.srcId;
  set srcId(double? v) {
    _wrapped.srcId = v;
  }

  /// True if this is the final event that will be sent to this handler.
  bool? get isFinalEvent => _wrapped.isFinalEvent;
  set isFinalEvent(bool? v) {
    _wrapped.isFinalEvent = v;
  }

  /// The length of the next part of the utterance. For example, in a `word`
  /// event, this is the length of the word which will be spoken next. It will
  /// be set to -1 if not set by the speech engine.
  int? get length => _wrapped.length;
  set length(int? v) {
    _wrapped.length = v;
  }
}

class TtsVoice {
  TtsVoice.fromJS(this._wrapped);

  TtsVoice({
    /// The name of the voice.
    String? voiceName,

    /// The language that this voice supports, in the form _language_-_region_.
    /// Examples: 'en', 'en-US', 'en-GB', 'zh-CN'.
    String? lang,

    /// This voice's gender.
    VoiceGender? gender,

    /// If true, the synthesis engine is a remote network resource. It may be
    /// higher latency and may incur bandwidth costs.
    bool? remote,

    /// The ID of the extension providing this voice.
    String? extensionId,

    /// All of the callback event types that this voice is capable of sending.
    List<EventType>? eventTypes,
  }) : _wrapped = $js.TtsVoice(
          voiceName: voiceName,
          lang: lang,
          gender: gender?.toJS,
          remote: remote,
          extensionId: extensionId,
          eventTypes: eventTypes?.toJSArray((e) => e.toJS),
        );

  final $js.TtsVoice _wrapped;

  $js.TtsVoice get toJS => _wrapped;

  /// The name of the voice.
  String? get voiceName => _wrapped.voiceName;
  set voiceName(String? v) {
    _wrapped.voiceName = v;
  }

  /// The language that this voice supports, in the form _language_-_region_.
  /// Examples: 'en', 'en-US', 'en-GB', 'zh-CN'.
  String? get lang => _wrapped.lang;
  set lang(String? v) {
    _wrapped.lang = v;
  }

  /// This voice's gender.
  VoiceGender? get gender => _wrapped.gender?.let(VoiceGender.fromJS);
  set gender(VoiceGender? v) {
    _wrapped.gender = v?.toJS;
  }

  /// If true, the synthesis engine is a remote network resource. It may be
  /// higher latency and may incur bandwidth costs.
  bool? get remote => _wrapped.remote;
  set remote(bool? v) {
    _wrapped.remote = v;
  }

  /// The ID of the extension providing this voice.
  String? get extensionId => _wrapped.extensionId;
  set extensionId(String? v) {
    _wrapped.extensionId = v;
  }

  /// All of the callback event types that this voice is capable of sending.
  List<EventType>? get eventTypes => _wrapped.eventTypes?.toDart
      .cast<$js.EventType>()
      .map((e) => EventType.fromJS(e))
      .toList();
  set eventTypes(List<EventType>? v) {
    _wrapped.eventTypes = v?.toJSArray((e) => e.toJS);
  }
}
