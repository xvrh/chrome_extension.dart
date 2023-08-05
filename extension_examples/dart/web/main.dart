import 'dart:js_interop';
import 'package:web/web.dart';

void main() {
  var button = document.querySelector('#startButton')! as HTMLElement;
  button.addEventListener(
      'click',
      (PointerEvent e) async {
        // Demonstrate apis
      }
          .toJS);
}
