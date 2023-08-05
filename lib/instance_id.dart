// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/instance_id.dart' as $js;

export 'src/chrome.dart' show chrome;

final _instanceId = ChromeInstanceId._();

extension ChromeInstanceIdExtension on Chrome {
  /// Use `chrome.instanceID` to access the Instance ID service.
  ChromeInstanceId get instanceId => _instanceId;
}

class ChromeInstanceId {
  ChromeInstanceId._();

  bool get isAvailable => $js.chrome.instanceIdNullable != null && alwaysTrue;

  /// Retrieves an identifier for the app instance. The instance ID will be
  /// returned by the `callback`. The same ID will be returned as long as the
  /// application identity has not been revoked or expired.
  /// [returns] Function called when the retrieval completes. It should check
  /// [runtime.lastError] for error when instanceID is empty.
  Future<String> getID() async {
    var $res = await promiseToFuture<String>($js.chrome.instanceId.getID());
    return $res;
  }

  /// Retrieves the time when the InstanceID has been generated. The creation
  /// time will be returned by the `callback`.
  /// [returns] Function called when the retrieval completes. It should check
  /// [runtime.lastError] for error when creationTime is zero.
  Future<double> getCreationTime() async {
    var $res =
        await promiseToFuture<double>($js.chrome.instanceId.getCreationTime());
    return $res;
  }

  /// Return a token that allows the authorized entity to access the service
  /// defined by scope.
  /// [getTokenParams] Parameters for getToken.
  /// [returns] Function called when the retrieval completes. It should check
  /// [runtime.lastError] for error when token is empty.
  Future<String> getToken(GetTokenParams getTokenParams) async {
    var $res = await promiseToFuture<String>(
        $js.chrome.instanceId.getToken(getTokenParams.toJS));
    return $res;
  }

  /// Revokes a granted token.
  /// [deleteTokenParams] Parameters for deleteToken.
  /// [returns] Function called when the token deletion completes. The token
  /// was revoked successfully if [runtime.lastError] is not set.
  Future<void> deleteToken(DeleteTokenParams deleteTokenParams) async {
    await promiseToFuture<void>(
        $js.chrome.instanceId.deleteToken(deleteTokenParams.toJS));
  }

  /// Resets the app instance identifier and revokes all tokens associated with
  /// it.
  /// [returns] Function called when the deletion completes. The instance
  /// identifier was revoked successfully if [runtime.lastError] is not set.
  Future<void> deleteID() async {
    await promiseToFuture<void>($js.chrome.instanceId.deleteID());
  }

  /// Fired when all the granted tokens need to be refreshed.
  EventStream<void> get onTokenRefresh =>
      $js.chrome.instanceId.onTokenRefresh.asStream(($c) => () {
            return $c(null);
          });
}

class GetTokenParams {
  GetTokenParams.fromJS(this._wrapped);

  GetTokenParams({
    /// Identifies the entity that is authorized to access resources associated
    /// with this Instance ID. It can be a project ID from [Google developer
    /// console](https://code.google.com/apis/console).
    required String authorizedEntity,

    /// Identifies authorized actions that the authorized entity can take. E.g.
    /// for sending GCM messages, `GCM` scope should be used.
    required String scope,

    /// Allows including a small number of string key/value pairs that will be
    /// associated with the token and may be used in processing the request.
    Map? options,
  }) : _wrapped = $js.GetTokenParams(
          authorizedEntity: authorizedEntity,
          scope: scope,
          options: options?.jsify(),
        );

  final $js.GetTokenParams _wrapped;

  $js.GetTokenParams get toJS => _wrapped;

  /// Identifies the entity that is authorized to access resources associated
  /// with this Instance ID. It can be a project ID from [Google developer
  /// console](https://code.google.com/apis/console).
  String get authorizedEntity => _wrapped.authorizedEntity;
  set authorizedEntity(String v) {
    _wrapped.authorizedEntity = v;
  }

  /// Identifies authorized actions that the authorized entity can take. E.g.
  /// for sending GCM messages, `GCM` scope should be used.
  String get scope => _wrapped.scope;
  set scope(String v) {
    _wrapped.scope = v;
  }

  /// Allows including a small number of string key/value pairs that will be
  /// associated with the token and may be used in processing the request.
  Map? get options => _wrapped.options?.toDartMap();
  set options(Map? v) {
    _wrapped.options = v?.jsify();
  }
}

class DeleteTokenParams {
  DeleteTokenParams.fromJS(this._wrapped);

  DeleteTokenParams({
    /// The authorized entity that is used to obtain the token.
    required String authorizedEntity,

    /// The scope that is used to obtain the token.
    required String scope,
  }) : _wrapped = $js.DeleteTokenParams(
          authorizedEntity: authorizedEntity,
          scope: scope,
        );

  final $js.DeleteTokenParams _wrapped;

  $js.DeleteTokenParams get toJS => _wrapped;

  /// The authorized entity that is used to obtain the token.
  String get authorizedEntity => _wrapped.authorizedEntity;
  set authorizedEntity(String v) {
    _wrapped.authorizedEntity = v;
  }

  /// The scope that is used to obtain the token.
  String get scope => _wrapped.scope;
  set scope(String v) {
    _wrapped.scope = v;
  }
}
