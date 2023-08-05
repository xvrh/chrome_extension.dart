// ignore_for_file: unnecessary_parenthesis

library;

import 'src/internal_helpers.dart';
import 'src/js/dom.dart' as $js;

export 'src/chrome.dart' show chrome;

final _dom = ChromeDom._();

extension ChromeDomExtension on Chrome {
  /// Use the `chrome.dom` API to access special DOM APIs for Extensions
  ChromeDom get dom => _dom;
}

class ChromeDom {
  ChromeDom._();

  bool get isAvailable => $js.chrome.domNullable != null && alwaysTrue;

  /// Gets the open shadow root or the closed shadow root hosted by the
  /// specified element. If the element doesn't attach the shadow root, it will
  /// return null.
  /// [returns] See <a
  /// href='https://developer.mozilla.org/en-US/docs/Web/API/ShadowRoot'>https://developer.mozilla.org/en-US/docs/Web/API/ShadowRoot</a>
  Map openOrClosedShadowRoot(JSObject element) {
    return $js.chrome.dom.openOrClosedShadowRoot(element).toDartMap();
  }
}
