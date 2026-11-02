// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'devtools.dart';
import 'src/internal_helpers.dart';
import 'src/js/devtools_network.dart' as $js;

export 'devtools.dart' show ChromeDevtools, ChromeDevtoolsExtension;
export 'src/chrome.dart' show chrome, EventStream;

final _devtoolsNetwork = ChromeDevtoolsNetwork._();

extension ChromeDevtoolsNetworkExtension on ChromeDevtools {
  /// Use the `chrome.devtools.network` API to retrieve the information about
  /// network requests displayed by the Developer Tools in the Network panel.
  ChromeDevtoolsNetwork get network => _devtoolsNetwork;
}

class ChromeDevtoolsNetwork {
  ChromeDevtoolsNetwork._();

  bool get isAvailable =>
      $js.chrome.devtoolsNullable?.networkNullable != null && alwaysTrue;

  /// Returns HAR log that contains all known network requests.
  /// [returns] A function that receives the HAR log when the request
  /// completes.
  Future<Map> getHAR() async {
    var $res = await $js.chrome.devtools.network.getHAR().toDart;
    return $res.toDartMap();
  }

  /// Fired when a network request is finished and all request data are
  /// available.
  EventStream<Request> get onRequestFinished =>
      $js.chrome.devtools.network.onRequestFinished
          .asStream(($c) => ($js.Request request) {
                return $c(Request.fromJS(request));
              }.toJS);

  /// Fired when the inspected window navigates to a new page.
  EventStream<String> get onNavigated =>
      $js.chrome.devtools.network.onNavigated.asStream(($c) => (String url) {
            return $c(url);
          }.toJS);
}

class Request {
  Request.fromJS(this._wrapped);

  Request() : _wrapped = $js.Request();

  final $js.Request _wrapped;

  $js.Request get toJS => _wrapped;

  /// Returns content of the response body.
  /// [returns] A function that receives the response body when the request
  /// completes.
  Future<GetContentCallbackResponse> getContent() async {
    var $res = await _wrapped.getContent().toDart;
    return GetContentCallbackResponse.fromJS($res);
  }
}

class GetContentCallbackResponse {
  GetContentCallbackResponse.fromJS(this._wrapped);

  GetContentCallbackResponse({
    /// Content of the response body (potentially encoded).
    required String content,

    /// Empty if content is not encoded, encoding name otherwise. Currently,
    /// only base64 is supported.
    required String encoding,
  }) : _wrapped = $js.GetContentCallbackResponse(
          content: content,
          encoding: encoding,
        );

  final $js.GetContentCallbackResponse _wrapped;

  $js.GetContentCallbackResponse get toJS => _wrapped;

  /// Content of the response body (potentially encoded).
  String get content => _wrapped.content;

  set content(String v) {
    _wrapped.content = v;
  }

  /// Empty if content is not encoded, encoding name otherwise. Currently, only
  /// base64 is supported.
  String get encoding => _wrapped.encoding;

  set encoding(String v) {
    _wrapped.encoding = v;
  }
}
