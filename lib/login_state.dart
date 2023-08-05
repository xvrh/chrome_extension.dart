// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/login_state.dart' as $js;

export 'src/chrome.dart' show chrome;

final _loginState = ChromeLoginState._();

extension ChromeLoginStateExtension on Chrome {
  /// Use the `chrome.loginState` API to read and monitor the login
  /// state.
  ChromeLoginState get loginState => _loginState;
}

class ChromeLoginState {
  ChromeLoginState._();

  bool get isAvailable => $js.chrome.loginStateNullable != null && alwaysTrue;

  /// Gets the type of the profile the extension is in.
  Future<ProfileType> getProfileType() async {
    var $res = await promiseToFuture<$js.ProfileType>(
        $js.chrome.loginState.getProfileType());
    return ProfileType.fromJS($res);
  }

  /// Gets the current session state.
  Future<SessionState> getSessionState() async {
    var $res = await promiseToFuture<$js.SessionState>(
        $js.chrome.loginState.getSessionState());
    return SessionState.fromJS($res);
  }

  /// Dispatched when the session state changes. `sessionState`
  /// is the new session state.
  EventStream<SessionState> get onSessionStateChanged =>
      $js.chrome.loginState.onSessionStateChanged
          .asStream(($c) => ($js.SessionState sessionState) {
                return $c(SessionState.fromJS(sessionState));
              });
}

enum ProfileType {
  /// The extension is in the signin profile.
  signinProfile('SIGNIN_PROFILE'),

  /// The extension is in the user profile.
  userProfile('USER_PROFILE');

  const ProfileType(this.value);

  final String value;

  String get toJS => value;
  static ProfileType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

enum SessionState {
  /// The session state is unknown.
  unknown('UNKNOWN'),

  /// The user is in the out-of-box-experience screen.
  inOobeScreen('IN_OOBE_SCREEN'),

  /// The user is in the login screen.
  inLoginScreen('IN_LOGIN_SCREEN'),

  /// The user is in the session.
  inSession('IN_SESSION'),

  /// The user is in the lock screen.
  inLockScreen('IN_LOCK_SCREEN'),

  /// The device is in RMA mode, finalizing repairs.
  inRmaScreen('IN_RMA_SCREEN');

  const SessionState(this.value);

  final String value;

  String get toJS => value;
  static SessionState fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}
