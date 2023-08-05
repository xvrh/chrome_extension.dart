import 'package:checks/checks.dart';
import 'package:chrome_apis/system_memory.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('getInfo', () async {
    var info = await chrome.system.memory.getInfo();
    check(info.availableCapacity).isGreaterThan(0);
    check(info.capacity).isGreaterThan(0);
  });
}
