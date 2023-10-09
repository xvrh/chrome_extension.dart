import 'dart:js_interop';
import 'package:chrome_extension/tabs.dart';
import 'package:web/web.dart';

void main() {
  chrome.tabs.query(QueryInfo());

  var button = document.querySelector('#startButton')! as HTMLElement;
  button.addEventListener(
      'click',
      (PointerEvent e) {
        // Demonstrate apis
      }
          .toJS);
}
