// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import
// ignore_for_file: unintended_html_in_doc_comment

library;

import 'dart:js_interop';
import 'chrome.dart';
import 'devtools.dart';

export 'chrome.dart';
export 'devtools.dart';

extension JSChromeJSDevtoolsNetworkExtension on JSChromeDevtools {
  @JS('network')
  external JSDevtoolsNetwork? get networkNullable;

  /// Use the `chrome.devtools.network` API to retrieve the information about
  /// network requests displayed by the Developer Tools in the Network panel.
  JSDevtoolsNetwork get network {
    var networkNullable = this.networkNullable;
    if (networkNullable == null) {
      throw ApiNotAvailableException('chrome.devtools.network');
    }
    return networkNullable;
  }
}

extension type JSDevtoolsNetwork._(JSObject _) {
  /// Returns HAR log that contains all known network requests.
  external void getHAR(

      /// A function that receives the HAR log when the request completes.
      JSFunction callback);

  /// Fired when a network request is finished and all request data are
  /// available.
  external Event get onRequestFinished;

  /// Fired when the inspected window navigates to a new page.
  external Event get onNavigated;
}
extension type Request._(JSObject _) implements JSObject {
  external factory Request();

  /// Returns content of the response body.
  external void getContent(

      /// A function that receives the response body when the request completes.
      JSFunction callback);
}
