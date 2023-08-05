import 'package:test/test.dart';
import '../runner/runner.dart';

void main() {
  test('chrome.devtools.panels',
      () => runTests('test/apis/devtools_panels', devtools: true));
}
