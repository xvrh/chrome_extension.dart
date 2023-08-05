// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:typed_data';
import 'src/internal_helpers.dart';
import 'src/js/tts_engine.dart' as $js;
import 'tts.dart';

export 'src/chrome.dart' show chrome;

final _ttsEngine = ChromeTtsEngine._();

extension ChromeTtsEngineExtension on Chrome {
  /// Use the `chrome.ttsEngine` API to implement a text-to-speech(TTS) engine
  /// using an extension. If your extension registers using this API, it will
  /// receive events containing an utterance to be spoken and other parameters
  /// when any extension or Chrome App uses the [tts](tts) API to generate
  /// speech. Your extension can then use any available web technology to
  /// synthesize and output the speech, and send events back to the calling
  /// function to report the status.
  ChromeTtsEngine get ttsEngine => _ttsEngine;
}

class ChromeTtsEngine {
  ChromeTtsEngine._();

  bool get isAvailable => $js.chrome.ttsEngineNullable != null && alwaysTrue;

  /// Called by an engine to update its list of voices. This list overrides any
  /// voices declared in this extension's manifest.
  /// [voices] Array of [tts.TtsVoice] objects representing the available
  /// voices for speech synthesis.
  void updateVoices(List<TtsVoice> voices) {
    $js.chrome.ttsEngine.updateVoices(voices.toJSArray((e) => e.toJS));
  }

  /// Routes a TTS event from a speech engine to a client.
  /// [event] The update event from the text-to-speech engine indicating the
  /// status of this utterance.
  void sendTtsEvent(
    int requestId,
    TtsEvent event,
  ) {
    $js.chrome.ttsEngine.sendTtsEvent(
      requestId,
      event.toJS,
    );
  }

  /// Routes TTS audio from a speech engine to a client.
  /// [audio] An audio buffer from the text-to-speech engine.
  void sendTtsAudio(
    int requestId,
    AudioBuffer audio,
  ) {
    $js.chrome.ttsEngine.sendTtsAudio(
      requestId,
      audio.toJS,
    );
  }

  /// Called when the user makes a call to tts.speak() and one of the voices
  /// from this extension's manifest is the first to match the options object.
  EventStream<OnSpeakEvent> get onSpeak =>
      $js.chrome.ttsEngine.onSpeak.asStream(($c) => (
            String utterance,
            $js.SpeakOptions options,
            Function sendTtsEvent,
          ) {
            return $c(OnSpeakEvent(
              utterance: utterance,
              options: SpeakOptions.fromJS(options),
              sendTtsEvent: ([Object? p1, Object? p2]) {
                return (sendTtsEvent as JSAny? Function(JSAny?, JSAny?))(
                        p1?.jsify(), p2?.jsify())
                    ?.dartify();
              },
            ));
          });

  /// Called when the user makes a call to tts.speak() and one of the voices
  /// from this extension's manifest is the first to match the options object.
  /// Differs from ttsEngine.onSpeak in that Chrome provides audio playback
  /// services and handles dispatching tts events.
  EventStream<OnSpeakWithAudioStreamEvent> get onSpeakWithAudioStream =>
      $js.chrome.ttsEngine.onSpeakWithAudioStream.asStream(($c) => (
            String utterance,
            $js.SpeakOptions options,
            $js.AudioStreamOptions audioStreamOptions,
            Function sendTtsAudio,
            Function sendError,
          ) {
            return $c(OnSpeakWithAudioStreamEvent(
              utterance: utterance,
              options: SpeakOptions.fromJS(options),
              audioStreamOptions: AudioStreamOptions.fromJS(audioStreamOptions),
              sendTtsAudio: ([Object? p1, Object? p2]) {
                return (sendTtsAudio as JSAny? Function(JSAny?, JSAny?))(
                        p1?.jsify(), p2?.jsify())
                    ?.dartify();
              },
              sendError: ([Object? p1, Object? p2]) {
                return (sendError as JSAny? Function(JSAny?, JSAny?))(
                        p1?.jsify(), p2?.jsify())
                    ?.dartify();
              },
            ));
          });

  /// Fired when a call is made to tts.stop and this extension may be in the
  /// middle of speaking. If an extension receives a call to onStop and speech
  /// is already stopped, it should do nothing (not raise an error). If speech
  /// is in the paused state, this should cancel the paused state.
  EventStream<void> get onStop =>
      $js.chrome.ttsEngine.onStop.asStream(($c) => () {
            return $c(null);
          });

  /// Optional: if an engine supports the pause event, it should pause the
  /// current utterance being spoken, if any, until it receives a resume event
  /// or stop event. Note that a stop event should also clear the paused state.
  EventStream<void> get onPause =>
      $js.chrome.ttsEngine.onPause.asStream(($c) => () {
            return $c(null);
          });

  /// Optional: if an engine supports the pause event, it should also support
  /// the resume event, to continue speaking the current utterance, if any. Note
  /// that a stop event should also clear the paused state.
  EventStream<void> get onResume =>
      $js.chrome.ttsEngine.onResume.asStream(($c) => () {
            return $c(null);
          });
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

class SpeakOptions {
  SpeakOptions.fromJS(this._wrapped);

  SpeakOptions({
    /// The name of the voice to use for synthesis.
    String? voiceName,

    /// The language to be used for synthesis, in the form _language_-_region_.
    /// Examples: 'en', 'en-US', 'en-GB', 'zh-CN'.
    String? lang,

    /// Gender of voice for synthesized speech.
    VoiceGender? gender,

    /// Speaking rate relative to the default rate for this voice. 1.0 is the
    /// default rate, normally around 180 to 220 words per minute. 2.0 is twice
    /// as fast, and 0.5 is half as fast. This value is guaranteed to be between
    /// 0.1 and 10.0, inclusive. When a voice does not support this full range
    /// of rates, don't return an error. Instead, clip the rate to the range the
    /// voice supports.
    double? rate,

    /// Speaking pitch between 0 and 2 inclusive, with 0 being lowest and 2
    /// being highest. 1.0 corresponds to this voice's default pitch.
    double? pitch,

    /// Speaking volume between 0 and 1 inclusive, with 0 being lowest and 1
    /// being highest, with a default of 1.0.
    double? volume,
  }) : _wrapped = $js.SpeakOptions(
          voiceName: voiceName,
          lang: lang,
          gender: gender?.toJS,
          rate: rate,
          pitch: pitch,
          volume: volume,
        );

  final $js.SpeakOptions _wrapped;

  $js.SpeakOptions get toJS => _wrapped;

  /// The name of the voice to use for synthesis.
  String? get voiceName => _wrapped.voiceName;
  set voiceName(String? v) {
    _wrapped.voiceName = v;
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
  /// fast, and 0.5 is half as fast. This value is guaranteed to be between 0.1
  /// and 10.0, inclusive. When a voice does not support this full range of
  /// rates, don't return an error. Instead, clip the rate to the range the
  /// voice supports.
  double? get rate => _wrapped.rate;
  set rate(double? v) {
    _wrapped.rate = v;
  }

  /// Speaking pitch between 0 and 2 inclusive, with 0 being lowest and 2 being
  /// highest. 1.0 corresponds to this voice's default pitch.
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
}

class AudioStreamOptions {
  AudioStreamOptions.fromJS(this._wrapped);

  AudioStreamOptions({
    /// The sample rate expected in an audio buffer.
    required int sampleRate,

    /// The number of samples within an audio buffer.
    required int bufferSize,
  }) : _wrapped = $js.AudioStreamOptions(
          sampleRate: sampleRate,
          bufferSize: bufferSize,
        );

  final $js.AudioStreamOptions _wrapped;

  $js.AudioStreamOptions get toJS => _wrapped;

  /// The sample rate expected in an audio buffer.
  int get sampleRate => _wrapped.sampleRate;
  set sampleRate(int v) {
    _wrapped.sampleRate = v;
  }

  /// The number of samples within an audio buffer.
  int get bufferSize => _wrapped.bufferSize;
  set bufferSize(int v) {
    _wrapped.bufferSize = v;
  }
}

class AudioBuffer {
  AudioBuffer.fromJS(this._wrapped);

  AudioBuffer({
    /// The audio buffer from the text-to-speech engine. It should have length
    /// exactly audioStreamOptions.bufferSize and encoded as mono, at
    /// audioStreamOptions.sampleRate, and as linear pcm, 32-bit signed float
    /// i.e. the Float32Array type in javascript.
    required ByteBuffer audioBuffer,

    /// The character index associated with this audio buffer.
    int? charIndex,

    /// True if this audio buffer is the last for the text being spoken.
    bool? isLastBuffer,
  }) : _wrapped = $js.AudioBuffer(
          audioBuffer: audioBuffer.toJS,
          charIndex: charIndex,
          isLastBuffer: isLastBuffer,
        );

  final $js.AudioBuffer _wrapped;

  $js.AudioBuffer get toJS => _wrapped;

  /// The audio buffer from the text-to-speech engine. It should have length
  /// exactly audioStreamOptions.bufferSize and encoded as mono, at
  /// audioStreamOptions.sampleRate, and as linear pcm, 32-bit signed float i.e.
  /// the Float32Array type in javascript.
  ByteBuffer get audioBuffer => _wrapped.audioBuffer.toDart;
  set audioBuffer(ByteBuffer v) {
    _wrapped.audioBuffer = v.toJS;
  }

  /// The character index associated with this audio buffer.
  int? get charIndex => _wrapped.charIndex;
  set charIndex(int? v) {
    _wrapped.charIndex = v;
  }

  /// True if this audio buffer is the last for the text being spoken.
  bool? get isLastBuffer => _wrapped.isLastBuffer;
  set isLastBuffer(bool? v) {
    _wrapped.isLastBuffer = v;
  }
}

class OnSpeakEvent {
  OnSpeakEvent({
    required this.utterance,
    required this.options,
    required this.sendTtsEvent,
  });

  /// The text to speak, specified as either plain text or an SSML document. If
  /// your engine does not support SSML, you should strip out all XML markup and
  /// synthesize only the underlying text content. The value of this parameter
  /// is guaranteed to be no more than 32,768 characters. If this engine does
  /// not support speaking that many characters at a time, the utterance should
  /// be split into smaller chunks and queued internally without returning an
  /// error.
  final String utterance;

  /// Options specified to the tts.speak() method.
  final SpeakOptions options;

  /// Call this function with events that occur in the process of speaking the
  /// utterance.
  final Function sendTtsEvent;
}

class OnSpeakWithAudioStreamEvent {
  OnSpeakWithAudioStreamEvent({
    required this.utterance,
    required this.options,
    required this.audioStreamOptions,
    required this.sendTtsAudio,
    required this.sendError,
  });

  /// The text to speak, specified as either plain text or an SSML document. If
  /// your engine does not support SSML, you should strip out all XML markup and
  /// synthesize only the underlying text content. The value of this parameter
  /// is guaranteed to be no more than 32,768 characters. If this engine does
  /// not support speaking that many characters at a time, the utterance should
  /// be split into smaller chunks and queued internally without returning an
  /// error.
  final String utterance;

  /// Options specified to the tts.speak() method.
  final SpeakOptions options;

  /// Contains the audio stream format expected to be produced by this engine.
  final AudioStreamOptions audioStreamOptions;

  /// Call this function with audio that occur in the process of speaking the
  /// utterance.
  final Function sendTtsAudio;

  /// Call this function to indicate an error with rendering this utterance.
  final Function sendError;
}
