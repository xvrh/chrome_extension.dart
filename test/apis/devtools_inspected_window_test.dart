import 'package:test/test.dart';
import '../runner/runner.dart';

void main() {
  test('chrome.devtools.inspectedWindow', () {
    return runTests(
      'test/apis/devtools_inspected_window',
      devtools: true,
      // Navigating after the launch is flaky while DevTools attaches to the tab.
      initialPage: 'assets/simple_page.html',
    );
  });
}
