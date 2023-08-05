// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSLoginStateExtension on JSChrome {
  @JS('loginState')
  external JSLoginState? get loginStateNullable;

  /// Use the `chrome.loginState` API to read and monitor the login
  /// state.
  JSLoginState get loginState {
    var loginStateNullable = this.loginStateNullable;
    if (loginStateNullable == null) {
      throw ApiNotAvailableException('chrome.loginState');
    }
    return loginStateNullable;
  }
}

@JS()
@staticInterop
class JSLoginState {}

extension JSLoginStateExtension on JSLoginState {
  /// Gets the type of the profile the extension is in.
  external JSPromise getProfileType();

  /// Gets the current session state.
  external JSPromise getSessionState();

  /// Dispatched when the session state changes. `sessionState`
  /// is the new session state.
  external Event get onSessionStateChanged;
}

typedef ProfileType = String;

typedef SessionState = String;
