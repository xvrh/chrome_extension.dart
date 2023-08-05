import 'package:test/test.dart';
import '../runner/runner.dart';

void main() {
  test('chrome.devtools.inspectedWindow', () {
    return runTests(
      'test/apis/devtools_inspected_window',
      devtools: true,
      afterBrowserOpen: (context) async {
        var page = (await context.browser.pages).first;
        await page.goto(context.staticPath('assets/simple_page.html'));
      },
    );
  });
}
