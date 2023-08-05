// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/desktop_capture.dart' as $js;
import 'tabs.dart';

export 'src/chrome.dart' show chrome;

final _desktopCapture = ChromeDesktopCapture._();

extension ChromeDesktopCaptureExtension on Chrome {
  /// Desktop Capture API that can be used to capture content of screen,
  /// individual windows or tabs.
  ChromeDesktopCapture get desktopCapture => _desktopCapture;
}

class ChromeDesktopCapture {
  ChromeDesktopCapture._();

  bool get isAvailable =>
      $js.chrome.desktopCaptureNullable != null && alwaysTrue;

  /// Shows desktop media picker UI with the specified set of sources.
  /// [sources] Set of sources that should be shown to the user. The sources
  /// order in the set decides the tab order in the picker.
  /// [targetTab] Optional tab for which the stream is created. If not
  /// specified then the resulting stream can be used only by the calling
  /// extension. The stream can only be used by frames in the given tab whose
  /// security origin matches `tab.url`. The tab's origin must be a secure
  /// origin, e.g. HTTPS.
  /// [options] Mirrors members of
  /// [DisplayMediaStreamConstraints](https://w3c.github.io/mediacapture-screen-share/#dom-displaymediastreamconstraints)
  /// which need to be applied before the user makes their selection, and must
  /// therefore be provided to chooseDesktopMedia() rather than be deferred to
  /// getUserMedia().
  /// [returns] An id that can be passed to cancelChooseDesktopMedia() in case
  /// the prompt need to be canceled.
  int chooseDesktopMedia(
    List<DesktopCaptureSourceType> sources,
    Tab? targetTab,
    ChooseDesktopMediaOptions? options,
    Function callback,
  ) {
    return $js.chrome.desktopCapture.chooseDesktopMedia(
      sources.toJSArray((e) => e.toJS),
      targetTab?.toJS,
      options?.toJS,
      allowInterop(callback),
    );
  }

  /// Hides desktop media picker dialog shown by chooseDesktopMedia().
  /// [desktopMediaRequestId] Id returned by chooseDesktopMedia()
  void cancelChooseDesktopMedia(int desktopMediaRequestId) {
    $js.chrome.desktopCapture.cancelChooseDesktopMedia(desktopMediaRequestId);
  }
}

/// Enum used to define set of desktop media sources used in
/// chooseDesktopMedia().
enum DesktopCaptureSourceType {
  screen('screen'),
  window('window'),
  tab('tab'),
  audio('audio');

  const DesktopCaptureSourceType(this.value);

  final String value;

  String get toJS => value;
  static DesktopCaptureSourceType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Mirrors
/// [SystemAudioPreferenceEnum](https://w3c.github.io/mediacapture-screen-share/#dom-systemaudiopreferenceenum).
enum SystemAudioPreferenceEnum {
  include('include'),
  exclude('exclude');

  const SystemAudioPreferenceEnum(this.value);

  final String value;

  String get toJS => value;
  static SystemAudioPreferenceEnum fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Mirrors
/// [SelfCapturePreferenceEnum](https://w3c.github.io/mediacapture-screen-share/#dom-selfcapturepreferenceenum).
enum SelfCapturePreferenceEnum {
  include('include'),
  exclude('exclude');

  const SelfCapturePreferenceEnum(this.value);

  final String value;

  String get toJS => value;
  static SelfCapturePreferenceEnum fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class ChooseDesktopMediaOptions {
  ChooseDesktopMediaOptions.fromJS(this._wrapped);

  ChooseDesktopMediaOptions({
    /// Mirrors
    /// [systemAudio](https://w3c.github.io/mediacapture-screen-share/#dom-displaymediastreamconstraints-systemaudio).
    SystemAudioPreferenceEnum? systemAudio,

    /// Mirrors
    /// [selfBrowserSurface](https://w3c.github.io/mediacapture-screen-share/#dom-displaymediastreamconstraints-selfbrowsersurface).
    SelfCapturePreferenceEnum? selfBrowserSurface,

    /// Indicates that the caller intends to perform local audio suppression,
    /// and that the media picker shown to the user should therefore reflect
    /// that with the appropriate warnings, as it does when getDisplayMedia() is
    /// invoked.
    bool? suppressLocalAudioPlaybackIntended,
  }) : _wrapped = $js.ChooseDesktopMediaOptions(
          systemAudio: systemAudio?.toJS,
          selfBrowserSurface: selfBrowserSurface?.toJS,
          suppressLocalAudioPlaybackIntended:
              suppressLocalAudioPlaybackIntended,
        );

  final $js.ChooseDesktopMediaOptions _wrapped;

  $js.ChooseDesktopMediaOptions get toJS => _wrapped;

  /// Mirrors
  /// [systemAudio](https://w3c.github.io/mediacapture-screen-share/#dom-displaymediastreamconstraints-systemaudio).
  SystemAudioPreferenceEnum? get systemAudio =>
      _wrapped.systemAudio?.let(SystemAudioPreferenceEnum.fromJS);
  set systemAudio(SystemAudioPreferenceEnum? v) {
    _wrapped.systemAudio = v?.toJS;
  }

  /// Mirrors
  /// [selfBrowserSurface](https://w3c.github.io/mediacapture-screen-share/#dom-displaymediastreamconstraints-selfbrowsersurface).
  SelfCapturePreferenceEnum? get selfBrowserSurface =>
      _wrapped.selfBrowserSurface?.let(SelfCapturePreferenceEnum.fromJS);
  set selfBrowserSurface(SelfCapturePreferenceEnum? v) {
    _wrapped.selfBrowserSurface = v?.toJS;
  }

  /// Indicates that the caller intends to perform local audio suppression, and
  /// that the media picker shown to the user should therefore reflect that with
  /// the appropriate warnings, as it does when getDisplayMedia() is invoked.
  bool? get suppressLocalAudioPlaybackIntended =>
      _wrapped.suppressLocalAudioPlaybackIntended;
  set suppressLocalAudioPlaybackIntended(bool? v) {
    _wrapped.suppressLocalAudioPlaybackIntended = v;
  }
}
