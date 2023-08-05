import 'package:test/test.dart';
import '../runner/runner.dart';

void main() {
  test('chrome.devtools.network',
      () => runTests('test/apis/devtools_network', devtools: true));
}
