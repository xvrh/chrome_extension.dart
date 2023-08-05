// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/i18n.dart' as $js;

export 'src/chrome.dart' show chrome;

final _i18n = ChromeI18n._();

extension ChromeI18nExtension on Chrome {
  /// Use the `chrome.i18n` infrastructure to implement internationalization
  /// across your whole app or extension.
  ChromeI18n get i18n => _i18n;
}

class ChromeI18n {
  ChromeI18n._();

  bool get isAvailable => $js.chrome.i18nNullable != null && alwaysTrue;

  /// Gets the accept-languages of the browser. This is different from the
  /// locale used by the browser; to get the locale, use [i18n.getUILanguage].
  Future<List<String>> getAcceptLanguages() async {
    var $res =
        await promiseToFuture<JSArray>($js.chrome.i18n.getAcceptLanguages());
    return $res.toDart.cast<$js.LanguageCode>().map((e) => e).toList();
  }

  /// Gets the localized string for the specified message. If the message is
  /// missing, this method returns an empty string (''). If the format of the
  /// `getMessage()` call is wrong - for example, _messageName_ is not a string
  /// or the _substitutions_ array has more than 9 elements - this method
  /// returns `undefined`.
  /// [messageName] The name of the message, as specified in the <a
  /// href='i18n-messages'>`messages.json`</a> file.
  /// [substitutions] Up to 9 substitution strings, if the message requires
  /// any.
  /// [returns] Message localized for current locale.
  String getMessage(
    String messageName,
    Object? substitutions,
    GetMessageOptions? options,
  ) {
    return $js.chrome.i18n.getMessage(
      messageName,
      substitutions?.jsify(),
      options?.toJS,
    );
  }

  /// Gets the browser UI language of the browser. This is different from
  /// [i18n.getAcceptLanguages] which returns the preferred user languages.
  /// [returns] The browser UI language code such as en-US or fr-FR.
  String getUILanguage() {
    return $js.chrome.i18n.getUILanguage();
  }

  /// Detects the language of the provided text using CLD.
  /// [text] User input string to be translated.
  Future<DetectLanguageCallbackResult> detectLanguage(String text) async {
    var $res = await promiseToFuture<$js.DetectLanguageCallbackResult>(
        $js.chrome.i18n.detectLanguage(text));
    return DetectLanguageCallbackResult.fromJS($res);
  }
}

/// An ISO language code such as `en` or `fr`. For a complete list of languages
/// supported by this method, see
/// [kLanguageInfoTable](http://src.chromium.org/viewvc/chrome/trunk/src/third_party/cld/languages/internal/languages.cc).
/// For an unknown language, `und` will be returned, which means that
/// [percentage] of the text is unknown to CLD
typedef LanguageCode = String;

class GetMessageOptions {
  GetMessageOptions.fromJS(this._wrapped);

  GetMessageOptions(
      {
      /// Escape `<` in translation to `&amp;lt;`. This applies only to the
      /// message itself, not to the placeholders. Developers might want to use
      /// this if the translation is used in an HTML context. Closure Templates
      /// used with Closure Compiler generate this automatically.
      bool? escapeLt})
      : _wrapped = $js.GetMessageOptions(escapeLt: escapeLt);

  final $js.GetMessageOptions _wrapped;

  $js.GetMessageOptions get toJS => _wrapped;

  /// Escape `<` in translation to `&amp;lt;`. This applies only to the message
  /// itself, not to the placeholders. Developers might want to use this if the
  /// translation is used in an HTML context. Closure Templates used with
  /// Closure Compiler generate this automatically.
  bool? get escapeLt => _wrapped.escapeLt;
  set escapeLt(bool? v) {
    _wrapped.escapeLt = v;
  }
}

class DetectLanguageCallbackResult {
  DetectLanguageCallbackResult.fromJS(this._wrapped);

  DetectLanguageCallbackResult({
    /// CLD detected language reliability
    required bool isReliable,

    /// array of detectedLanguage
    required List<DetectLanguageCallbackResultLanguages> languages,
  }) : _wrapped = $js.DetectLanguageCallbackResult(
          isReliable: isReliable,
          languages: languages.toJSArray((e) => e.toJS),
        );

  final $js.DetectLanguageCallbackResult _wrapped;

  $js.DetectLanguageCallbackResult get toJS => _wrapped;

  /// CLD detected language reliability
  bool get isReliable => _wrapped.isReliable;
  set isReliable(bool v) {
    _wrapped.isReliable = v;
  }

  /// array of detectedLanguage
  List<DetectLanguageCallbackResultLanguages> get languages =>
      _wrapped.languages.toDart
          .cast<$js.DetectLanguageCallbackResultLanguages>()
          .map((e) => DetectLanguageCallbackResultLanguages.fromJS(e))
          .toList();
  set languages(List<DetectLanguageCallbackResultLanguages> v) {
    _wrapped.languages = v.toJSArray((e) => e.toJS);
  }
}

class DetectLanguageCallbackResultLanguages {
  DetectLanguageCallbackResultLanguages.fromJS(this._wrapped);

  DetectLanguageCallbackResultLanguages({
    required String language,

    /// The percentage of the detected language
    required int percentage,
  }) : _wrapped = $js.DetectLanguageCallbackResultLanguages(
          language: language,
          percentage: percentage,
        );

  final $js.DetectLanguageCallbackResultLanguages _wrapped;

  $js.DetectLanguageCallbackResultLanguages get toJS => _wrapped;

  String get language => _wrapped.language;
  set language(String v) {
    _wrapped.language = v;
  }

  /// The percentage of the detected language
  int get percentage => _wrapped.percentage;
  set percentage(int v) {
    _wrapped.percentage = v;
  }
}
