// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import
// ignore_for_file: unintended_html_in_doc_comment

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'tabs.dart';
import 'windows.dart';

export 'chrome.dart';

extension JSChromeJSSessionsExtension on JSChrome {
  @JS('sessions')
  external JSSessions? get sessionsNullable;

  /// Use the `chrome.sessions` API to query and restore tabs and windows from a
  /// browsing session.
  JSSessions get sessions {
    var sessionsNullable = this.sessionsNullable;
    if (sessionsNullable == null) {
      throw ApiNotAvailableException('chrome.sessions');
    }
    return sessionsNullable;
  }
}

extension type JSSessions._(JSObject _) {
  /// Gets the list of recently closed tabs and/or windows.
  external JSPromise getRecentlyClosed(Filter? filter);

  /// Retrieves all devices with synced sessions.
  external JSPromise getDevices(Filter? filter);

  /// Reopens a [windows.Window] or [tabs.Tab], with an optional callback to run
  /// when the entry has been restored.
  external JSPromise restore(

      /// The [windows.Window.sessionId], or [tabs.Tab.sessionId] to restore. If
      /// this parameter is not specified, the most recently closed session is
      /// restored.
      String? sessionId);

  /// Fired when recently closed tabs and/or windows are changed. This event
  /// does not monitor synced sessions changes.
  external Event get onChanged;

  /// The maximum number of [sessions.Session] that will be included in a
  /// requested list.
  external int get MAX_SESSION_RESULTS;
}
extension type Filter._(JSObject _) implements JSObject {
  external factory Filter(
      {
      /// The maximum number of entries to be fetched in the requested list. Omit
      /// this parameter to fetch the maximum number of entries
      /// ([sessions.MAX_SESSION_RESULTS]).
      int? maxResults});

  /// The maximum number of entries to be fetched in the requested list. Omit
  /// this parameter to fetch the maximum number of entries
  /// ([sessions.MAX_SESSION_RESULTS]).
  external int? maxResults;
}
extension type Session._(JSObject _) implements JSObject {
  external factory Session({
    /// The time when the window or tab was closed or modified, represented in
    /// milliseconds since the epoch.
    int lastModified,

    /// The [tabs.Tab], if this entry describes a tab. Either this or
    /// [sessions.Session.window] will be set.
    Tab? tab,

    /// The [windows.Window], if this entry describes a window. Either this or
    /// [sessions.Session.tab] will be set.
    Window? window,
  });

  /// The time when the window or tab was closed or modified, represented in
  /// milliseconds since the epoch.
  external int lastModified;

  /// The [tabs.Tab], if this entry describes a tab. Either this or
  /// [sessions.Session.window] will be set.
  external Tab? tab;

  /// The [windows.Window], if this entry describes a window. Either this or
  /// [sessions.Session.tab] will be set.
  external Window? window;
}
extension type Device._(JSObject _) implements JSObject {
  external factory Device({
    String info,

    /// The name of the foreign device.
    String deviceName,

    /// A list of open window sessions for the foreign device, sorted from most
    /// recently to least recently modified session.
    JSArray sessions,
  });

  external String info;

  /// The name of the foreign device.
  external String deviceName;

  /// A list of open window sessions for the foreign device, sorted from most
  /// recently to least recently modified session.
  external JSArray sessions;
}
