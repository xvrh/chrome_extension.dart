// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'src/internal_helpers.dart';
import 'src/js/browsing_data.dart' as $js;

export 'src/chrome.dart' show chrome;

final _browsingData = ChromeBrowsingData._();

extension ChromeBrowsingDataExtension on Chrome {
  /// Use the `chrome.browsingData` API to remove browsing data from a user's
  /// local profile.
  ChromeBrowsingData get browsingData => _browsingData;
}

class ChromeBrowsingData {
  ChromeBrowsingData._();

  bool get isAvailable => $js.chrome.browsingDataNullable != null && alwaysTrue;

  /// Reports which types of data are currently selected in the 'Clear browsing
  /// data' settings UI.  Note: some of the data types included in this API are
  /// not available in the settings UI, and some UI settings control more than
  /// one data type listed here.
  Future<SettingsCallbackResult> settings() async {
    var $res = await promiseToFuture<$js.SettingsCallbackResult>(
        $js.chrome.browsingData.settings());
    return SettingsCallbackResult.fromJS($res);
  }

  /// Clears various types of browsing data stored in a user's profile.
  /// [dataToRemove] The set of data types to remove.
  /// [returns] Called when deletion has completed.
  Future<void> remove(
    RemovalOptions options,
    DataTypeSet dataToRemove,
  ) async {
    await promiseToFuture<void>($js.chrome.browsingData.remove(
      options.toJS,
      dataToRemove.toJS,
    ));
  }

  /// Clears websites' appcache data.
  /// [returns] Called when websites' appcache data has been cleared.
  Future<void> removeAppcache(RemovalOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.browsingData.removeAppcache(options.toJS));
  }

  /// Clears the browser's cache.
  /// [returns] Called when the browser's cache has been cleared.
  Future<void> removeCache(RemovalOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.browsingData.removeCache(options.toJS));
  }

  /// Clears websites' cache storage data.
  /// [returns] Called when websites' cache storage has been cleared.
  Future<void> removeCacheStorage(RemovalOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.browsingData.removeCacheStorage(options.toJS));
  }

  /// Clears the browser's cookies and server-bound certificates modified within
  /// a particular timeframe.
  /// [returns] Called when the browser's cookies and server-bound
  /// certificates have been cleared.
  Future<void> removeCookies(RemovalOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.browsingData.removeCookies(options.toJS));
  }

  /// Clears the browser's list of downloaded files (_not_ the downloaded files
  /// themselves).
  /// [returns] Called when the browser's list of downloaded files has been
  /// cleared.
  Future<void> removeDownloads(RemovalOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.browsingData.removeDownloads(options.toJS));
  }

  /// Clears websites' file system data.
  /// [returns] Called when websites' file systems have been cleared.
  Future<void> removeFileSystems(RemovalOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.browsingData.removeFileSystems(options.toJS));
  }

  /// Clears the browser's stored form data (autofill).
  /// [returns] Called when the browser's form data has been cleared.
  Future<void> removeFormData(RemovalOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.browsingData.removeFormData(options.toJS));
  }

  /// Clears the browser's history.
  /// [returns] Called when the browser's history has cleared.
  Future<void> removeHistory(RemovalOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.browsingData.removeHistory(options.toJS));
  }

  /// Clears websites' IndexedDB data.
  /// [returns] Called when websites' IndexedDB data has been cleared.
  Future<void> removeIndexedDB(RemovalOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.browsingData.removeIndexedDB(options.toJS));
  }

  /// Clears websites' local storage data.
  /// [returns] Called when websites' local storage has been cleared.
  Future<void> removeLocalStorage(RemovalOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.browsingData.removeLocalStorage(options.toJS));
  }

  /// Clears plugins' data.
  /// [returns] Called when plugins' data has been cleared.
  @Deprecated(
      r'Support for Flash has been removed. This function has no effect.')
  Future<void> removePluginData(RemovalOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.browsingData.removePluginData(options.toJS));
  }

  /// Clears the browser's stored passwords.
  /// [returns] Called when the browser's passwords have been cleared.
  Future<void> removePasswords(RemovalOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.browsingData.removePasswords(options.toJS));
  }

  /// Clears websites' service workers.
  /// [returns] Called when websites' service workers have been cleared.
  Future<void> removeServiceWorkers(RemovalOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.browsingData.removeServiceWorkers(options.toJS));
  }

  /// Clears websites' WebSQL data.
  /// [returns] Called when websites' WebSQL databases have been cleared.
  Future<void> removeWebSQL(RemovalOptions options) async {
    await promiseToFuture<void>(
        $js.chrome.browsingData.removeWebSQL(options.toJS));
  }
}

class RemovalOptions {
  RemovalOptions.fromJS(this._wrapped);

  RemovalOptions({
    /// Remove data accumulated on or after this date, represented in
    /// milliseconds since the epoch (accessible via the `getTime` method of the
    /// JavaScript `Date` object). If absent, defaults to 0 (which would remove
    /// all browsing data).
    double? since,

    /// An object whose properties specify which origin types ought to be
    /// cleared. If this object isn't specified, it defaults to clearing only
    /// "unprotected" origins. Please ensure that you _really_ want to remove
    /// application data before adding 'protectedWeb' or 'extensions'.
    RemovalOptionsOriginTypes? originTypes,

    /// When present, only data for origins in this list is deleted. Only
    /// supported for cookies, storage and cache. Cookies are cleared for the
    /// whole registrable domain.
    List<String>? origins,

    /// When present, data for origins in this list is excluded from deletion.
    /// Can't be used together with `origins`. Only supported for cookies,
    /// storage and cache.  Cookies are excluded for the whole registrable
    /// domain.
    List<String>? excludeOrigins,
  }) : _wrapped = $js.RemovalOptions(
          since: since,
          originTypes: originTypes?.toJS,
          origins: origins?.toJSArray((e) => e),
          excludeOrigins: excludeOrigins?.toJSArray((e) => e),
        );

  final $js.RemovalOptions _wrapped;

  $js.RemovalOptions get toJS => _wrapped;

  /// Remove data accumulated on or after this date, represented in milliseconds
  /// since the epoch (accessible via the `getTime` method of the JavaScript
  /// `Date` object). If absent, defaults to 0 (which would remove all browsing
  /// data).
  double? get since => _wrapped.since;
  set since(double? v) {
    _wrapped.since = v;
  }

  /// An object whose properties specify which origin types ought to be cleared.
  /// If this object isn't specified, it defaults to clearing only "unprotected"
  /// origins. Please ensure that you _really_ want to remove application data
  /// before adding 'protectedWeb' or 'extensions'.
  RemovalOptionsOriginTypes? get originTypes =>
      _wrapped.originTypes?.let(RemovalOptionsOriginTypes.fromJS);
  set originTypes(RemovalOptionsOriginTypes? v) {
    _wrapped.originTypes = v?.toJS;
  }

  /// When present, only data for origins in this list is deleted. Only
  /// supported for cookies, storage and cache. Cookies are cleared for the
  /// whole registrable domain.
  List<String>? get origins =>
      _wrapped.origins?.toDart.cast<String>().map((e) => e).toList();
  set origins(List<String>? v) {
    _wrapped.origins = v?.toJSArray((e) => e);
  }

  /// When present, data for origins in this list is excluded from deletion.
  /// Can't be used together with `origins`. Only supported for cookies, storage
  /// and cache.  Cookies are excluded for the whole registrable domain.
  List<String>? get excludeOrigins =>
      _wrapped.excludeOrigins?.toDart.cast<String>().map((e) => e).toList();
  set excludeOrigins(List<String>? v) {
    _wrapped.excludeOrigins = v?.toJSArray((e) => e);
  }
}

class DataTypeSet {
  DataTypeSet.fromJS(this._wrapped);

  DataTypeSet({
    /// Websites' appcaches.
    bool? appcache,

    /// The browser's cache.
    bool? cache,

    /// Cache storage
    bool? cacheStorage,

    /// The browser's cookies.
    bool? cookies,

    /// The browser's download list.
    bool? downloads,

    /// Websites' file systems.
    bool? fileSystems,

    /// The browser's stored form data.
    bool? formData,

    /// The browser's history.
    bool? history,

    /// Websites' IndexedDB data.
    bool? indexedDb,

    /// Websites' local storage data.
    bool? localStorage,

    /// Server-bound certificates.
    bool? serverBoundCertificates,

    /// Stored passwords.
    bool? passwords,

    /// Plugins' data.
    bool? pluginData,

    /// Service Workers.
    bool? serviceWorkers,

    /// Websites' WebSQL data.
    bool? webSql,
  }) : _wrapped = $js.DataTypeSet(
          appcache: appcache,
          cache: cache,
          cacheStorage: cacheStorage,
          cookies: cookies,
          downloads: downloads,
          fileSystems: fileSystems,
          formData: formData,
          history: history,
          indexedDB: indexedDb,
          localStorage: localStorage,
          serverBoundCertificates: serverBoundCertificates,
          passwords: passwords,
          pluginData: pluginData,
          serviceWorkers: serviceWorkers,
          webSQL: webSql,
        );

  final $js.DataTypeSet _wrapped;

  $js.DataTypeSet get toJS => _wrapped;

  /// Websites' appcaches.
  bool? get appcache => _wrapped.appcache;
  set appcache(bool? v) {
    _wrapped.appcache = v;
  }

  /// The browser's cache.
  bool? get cache => _wrapped.cache;
  set cache(bool? v) {
    _wrapped.cache = v;
  }

  /// Cache storage
  bool? get cacheStorage => _wrapped.cacheStorage;
  set cacheStorage(bool? v) {
    _wrapped.cacheStorage = v;
  }

  /// The browser's cookies.
  bool? get cookies => _wrapped.cookies;
  set cookies(bool? v) {
    _wrapped.cookies = v;
  }

  /// The browser's download list.
  bool? get downloads => _wrapped.downloads;
  set downloads(bool? v) {
    _wrapped.downloads = v;
  }

  /// Websites' file systems.
  bool? get fileSystems => _wrapped.fileSystems;
  set fileSystems(bool? v) {
    _wrapped.fileSystems = v;
  }

  /// The browser's stored form data.
  bool? get formData => _wrapped.formData;
  set formData(bool? v) {
    _wrapped.formData = v;
  }

  /// The browser's history.
  bool? get history => _wrapped.history;
  set history(bool? v) {
    _wrapped.history = v;
  }

  /// Websites' IndexedDB data.
  bool? get indexedDb => _wrapped.indexedDB;
  set indexedDb(bool? v) {
    _wrapped.indexedDB = v;
  }

  /// Websites' local storage data.
  bool? get localStorage => _wrapped.localStorage;
  set localStorage(bool? v) {
    _wrapped.localStorage = v;
  }

  /// Server-bound certificates.
  bool? get serverBoundCertificates => _wrapped.serverBoundCertificates;
  set serverBoundCertificates(bool? v) {
    _wrapped.serverBoundCertificates = v;
  }

  /// Stored passwords.
  bool? get passwords => _wrapped.passwords;
  set passwords(bool? v) {
    _wrapped.passwords = v;
  }

  /// Plugins' data.
  bool? get pluginData => _wrapped.pluginData;
  set pluginData(bool? v) {
    _wrapped.pluginData = v;
  }

  /// Service Workers.
  bool? get serviceWorkers => _wrapped.serviceWorkers;
  set serviceWorkers(bool? v) {
    _wrapped.serviceWorkers = v;
  }

  /// Websites' WebSQL data.
  bool? get webSql => _wrapped.webSQL;
  set webSql(bool? v) {
    _wrapped.webSQL = v;
  }
}

class SettingsCallbackResult {
  SettingsCallbackResult.fromJS(this._wrapped);

  SettingsCallbackResult({
    required RemovalOptions options,

    /// All of the types will be present in the result, with values of `true` if
    /// they are both selected to be removed and permitted to be removed,
    /// otherwise `false`.
    required DataTypeSet dataToRemove,

    /// All of the types will be present in the result, with values of `true` if
    /// they are permitted to be removed (e.g., by enterprise policy) and
    /// `false` if not.
    required DataTypeSet dataRemovalPermitted,
  }) : _wrapped = $js.SettingsCallbackResult(
          options: options.toJS,
          dataToRemove: dataToRemove.toJS,
          dataRemovalPermitted: dataRemovalPermitted.toJS,
        );

  final $js.SettingsCallbackResult _wrapped;

  $js.SettingsCallbackResult get toJS => _wrapped;

  RemovalOptions get options => RemovalOptions.fromJS(_wrapped.options);
  set options(RemovalOptions v) {
    _wrapped.options = v.toJS;
  }

  /// All of the types will be present in the result, with values of `true` if
  /// they are both selected to be removed and permitted to be removed,
  /// otherwise `false`.
  DataTypeSet get dataToRemove => DataTypeSet.fromJS(_wrapped.dataToRemove);
  set dataToRemove(DataTypeSet v) {
    _wrapped.dataToRemove = v.toJS;
  }

  /// All of the types will be present in the result, with values of `true` if
  /// they are permitted to be removed (e.g., by enterprise policy) and `false`
  /// if not.
  DataTypeSet get dataRemovalPermitted =>
      DataTypeSet.fromJS(_wrapped.dataRemovalPermitted);
  set dataRemovalPermitted(DataTypeSet v) {
    _wrapped.dataRemovalPermitted = v.toJS;
  }
}

class RemovalOptionsOriginTypes {
  RemovalOptionsOriginTypes.fromJS(this._wrapped);

  RemovalOptionsOriginTypes({
    /// Normal websites.
    bool? unprotectedWeb,

    /// Websites that have been installed as hosted applications (be careful!).
    bool? protectedWeb,

    /// Extensions and packaged applications a user has installed (be _really_
    /// careful!).
    bool? extension,
  }) : _wrapped = $js.RemovalOptionsOriginTypes(
          unprotectedWeb: unprotectedWeb,
          protectedWeb: protectedWeb,
          extension: extension,
        );

  final $js.RemovalOptionsOriginTypes _wrapped;

  $js.RemovalOptionsOriginTypes get toJS => _wrapped;

  /// Normal websites.
  bool? get unprotectedWeb => _wrapped.unprotectedWeb;
  set unprotectedWeb(bool? v) {
    _wrapped.unprotectedWeb = v;
  }

  /// Websites that have been installed as hosted applications (be careful!).
  bool? get protectedWeb => _wrapped.protectedWeb;
  set protectedWeb(bool? v) {
    _wrapped.protectedWeb = v;
  }

  /// Extensions and packaged applications a user has installed (be _really_
  /// careful!).
  bool? get extension => _wrapped.extension;
  set extension(bool? v) {
    _wrapped.extension = v;
  }
}
