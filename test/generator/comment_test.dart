import 'package:test/test.dart';
import '../../tool/generator/comment.dart';

void main() {
  test('convertHtmlToDartdoc', () {
    expect(
        convertHtmlToDartdoc(
            "Use the <code>chrome.contextMenus</code> API to <em>add</em> items to <a href='index.html'>index html</a>"),
        "Use the `chrome.contextMenus` API to _add_ items to [index html](index.html)");
  });
}
