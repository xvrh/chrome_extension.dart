import 'package:test/test.dart';
import '../runner/runner.dart';

void main() {
  test(
    'chrome.runtime background',
    () => runTests('test/apis/runtime'),
  );
  test(
    'chrome.runtime foreground',
    () {
      return runTests(
        'test/apis/runtime_foreground',
        afterBrowserOpen: (context) async {
          var browser = context.browser;
          var extension = (await browser.extensions).values.single;
          await (await browser.pages)
              .first
              .goto('chrome-extension://${extension.id}/popup.html');
        },
      );
    },
  );
}
