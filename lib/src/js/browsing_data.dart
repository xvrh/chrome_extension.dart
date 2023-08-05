// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSBrowsingDataExtension on JSChrome {
  @JS('browsingData')
  external JSBrowsingData? get browsingDataNullable;

  /// Use the `chrome.browsingData` API to remove browsing data from a user's
  /// local profile.
  JSBrowsingData get browsingData {
    var browsingDataNullable = this.browsingDataNullable;
    if (browsingDataNullable == null) {
      throw ApiNotAvailableException('chrome.browsingData');
    }
    return browsingDataNullable;
  }
}

@JS()
@staticInterop
class JSBrowsingData {}

extension JSBrowsingDataExtension on JSBrowsingData {
  /// Reports which types of data are currently selected in the 'Clear browsing
  /// data' settings UI.  Note: some of the data types included in this API are
  /// not available in the settings UI, and some UI settings control more than
  /// one data type listed here.
  external JSPromise settings();

  /// Clears various types of browsing data stored in a user's profile.
  external JSPromise remove(
    RemovalOptions options,

    /// The set of data types to remove.
    DataTypeSet dataToRemove,
  );

  /// Clears websites' appcache data.
  external JSPromise removeAppcache(RemovalOptions options);

  /// Clears the browser's cache.
  external JSPromise removeCache(RemovalOptions options);

  /// Clears websites' cache storage data.
  external JSPromise removeCacheStorage(RemovalOptions options);

  /// Clears the browser's cookies and server-bound certificates modified within
  /// a particular timeframe.
  external JSPromise removeCookies(RemovalOptions options);

  /// Clears the browser's list of downloaded files (_not_ the downloaded files
  /// themselves).
  external JSPromise removeDownloads(RemovalOptions options);

  /// Clears websites' file system data.
  external JSPromise removeFileSystems(RemovalOptions options);

  /// Clears the browser's stored form data (autofill).
  external JSPromise removeFormData(RemovalOptions options);

  /// Clears the browser's history.
  external JSPromise removeHistory(RemovalOptions options);

  /// Clears websites' IndexedDB data.
  external JSPromise removeIndexedDB(RemovalOptions options);

  /// Clears websites' local storage data.
  external JSPromise removeLocalStorage(RemovalOptions options);

  /// Clears plugins' data.
  @Deprecated(
      r'Support for Flash has been removed. This function has no effect.')
  external JSPromise removePluginData(RemovalOptions options);

  /// Clears the browser's stored passwords.
  external JSPromise removePasswords(RemovalOptions options);

  /// Clears websites' service workers.
  external JSPromise removeServiceWorkers(RemovalOptions options);

  /// Clears websites' WebSQL data.
  external JSPromise removeWebSQL(RemovalOptions options);
}

@JS()
@staticInterop
@anonymous
class RemovalOptions {
  external factory RemovalOptions({
    /// Remove data accumulated on or after this date, represented in milliseconds
    /// since the epoch (accessible via the `getTime` method of the JavaScript
    /// `Date` object). If absent, defaults to 0 (which would remove all browsing
    /// data).
    double? since,

    /// An object whose properties specify which origin types ought to be cleared.
    /// If this object isn't specified, it defaults to clearing only "unprotected"
    /// origins. Please ensure that you _really_ want to remove application data
    /// before adding 'protectedWeb' or 'extensions'.
    RemovalOptionsOriginTypes? originTypes,

    /// When present, only data for origins in this list is deleted. Only
    /// supported for cookies, storage and cache. Cookies are cleared for the
    /// whole registrable domain.
    JSArray? origins,

    /// When present, data for origins in this list is excluded from deletion.
    /// Can't be used together with `origins`. Only supported for cookies, storage
    /// and cache.  Cookies are excluded for the whole registrable domain.
    JSArray? excludeOrigins,
  });
}

extension RemovalOptionsExtension on RemovalOptions {
  /// Remove data accumulated on or after this date, represented in milliseconds
  /// since the epoch (accessible via the `getTime` method of the JavaScript
  /// `Date` object). If absent, defaults to 0 (which would remove all browsing
  /// data).
  external double? since;

  /// An object whose properties specify which origin types ought to be cleared.
  /// If this object isn't specified, it defaults to clearing only "unprotected"
  /// origins. Please ensure that you _really_ want to remove application data
  /// before adding 'protectedWeb' or 'extensions'.
  external RemovalOptionsOriginTypes? originTypes;

  /// When present, only data for origins in this list is deleted. Only
  /// supported for cookies, storage and cache. Cookies are cleared for the
  /// whole registrable domain.
  external JSArray? origins;

  /// When present, data for origins in this list is excluded from deletion.
  /// Can't be used together with `origins`. Only supported for cookies, storage
  /// and cache.  Cookies are excluded for the whole registrable domain.
  external JSArray? excludeOrigins;
}

@JS()
@staticInterop
@anonymous
class DataTypeSet {
  external factory DataTypeSet({
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
    bool? indexedDB,

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
    bool? webSQL,
  });
}

extension DataTypeSetExtension on DataTypeSet {
  /// Websites' appcaches.
  external bool? appcache;

  /// The browser's cache.
  external bool? cache;

  /// Cache storage
  external bool? cacheStorage;

  /// The browser's cookies.
  external bool? cookies;

  /// The browser's download list.
  external bool? downloads;

  /// Websites' file systems.
  external bool? fileSystems;

  /// The browser's stored form data.
  external bool? formData;

  /// The browser's history.
  external bool? history;

  /// Websites' IndexedDB data.
  external bool? indexedDB;

  /// Websites' local storage data.
  external bool? localStorage;

  /// Server-bound certificates.
  external bool? serverBoundCertificates;

  /// Stored passwords.
  external bool? passwords;

  /// Plugins' data.
  external bool? pluginData;

  /// Service Workers.
  external bool? serviceWorkers;

  /// Websites' WebSQL data.
  external bool? webSQL;
}

@JS()
@staticInterop
@anonymous
class SettingsCallbackResult {
  external factory SettingsCallbackResult({
    RemovalOptions options,

    /// All of the types will be present in the result, with values of `true` if
    /// they are both selected to be removed and permitted to be removed,
    /// otherwise `false`.
    DataTypeSet dataToRemove,

    /// All of the types will be present in the result, with values of `true` if
    /// they are permitted to be removed (e.g., by enterprise policy) and `false`
    /// if not.
    DataTypeSet dataRemovalPermitted,
  });
}

extension SettingsCallbackResultExtension on SettingsCallbackResult {
  external RemovalOptions options;

  /// All of the types will be present in the result, with values of `true` if
  /// they are both selected to be removed and permitted to be removed,
  /// otherwise `false`.
  external DataTypeSet dataToRemove;

  /// All of the types will be present in the result, with values of `true` if
  /// they are permitted to be removed (e.g., by enterprise policy) and `false`
  /// if not.
  external DataTypeSet dataRemovalPermitted;
}

@JS()
@staticInterop
@anonymous
class RemovalOptionsOriginTypes {
  external factory RemovalOptionsOriginTypes({
    /// Normal websites.
    bool? unprotectedWeb,

    /// Websites that have been installed as hosted applications (be careful!).
    bool? protectedWeb,

    /// Extensions and packaged applications a user has installed (be _really_
    /// careful!).
    bool? extension,
  });
}

extension RemovalOptionsOriginTypesExtension on RemovalOptionsOriginTypes {
  /// Normal websites.
  external bool? unprotectedWeb;

  /// Websites that have been installed as hosted applications (be careful!).
  external bool? protectedWeb;

  /// Extensions and packaged applications a user has installed (be _really_
  /// careful!).
  external bool? extension;
}
