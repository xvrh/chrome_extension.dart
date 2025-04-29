// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'dart:typed_data';
import 'src/internal_helpers.dart';
import 'src/js/notifications.dart' as $js;

export 'src/chrome.dart' show chrome, EventStream;

final _notifications = ChromeNotifications._();

extension ChromeNotificationsExtension on Chrome {
  /// Use the `chrome.notifications` API to create rich notifications
  /// using templates and show these notifications to users in the system tray.
  ChromeNotifications get notifications => _notifications;
}

class ChromeNotifications {
  ChromeNotifications._();

  bool get isAvailable =>
      $js.chrome.notificationsNullable != null && alwaysTrue;

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
  Future<String> create(
    String? notificationId,
    NotificationOptions options,
  ) async {
    var $res =
        await $js.chrome.notifications
            .create(notificationId, options.toJS)
            .toDart;
    return ($res).dartify() as String? ?? '';
  }

  /// Updates an existing notification.
  /// |notificationId|: The id of the notification to be updated. This is
  /// returned by [notifications.create] method.
  /// |options|: Contents of the notification to update to.
  /// |callback|: Called to indicate whether a matching notification existed.
  ///
  /// The callback is required before Chrome 42.
  Future<bool> update(
    String notificationId,
    NotificationOptions options,
  ) async {
    var $res =
        await $js.chrome.notifications
            .update(notificationId, options.toJS)
            .toDart;
    return ($res).dartify() as bool? ?? false;
  }

  /// Clears the specified notification.
  /// |notificationId|: The id of the notification to be cleared. This is
  /// returned by [notifications.create] method.
  /// |callback|: Called to indicate whether a matching notification existed.
  ///
  /// The callback is required before Chrome 42.
  Future<bool> clear(String notificationId) async {
    var $res = await $js.chrome.notifications.clear(notificationId).toDart;
    return ($res).dartify() as bool? ?? false;
  }

  /// Retrieves all the notifications of this app or extension.
  /// |callback|: Returns the set of notification_ids currently in the system.
  Future<Map> getAll() async {
    var $res = await $js.chrome.notifications.getAll().toDart;
    return ($res).dartify() as Map? ?? {};
  }

  /// Retrieves whether the user has enabled notifications from this app
  /// or extension.
  /// |callback|: Returns the current permission level.
  Future<PermissionLevel> getPermissionLevel() async {
    var $res = await $js.chrome.notifications.getPermissionLevel().toDart;
    return PermissionLevel.fromJS($res! as $js.PermissionLevel);
  }

  /// The notification closed, either by the system or by user action.
  EventStream<OnClosedEvent> get onClosed =>
      $js.chrome.notifications.onClosed.asStream(
        ($c) =>
            (String notificationId, bool byUser) {
              return $c(
                OnClosedEvent(notificationId: notificationId, byUser: byUser),
              );
            }.toJS,
      );

  /// The user clicked in a non-button area of the notification.
  EventStream<String> get onClicked =>
      $js.chrome.notifications.onClicked.asStream(
        ($c) =>
            (String notificationId) {
              return $c(notificationId);
            }.toJS,
      );

  /// The user pressed a button in the notification.
  EventStream<OnButtonClickedEvent> get onButtonClicked =>
      $js.chrome.notifications.onButtonClicked.asStream(
        ($c) =>
            (String notificationId, int buttonIndex) {
              return $c(
                OnButtonClickedEvent(
                  notificationId: notificationId,
                  buttonIndex: buttonIndex,
                ),
              );
            }.toJS,
      );

  /// The user changes the permission level.  As of Chrome 47, only ChromeOS
  /// has UI that dispatches this event.
  EventStream<PermissionLevel> get onPermissionLevelChanged =>
      $js.chrome.notifications.onPermissionLevelChanged.asStream(
        ($c) =>
            ($js.PermissionLevel level) {
              return $c(PermissionLevel.fromJS(level));
            }.toJS,
      );

  /// The user clicked on a link for the app's notification settings.  As of
  /// Chrome 47, only ChromeOS has UI that dispatches this event.
  /// As of Chrome 65, that UI has been removed from ChromeOS, too.
  EventStream<void> get onShowSettings =>
      $js.chrome.notifications.onShowSettings.asStream(
        ($c) =>
            () {
              return $c(null);
            }.toJS,
      );
}

enum TemplateType {
  /// Contains an icon, title, message, expandedMessage, and up to two
  /// buttons.
  basic('basic'),

  /// Contains an icon, title, message, expandedMessage, image, and up
  ///  to two buttons.
  image('image'),

  /// Contains an icon, title, message, items, and up to two buttons.
  /// Users on Mac OS X only see the first item.
  list('list'),

  /// Contains an icon, title, message, progress, and up to two buttons.
  progress('progress');

  const TemplateType(this.value);

  final String value;

  JSString get toJS => value.toJS;
  static TemplateType fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

enum PermissionLevel {
  /// Specifies that the user has elected to show notifications
  /// from the app or extension. This is the default at install time.
  granted('granted'),

  /// Specifies that the user has elected not to show notifications
  /// from the app or extension.
  denied('denied');

  const PermissionLevel(this.value);

  final String value;

  JSString get toJS => value.toJS;
  static PermissionLevel fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

class NotificationItem {
  NotificationItem.fromJS(this._wrapped);

  NotificationItem({
    /// Title of one item of a list notification.
    required String title,

    /// Additional details about this item.
    required String message,
  }) : _wrapped = $js.NotificationItem(title: title, message: message);

  final $js.NotificationItem _wrapped;

  $js.NotificationItem get toJS => _wrapped;

  /// Title of one item of a list notification.
  String get title => _wrapped.title;

  set title(String v) {
    _wrapped.title = v;
  }

  /// Additional details about this item.
  String get message => _wrapped.message;

  set message(String v) {
    _wrapped.message = v;
  }
}

class NotificationBitmap {
  NotificationBitmap.fromJS(this._wrapped);

  NotificationBitmap({
    required int width,
    required int height,
    ByteBuffer? data,
  }) : _wrapped = $js.NotificationBitmap(
         width: width,
         height: height,
         data: data?.toJS,
       );

  final $js.NotificationBitmap _wrapped;

  $js.NotificationBitmap get toJS => _wrapped;

  int get width => _wrapped.width;

  set width(int v) {
    _wrapped.width = v;
  }

  int get height => _wrapped.height;

  set height(int v) {
    _wrapped.height = v;
  }

  ByteBuffer? get data => _wrapped.data?.toDart;

  set data(ByteBuffer? v) {
    _wrapped.data = v?.toJS;
  }
}

class NotificationButton {
  NotificationButton.fromJS(this._wrapped);

  NotificationButton({
    required String title,
    String? iconUrl,
    NotificationBitmap? iconBitmap,
  }) : _wrapped = $js.NotificationButton(
         title: title,
         iconUrl: iconUrl,
         iconBitmap: iconBitmap?.toJS,
       );

  final $js.NotificationButton _wrapped;

  $js.NotificationButton get toJS => _wrapped;

  String get title => _wrapped.title;

  set title(String v) {
    _wrapped.title = v;
  }

  String? get iconUrl => _wrapped.iconUrl;

  set iconUrl(String? v) {
    _wrapped.iconUrl = v;
  }

  NotificationBitmap? get iconBitmap =>
      _wrapped.iconBitmap?.let(NotificationBitmap.fromJS);

  set iconBitmap(NotificationBitmap? v) {
    _wrapped.iconBitmap = v?.toJS;
  }
}

class NotificationOptions {
  NotificationOptions.fromJS(this._wrapped);

  NotificationOptions({
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
    List<NotificationButton>? buttons,

    /// Secondary notification content.
    String? expandedMessage,

    /// A URL to the image thumbnail for image-type notifications.
    /// URLs have the same restrictions as
    /// $(ref:notifications.NotificationOptions.iconUrl iconUrl).
    String? imageUrl,
    NotificationBitmap? imageBitmap,

    /// Items for multi-item notifications. Users on Mac OS X only see the first
    /// item.
    List<NotificationItem>? items,

    /// Current progress ranges from 0 to 100.
    int? progress,
    bool? isClickable,

    /// Indicates that the notification should remain visible on screen until
    /// the
    /// user activates or dismisses the notification. This defaults to false.
    bool? requireInteraction,

    /// Indicates that no sounds or vibrations should be made when the
    /// notification is being shown. This defaults to false.
    bool? silent,
  }) : _wrapped = $js.NotificationOptions(
         type: type?.toJS,
         iconUrl: iconUrl,
         iconBitmap: iconBitmap?.toJS,
         appIconMaskUrl: appIconMaskUrl,
         appIconMaskBitmap: appIconMaskBitmap?.toJS,
         title: title,
         message: message,
         contextMessage: contextMessage,
         priority: priority,
         eventTime: eventTime,
         buttons: buttons?.toJSArray((e) => e.toJS),
         expandedMessage: expandedMessage,
         imageUrl: imageUrl,
         imageBitmap: imageBitmap?.toJS,
         items: items?.toJSArray((e) => e.toJS),
         progress: progress,
         isClickable: isClickable,
         requireInteraction: requireInteraction,
         silent: silent,
       );

  final $js.NotificationOptions _wrapped;

  $js.NotificationOptions get toJS => _wrapped;

  /// Which type of notification to display.
  /// _Required for [notifications.create]_ method.
  TemplateType? get type => _wrapped.type?.let(TemplateType.fromJS);

  set type(TemplateType? v) {
    _wrapped.type = v?.toJS;
  }

  /// A URL to the sender's avatar, app icon, or a thumbnail for image
  /// notifications.
  ///
  /// URLs can be a data URL, a blob URL, or a URL relative to a resource
  /// within this extension's .crx file
  /// _Required for [notifications.create]_ method.
  String? get iconUrl => _wrapped.iconUrl;

  set iconUrl(String? v) {
    _wrapped.iconUrl = v;
  }

  NotificationBitmap? get iconBitmap =>
      _wrapped.iconBitmap?.let(NotificationBitmap.fromJS);

  set iconBitmap(NotificationBitmap? v) {
    _wrapped.iconBitmap = v?.toJS;
  }

  /// A URL to the app icon mask. URLs have the same restrictions as
  /// $(ref:notifications.NotificationOptions.iconUrl iconUrl).
  ///
  /// The app icon mask should be in alpha channel, as only the alpha channel
  /// of the image will be considered.
  String? get appIconMaskUrl => _wrapped.appIconMaskUrl;

  set appIconMaskUrl(String? v) {
    _wrapped.appIconMaskUrl = v;
  }

  NotificationBitmap? get appIconMaskBitmap =>
      _wrapped.appIconMaskBitmap?.let(NotificationBitmap.fromJS);

  set appIconMaskBitmap(NotificationBitmap? v) {
    _wrapped.appIconMaskBitmap = v?.toJS;
  }

  /// Title of the notification (e.g. sender name for email).
  /// _Required for [notifications.create]_ method.
  String? get title => _wrapped.title;

  set title(String? v) {
    _wrapped.title = v;
  }

  /// Main notification content.
  /// _Required for [notifications.create]_ method.
  String? get message => _wrapped.message;

  set message(String? v) {
    _wrapped.message = v;
  }

  /// Alternate notification content with a lower-weight font.
  String? get contextMessage => _wrapped.contextMessage;

  set contextMessage(String? v) {
    _wrapped.contextMessage = v;
  }

  /// Priority ranges from -2 to 2. -2 is lowest priority. 2 is highest. Zero
  /// is default.  On platforms that don't support a notification center
  /// (Windows, Linux & Mac), -2 and -1 result in an error as notifications
  /// with those priorities will not be shown at all.
  int? get priority => _wrapped.priority;

  set priority(int? v) {
    _wrapped.priority = v;
  }

  /// A timestamp associated with the notification, in milliseconds past the
  /// epoch (e.g. `Date.now() + n`).
  double? get eventTime => _wrapped.eventTime;

  set eventTime(double? v) {
    _wrapped.eventTime = v;
  }

  /// Text and icons for up to two notification action buttons.
  List<NotificationButton>? get buttons =>
      _wrapped.buttons?.toDart
          .cast<$js.NotificationButton>()
          .map((e) => NotificationButton.fromJS(e))
          .toList();

  set buttons(List<NotificationButton>? v) {
    _wrapped.buttons = v?.toJSArray((e) => e.toJS);
  }

  /// Secondary notification content.
  String? get expandedMessage => _wrapped.expandedMessage;

  set expandedMessage(String? v) {
    _wrapped.expandedMessage = v;
  }

  /// A URL to the image thumbnail for image-type notifications.
  /// URLs have the same restrictions as
  /// $(ref:notifications.NotificationOptions.iconUrl iconUrl).
  String? get imageUrl => _wrapped.imageUrl;

  set imageUrl(String? v) {
    _wrapped.imageUrl = v;
  }

  NotificationBitmap? get imageBitmap =>
      _wrapped.imageBitmap?.let(NotificationBitmap.fromJS);

  set imageBitmap(NotificationBitmap? v) {
    _wrapped.imageBitmap = v?.toJS;
  }

  /// Items for multi-item notifications. Users on Mac OS X only see the first
  /// item.
  List<NotificationItem>? get items =>
      _wrapped.items?.toDart
          .cast<$js.NotificationItem>()
          .map((e) => NotificationItem.fromJS(e))
          .toList();

  set items(List<NotificationItem>? v) {
    _wrapped.items = v?.toJSArray((e) => e.toJS);
  }

  /// Current progress ranges from 0 to 100.
  int? get progress => _wrapped.progress;

  set progress(int? v) {
    _wrapped.progress = v;
  }

  bool? get isClickable => _wrapped.isClickable;

  set isClickable(bool? v) {
    _wrapped.isClickable = v;
  }

  /// Indicates that the notification should remain visible on screen until the
  /// user activates or dismisses the notification. This defaults to false.
  bool? get requireInteraction => _wrapped.requireInteraction;

  set requireInteraction(bool? v) {
    _wrapped.requireInteraction = v;
  }

  /// Indicates that no sounds or vibrations should be made when the
  /// notification is being shown. This defaults to false.
  bool? get silent => _wrapped.silent;

  set silent(bool? v) {
    _wrapped.silent = v;
  }
}

class OnClosedEvent {
  OnClosedEvent({required this.notificationId, required this.byUser});

  final String notificationId;

  final bool byUser;
}

class OnButtonClickedEvent {
  OnButtonClickedEvent({
    required this.notificationId,
    required this.buttonIndex,
  });

  final String notificationId;

  final int buttonIndex;
}
