import 'package:test/test.dart';
import '../runner/runner.dart';

void main() {
  test('chrome.system.cpu', () => runTests('test/apis/system_cpu'));
  test('chrome.system.display', () => runTests('test/apis/system_display'));
  test('chrome.system.memory', () => runTests('test/apis/system_memory'));
  test('chrome.system.network', () => runTests('test/apis/system_network'));
  test('chrome.system.storage', () => runTests('test/apis/system_storage'));
}
