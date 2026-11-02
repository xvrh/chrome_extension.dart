// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import
// ignore_for_file: unintended_html_in_doc_comment

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

extension type JSTtsEngine._(JSObject _) {
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

  /// Called by an engine when a language install is attempted, and when a
  /// language is uninstalled. Also called in response to a status request from
  /// a client. When a voice is installed or uninstalled, the engine should also
  /// call ttsEngine.updateVoices to register the voice.
  external void updateLanguage(

      /// The install status of the language.
      LanguageStatus status);

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

  /// Fired when a TTS client requests to install a new language. The engine
  /// should attempt to download and install the language, and call
  /// ttsEngine.updateLanguage with the result. On success, the engine should
  /// also call ttsEngine.updateVoices to register the newly available voices.
  external Event get onInstallLanguageRequest;

  /// Fired when a TTS client indicates a language is no longer needed.
  external Event get onUninstallLanguageRequest;

  /// Fired when a TTS client requests the install status of a language.
  external Event get onLanguageStatusRequest;
}

/// Type of requestor.
typedef TtsClientSource = JSString;

typedef VoiceGender = JSString;

/// The install status of a voice.
typedef LanguageInstallStatus = JSString;
extension type TtsClient._(JSObject _) implements JSObject {
  external factory TtsClient({
    /// Client making a language management request. For an extension, this is the
    /// unique extension ID. For Chrome features, this is the human-readable name
    /// of the feature.
    String id,

    /// Type of requestor.
    TtsClientSource source,
  });

  /// Client making a language management request. For an extension, this is the
  /// unique extension ID. For Chrome features, this is the human-readable name
  /// of the feature.
  external String id;

  /// Type of requestor.
  external TtsClientSource source;
}
extension type LanguageUninstallOptions._(JSObject _) implements JSObject {
  external factory LanguageUninstallOptions(
      {
      /// True if the TTS client wants the language to be immediately uninstalled.
      /// The engine may choose whether or when to uninstall the language, based on
      /// this parameter and the requestor information. If false, it may use other
      /// criteria, such as recent usage, to determine when to uninstall.
      bool uninstallImmediately});

  /// True if the TTS client wants the language to be immediately uninstalled.
  /// The engine may choose whether or when to uninstall the language, based on
  /// this parameter and the requestor information. If false, it may use other
  /// criteria, such as recent usage, to determine when to uninstall.
  external bool uninstallImmediately;
}
extension type LanguageStatus._(JSObject _) implements JSObject {
  external factory LanguageStatus({
    /// Language string in the form of language code-region code, where the region
    /// may be omitted. Examples are en, en-AU, zh-CH.
    String lang,

    /// Installation status.
    LanguageInstallStatus installStatus,

    /// Detail about installation failures. Optionally populated if the language
    /// failed to install.
    String? error,
  });

  /// Language string in the form of language code-region code, where the region
  /// may be omitted. Examples are en, en-AU, zh-CH.
  external String lang;

  /// Installation status.
  external LanguageInstallStatus installStatus;

  /// Detail about installation failures. Optionally populated if the language
  /// failed to install.
  external String? error;
}
extension type SpeakOptions._(JSObject _) implements JSObject {
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
extension type AudioStreamOptions._(JSObject _) implements JSObject {
  external factory AudioStreamOptions({
    /// The sample rate expected in an audio buffer.
    int sampleRate,

    /// The number of samples within an audio buffer.
    int bufferSize,
  });

  /// The sample rate expected in an audio buffer.
  external int sampleRate;

  /// The number of samples within an audio buffer.
  external int bufferSize;
}
extension type AudioBuffer._(JSObject _) implements JSObject {
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
