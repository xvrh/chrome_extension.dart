import 'package:test/test.dart';
import 'runner/runner.dart';

void main() {
  test('chrome.*.isAvailable', () => runTests('test/is_available'));
}
