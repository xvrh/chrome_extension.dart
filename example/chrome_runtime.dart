import 'dart:js_interop';
import 'package:chrome_extension/runtime.dart';

void main() async {
  chrome.runtime.onInstalled.listen((e) {
    print('OnInstalled: ${e.reason}');
  });

  chrome.runtime.onMessage.listen((e) {
    e.sendResponse.callAsFunction(null, {'the_response': 1}.jsify());
  });
}
