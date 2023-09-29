import 'package:chrome_extension/runtime.dart';

void main() async {
  chrome.runtime.onInstalled.listen((e) {
    print('OnInstalled: ${e.reason}');
  });
}
