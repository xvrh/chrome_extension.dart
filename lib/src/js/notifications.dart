// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSNotificationsExtension on JSChrome {
  @JS('notifications')
  external JSNotifications? get notificationsNullable;

  /// Use the `chrome.notifications` API to create rich notifications
  /// using templates and show these notifications to users in the system tray.
  JSNotifications get notifications {
    var notificationsNullable = this.notificationsNullable;
    if (notificationsNullable == null) {
      throw ApiNotAvailableException('chrome.notifications');
    }
    return notificationsNullable;
  }
}

@JS()
@staticInterop
class JSNotifications {}

extension JSNotificationsExtension on JSNotifications {
  /// Creates and displays a notification.
  /// |notificationId|: Identifier of the notification. If not set or empty, an
  /// ID will automatically be generated. If it matches an existing
  /// notification, this method first clears that notification before
  /// proceeding with the create operation. The identifier may not be longer
  /// than 500 characters.
  ///
  /// The `notificationId` parameter is required before Chrome 42.
  /// |options|: Contents of the notification.
  /// |callback|: Returns the notification id (either supplied or generated)
  /// that represents the created notification.
  ///
  /// The callback is required before Chrome 42.
  external void create(
    String? notificationId,
    NotificationOptions options,
    JSFunction? callback,
  );

  /// Updates an existing notification.
  /// |notificationId|: The id of the notification to be updated. This is
  /// returned by [notifications.create] method.
  /// |options|: Contents of the notification to update to.
  /// |callback|: Called to indicate whether a matching notification existed.
  ///
  /// The callback is required before Chrome 42.
  external void update(
    String notificationId,
    NotificationOptions options,
    JSFunction? callback,
  );

  /// Clears the specified notification.
  /// |notificationId|: The id of the notification to be cleared. This is
  /// returned by [notifications.create] method.
  /// |callback|: Called to indicate whether a matching notification existed.
  ///
  /// The callback is required before Chrome 42.
  external void clear(
    String notificationId,
    JSFunction? callback,
  );

  /// Retrieves all the notifications of this app or extension.
  /// |callback|: Returns the set of notification_ids currently in the system.
  external void getAll(JSFunction callback);

  /// Retrieves whether the user has enabled notifications from this app
  /// or extension.
  /// |callback|: Returns the current permission level.
  external void getPermissionLevel(JSFunction callback);

  /// The notification closed, either by the system or by user action.
  external Event get onClosed;

  /// The user clicked in a non-button area of the notification.
  external Event get onClicked;

  /// The user pressed a button in the notification.
  external Event get onButtonClicked;

  /// The user changes the permission level.  As of Chrome 47, only ChromeOS
  /// has UI that dispatches this event.
  external Event get onPermissionLevelChanged;

  /// The user clicked on a link for the app's notification settings.  As of
  /// Chrome 47, only ChromeOS has UI that dispatches this event.
  /// As of Chrome 65, that UI has been removed from ChromeOS, too.
  external Event get onShowSettings;
}

typedef TemplateType = String;

typedef PermissionLevel = String;

@JS()
@staticInterop
@anonymous
class NotificationItem {
  external factory NotificationItem({
    /// Title of one item of a list notification.
    String title,

    /// Additional details about this item.
    String message,
  });
}

extension NotificationItemExtension on NotificationItem {
  /// Title of one item of a list notification.
  external String title;

  /// Additional details about this item.
  external String message;
}

@JS()
@staticInterop
@anonymous
class NotificationBitmap {
  external factory NotificationBitmap({
    int width,
    int height,
    JSArrayBuffer? data,
  });
}

extension NotificationBitmapExtension on NotificationBitmap {
  external int width;

  external int height;

  external JSArrayBuffer? data;
}

@JS()
@staticInterop
@anonymous
class NotificationButton {
  external factory NotificationButton({
    String title,
    String? iconUrl,
    NotificationBitmap? iconBitmap,
  });
}

extension NotificationButtonExtension on NotificationButton {
  external String title;

  external String? iconUrl;

  external NotificationBitmap? iconBitmap;
}

@JS()
@staticInterop
@anonymous
class NotificationOptions {
  external factory NotificationOptions({
    /// Which type of notification to display.
    /// _Required for [notifications.create]_ method.
    TemplateType? type,

    /// A URL to the sender's avatar, app icon, or a thumbnail for image
    /// notifications.
    ///
    /// URLs can be a data URL, a blob URL, or a URL relative to a resource
    /// within this extension's .crx file
    /// _Required for [notifications.create]_ method.
    String? iconUrl,
    NotificationBitmap? iconBitmap,

    /// A URL to the app icon mask. URLs have the same restrictions as
    /// $(ref:notifications.NotificationOptions.iconUrl iconUrl).
    ///
    /// The app icon mask should be in alpha channel, as only the alpha channel
    /// of the image will be considered.
    String? appIconMaskUrl,
    NotificationBitmap? appIconMaskBitmap,

    /// Title of the notification (e.g. sender name for email).
    /// _Required for [notifications.create]_ method.
    String? title,

    /// Main notification content.
    /// _Required for [notifications.create]_ method.
    String? message,

    /// Alternate notification content with a lower-weight font.
    String? contextMessage,

    /// Priority ranges from -2 to 2. -2 is lowest priority. 2 is highest. Zero
    /// is default.  On platforms that don't support a notification center
    /// (Windows, Linux & Mac), -2 and -1 result in an error as notifications
    /// with those priorities will not be shown at all.
    int? priority,

    /// A timestamp associated with the notification, in milliseconds past the
    /// epoch (e.g. `Date.now() + n`).
    double? eventTime,

    /// Text and icons for up to two notification action buttons.
    JSArray? buttons,

    /// Secondary notification content.
    String? expandedMessage,

    /// A URL to the image thumbnail for image-type notifications.
    /// URLs have the same restrictions as
    /// $(ref:notifications.NotificationOptions.iconUrl iconUrl).
    String? imageUrl,
    NotificationBitmap? imageBitmap,

    /// Items for multi-item notifications. Users on Mac OS X only see the first
    /// item.
    JSArray? items,

    /// Current progress ranges from 0 to 100.
    int? progress,
    bool? isClickable,

    /// Indicates that the notification should remain visible on screen until the
    /// user activates or dismisses the notification. This defaults to false.
    bool? requireInteraction,

    /// Indicates that no sounds or vibrations should be made when the
    /// notification is being shown. This defaults to false.
    bool? silent,
  });
}

extension NotificationOptionsExtension on NotificationOptions {
  /// Which type of notification to display.
  /// _Required for [notifications.create]_ method.
  external TemplateType? type;

  /// A URL to the sender's avatar, app icon, or a thumbnail for image
  /// notifications.
  ///
  /// URLs can be a data URL, a blob URL, or a URL relative to a resource
  /// within this extension's .crx file
  /// _Required for [notifications.create]_ method.
  external String? iconUrl;

  external NotificationBitmap? iconBitmap;

  /// A URL to the app icon mask. URLs have the same restrictions as
  /// $(ref:notifications.NotificationOptions.iconUrl iconUrl).
  ///
  /// The app icon mask should be in alpha channel, as only the alpha channel
  /// of the image will be considered.
  external String? appIconMaskUrl;

  external NotificationBitmap? appIconMaskBitmap;

  /// Title of the notification (e.g. sender name for email).
  /// _Required for [notifications.create]_ method.
  external String? title;

  /// Main notification content.
  /// _Required for [notifications.create]_ method.
  external String? message;

  /// Alternate notification content with a lower-weight font.
  external String? contextMessage;

  /// Priority ranges from -2 to 2. -2 is lowest priority. 2 is highest. Zero
  /// is default.  On platforms that don't support a notification center
  /// (Windows, Linux & Mac), -2 and -1 result in an error as notifications
  /// with those priorities will not be shown at all.
  external int? priority;

  /// A timestamp associated with the notification, in milliseconds past the
  /// epoch (e.g. `Date.now() + n`).
  external double? eventTime;

  /// Text and icons for up to two notification action buttons.
  external JSArray? buttons;

  /// Secondary notification content.
  external String? expandedMessage;

  /// A URL to the image thumbnail for image-type notifications.
  /// URLs have the same restrictions as
  /// $(ref:notifications.NotificationOptions.iconUrl iconUrl).
  external String? imageUrl;

  external NotificationBitmap? imageBitmap;

  /// Items for multi-item notifications. Users on Mac OS X only see the first
  /// item.
  external JSArray? items;

  /// Current progress ranges from 0 to 100.
  external int? progress;

  external bool? isClickable;

  /// Indicates that the notification should remain visible on screen until the
  /// user activates or dismisses the notification. This defaults to false.
  external bool? requireInteraction;

  /// Indicates that no sounds or vibrations should be made when the
  /// notification is being shown. This defaults to false.
  external bool? silent;
}
