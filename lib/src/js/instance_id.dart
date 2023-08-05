// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSInstanceIdExtension on JSChrome {
  @JS('instanceId')
  external JSInstanceId? get instanceIdNullable;

  /// Use `chrome.instanceID` to access the Instance ID service.
  JSInstanceId get instanceId {
    var instanceIdNullable = this.instanceIdNullable;
    if (instanceIdNullable == null) {
      throw ApiNotAvailableException('chrome.instanceId');
    }
    return instanceIdNullable;
  }
}

@JS()
@staticInterop
class JSInstanceId {}

extension JSInstanceIdExtension on JSInstanceId {
  /// Retrieves an identifier for the app instance. The instance ID will be
  /// returned by the `callback`. The same ID will be returned as long as the
  /// application identity has not been revoked or expired.
  external JSPromise getID();

  /// Retrieves the time when the InstanceID has been generated. The creation
  /// time will be returned by the `callback`.
  external JSPromise getCreationTime();

  /// Return a token that allows the authorized entity to access the service
  /// defined by scope.
  external JSPromise getToken(

      /// Parameters for getToken.
      GetTokenParams getTokenParams);

  /// Revokes a granted token.
  external JSPromise deleteToken(

      /// Parameters for deleteToken.
      DeleteTokenParams deleteTokenParams);

  /// Resets the app instance identifier and revokes all tokens associated with
  /// it.
  external JSPromise deleteID();

  /// Fired when all the granted tokens need to be refreshed.
  external Event get onTokenRefresh;
}

@JS()
@staticInterop
@anonymous
class GetTokenParams {
  external factory GetTokenParams({
    /// Identifies the entity that is authorized to access resources associated
    /// with this Instance ID. It can be a project ID from [Google developer
    /// console](https://code.google.com/apis/console).
    String authorizedEntity,

    /// Identifies authorized actions that the authorized entity can take. E.g.
    /// for sending GCM messages, `GCM` scope should be used.
    String scope,

    /// Allows including a small number of string key/value pairs that will be
    /// associated with the token and may be used in processing the request.
    JSAny? options,
  });
}

extension GetTokenParamsExtension on GetTokenParams {
  /// Identifies the entity that is authorized to access resources associated
  /// with this Instance ID. It can be a project ID from [Google developer
  /// console](https://code.google.com/apis/console).
  external String authorizedEntity;

  /// Identifies authorized actions that the authorized entity can take. E.g.
  /// for sending GCM messages, `GCM` scope should be used.
  external String scope;

  /// Allows including a small number of string key/value pairs that will be
  /// associated with the token and may be used in processing the request.
  external JSAny? options;
}

@JS()
@staticInterop
@anonymous
class DeleteTokenParams {
  external factory DeleteTokenParams({
    /// The authorized entity that is used to obtain the token.
    String authorizedEntity,

    /// The scope that is used to obtain the token.
    String scope,
  });
}

extension DeleteTokenParamsExtension on DeleteTokenParams {
  /// The authorized entity that is used to obtain the token.
  external String authorizedEntity;

  /// The scope that is used to obtain the token.
  external String scope;
}
