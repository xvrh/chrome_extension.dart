import 'package:checks/checks.dart';
import 'package:chrome_apis/system_cpu.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('getInfo', () async {
    var info = await chrome.system.cpu.getInfo();
    check(info.archName).isNotEmpty();
    check(info.features).isNotNull();
    check(info.modelName).isNotEmpty();
    check(info.numOfProcessors).isGreaterOrEqual(1);
    check(info.processors).isNotEmpty();
    check(info.processors.first.usage.idle).isGreaterOrEqual(0);
    check(info.processors.first.usage.kernel).isGreaterOrEqual(0);
    check(info.processors.first.usage.user).isGreaterOrEqual(0);
    check(info.processors.first.usage.total).isGreaterOrEqual(0);
    check(info.temperatures).isNotNull();
  });
}
