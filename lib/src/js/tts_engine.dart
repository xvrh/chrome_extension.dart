// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'tts.dart';

export 'chrome.dart';

extension JSChromeJSTtsEngineExtension on JSChrome {
  @JS('ttsEngine')
  external JSTtsEngine? get ttsEngineNullable;

  /// Use the `chrome.ttsEngine` API to implement a text-to-speech(TTS) engine
  /// using an extension. If your extension registers using this API, it will
  /// receive events containing an utterance to be spoken and other parameters
  /// when any extension or Chrome App uses the [tts](tts) API to generate
  /// speech. Your extension can then use any available web technology to
  /// synthesize and output the speech, and send events back to the calling
  /// function to report the status.
  JSTtsEngine get ttsEngine {
    var ttsEngineNullable = this.ttsEngineNullable;
    if (ttsEngineNullable == null) {
      throw ApiNotAvailableException('chrome.ttsEngine');
    }
    return ttsEngineNullable;
  }
}

@JS()
@staticInterop
class JSTtsEngine {}

extension JSTtsEngineExtension on JSTtsEngine {
  /// Called by an engine to update its list of voices. This list overrides any
  /// voices declared in this extension's manifest.
  external void updateVoices(

      /// Array of [tts.TtsVoice] objects representing the available voices for
      /// speech synthesis.
      JSArray voices);

  /// Routes a TTS event from a speech engine to a client.
  external void sendTtsEvent(
    int requestId,

    /// The update event from the text-to-speech engine indicating the status of
    /// this utterance.
    TtsEvent event,
  );

  /// Routes TTS audio from a speech engine to a client.
  external void sendTtsAudio(
    int requestId,

    /// An audio buffer from the text-to-speech engine.
    AudioBuffer audio,
  );

  /// Called when the user makes a call to tts.speak() and one of the voices
  /// from this extension's manifest is the first to match the options object.
  external Event get onSpeak;

  /// Called when the user makes a call to tts.speak() and one of the voices
  /// from this extension's manifest is the first to match the options object.
  /// Differs from ttsEngine.onSpeak in that Chrome provides audio playback
  /// services and handles dispatching tts events.
  external Event get onSpeakWithAudioStream;

  /// Fired when a call is made to tts.stop and this extension may be in the
  /// middle of speaking. If an extension receives a call to onStop and speech
  /// is already stopped, it should do nothing (not raise an error). If speech
  /// is in the paused state, this should cancel the paused state.
  external Event get onStop;

  /// Optional: if an engine supports the pause event, it should pause the
  /// current utterance being spoken, if any, until it receives a resume event
  /// or stop event. Note that a stop event should also clear the paused state.
  external Event get onPause;

  /// Optional: if an engine supports the pause event, it should also support
  /// the resume event, to continue speaking the current utterance, if any. Note
  /// that a stop event should also clear the paused state.
  external Event get onResume;
}

typedef VoiceGender = String;

@JS()
@staticInterop
@anonymous
class SpeakOptions {
  external factory SpeakOptions({
    /// The name of the voice to use for synthesis.
    String? voiceName,

    /// The language to be used for synthesis, in the form _language_-_region_.
    /// Examples: 'en', 'en-US', 'en-GB', 'zh-CN'.
    String? lang,

    /// Gender of voice for synthesized speech.
    VoiceGender? gender,

    /// Speaking rate relative to the default rate for this voice. 1.0 is the
    /// default rate, normally around 180 to 220 words per minute. 2.0 is twice as
    /// fast, and 0.5 is half as fast. This value is guaranteed to be between 0.1
    /// and 10.0, inclusive. When a voice does not support this full range of
    /// rates, don't return an error. Instead, clip the rate to the range the
    /// voice supports.
    double? rate,

    /// Speaking pitch between 0 and 2 inclusive, with 0 being lowest and 2 being
    /// highest. 1.0 corresponds to this voice's default pitch.
    double? pitch,

    /// Speaking volume between 0 and 1 inclusive, with 0 being lowest and 1 being
    /// highest, with a default of 1.0.
    double? volume,
  });
}

extension SpeakOptionsExtension on SpeakOptions {
  /// The name of the voice to use for synthesis.
  external String? voiceName;

  /// The language to be used for synthesis, in the form _language_-_region_.
  /// Examples: 'en', 'en-US', 'en-GB', 'zh-CN'.
  external String? lang;

  /// Gender of voice for synthesized speech.
  external VoiceGender? gender;

  /// Speaking rate relative to the default rate for this voice. 1.0 is the
  /// default rate, normally around 180 to 220 words per minute. 2.0 is twice as
  /// fast, and 0.5 is half as fast. This value is guaranteed to be between 0.1
  /// and 10.0, inclusive. When a voice does not support this full range of
  /// rates, don't return an error. Instead, clip the rate to the range the
  /// voice supports.
  external double? rate;

  /// Speaking pitch between 0 and 2 inclusive, with 0 being lowest and 2 being
  /// highest. 1.0 corresponds to this voice's default pitch.
  external double? pitch;

  /// Speaking volume between 0 and 1 inclusive, with 0 being lowest and 1 being
  /// highest, with a default of 1.0.
  external double? volume;
}

@JS()
@staticInterop
@anonymous
class AudioStreamOptions {
  external factory AudioStreamOptions({
    /// The sample rate expected in an audio buffer.
    int sampleRate,

    /// The number of samples within an audio buffer.
    int bufferSize,
  });
}

extension AudioStreamOptionsExtension on AudioStreamOptions {
  /// The sample rate expected in an audio buffer.
  external int sampleRate;

  /// The number of samples within an audio buffer.
  external int bufferSize;
}

@JS()
@staticInterop
@anonymous
class AudioBuffer {
  external factory AudioBuffer({
    /// The audio buffer from the text-to-speech engine. It should have length
    /// exactly audioStreamOptions.bufferSize and encoded as mono, at
    /// audioStreamOptions.sampleRate, and as linear pcm, 32-bit signed float i.e.
    /// the Float32Array type in javascript.
    JSArrayBuffer audioBuffer,

    /// The character index associated with this audio buffer.
    int? charIndex,

    /// True if this audio buffer is the last for the text being spoken.
    bool? isLastBuffer,
  });
}

extension AudioBufferExtension on AudioBuffer {
  /// The audio buffer from the text-to-speech engine. It should have length
  /// exactly audioStreamOptions.bufferSize and encoded as mono, at
  /// audioStreamOptions.sampleRate, and as linear pcm, 32-bit signed float i.e.
  /// the Float32Array type in javascript.
  external JSArrayBuffer audioBuffer;

  /// The character index associated with this audio buffer.
  external int? charIndex;

  /// True if this audio buffer is the last for the text being spoken.
  external bool? isLastBuffer;
}
