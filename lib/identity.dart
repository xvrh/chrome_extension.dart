// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/identity.dart' as $js;

export 'src/chrome.dart' show chrome;

final _identity = ChromeIdentity._();

extension ChromeIdentityExtension on Chrome {
  /// Use the `chrome.identity` API to get OAuth2 access tokens.
  ChromeIdentity get identity => _identity;
}

class ChromeIdentity {
  ChromeIdentity._();

  bool get isAvailable => $js.chrome.identityNullable != null && alwaysTrue;

  /// Retrieves a list of AccountInfo objects describing the accounts
  /// present on the profile.
  ///
  /// `getAccounts` is only supported on dev channel.
  Future<List<AccountInfo>> getAccounts() async {
    var $res =
        await promiseToFuture<JSArray>($js.chrome.identity.getAccounts());
    return $res.toDart
        .cast<$js.AccountInfo>()
        .map((e) => AccountInfo.fromJS(e))
        .toList();
  }

  /// Gets an OAuth2 access token using the client ID and scopes
  /// specified in the <a
  /// href="app_identity.html#update_manifest">`oauth2`
  /// section of manifest.json</a>.
  ///
  /// The Identity API caches access tokens in memory, so it's ok to
  /// call `getAuthToken` non-interactively any time a token is
  /// required. The token cache automatically handles expiration.
  ///
  /// For a good user experience it is important interactive token requests are
  /// initiated by UI in your app explaining what the authorization is for.
  /// Failing to do this will cause your users to get authorization requests,
  /// or Chrome sign in screens if they are not signed in, with with no
  /// context. In particular, do not use `getAuthToken`
  /// interactively when your app is first launched.
  ///
  /// Note: When called with a callback, instead of returning an object this
  /// function will return the two properties as separate arguments passed to
  /// the callback.
  ///
  /// |details| : Token options.
  /// |callback| : Called with an OAuth2 access token as specified by the
  /// manifest, or undefined if there was an error. The
  /// `grantedScopes` parameter is populated since Chrome 87. When
  /// available, this parameter contains the list of granted scopes
  /// corresponding with the returned token.
  Future<GetAuthTokenResult> getAuthToken(TokenDetails? details) async {
    var $res = await promiseToFuture<$js.GetAuthTokenResult>(
        $js.chrome.identity.getAuthToken(details?.toJS));
    return GetAuthTokenResult.fromJS($res);
  }

  /// Retrieves email address and obfuscated gaia id of the user
  /// signed into a profile.
  ///
  /// Requires the `identity.email` manifest permission. Otherwise,
  /// returns an empty result.
  ///
  /// This API is different from identity.getAccounts in two
  /// ways. The information returned is available offline, and it
  /// only applies to the primary account for the profile.
  ///
  /// |details|: Profile options.
  /// |callback|: Called with the `ProfileUserInfo` of the primary
  /// Chrome account, of an empty `ProfileUserInfo` if the account
  /// with given `details` doesn't exist.
  Future<ProfileUserInfo> getProfileUserInfo(ProfileDetails? details) async {
    var $res = await promiseToFuture<$js.ProfileUserInfo>(
        $js.chrome.identity.getProfileUserInfo(details?.toJS));
    return ProfileUserInfo.fromJS($res);
  }

  /// Removes an OAuth2 access token from the Identity API's token cache.
  ///
  /// If an access token is discovered to be invalid, it should be
  /// passed to removeCachedAuthToken to remove it from the
  /// cache. The app may then retrieve a fresh token with
  /// `getAuthToken`.
  ///
  /// |details| : Token information.
  /// |callback| : Called when the token has been removed from the cache.
  Future<void> removeCachedAuthToken(InvalidTokenDetails details) async {
    await promiseToFuture<void>(
        $js.chrome.identity.removeCachedAuthToken(details.toJS));
  }

  /// Resets the state of the Identity API:
  /// <ul>
  ///   <li>Removes all OAuth2 access tokens from the token cache</li>
  ///   <li>Removes user's account preferences</li>
  ///   <li>De-authorizes the user from all auth flows</li>
  /// </ul>
  ///
  /// |callback| : Called when the state has been cleared.
  Future<void> clearAllCachedAuthTokens() async {
    await promiseToFuture<void>($js.chrome.identity.clearAllCachedAuthTokens());
  }

  /// Starts an auth flow at the specified URL.
  ///
  /// This method enables auth flows with non-Google identity
  /// providers by launching a web view and navigating it to the
  /// first URL in the provider's auth flow. When the provider
  /// redirects to a URL matching the pattern
  /// `https://<app-id>.chromiumapp.org/*`, the
  /// window will close, and the final redirect URL will be passed to
  /// the [callback] function.
  ///
  /// For a good user experience it is important interactive auth flows are
  /// initiated by UI in your app explaining what the authorization is for.
  /// Failing to do this will cause your users to get authorization requests
  /// with no context. In particular, do not launch an interactive auth flow
  /// when your app is first launched.
  ///
  /// |details| : WebAuth flow options.
  /// |callback| : Called with the URL redirected back to your application.
  Future<String?> launchWebAuthFlow(WebAuthFlowDetails details) async {
    var $res = await promiseToFuture<String?>(
        $js.chrome.identity.launchWebAuthFlow(details.toJS));
    return $res;
  }

  /// Generates a redirect URL to be used in |launchWebAuthFlow|.
  ///
  /// The generated URLs match the pattern
  /// `https://<app-id>.chromiumapp.org/*`.
  ///
  /// |path| : The path appended to the end of the generated URL.
  String getRedirectURL(String? path) {
    return $js.chrome.identity.getRedirectURL(path);
  }

  /// Fired when signin state changes for an account on the user's profile.
  EventStream<OnSignInChangedEvent> get onSignInChanged =>
      $js.chrome.identity.onSignInChanged.asStream(($c) => (
            $js.AccountInfo account,
            bool signedIn,
          ) {
            return $c(OnSignInChangedEvent(
              account: AccountInfo.fromJS(account),
              signedIn: signedIn,
            ));
          });
}

enum AccountStatus {
  /// Sync is enabled for the primary account.
  sync('SYNC'),

  /// Any primary account, if exists.
  any('ANY');

  const AccountStatus(this.value);

  final String value;

  String get toJS => value;
  static AccountStatus fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class AccountInfo {
  AccountInfo.fromJS(this._wrapped);

  AccountInfo(
      {
      /// A unique identifier for the account. This ID will not change
      /// for the lifetime of the account.
      required String id})
      : _wrapped = $js.AccountInfo(id: id);

  final $js.AccountInfo _wrapped;

  $js.AccountInfo get toJS => _wrapped;

  /// A unique identifier for the account. This ID will not change
  /// for the lifetime of the account.
  String get id => _wrapped.id;
  set id(String v) {
    _wrapped.id = v;
  }
}

class ProfileDetails {
  ProfileDetails.fromJS(this._wrapped);

  ProfileDetails(
      {
      /// A status of the primary account signed into a profile whose
      /// `ProfileUserInfo` should be returned. Defaults to
      /// `SYNC` account status.
      AccountStatus? accountStatus})
      : _wrapped = $js.ProfileDetails(accountStatus: accountStatus?.toJS);

  final $js.ProfileDetails _wrapped;

  $js.ProfileDetails get toJS => _wrapped;

  /// A status of the primary account signed into a profile whose
  /// `ProfileUserInfo` should be returned. Defaults to
  /// `SYNC` account status.
  AccountStatus? get accountStatus =>
      _wrapped.accountStatus?.let(AccountStatus.fromJS);
  set accountStatus(AccountStatus? v) {
    _wrapped.accountStatus = v?.toJS;
  }
}

class ProfileUserInfo {
  ProfileUserInfo.fromJS(this._wrapped);

  ProfileUserInfo({
    /// An email address for the user account signed into the current
    /// profile. Empty if the user is not signed in or the
    /// `identity.email` manifest permission is not
    /// specified.
    required String email,

    /// A unique identifier for the account. This ID will not change
    /// for the lifetime of the account. Empty if the user is not
    /// signed in or (in M41+) the `identity.email`
    /// manifest permission is not specified.
    required String id,
  }) : _wrapped = $js.ProfileUserInfo(
          email: email,
          id: id,
        );

  final $js.ProfileUserInfo _wrapped;

  $js.ProfileUserInfo get toJS => _wrapped;

  /// An email address for the user account signed into the current
  /// profile. Empty if the user is not signed in or the
  /// `identity.email` manifest permission is not
  /// specified.
  String get email => _wrapped.email;
  set email(String v) {
    _wrapped.email = v;
  }

  /// A unique identifier for the account. This ID will not change
  /// for the lifetime of the account. Empty if the user is not
  /// signed in or (in M41+) the `identity.email`
  /// manifest permission is not specified.
  String get id => _wrapped.id;
  set id(String v) {
    _wrapped.id = v;
  }
}

class TokenDetails {
  TokenDetails.fromJS(this._wrapped);

  TokenDetails({
    /// Fetching a token may require the user to sign-in to Chrome, or
    /// approve the application's requested scopes. If the interactive
    /// flag is `true`, `getAuthToken` will
    /// prompt the user as necessary. When the flag is
    /// `false` or omitted, `getAuthToken` will
    /// return failure any time a prompt would be required.
    bool? interactive,

    /// The account ID whose token should be returned. If not specified, the
    /// function will use an account from the Chrome profile: the Sync account
    /// if
    /// there is one, or otherwise the first Google web account.
    AccountInfo? account,

    /// A list of OAuth2 scopes to request.
    ///
    /// When the `scopes` field is present, it overrides the
    /// list of scopes specified in manifest.json.
    List<String>? scopes,

    /// The `enableGranularPermissions` flag allows extensions to
    /// opt-in early to the granular permissions consent screen, in which
    /// requested permissions are granted or denied individually.
    bool? enableGranularPermissions,
  }) : _wrapped = $js.TokenDetails(
          interactive: interactive,
          account: account?.toJS,
          scopes: scopes?.toJSArray((e) => e),
          enableGranularPermissions: enableGranularPermissions,
        );

  final $js.TokenDetails _wrapped;

  $js.TokenDetails get toJS => _wrapped;

  /// Fetching a token may require the user to sign-in to Chrome, or
  /// approve the application's requested scopes. If the interactive
  /// flag is `true`, `getAuthToken` will
  /// prompt the user as necessary. When the flag is
  /// `false` or omitted, `getAuthToken` will
  /// return failure any time a prompt would be required.
  bool? get interactive => _wrapped.interactive;
  set interactive(bool? v) {
    _wrapped.interactive = v;
  }

  /// The account ID whose token should be returned. If not specified, the
  /// function will use an account from the Chrome profile: the Sync account if
  /// there is one, or otherwise the first Google web account.
  AccountInfo? get account => _wrapped.account?.let(AccountInfo.fromJS);
  set account(AccountInfo? v) {
    _wrapped.account = v?.toJS;
  }

  /// A list of OAuth2 scopes to request.
  ///
  /// When the `scopes` field is present, it overrides the
  /// list of scopes specified in manifest.json.
  List<String>? get scopes =>
      _wrapped.scopes?.toDart.cast<String>().map((e) => e).toList();
  set scopes(List<String>? v) {
    _wrapped.scopes = v?.toJSArray((e) => e);
  }

  /// The `enableGranularPermissions` flag allows extensions to
  /// opt-in early to the granular permissions consent screen, in which
  /// requested permissions are granted or denied individually.
  bool? get enableGranularPermissions => _wrapped.enableGranularPermissions;
  set enableGranularPermissions(bool? v) {
    _wrapped.enableGranularPermissions = v;
  }
}

class InvalidTokenDetails {
  InvalidTokenDetails.fromJS(this._wrapped);

  InvalidTokenDetails(
      {
      /// The specific token that should be removed from the cache.
      required String token})
      : _wrapped = $js.InvalidTokenDetails(token: token);

  final $js.InvalidTokenDetails _wrapped;

  $js.InvalidTokenDetails get toJS => _wrapped;

  /// The specific token that should be removed from the cache.
  String get token => _wrapped.token;
  set token(String v) {
    _wrapped.token = v;
  }
}

class WebAuthFlowDetails {
  WebAuthFlowDetails.fromJS(this._wrapped);

  WebAuthFlowDetails({
    /// The URL that initiates the auth flow.
    required String url,

    /// Whether to launch auth flow in interactive mode.
    ///
    /// Since some auth flows may immediately redirect to a result URL,
    /// `launchWebAuthFlow` hides its web view until the first
    /// navigation either redirects to the final URL, or finishes loading a page
    /// meant to be displayed.
    ///
    /// If the `interactive` flag is `true`, the window
    /// will be displayed when a page load completes. If the flag is
    /// `false` or omitted, `launchWebAuthFlow` will return
    /// with an error if the initial navigation does not complete the flow.
    ///
    /// For flows that use JavaScript for redirection,
    /// `abortOnLoadForNonInteractive` can be set to `false`
    /// in combination with setting `timeoutMsForNonInteractive` to give
    /// the page a chance to perform any redirects.
    bool? interactive,

    /// Whether to terminate `launchWebAuthFlow` for non-interactive
    /// requests after the page loads. This parameter does not affect
    /// interactive
    /// flows.
    ///
    /// When set to `true` (default) the flow will terminate
    /// immediately after the page loads. When set to `false`, the
    /// flow will only terminate after the
    /// `timeoutMsForNonInteractive` passes. This is useful for
    /// identity providers that use JavaScript to perform redirections after the
    /// page loads.
    bool? abortOnLoadForNonInteractive,

    /// The maximum amount of time, in miliseconds,
    /// `launchWebAuthFlow` is allowed to run in non-interactive mode
    /// in total. Only has an effect if `interactive` is
    /// `false`.
    int? timeoutMsForNonInteractive,
  }) : _wrapped = $js.WebAuthFlowDetails(
          url: url,
          interactive: interactive,
          abortOnLoadForNonInteractive: abortOnLoadForNonInteractive,
          timeoutMsForNonInteractive: timeoutMsForNonInteractive,
        );

  final $js.WebAuthFlowDetails _wrapped;

  $js.WebAuthFlowDetails get toJS => _wrapped;

  /// The URL that initiates the auth flow.
  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }

  /// Whether to launch auth flow in interactive mode.
  ///
  /// Since some auth flows may immediately redirect to a result URL,
  /// `launchWebAuthFlow` hides its web view until the first
  /// navigation either redirects to the final URL, or finishes loading a page
  /// meant to be displayed.
  ///
  /// If the `interactive` flag is `true`, the window
  /// will be displayed when a page load completes. If the flag is
  /// `false` or omitted, `launchWebAuthFlow` will return
  /// with an error if the initial navigation does not complete the flow.
  ///
  /// For flows that use JavaScript for redirection,
  /// `abortOnLoadForNonInteractive` can be set to `false`
  /// in combination with setting `timeoutMsForNonInteractive` to give
  /// the page a chance to perform any redirects.
  bool? get interactive => _wrapped.interactive;
  set interactive(bool? v) {
    _wrapped.interactive = v;
  }

  /// Whether to terminate `launchWebAuthFlow` for non-interactive
  /// requests after the page loads. This parameter does not affect interactive
  /// flows.
  ///
  /// When set to `true` (default) the flow will terminate
  /// immediately after the page loads. When set to `false`, the
  /// flow will only terminate after the
  /// `timeoutMsForNonInteractive` passes. This is useful for
  /// identity providers that use JavaScript to perform redirections after the
  /// page loads.
  bool? get abortOnLoadForNonInteractive =>
      _wrapped.abortOnLoadForNonInteractive;
  set abortOnLoadForNonInteractive(bool? v) {
    _wrapped.abortOnLoadForNonInteractive = v;
  }

  /// The maximum amount of time, in miliseconds,
  /// `launchWebAuthFlow` is allowed to run in non-interactive mode
  /// in total. Only has an effect if `interactive` is
  /// `false`.
  int? get timeoutMsForNonInteractive => _wrapped.timeoutMsForNonInteractive;
  set timeoutMsForNonInteractive(int? v) {
    _wrapped.timeoutMsForNonInteractive = v;
  }
}

class GetAuthTokenResult {
  GetAuthTokenResult.fromJS(this._wrapped);

  GetAuthTokenResult({
    /// The specific token associated with the request.
    String? token,

    /// A list of OAuth2 scopes granted to the extension.
    List<String>? grantedScopes,
  }) : _wrapped = $js.GetAuthTokenResult(
          token: token,
          grantedScopes: grantedScopes?.toJSArray((e) => e),
        );

  final $js.GetAuthTokenResult _wrapped;

  $js.GetAuthTokenResult get toJS => _wrapped;

  /// The specific token associated with the request.
  String? get token => _wrapped.token;
  set token(String? v) {
    _wrapped.token = v;
  }

  /// A list of OAuth2 scopes granted to the extension.
  List<String>? get grantedScopes =>
      _wrapped.grantedScopes?.toDart.cast<String>().map((e) => e).toList();
  set grantedScopes(List<String>? v) {
    _wrapped.grantedScopes = v?.toJSArray((e) => e);
  }
}

class OnSignInChangedEvent {
  OnSignInChangedEvent({
    required this.account,
    required this.signedIn,
  });

  final AccountInfo account;

  final bool signedIn;
}
