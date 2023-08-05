// ignore_for_file: unnecessary_parenthesis

library;

import 'src/internal_helpers.dart';
import 'src/js/accessibility_features.dart' as $js;
import 'types.dart';

export 'src/chrome.dart' show chrome;

final _accessibilityFeatures = ChromeAccessibilityFeatures._();

extension ChromeAccessibilityFeaturesExtension on Chrome {
  /// Use the `chrome.accessibilityFeatures` API to manage Chrome's
  /// accessibility features. This API relies on the [ChromeSetting prototype of
  /// the type API](types#ChromeSetting) for getting and setting individual
  /// accessibility features. In order to get feature states the extension must
  /// request `accessibilityFeatures.read` permission. For modifying feature
  /// state, the extension needs `accessibilityFeatures.modify` permission. Note
  /// that `accessibilityFeatures.modify` does not imply
  /// `accessibilityFeatures.read` permission.
  ChromeAccessibilityFeatures get accessibilityFeatures =>
      _accessibilityFeatures;
}

class ChromeAccessibilityFeatures {
  ChromeAccessibilityFeatures._();

  bool get isAvailable =>
      $js.chrome.accessibilityFeaturesNullable != null && alwaysTrue;

  /// *ChromeOS only.*
  ///
  /// Spoken feedback (text-to-speech). The value indicates whether the feature
  /// is enabled or not. `get()` requires `accessibilityFeatures.read`
  /// permission. `set()` and `clear()` require `accessibilityFeatures.modify`
  /// permission.
  ChromeSetting? get spokenFeedback =>
      $js.chrome.accessibilityFeatures.spokenFeedback
          ?.let(ChromeSetting.fromJS);

  /// *ChromeOS only.*
  ///
  /// Enlarged cursor. The value indicates whether the feature is enabled or
  /// not. `get()` requires `accessibilityFeatures.read` permission. `set()` and
  /// `clear()` require `accessibilityFeatures.modify` permission.
  ChromeSetting? get largeCursor =>
      $js.chrome.accessibilityFeatures.largeCursor?.let(ChromeSetting.fromJS);

  /// *ChromeOS only.*
  ///
  /// Sticky modifier keys (like shift or alt). The value indicates whether the
  /// feature is enabled or not. `get()` requires `accessibilityFeatures.read`
  /// permission. `set()` and `clear()` require `accessibilityFeatures.modify`
  /// permission.
  ChromeSetting? get stickyKeys =>
      $js.chrome.accessibilityFeatures.stickyKeys?.let(ChromeSetting.fromJS);

  /// *ChromeOS only.*
  ///
  /// High contrast rendering mode. The value indicates whether the feature is
  /// enabled or not. `get()` requires `accessibilityFeatures.read` permission.
  /// `set()` and `clear()` require `accessibilityFeatures.modify` permission.
  ChromeSetting? get highContrast =>
      $js.chrome.accessibilityFeatures.highContrast?.let(ChromeSetting.fromJS);

  /// *ChromeOS only.*
  ///
  /// Full screen magnification. The value indicates whether the feature is
  /// enabled or not. `get()` requires `accessibilityFeatures.read` permission.
  /// `set()` and `clear()` require `accessibilityFeatures.modify` permission.
  ChromeSetting? get screenMagnifier =>
      $js.chrome.accessibilityFeatures.screenMagnifier
          ?.let(ChromeSetting.fromJS);

  /// *ChromeOS only.*
  ///
  /// Auto mouse click after mouse stops moving. The value indicates whether the
  /// feature is enabled or not. `get()` requires `accessibilityFeatures.read`
  /// permission. `set()` and `clear()` require `accessibilityFeatures.modify`
  /// permission.
  ChromeSetting? get autoclick =>
      $js.chrome.accessibilityFeatures.autoclick?.let(ChromeSetting.fromJS);

  /// *ChromeOS only.*
  ///
  /// Virtual on-screen keyboard. The value indicates whether the feature is
  /// enabled or not. `get()` requires `accessibilityFeatures.read` permission.
  /// `set()` and `clear()` require `accessibilityFeatures.modify` permission.
  ChromeSetting? get virtualKeyboard =>
      $js.chrome.accessibilityFeatures.virtualKeyboard
          ?.let(ChromeSetting.fromJS);

  /// *ChromeOS only.*
  ///
  /// Caret highlighting. The value indicates whether the feature is enabled or
  /// not. `get()` requires `accessibilityFeatures.read` permission. `set()` and
  /// `clear()` require `accessibilityFeatures.modify` permission.
  ChromeSetting? get caretHighlight =>
      $js.chrome.accessibilityFeatures.caretHighlight
          ?.let(ChromeSetting.fromJS);

  /// *ChromeOS only.*
  ///
  /// Cursor highlighting. The value indicates whether the feature is enabled or
  /// not. `get()` requires `accessibilityFeatures.read` permission. `set()` and
  /// `clear()` require `accessibilityFeatures.modify` permission.
  ChromeSetting? get cursorHighlight =>
      $js.chrome.accessibilityFeatures.cursorHighlight
          ?.let(ChromeSetting.fromJS);

  /// *ChromeOS only.*
  ///
  /// Cursor color. The value indicates whether the feature is enabled or not,
  /// doesn't indicate the color of it. `get()` requires
  /// `accessibilityFeatures.read` permission. `set()` and `clear()` require
  /// `accessibilityFeatures.modify` permission.
  ChromeSetting? get cursorColor =>
      $js.chrome.accessibilityFeatures.cursorColor?.let(ChromeSetting.fromJS);

  /// *ChromeOS only.*
  ///
  /// Docked magnifier. The value indicates whether docked magnifier feature is
  /// enabled or not. `get()` requires `accessibilityFeatures.read` permission.
  /// `set()` and `clear()` require `accessibilityFeatures.modify` permission.
  ChromeSetting? get dockedMagnifier =>
      $js.chrome.accessibilityFeatures.dockedMagnifier
          ?.let(ChromeSetting.fromJS);

  /// *ChromeOS only.*
  ///
  /// Focus highlighting. The value indicates whether the feature is enabled or
  /// not. `get()` requires `accessibilityFeatures.read` permission. `set()` and
  /// `clear()` require `accessibilityFeatures.modify` permission.
  ChromeSetting? get focusHighlight =>
      $js.chrome.accessibilityFeatures.focusHighlight
          ?.let(ChromeSetting.fromJS);

  /// *ChromeOS only.*
  ///
  /// Select-to-speak. The value indicates whether the feature is enabled or
  /// not. `get()` requires `accessibilityFeatures.read` permission. `set()` and
  /// `clear()` require `accessibilityFeatures.modify` permission.
  ChromeSetting? get selectToSpeak =>
      $js.chrome.accessibilityFeatures.selectToSpeak?.let(ChromeSetting.fromJS);

  /// *ChromeOS only.*
  ///
  /// Switch Access. The value indicates whether the feature is enabled or not.
  /// `get()` requires `accessibilityFeatures.read` permission. `set()` and
  /// `clear()` require `accessibilityFeatures.modify` permission.
  ChromeSetting? get switchAccess =>
      $js.chrome.accessibilityFeatures.switchAccess?.let(ChromeSetting.fromJS);

  /// `get()` requires `accessibilityFeatures.read` permission. `set()` and
  /// `clear()` require `accessibilityFeatures.modify` permission.
  ChromeSetting get animationPolicy =>
      ChromeSetting.fromJS($js.chrome.accessibilityFeatures.animationPolicy);

  /// *ChromeOS only.*
  ///
  /// Dictation. The value indicates whether the feature is enabled or not.
  /// `get()` requires `accessibilityFeatures.read` permission. `set()` and
  /// `clear()` require `accessibilityFeatures.modify` permission.
  ChromeSetting? get dictation =>
      $js.chrome.accessibilityFeatures.dictation?.let(ChromeSetting.fromJS);
}
