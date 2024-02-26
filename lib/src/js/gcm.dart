// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

@JS()
library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSGcmExtension on JSChrome {
  @JS('gcm')
  external JSGcm? get gcmNullable;

  /// Use `chrome.gcm` to enable apps and extensions to send and receive
  /// messages through [Firebase Cloud
  /// Messaging](https://firebase.google.com/docs/cloud-messaging/) (FCM).
  JSGcm get gcm {
    var gcmNullable = this.gcmNullable;
    if (gcmNullable == null) {
      throw ApiNotAvailableException('chrome.gcm');
    }
    return gcmNullable;
  }
}

extension type JSGcm._(JSObject _) {
  /// Registers the application with FCM. The registration ID will be returned
  /// by the `callback`. If `register` is called again with the same list of
  /// `senderIds`, the same registration ID will be returned.
  external JSPromise register(

      /// A list of server IDs that are allowed to send messages to the
      /// application. It should contain at least one and no more than 100 sender
      /// IDs.
      JSArray senderIds);

  /// Unregisters the application from FCM.
  external JSPromise unregister();

  /// Sends a message according to its contents.
  external JSPromise send(

      /// A message to send to the other party via FCM.
      SendMessage message);

  /// Fired when a message is received through FCM.
  external Event get onMessage;

  /// Fired when a FCM server had to delete messages sent by an app server to
  /// the application. See [Lifetime of a
  /// message](https://firebase.google.com/docs/cloud-messaging/concept-options#lifetime)
  /// for details on handling this event.
  external Event get onMessagesDeleted;

  /// Fired when it was not possible to send a message to the FCM server.
  external Event get onSendError;

  /// The maximum size (in bytes) of all key/value pairs in a message.
  external int get MAX_MESSAGE_SIZE;
}
extension type OnMessageMessage._(JSObject _) implements JSObject {
  external factory OnMessageMessage({
    /// The message data.
    JSAny data,

    /// The sender who issued the message.
    String? from,

    /// The collapse key of a message. See the <a
    /// href='https://firebase.google.com/docs/cloud-messaging/concept-options#collapsible_and_non-collapsible_messages'>Non-collapsible
    /// and collapsible messages</a> for details.
    String? collapseKey,
  });

  /// The message data.
  external JSAny data;

  /// The sender who issued the message.
  external String? from;

  /// The collapse key of a message. See the <a
  /// href='https://firebase.google.com/docs/cloud-messaging/concept-options#collapsible_and_non-collapsible_messages'>Non-collapsible
  /// and collapsible messages</a> for details.
  external String? collapseKey;
}
extension type OnSendErrorError._(JSObject _) implements JSObject {
  external factory OnSendErrorError({
    /// The error message describing the problem.
    String errorMessage,

    /// The ID of the message with this error, if error is related to a specific
    /// message.
    String? messageId,

    /// Additional details related to the error, when available.
    JSAny details,
  });

  /// The error message describing the problem.
  external String errorMessage;

  /// The ID of the message with this error, if error is related to a specific
  /// message.
  external String? messageId;

  /// Additional details related to the error, when available.
  external JSAny details;
}
extension type SendMessage._(JSObject _) implements JSObject {
  external factory SendMessage({
    /// The ID of the server to send the message to as assigned by [Google API
    /// Console](https://console.cloud.google.com/apis/dashboard).
    String destinationId,

    /// The ID of the message. It must be unique for each message in scope of the
    /// applications. See the [Cloud Messaging
    /// documentation](https://firebase.google.com/docs/cloud-messaging/js/client)
    /// for advice for picking and handling an ID.
    String messageId,

    /// Time-to-live of the message in seconds. If it is not possible to send the
    /// message within that time, an onSendError event will be raised. A
    /// time-to-live of 0 indicates that the message should be sent immediately or
    /// fail if it's not possible. The default value of time-to-live is 86,400
    /// seconds (1 day) and the maximum value is 2,419,200 seconds (28 days).
    int? timeToLive,

    /// Message data to send to the server. Case-insensitive `goog.` and `google`,
    /// as well as case-sensitive `collapse_key` are disallowed as key prefixes.
    /// Sum of all key/value pairs should not exceed [gcm.MAX_MESSAGE_SIZE].
    JSAny data,
  });

  /// The ID of the server to send the message to as assigned by [Google API
  /// Console](https://console.cloud.google.com/apis/dashboard).
  external String destinationId;

  /// The ID of the message. It must be unique for each message in scope of the
  /// applications. See the [Cloud Messaging
  /// documentation](https://firebase.google.com/docs/cloud-messaging/js/client)
  /// for advice for picking and handling an ID.
  external String messageId;

  /// Time-to-live of the message in seconds. If it is not possible to send the
  /// message within that time, an onSendError event will be raised. A
  /// time-to-live of 0 indicates that the message should be sent immediately or
  /// fail if it's not possible. The default value of time-to-live is 86,400
  /// seconds (1 day) and the maximum value is 2,419,200 seconds (28 days).
  external int? timeToLive;

  /// Message data to send to the server. Case-insensitive `goog.` and `google`,
  /// as well as case-sensitive `collapse_key` are disallowed as key prefixes.
  /// Sum of all key/value pairs should not exceed [gcm.MAX_MESSAGE_SIZE].
  external JSAny data;
}
