import 'package:test/test.dart';
import '../runner/runner.dart';

void main() {
  test('chrome.scripting', () async {
    await runTests(
      'test/apis/scripting',
      afterBrowserOpen: (context) async {
        var page = (await context.browser.pages).first;
        await page.goto(context.staticPath('assets/simple_page.html'));
      },
    );
  });
}
