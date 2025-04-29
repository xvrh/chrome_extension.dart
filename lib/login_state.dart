// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'src/internal_helpers.dart';
import 'src/js/login_state.dart' as $js;

export 'src/chrome.dart' show chrome, EventStream;

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
    var $res = await $js.chrome.loginState.getProfileType().toDart;
    return ProfileType.fromJS($res! as $js.ProfileType);
  }

  /// Gets the current session state.
  Future<SessionState> getSessionState() async {
    var $res = await $js.chrome.loginState.getSessionState().toDart;
    return SessionState.fromJS($res! as $js.SessionState);
  }

  /// Dispatched when the session state changes. `sessionState`
  /// is the new session state.
  EventStream<SessionState> get onSessionStateChanged =>
      $js.chrome.loginState.onSessionStateChanged.asStream(
        ($c) =>
            ($js.SessionState sessionState) {
              return $c(SessionState.fromJS(sessionState));
            }.toJS,
      );
}

enum ProfileType {
  /// Specifies that the extension is in the signin profile.
  signinProfile('SIGNIN_PROFILE'),

  /// Specifies that the extension is in the user profile.
  userProfile('USER_PROFILE');

  const ProfileType(this.value);

  final String value;

  JSString get toJS => value.toJS;
  static ProfileType fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

enum SessionState {
  /// Specifies that the session state is unknown.
  unknown('UNKNOWN'),

  /// Specifies that the user is in the out-of-box-experience screen.
  inOobeScreen('IN_OOBE_SCREEN'),

  /// Specifies that the user is in the login screen.
  inLoginScreen('IN_LOGIN_SCREEN'),

  /// Specifies that the user is in the session.
  inSession('IN_SESSION'),

  /// Specifies that the user is in the lock screen.
  inLockScreen('IN_LOCK_SCREEN'),

  /// Specifies that the device is in RMA mode, finalizing repairs.
  inRmaScreen('IN_RMA_SCREEN');

  const SessionState(this.value);

  final String value;

  JSString get toJS => value.toJS;
  static SessionState fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}
