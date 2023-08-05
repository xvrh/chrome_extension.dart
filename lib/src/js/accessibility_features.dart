// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'types.dart';

export 'chrome.dart';

extension JSChromeJSAccessibilityFeaturesExtension on JSChrome {
  @JS('accessibilityFeatures')
  external JSAccessibilityFeatures? get accessibilityFeaturesNullable;

  /// Use the `chrome.accessibilityFeatures` API to manage Chrome's
  /// accessibility features. This API relies on the [ChromeSetting prototype of
  /// the type API](types#ChromeSetting) for getting and setting individual
  /// accessibility features. In order to get feature states the extension must
  /// request `accessibilityFeatures.read` permission. For modifying feature
  /// state, the extension needs `accessibilityFeatures.modify` permission. Note
  /// that `accessibilityFeatures.modify` does not imply
  /// `accessibilityFeatures.read` permission.
  JSAccessibilityFeatures get accessibilityFeatures {
    var accessibilityFeaturesNullable = this.accessibilityFeaturesNullable;
    if (accessibilityFeaturesNullable == null) {
      throw ApiNotAvailableException('chrome.accessibilityFeatures');
    }
    return accessibilityFeaturesNullable;
  }
}

@JS()
@staticInterop
class JSAccessibilityFeatures {}

extension JSAccessibilityFeaturesExtension on JSAccessibilityFeatures {
  /// *ChromeOS only.*
  ///
  /// Spoken feedback (text-to-speech). The value indicates whether the feature
  /// is enabled or not. `get()` requires `accessibilityFeatures.read`
  /// permission. `set()` and `clear()` require `accessibilityFeatures.modify`
  /// permission.
  external ChromeSetting? get spokenFeedback;

  /// *ChromeOS only.*
  ///
  /// Enlarged cursor. The value indicates whether the feature is enabled or
  /// not. `get()` requires `accessibilityFeatures.read` permission. `set()` and
  /// `clear()` require `accessibilityFeatures.modify` permission.
  external ChromeSetting? get largeCursor;

  /// *ChromeOS only.*
  ///
  /// Sticky modifier keys (like shift or alt). The value indicates whether the
  /// feature is enabled or not. `get()` requires `accessibilityFeatures.read`
  /// permission. `set()` and `clear()` require `accessibilityFeatures.modify`
  /// permission.
  external ChromeSetting? get stickyKeys;

  /// *ChromeOS only.*
  ///
  /// High contrast rendering mode. The value indicates whether the feature is
  /// enabled or not. `get()` requires `accessibilityFeatures.read` permission.
  /// `set()` and `clear()` require `accessibilityFeatures.modify` permission.
  external ChromeSetting? get highContrast;

  /// *ChromeOS only.*
  ///
  /// Full screen magnification. The value indicates whether the feature is
  /// enabled or not. `get()` requires `accessibilityFeatures.read` permission.
  /// `set()` and `clear()` require `accessibilityFeatures.modify` permission.
  external ChromeSetting? get screenMagnifier;

  /// *ChromeOS only.*
  ///
  /// Auto mouse click after mouse stops moving. The value indicates whether the
  /// feature is enabled or not. `get()` requires `accessibilityFeatures.read`
  /// permission. `set()` and `clear()` require `accessibilityFeatures.modify`
  /// permission.
  external ChromeSetting? get autoclick;

  /// *ChromeOS only.*
  ///
  /// Virtual on-screen keyboard. The value indicates whether the feature is
  /// enabled or not. `get()` requires `accessibilityFeatures.read` permission.
  /// `set()` and `clear()` require `accessibilityFeatures.modify` permission.
  external ChromeSetting? get virtualKeyboard;

  /// *ChromeOS only.*
  ///
  /// Caret highlighting. The value indicates whether the feature is enabled or
  /// not. `get()` requires `accessibilityFeatures.read` permission. `set()` and
  /// `clear()` require `accessibilityFeatures.modify` permission.
  external ChromeSetting? get caretHighlight;

  /// *ChromeOS only.*
  ///
  /// Cursor highlighting. The value indicates whether the feature is enabled or
  /// not. `get()` requires `accessibilityFeatures.read` permission. `set()` and
  /// `clear()` require `accessibilityFeatures.modify` permission.
  external ChromeSetting? get cursorHighlight;

  /// *ChromeOS only.*
  ///
  /// Cursor color. The value indicates whether the feature is enabled or not,
  /// doesn't indicate the color of it. `get()` requires
  /// `accessibilityFeatures.read` permission. `set()` and `clear()` require
  /// `accessibilityFeatures.modify` permission.
  external ChromeSetting? get cursorColor;

  /// *ChromeOS only.*
  ///
  /// Docked magnifier. The value indicates whether docked magnifier feature is
  /// enabled or not. `get()` requires `accessibilityFeatures.read` permission.
  /// `set()` and `clear()` require `accessibilityFeatures.modify` permission.
  external ChromeSetting? get dockedMagnifier;

  /// *ChromeOS only.*
  ///
  /// Focus highlighting. The value indicates whether the feature is enabled or
  /// not. `get()` requires `accessibilityFeatures.read` permission. `set()` and
  /// `clear()` require `accessibilityFeatures.modify` permission.
  external ChromeSetting? get focusHighlight;

  /// *ChromeOS only.*
  ///
  /// Select-to-speak. The value indicates whether the feature is enabled or
  /// not. `get()` requires `accessibilityFeatures.read` permission. `set()` and
  /// `clear()` require `accessibilityFeatures.modify` permission.
  external ChromeSetting? get selectToSpeak;

  /// *ChromeOS only.*
  ///
  /// Switch Access. The value indicates whether the feature is enabled or not.
  /// `get()` requires `accessibilityFeatures.read` permission. `set()` and
  /// `clear()` require `accessibilityFeatures.modify` permission.
  external ChromeSetting? get switchAccess;

  /// `get()` requires `accessibilityFeatures.read` permission. `set()` and
  /// `clear()` require `accessibilityFeatures.modify` permission.
  external ChromeSetting get animationPolicy;

  /// *ChromeOS only.*
  ///
  /// Dictation. The value indicates whether the feature is enabled or not.
  /// `get()` requires `accessibilityFeatures.read` permission. `set()` and
  /// `clear()` require `accessibilityFeatures.modify` permission.
  external ChromeSetting? get dictation;
}
