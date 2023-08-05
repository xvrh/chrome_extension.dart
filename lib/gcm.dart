// ignore_for_file: unnecessary_parenthesis

library;

import 'src/internal_helpers.dart';
import 'src/js/gcm.dart' as $js;

export 'src/chrome.dart' show chrome;

final _gcm = ChromeGcm._();

extension ChromeGcmExtension on Chrome {
  /// Use `chrome.gcm` to enable apps and extensions to send and receive
  /// messages through [Firebase Cloud
  /// Messaging](https://firebase.google.com/docs/cloud-messaging/) (FCM).
  ChromeGcm get gcm => _gcm;
}

class ChromeGcm {
  ChromeGcm._();

  bool get isAvailable => $js.chrome.gcmNullable != null && alwaysTrue;

  /// Registers the application with FCM. The registration ID will be returned
  /// by the `callback`. If `register` is called again with the same list of
  /// `senderIds`, the same registration ID will be returned.
  /// [senderIds] A list of server IDs that are allowed to send messages to
  /// the application. It should contain at least one and no more than 100
  /// sender IDs.
  /// [returns] Function called when registration completes. It should check
  /// [runtime.lastError] for error when `registrationId` is empty.
  Future<String> register(List<String> senderIds) {
    var $completer = Completer<String>();
    $js.chrome.gcm.register(
      senderIds.toJSArray((e) => e),
      (String registrationId) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(registrationId);
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// Unregisters the application from FCM.
  /// [returns] A function called after the unregistration completes.
  /// Unregistration was successful if [runtime.lastError] is not set.
  Future<void> unregister() {
    var $completer = Completer<void>();
    $js.chrome.gcm.unregister(() {
      if (checkRuntimeLastError($completer)) {
        $completer.complete(null);
      }
    }.toJS);
    return $completer.future;
  }

  /// Sends a message according to its contents.
  /// [message] A message to send to the other party via FCM.
  /// [returns] A function called after the message is successfully queued for
  /// sending. [runtime.lastError] should be checked, to ensure a message was
  /// sent without problems.
  Future<String> send(SendMessage message) {
    var $completer = Completer<String>();
    $js.chrome.gcm.send(
      message.toJS,
      (String messageId) {
        if (checkRuntimeLastError($completer)) {
          $completer.complete(messageId);
        }
      }.toJS,
    );
    return $completer.future;
  }

  /// The maximum size (in bytes) of all key/value pairs in a message.
  int get maxMessageSize => $js.chrome.gcm.MAX_MESSAGE_SIZE;

  /// Fired when a message is received through FCM.
  EventStream<OnMessageMessage> get onMessage =>
      $js.chrome.gcm.onMessage.asStream(($c) => ($js.OnMessageMessage message) {
            return $c(OnMessageMessage.fromJS(message));
          });

  /// Fired when a FCM server had to delete messages sent by an app server to
  /// the application. See [Lifetime of a
  /// message](https://firebase.google.com/docs/cloud-messaging/concept-options#lifetime)
  /// for details on handling this event.
  EventStream<void> get onMessagesDeleted =>
      $js.chrome.gcm.onMessagesDeleted.asStream(($c) => () {
            return $c(null);
          });

  /// Fired when it was not possible to send a message to the FCM server.
  EventStream<OnSendErrorError> get onSendError =>
      $js.chrome.gcm.onSendError.asStream(($c) => ($js.OnSendErrorError error) {
            return $c(OnSendErrorError.fromJS(error));
          });
}

class OnMessageMessage {
  OnMessageMessage.fromJS(this._wrapped);

  OnMessageMessage({
    /// The message data.
    required Map data,

    /// The sender who issued the message.
    String? from,

    /// The collapse key of a message. See the <a
    /// href='https://firebase.google.com/docs/cloud-messaging/concept-options#collapsible_and_non-collapsible_messages'>Non-collapsible
    /// and collapsible messages</a> for details.
    String? collapseKey,
  }) : _wrapped = $js.OnMessageMessage(
          data: data.jsify()!,
          from: from,
          collapseKey: collapseKey,
        );

  final $js.OnMessageMessage _wrapped;

  $js.OnMessageMessage get toJS => _wrapped;

  /// The message data.
  Map get data => _wrapped.data.toDartMap();
  set data(Map v) {
    _wrapped.data = v.jsify()!;
  }

  /// The sender who issued the message.
  String? get from => _wrapped.from;
  set from(String? v) {
    _wrapped.from = v;
  }

  /// The collapse key of a message. See the <a
  /// href='https://firebase.google.com/docs/cloud-messaging/concept-options#collapsible_and_non-collapsible_messages'>Non-collapsible
  /// and collapsible messages</a> for details.
  String? get collapseKey => _wrapped.collapseKey;
  set collapseKey(String? v) {
    _wrapped.collapseKey = v;
  }
}

class OnSendErrorError {
  OnSendErrorError.fromJS(this._wrapped);

  OnSendErrorError({
    /// The error message describing the problem.
    required String errorMessage,

    /// The ID of the message with this error, if error is related to a specific
    /// message.
    String? messageId,

    /// Additional details related to the error, when available.
    required Map details,
  }) : _wrapped = $js.OnSendErrorError(
          errorMessage: errorMessage,
          messageId: messageId,
          details: details.jsify()!,
        );

  final $js.OnSendErrorError _wrapped;

  $js.OnSendErrorError get toJS => _wrapped;

  /// The error message describing the problem.
  String get errorMessage => _wrapped.errorMessage;
  set errorMessage(String v) {
    _wrapped.errorMessage = v;
  }

  /// The ID of the message with this error, if error is related to a specific
  /// message.
  String? get messageId => _wrapped.messageId;
  set messageId(String? v) {
    _wrapped.messageId = v;
  }

  /// Additional details related to the error, when available.
  Map get details => _wrapped.details.toDartMap();
  set details(Map v) {
    _wrapped.details = v.jsify()!;
  }
}

class SendMessage {
  SendMessage.fromJS(this._wrapped);

  SendMessage({
    /// The ID of the server to send the message to as assigned by [Google API
    /// Console](https://console.cloud.google.com/apis/dashboard).
    required String destinationId,

    /// The ID of the message. It must be unique for each message in scope of
    /// the applications. See the [Cloud Messaging
    /// documentation](https://firebase.google.com/docs/cloud-messaging/js/client)
    /// for advice for picking and handling an ID.
    required String messageId,

    /// Time-to-live of the message in seconds. If it is not possible to send
    /// the message within that time, an onSendError event will be raised. A
    /// time-to-live of 0 indicates that the message should be sent immediately
    /// or fail if it's not possible. The default value of time-to-live is
    /// 86,400 seconds (1 day) and the maximum value is 2,419,200 seconds (28
    /// days).
    int? timeToLive,

    /// Message data to send to the server. Case-insensitive `goog.` and
    /// `google`, as well as case-sensitive `collapse_key` are disallowed as key
    /// prefixes. Sum of all key/value pairs should not exceed
    /// [gcm.MAX_MESSAGE_SIZE].
    required Map data,
  }) : _wrapped = $js.SendMessage(
          destinationId: destinationId,
          messageId: messageId,
          timeToLive: timeToLive,
          data: data.jsify()!,
        );

  final $js.SendMessage _wrapped;

  $js.SendMessage get toJS => _wrapped;

  /// The ID of the server to send the message to as assigned by [Google API
  /// Console](https://console.cloud.google.com/apis/dashboard).
  String get destinationId => _wrapped.destinationId;
  set destinationId(String v) {
    _wrapped.destinationId = v;
  }

  /// The ID of the message. It must be unique for each message in scope of the
  /// applications. See the [Cloud Messaging
  /// documentation](https://firebase.google.com/docs/cloud-messaging/js/client)
  /// for advice for picking and handling an ID.
  String get messageId => _wrapped.messageId;
  set messageId(String v) {
    _wrapped.messageId = v;
  }

  /// Time-to-live of the message in seconds. If it is not possible to send the
  /// message within that time, an onSendError event will be raised. A
  /// time-to-live of 0 indicates that the message should be sent immediately or
  /// fail if it's not possible. The default value of time-to-live is 86,400
  /// seconds (1 day) and the maximum value is 2,419,200 seconds (28 days).
  int? get timeToLive => _wrapped.timeToLive;
  set timeToLive(int? v) {
    _wrapped.timeToLive = v;
  }

  /// Message data to send to the server. Case-insensitive `goog.` and `google`,
  /// as well as case-sensitive `collapse_key` are disallowed as key prefixes.
  /// Sum of all key/value pairs should not exceed [gcm.MAX_MESSAGE_SIZE].
  Map get data => _wrapped.data.toDartMap();
  set data(Map v) {
    _wrapped.data = v.jsify()!;
  }
}
