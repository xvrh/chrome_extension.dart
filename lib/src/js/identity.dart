// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSIdentityExtension on JSChrome {
  @JS('identity')
  external JSIdentity? get identityNullable;

  /// Use the `chrome.identity` API to get OAuth2 access tokens.
  JSIdentity get identity {
    var identityNullable = this.identityNullable;
    if (identityNullable == null) {
      throw ApiNotAvailableException('chrome.identity');
    }
    return identityNullable;
  }
}

@JS()
@staticInterop
class JSIdentity {}

extension JSIdentityExtension on JSIdentity {
  /// Retrieves a list of AccountInfo objects describing the accounts
  /// present on the profile.
  ///
  /// `getAccounts` is only supported on dev channel.
  external JSPromise getAccounts();

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
  external JSPromise getAuthToken(TokenDetails? details);

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
  external JSPromise getProfileUserInfo(ProfileDetails? details);

  /// Removes an OAuth2 access token from the Identity API's token cache.
  ///
  /// If an access token is discovered to be invalid, it should be
  /// passed to removeCachedAuthToken to remove it from the
  /// cache. The app may then retrieve a fresh token with
  /// `getAuthToken`.
  ///
  /// |details| : Token information.
  /// |callback| : Called when the token has been removed from the cache.
  external JSPromise removeCachedAuthToken(InvalidTokenDetails details);

  /// Resets the state of the Identity API:
  /// <ul>
  ///   <li>Removes all OAuth2 access tokens from the token cache</li>
  ///   <li>Removes user's account preferences</li>
  ///   <li>De-authorizes the user from all auth flows</li>
  /// </ul>
  ///
  /// |callback| : Called when the state has been cleared.
  external JSPromise clearAllCachedAuthTokens();

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
  external JSPromise launchWebAuthFlow(WebAuthFlowDetails details);

  /// Generates a redirect URL to be used in |launchWebAuthFlow|.
  ///
  /// The generated URLs match the pattern
  /// `https://<app-id>.chromiumapp.org/*`.
  ///
  /// |path| : The path appended to the end of the generated URL.
  external String getRedirectURL(String? path);

  /// Fired when signin state changes for an account on the user's profile.
  external Event get onSignInChanged;
}

typedef AccountStatus = String;

@JS()
@staticInterop
@anonymous
class AccountInfo {
  external factory AccountInfo(
      {
      /// A unique identifier for the account. This ID will not change
      /// for the lifetime of the account.
      String id});
}

extension AccountInfoExtension on AccountInfo {
  /// A unique identifier for the account. This ID will not change
  /// for the lifetime of the account.
  external String id;
}

@JS()
@staticInterop
@anonymous
class ProfileDetails {
  external factory ProfileDetails(
      {
      /// A status of the primary account signed into a profile whose
      /// `ProfileUserInfo` should be returned. Defaults to
      /// `SYNC` account status.
      AccountStatus? accountStatus});
}

extension ProfileDetailsExtension on ProfileDetails {
  /// A status of the primary account signed into a profile whose
  /// `ProfileUserInfo` should be returned. Defaults to
  /// `SYNC` account status.
  external AccountStatus? accountStatus;
}

@JS()
@staticInterop
@anonymous
class ProfileUserInfo {
  external factory ProfileUserInfo({
    /// An email address for the user account signed into the current
    /// profile. Empty if the user is not signed in or the
    /// `identity.email` manifest permission is not
    /// specified.
    String email,

    /// A unique identifier for the account. This ID will not change
    /// for the lifetime of the account. Empty if the user is not
    /// signed in or (in M41+) the `identity.email`
    /// manifest permission is not specified.
    String id,
  });
}

extension ProfileUserInfoExtension on ProfileUserInfo {
  /// An email address for the user account signed into the current
  /// profile. Empty if the user is not signed in or the
  /// `identity.email` manifest permission is not
  /// specified.
  external String email;

  /// A unique identifier for the account. This ID will not change
  /// for the lifetime of the account. Empty if the user is not
  /// signed in or (in M41+) the `identity.email`
  /// manifest permission is not specified.
  external String id;
}

@JS()
@staticInterop
@anonymous
class TokenDetails {
  external factory TokenDetails({
    /// Fetching a token may require the user to sign-in to Chrome, or
    /// approve the application's requested scopes. If the interactive
    /// flag is `true`, `getAuthToken` will
    /// prompt the user as necessary. When the flag is
    /// `false` or omitted, `getAuthToken` will
    /// return failure any time a prompt would be required.
    bool? interactive,

    /// The account ID whose token should be returned. If not specified, the
    /// function will use an account from the Chrome profile: the Sync account if
    /// there is one, or otherwise the first Google web account.
    AccountInfo? account,

    /// A list of OAuth2 scopes to request.
    ///
    /// When the `scopes` field is present, it overrides the
    /// list of scopes specified in manifest.json.
    JSArray? scopes,

    /// The `enableGranularPermissions` flag allows extensions to
    /// opt-in early to the granular permissions consent screen, in which
    /// requested permissions are granted or denied individually.
    bool? enableGranularPermissions,
  });
}

extension TokenDetailsExtension on TokenDetails {
  /// Fetching a token may require the user to sign-in to Chrome, or
  /// approve the application's requested scopes. If the interactive
  /// flag is `true`, `getAuthToken` will
  /// prompt the user as necessary. When the flag is
  /// `false` or omitted, `getAuthToken` will
  /// return failure any time a prompt would be required.
  external bool? interactive;

  /// The account ID whose token should be returned. If not specified, the
  /// function will use an account from the Chrome profile: the Sync account if
  /// there is one, or otherwise the first Google web account.
  external AccountInfo? account;

  /// A list of OAuth2 scopes to request.
  ///
  /// When the `scopes` field is present, it overrides the
  /// list of scopes specified in manifest.json.
  external JSArray? scopes;

  /// The `enableGranularPermissions` flag allows extensions to
  /// opt-in early to the granular permissions consent screen, in which
  /// requested permissions are granted or denied individually.
  external bool? enableGranularPermissions;
}

@JS()
@staticInterop
@anonymous
class InvalidTokenDetails {
  external factory InvalidTokenDetails(
      {
      /// The specific token that should be removed from the cache.
      String token});
}

extension InvalidTokenDetailsExtension on InvalidTokenDetails {
  /// The specific token that should be removed from the cache.
  external String token;
}

@JS()
@staticInterop
@anonymous
class WebAuthFlowDetails {
  external factory WebAuthFlowDetails({
    /// The URL that initiates the auth flow.
    String url,

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
    /// requests after the page loads. This parameter does not affect interactive
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
  });
}

extension WebAuthFlowDetailsExtension on WebAuthFlowDetails {
  /// The URL that initiates the auth flow.
  external String url;

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
  external bool? interactive;

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
  external bool? abortOnLoadForNonInteractive;

  /// The maximum amount of time, in miliseconds,
  /// `launchWebAuthFlow` is allowed to run in non-interactive mode
  /// in total. Only has an effect if `interactive` is
  /// `false`.
  external int? timeoutMsForNonInteractive;
}

@JS()
@staticInterop
@anonymous
class GetAuthTokenResult {
  external factory GetAuthTokenResult({
    /// The specific token associated with the request.
    String? token,

    /// A list of OAuth2 scopes granted to the extension.
    JSArray? grantedScopes,
  });
}

extension GetAuthTokenResultExtension on GetAuthTokenResult {
  /// The specific token associated with the request.
  external String? token;

  /// A list of OAuth2 scopes granted to the extension.
  external JSArray? grantedScopes;
}
