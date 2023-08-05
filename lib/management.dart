// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/management.dart' as $js;

export 'src/chrome.dart' show chrome;

final _management = ChromeManagement._();

extension ChromeManagementExtension on Chrome {
  /// The `chrome.management` API provides ways to manage the list of
  /// extensions/apps that are installed and running. It is particularly useful
  /// for extensions that [override](override) the built-in New Tab page.
  ChromeManagement get management => _management;
}

class ChromeManagement {
  ChromeManagement._();

  bool get isAvailable => $js.chrome.managementNullable != null && alwaysTrue;

  /// Returns a list of information about installed extensions and apps.
  Future<List<ExtensionInfo>> getAll() async {
    var $res = await promiseToFuture<JSArray>($js.chrome.management.getAll());
    return $res.toDart
        .cast<$js.ExtensionInfo>()
        .map((e) => ExtensionInfo.fromJS(e))
        .toList();
  }

  /// Returns information about the installed extension, app, or theme that has
  /// the given ID.
  /// [id] The ID from an item of [management.ExtensionInfo].
  Future<ExtensionInfo> get(String id) async {
    var $res =
        await promiseToFuture<$js.ExtensionInfo>($js.chrome.management.get(id));
    return ExtensionInfo.fromJS($res);
  }

  /// Returns information about the calling extension, app, or theme. Note: This
  /// function can be used without requesting the 'management' permission in the
  /// manifest.
  Future<ExtensionInfo> getSelf() async {
    var $res = await promiseToFuture<$js.ExtensionInfo>(
        $js.chrome.management.getSelf());
    return ExtensionInfo.fromJS($res);
  }

  /// Returns a list of [permission warnings](permission_warnings) for the given
  /// extension id.
  /// [id] The ID of an already installed extension.
  Future<List<String>> getPermissionWarningsById(String id) async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.management.getPermissionWarningsById(id));
    return $res.toDart.cast<String>().map((e) => e).toList();
  }

  /// Returns a list of [permission warnings](permission_warnings) for the given
  /// extension manifest string. Note: This function can be used without
  /// requesting the 'management' permission in the manifest.
  /// [manifestStr] Extension manifest JSON string.
  Future<List<String>> getPermissionWarningsByManifest(
      String manifestStr) async {
    var $res = await promiseToFuture<JSArray>(
        $js.chrome.management.getPermissionWarningsByManifest(manifestStr));
    return $res.toDart.cast<String>().map((e) => e).toList();
  }

  /// Enables or disables an app or extension. In most cases this function must
  /// be called in the context of a user gesture (e.g. an onclick handler for a
  /// button), and may present the user with a native confirmation UI as a way
  /// of preventing abuse.
  /// [id] This should be the id from an item of [management.ExtensionInfo].
  /// [enabled] Whether this item should be enabled or disabled.
  Future<void> setEnabled(
    String id,
    bool enabled,
  ) async {
    await promiseToFuture<void>($js.chrome.management.setEnabled(
      id,
      enabled,
    ));
  }

  /// Uninstalls a currently installed app or extension. Note: This function
  /// does not work in managed environments when the user is not allowed to
  /// uninstall the specified extension/app. If the uninstall fails (e.g. the
  /// user cancels the dialog) the promise will be rejected or the callback will
  /// be called with [runtime.lastError] set.
  /// [id] This should be the id from an item of [management.ExtensionInfo].
  Future<void> uninstall(
    String id,
    UninstallOptions? options,
  ) async {
    await promiseToFuture<void>($js.chrome.management.uninstall(
      id,
      options?.toJS,
    ));
  }

  /// Uninstalls the calling extension. Note: This function can be used without
  /// requesting the 'management' permission in the manifest. This function does
  /// not work in managed environments when the user is not allowed to uninstall
  /// the specified extension/app.
  Future<void> uninstallSelf(UninstallOptions? options) async {
    await promiseToFuture<void>(
        $js.chrome.management.uninstallSelf(options?.toJS));
  }

  /// Launches an application.
  /// [id] The extension id of the application.
  Future<void> launchApp(String id) async {
    await promiseToFuture<void>($js.chrome.management.launchApp(id));
  }

  /// Display options to create shortcuts for an app. On Mac, only packaged app
  /// shortcuts can be created.
  /// [id] This should be the id from an app item of
  /// [management.ExtensionInfo].
  Future<void> createAppShortcut(String id) async {
    await promiseToFuture<void>($js.chrome.management.createAppShortcut(id));
  }

  /// Set the launch type of an app.
  /// [id] This should be the id from an app item of
  /// [management.ExtensionInfo].
  /// [launchType] The target launch type. Always check and make sure this
  /// launch type is in [ExtensionInfo.availableLaunchTypes], because the
  /// available launch types vary on different platforms and configurations.
  Future<void> setLaunchType(
    String id,
    LaunchType launchType,
  ) async {
    await promiseToFuture<void>($js.chrome.management.setLaunchType(
      id,
      launchType.toJS,
    ));
  }

  /// Generate an app for a URL. Returns the generated bookmark app.
  /// [url] The URL of a web page. The scheme of the URL can only be "http" or
  /// "https".
  /// [title] The title of the generated app.
  Future<ExtensionInfo> generateAppForLink(
    String url,
    String title,
  ) async {
    var $res = await promiseToFuture<$js.ExtensionInfo>(
        $js.chrome.management.generateAppForLink(
      url,
      title,
    ));
    return ExtensionInfo.fromJS($res);
  }

  /// Checks if the replacement android app can be installed. Errors generated
  /// by this API are reported by setting [runtime.lastError] and executing the
  /// function's regular callback.
  Future<bool> canInstallReplacementAndroidApp() async {
    var $res = await promiseToFuture<bool>(
        $js.chrome.management.canInstallReplacementAndroidApp());
    return $res;
  }

  /// Prompts the user to install the replacement Android app from the manifest.
  /// Errors generated by this API are reported by setting [runtime.lastError]
  /// and executing the function's regular callback.
  Future<void> installReplacementAndroidApp() async {
    await promiseToFuture<void>(
        $js.chrome.management.installReplacementAndroidApp());
  }

  /// Launches the replacement_web_app specified in the manifest. Prompts the
  /// user to install if not already installed.
  Future<void> installReplacementWebApp() async {
    await promiseToFuture<void>(
        $js.chrome.management.installReplacementWebApp());
  }

  /// Fired when an app or extension has been installed.
  EventStream<ExtensionInfo> get onInstalled =>
      $js.chrome.management.onInstalled
          .asStream(($c) => ($js.ExtensionInfo info) {
                return $c(ExtensionInfo.fromJS(info));
              });

  /// Fired when an app or extension has been uninstalled.
  EventStream<String> get onUninstalled =>
      $js.chrome.management.onUninstalled.asStream(($c) => (String id) {
            return $c(id);
          });

  /// Fired when an app or extension has been enabled.
  EventStream<ExtensionInfo> get onEnabled => $js.chrome.management.onEnabled
      .asStream(($c) => ($js.ExtensionInfo info) {
            return $c(ExtensionInfo.fromJS(info));
          });

  /// Fired when an app or extension has been disabled.
  EventStream<ExtensionInfo> get onDisabled => $js.chrome.management.onDisabled
      .asStream(($c) => ($js.ExtensionInfo info) {
            return $c(ExtensionInfo.fromJS(info));
          });
}

/// These are all possible app launch types.
enum LaunchType {
  openAsRegularTab('OPEN_AS_REGULAR_TAB'),
  openAsPinnedTab('OPEN_AS_PINNED_TAB'),
  openAsWindow('OPEN_AS_WINDOW'),
  openFullScreen('OPEN_FULL_SCREEN');

  const LaunchType(this.value);

  final String value;

  String get toJS => value;
  static LaunchType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// A reason the item is disabled.
enum ExtensionDisabledReason {
  unknown('unknown'),
  permissionsIncrease('permissions_increase');

  const ExtensionDisabledReason(this.value);

  final String value;

  String get toJS => value;
  static ExtensionDisabledReason fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The type of this extension, app, or theme.
enum ExtensionType {
  extension('extension'),
  hostedApp('hosted_app'),
  packagedApp('packaged_app'),
  legacyPackagedApp('legacy_packaged_app'),
  theme('theme'),
  loginScreenExtension('login_screen_extension');

  const ExtensionType(this.value);

  final String value;

  String get toJS => value;
  static ExtensionType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// How the extension was installed. One of
/// [admin]: The extension was installed because of an administrative policy,
/// [development]: The extension was loaded unpacked in developer mode,
/// [normal]: The extension was installed normally via a .crx file,
/// [sideload]: The extension was installed by other software on the machine,
/// [other]: The extension was installed by other means.
enum ExtensionInstallType {
  admin('admin'),
  development('development'),
  normal('normal'),
  sideload('sideload'),
  other('other');

  const ExtensionInstallType(this.value);

  final String value;

  String get toJS => value;
  static ExtensionInstallType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class IconInfo {
  IconInfo.fromJS(this._wrapped);

  IconInfo({
    /// A number representing the width and height of the icon. Likely values
    /// include (but are not limited to) 128, 48, 24, and 16.
    required int size,

    /// The URL for this icon image. To display a grayscale version of the icon
    /// (to indicate that an extension is disabled, for example), append
    /// `?grayscale=true` to the URL.
    required String url,
  }) : _wrapped = $js.IconInfo(
          size: size,
          url: url,
        );

  final $js.IconInfo _wrapped;

  $js.IconInfo get toJS => _wrapped;

  /// A number representing the width and height of the icon. Likely values
  /// include (but are not limited to) 128, 48, 24, and 16.
  int get size => _wrapped.size;
  set size(int v) {
    _wrapped.size = v;
  }

  /// The URL for this icon image. To display a grayscale version of the icon
  /// (to indicate that an extension is disabled, for example), append
  /// `?grayscale=true` to the URL.
  String get url => _wrapped.url;
  set url(String v) {
    _wrapped.url = v;
  }
}

class ExtensionInfo {
  ExtensionInfo.fromJS(this._wrapped);

  ExtensionInfo({
    /// The extension's unique identifier.
    required String id,

    /// The name of this extension, app, or theme.
    required String name,

    /// A short version of the name of this extension, app, or theme.
    required String shortName,

    /// The description of this extension, app, or theme.
    required String description,

    /// The [version](manifest/version) of this extension, app, or theme.
    required String version,

    /// The [version name](manifest/version#version_name) of this extension,
    /// app, or theme if the manifest specified one.
    String? versionName,

    /// Whether this extension can be disabled or uninstalled by the user.
    required bool mayDisable,

    /// Whether this extension can be enabled by the user. This is only returned
    /// for extensions which are not enabled.
    bool? mayEnable,

    /// Whether it is currently enabled or disabled.
    required bool enabled,

    /// A reason the item is disabled.
    ExtensionDisabledReason? disabledReason,

    /// True if this is an app.
    required bool isApp,

    /// The type of this extension, app, or theme.
    required ExtensionType type,

    /// The launch url (only present for apps).
    String? appLaunchUrl,

    /// The URL of the homepage of this extension, app, or theme.
    String? homepageUrl,

    /// The update URL of this extension, app, or theme.
    String? updateUrl,

    /// Whether the extension, app, or theme declares that it supports offline.
    required bool offlineEnabled,

    /// The url for the item's options page, if it has one.
    required String optionsUrl,

    /// A list of icon information. Note that this just reflects what was
    /// declared in the manifest, and the actual image at that url may be larger
    /// or smaller than what was declared, so you might consider using explicit
    /// width and height attributes on img tags referencing these images. See
    /// the [manifest documentation on icons](manifest/icons) for more details.
    List<IconInfo>? icons,

    /// Returns a list of API based permissions.
    required List<String> permissions,

    /// Returns a list of host based permissions.
    required List<String> hostPermissions,

    /// How the extension was installed.
    required ExtensionInstallType installType,

    /// The app launch type (only present for apps).
    LaunchType? launchType,

    /// The currently available launch types (only present for apps).
    List<LaunchType>? availableLaunchTypes,
  }) : _wrapped = $js.ExtensionInfo(
          id: id,
          name: name,
          shortName: shortName,
          description: description,
          version: version,
          versionName: versionName,
          mayDisable: mayDisable,
          mayEnable: mayEnable,
          enabled: enabled,
          disabledReason: disabledReason?.toJS,
          isApp: isApp,
          type: type.toJS,
          appLaunchUrl: appLaunchUrl,
          homepageUrl: homepageUrl,
          updateUrl: updateUrl,
          offlineEnabled: offlineEnabled,
          optionsUrl: optionsUrl,
          icons: icons?.toJSArray((e) => e.toJS),
          permissions: permissions.toJSArray((e) => e),
          hostPermissions: hostPermissions.toJSArray((e) => e),
          installType: installType.toJS,
          launchType: launchType?.toJS,
          availableLaunchTypes: availableLaunchTypes?.toJSArray((e) => e.toJS),
        );

  final $js.ExtensionInfo _wrapped;

  $js.ExtensionInfo get toJS => _wrapped;

  /// The extension's unique identifier.
  String get id => _wrapped.id;
  set id(String v) {
    _wrapped.id = v;
  }

  /// The name of this extension, app, or theme.
  String get name => _wrapped.name;
  set name(String v) {
    _wrapped.name = v;
  }

  /// A short version of the name of this extension, app, or theme.
  String get shortName => _wrapped.shortName;
  set shortName(String v) {
    _wrapped.shortName = v;
  }

  /// The description of this extension, app, or theme.
  String get description => _wrapped.description;
  set description(String v) {
    _wrapped.description = v;
  }

  /// The [version](manifest/version) of this extension, app, or theme.
  String get version => _wrapped.version;
  set version(String v) {
    _wrapped.version = v;
  }

  /// The [version name](manifest/version#version_name) of this extension, app,
  /// or theme if the manifest specified one.
  String? get versionName => _wrapped.versionName;
  set versionName(String? v) {
    _wrapped.versionName = v;
  }

  /// Whether this extension can be disabled or uninstalled by the user.
  bool get mayDisable => _wrapped.mayDisable;
  set mayDisable(bool v) {
    _wrapped.mayDisable = v;
  }

  /// Whether this extension can be enabled by the user. This is only returned
  /// for extensions which are not enabled.
  bool? get mayEnable => _wrapped.mayEnable;
  set mayEnable(bool? v) {
    _wrapped.mayEnable = v;
  }

  /// Whether it is currently enabled or disabled.
  bool get enabled => _wrapped.enabled;
  set enabled(bool v) {
    _wrapped.enabled = v;
  }

  /// A reason the item is disabled.
  ExtensionDisabledReason? get disabledReason =>
      _wrapped.disabledReason?.let(ExtensionDisabledReason.fromJS);
  set disabledReason(ExtensionDisabledReason? v) {
    _wrapped.disabledReason = v?.toJS;
  }

  /// True if this is an app.
  bool get isApp => _wrapped.isApp;
  set isApp(bool v) {
    _wrapped.isApp = v;
  }

  /// The type of this extension, app, or theme.
  ExtensionType get type => ExtensionType.fromJS(_wrapped.type);
  set type(ExtensionType v) {
    _wrapped.type = v.toJS;
  }

  /// The launch url (only present for apps).
  String? get appLaunchUrl => _wrapped.appLaunchUrl;
  set appLaunchUrl(String? v) {
    _wrapped.appLaunchUrl = v;
  }

  /// The URL of the homepage of this extension, app, or theme.
  String? get homepageUrl => _wrapped.homepageUrl;
  set homepageUrl(String? v) {
    _wrapped.homepageUrl = v;
  }

  /// The update URL of this extension, app, or theme.
  String? get updateUrl => _wrapped.updateUrl;
  set updateUrl(String? v) {
    _wrapped.updateUrl = v;
  }

  /// Whether the extension, app, or theme declares that it supports offline.
  bool get offlineEnabled => _wrapped.offlineEnabled;
  set offlineEnabled(bool v) {
    _wrapped.offlineEnabled = v;
  }

  /// The url for the item's options page, if it has one.
  String get optionsUrl => _wrapped.optionsUrl;
  set optionsUrl(String v) {
    _wrapped.optionsUrl = v;
  }

  /// A list of icon information. Note that this just reflects what was declared
  /// in the manifest, and the actual image at that url may be larger or smaller
  /// than what was declared, so you might consider using explicit width and
  /// height attributes on img tags referencing these images. See the [manifest
  /// documentation on icons](manifest/icons) for more details.
  List<IconInfo>? get icons => _wrapped.icons?.toDart
      .cast<$js.IconInfo>()
      .map((e) => IconInfo.fromJS(e))
      .toList();
  set icons(List<IconInfo>? v) {
    _wrapped.icons = v?.toJSArray((e) => e.toJS);
  }

  /// Returns a list of API based permissions.
  List<String> get permissions =>
      _wrapped.permissions.toDart.cast<String>().map((e) => e).toList();
  set permissions(List<String> v) {
    _wrapped.permissions = v.toJSArray((e) => e);
  }

  /// Returns a list of host based permissions.
  List<String> get hostPermissions =>
      _wrapped.hostPermissions.toDart.cast<String>().map((e) => e).toList();
  set hostPermissions(List<String> v) {
    _wrapped.hostPermissions = v.toJSArray((e) => e);
  }

  /// How the extension was installed.
  ExtensionInstallType get installType =>
      ExtensionInstallType.fromJS(_wrapped.installType);
  set installType(ExtensionInstallType v) {
    _wrapped.installType = v.toJS;
  }

  /// The app launch type (only present for apps).
  LaunchType? get launchType => _wrapped.launchType?.let(LaunchType.fromJS);
  set launchType(LaunchType? v) {
    _wrapped.launchType = v?.toJS;
  }

  /// The currently available launch types (only present for apps).
  List<LaunchType>? get availableLaunchTypes =>
      _wrapped.availableLaunchTypes?.toDart
          .cast<$js.LaunchType>()
          .map((e) => LaunchType.fromJS(e))
          .toList();
  set availableLaunchTypes(List<LaunchType>? v) {
    _wrapped.availableLaunchTypes = v?.toJSArray((e) => e.toJS);
  }
}

class UninstallOptions {
  UninstallOptions.fromJS(this._wrapped);

  UninstallOptions(
      {
      /// Whether or not a confirm-uninstall dialog should prompt the user.
      /// Defaults to false for self uninstalls. If an extension uninstalls
      /// another extension, this parameter is ignored and the dialog is always
      /// shown.
      bool? showConfirmDialog})
      : _wrapped = $js.UninstallOptions(showConfirmDialog: showConfirmDialog);

  final $js.UninstallOptions _wrapped;

  $js.UninstallOptions get toJS => _wrapped;

  /// Whether or not a confirm-uninstall dialog should prompt the user. Defaults
  /// to false for self uninstalls. If an extension uninstalls another
  /// extension, this parameter is ignored and the dialog is always shown.
  bool? get showConfirmDialog => _wrapped.showConfirmDialog;
  set showConfirmDialog(bool? v) {
    _wrapped.showConfirmDialog = v;
  }
}
