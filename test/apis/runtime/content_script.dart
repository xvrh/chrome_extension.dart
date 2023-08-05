import 'package:chrome_apis/runtime.dart';

void main() {
  chrome.runtime.onMessage.listen((event) {
    void echo() {
      // ignore: avoid_dynamic_calls
      event.sendResponse({'response': event.message});
    }

    if (event.message == 'async') {
      Future.delayed(const Duration(milliseconds: 100)).then((_) {
        echo();
      });
      return true;
    } else if (event.message == 'no_response') {
      Future.delayed(const Duration(milliseconds: 100)).then((_) {
        echo();
      });
      // don't response
      return false;
    } else {
      echo();
    }
  });

  // Used by the test to detect when the content_script is ready
  print('Content script ready ${Uri.base.path}');
}
