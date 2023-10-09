import 'package:chrome_extension/runtime.dart';
import 'package:chrome_extension/src/internal_helpers.dart';

void main() {
  chrome.runtime.onMessage.listen((event) {
    print("Got message ${event.message}");
    void echo() {
      print("Will response");
      try {
        event.sendResponse
            .callAsFunction(null, {'response': event.message}.jsify());
        print("After response");
      } catch (e) {
        print("error $e");
      }
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
