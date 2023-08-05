// ignore_for_file: unnecessary_parenthesis

library;

import 'devtools.dart';
import 'src/internal_helpers.dart';
import 'src/js/devtools_network.dart' as $js;

export 'devtools.dart' show ChromeDevtools, ChromeDevtoolsExtension;
export 'src/chrome.dart' show chrome;

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
  Future<Map> getHAR() {
    var $completer = Completer<Map>();
    $js.chrome.devtools.network.getHAR((JSAny harLog) {
      if (checkRuntimeLastError($completer)) {
        $completer.complete(harLog.toDartMap());
      }
    }.toJS);
    return $completer.future;
  }

  /// Fired when a network request is finished and all request data are
  /// available.
  EventStream<Request> get onRequestFinished =>
      $js.chrome.devtools.network.onRequestFinished
          .asStream(($c) => ($js.Request request) {
                return $c(Request.fromJS(request));
              });

  /// Fired when the inspected window navigates to a new page.
  EventStream<String> get onNavigated =>
      $js.chrome.devtools.network.onNavigated.asStream(($c) => (String url) {
            return $c(url);
          });
}

class Request {
  Request.fromJS(this._wrapped);

  Request() : _wrapped = $js.Request();

  final $js.Request _wrapped;

  $js.Request get toJS => _wrapped;

  /// Returns content of the response body.
  /// [returns] A function that receives the response body when the request
  /// completes.
  Future<GetContentResult> getContent() {
    var $completer = Completer<GetContentResult>();
    _wrapped.getContent((
      String content,
      String encoding,
    ) {
      if (checkRuntimeLastError($completer)) {
        $completer.complete(GetContentResult(
          content: content,
          encoding: encoding,
        ));
      }
    }.toJS);
    return $completer.future;
  }
}

class GetContentResult {
  GetContentResult({
    required this.content,
    required this.encoding,
  });

  /// Content of the response body (potentially encoded).
  final String content;

  /// Empty if content is not encoded, encoding name otherwise. Currently, only
  /// base64 is supported.
  final String encoding;
}
