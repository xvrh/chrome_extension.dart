// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSTtsExtension on JSChrome {
  @JS('tts')
  external JSTts? get ttsNullable;

  /// Use the `chrome.tts` API to play synthesized text-to-speech (TTS). See
  /// also the related
  /// [ttsEngine](http://developer.chrome.com/extensions/ttsEngine) API, which
  /// allows an extension to implement a speech engine.
  JSTts get tts {
    var ttsNullable = this.ttsNullable;
    if (ttsNullable == null) {
      throw ApiNotAvailableException('chrome.tts');
    }
    return ttsNullable;
  }
}

@JS()
@staticInterop
class JSTts {}

extension JSTtsExtension on JSTts {
  /// Speaks text using a text-to-speech engine.
  external JSPromise speak(
    /// The text to speak, either plain text or a complete, well-formed SSML
    /// document. Speech engines that do not support SSML will strip away the
    /// tags and speak the text. The maximum length of the text is 32,768
    /// characters.
    String utterance,

    /// The speech options.
    TtsOptions? options,
  );

  /// Stops any current speech and flushes the queue of any pending utterances.
  /// In addition, if speech was paused, it will now be un-paused for the next
  /// call to speak.
  external void stop();

  /// Pauses speech synthesis, potentially in the middle of an utterance. A call
  /// to resume or stop will un-pause speech.
  external void pause();

  /// If speech was paused, resumes speaking where it left off.
  external void resume();

  /// Checks whether the engine is currently speaking. On Mac OS X, the result
  /// is true whenever the system speech engine is speaking, even if the speech
  /// wasn't initiated by Chrome.
  external JSPromise isSpeaking();

  /// Gets an array of all available voices.
  external JSPromise getVoices();

  /// Used to pass events back to the function calling speak().
  external Event get onEvent;
}

typedef EventType = String;

typedef VoiceGender = String;

@JS()
@staticInterop
@anonymous
class TtsOptions {
  external factory TtsOptions({
    /// If true, enqueues this utterance if TTS is already in progress. If false
    /// (the default), interrupts any current speech and flushes the speech queue
    /// before speaking this new utterance.
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
    /// default rate, normally around 180 to 220 words per minute. 2.0 is twice as
    /// fast, and 0.5 is half as fast. Values below 0.1 or above 10.0 are strictly
    /// disallowed, but many voices will constrain the minimum and maximum rates
    /// further-for example a particular voice may not actually speak faster than
    /// 3 times normal even if you specify a value larger than 3.0.
    double? rate,

    /// Speaking pitch between 0 and 2 inclusive, with 0 being lowest and 2 being
    /// highest. 1.0 corresponds to a voice's default pitch.
    double? pitch,

    /// Speaking volume between 0 and 1 inclusive, with 0 being lowest and 1 being
    /// highest, with a default of 1.0.
    double? volume,

    /// The TTS event types the voice must support.
    JSArray? requiredEventTypes,

    /// The TTS event types that you are interested in listening to. If missing,
    /// all event types may be sent.
    JSArray? desiredEventTypes,

    /// This function is called with events that occur in the process of speaking
    /// the utterance.
    Function? onEvent,
  });
}

extension TtsOptionsExtension on TtsOptions {
  /// If true, enqueues this utterance if TTS is already in progress. If false
  /// (the default), interrupts any current speech and flushes the speech queue
  /// before speaking this new utterance.
  external bool? enqueue;

  /// The name of the voice to use for synthesis. If empty, uses any available
  /// voice.
  external String? voiceName;

  /// The extension ID of the speech engine to use, if known.
  external String? extensionId;

  /// The language to be used for synthesis, in the form _language_-_region_.
  /// Examples: 'en', 'en-US', 'en-GB', 'zh-CN'.
  external String? lang;

  /// Gender of voice for synthesized speech.
  external VoiceGender? gender;

  /// Speaking rate relative to the default rate for this voice. 1.0 is the
  /// default rate, normally around 180 to 220 words per minute. 2.0 is twice as
  /// fast, and 0.5 is half as fast. Values below 0.1 or above 10.0 are strictly
  /// disallowed, but many voices will constrain the minimum and maximum rates
  /// further-for example a particular voice may not actually speak faster than
  /// 3 times normal even if you specify a value larger than 3.0.
  external double? rate;

  /// Speaking pitch between 0 and 2 inclusive, with 0 being lowest and 2 being
  /// highest. 1.0 corresponds to a voice's default pitch.
  external double? pitch;

  /// Speaking volume between 0 and 1 inclusive, with 0 being lowest and 1 being
  /// highest, with a default of 1.0.
  external double? volume;

  /// The TTS event types the voice must support.
  external JSArray? requiredEventTypes;

  /// The TTS event types that you are interested in listening to. If missing,
  /// all event types may be sent.
  external JSArray? desiredEventTypes;

  /// This function is called with events that occur in the process of speaking
  /// the utterance.
  external Function? onEvent;
}

@JS()
@staticInterop
@anonymous
class TtsEvent {
  external factory TtsEvent({
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
    EventType type,

    /// The index of the current character in the utterance. For word events, the
    /// event fires at the end of one word and before the beginning of the next.
    /// The `charIndex` represents a point in the text at the beginning of the
    /// next word to be spoken.
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
  });
}

extension TtsEventExtension on TtsEvent {
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
  external EventType type;

  /// The index of the current character in the utterance. For word events, the
  /// event fires at the end of one word and before the beginning of the next.
  /// The `charIndex` represents a point in the text at the beginning of the
  /// next word to be spoken.
  external int? charIndex;

  /// The error description, if the event type is `error`.
  external String? errorMessage;

  /// An ID unique to the calling function's context so that events can get
  /// routed back to the correct tts.speak call.
  external double? srcId;

  /// True if this is the final event that will be sent to this handler.
  external bool? isFinalEvent;

  /// The length of the next part of the utterance. For example, in a `word`
  /// event, this is the length of the word which will be spoken next. It will
  /// be set to -1 if not set by the speech engine.
  external int? length;
}

@JS()
@staticInterop
@anonymous
class TtsVoice {
  external factory TtsVoice({
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
    JSArray? eventTypes,
  });
}

extension TtsVoiceExtension on TtsVoice {
  /// The name of the voice.
  external String? voiceName;

  /// The language that this voice supports, in the form _language_-_region_.
  /// Examples: 'en', 'en-US', 'en-GB', 'zh-CN'.
  external String? lang;

  /// This voice's gender.
  external VoiceGender? gender;

  /// If true, the synthesis engine is a remote network resource. It may be
  /// higher latency and may incur bandwidth costs.
  external bool? remote;

  /// The ID of the extension providing this voice.
  external String? extensionId;

  /// All of the callback event types that this voice is capable of sending.
  external JSArray? eventTypes;
}
