import 'package:checks/checks.dart';
import 'package:chrome_apis/system_network.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('getNetworkInterfaces', () async {
    var interfaces = await chrome.system.network.getNetworkInterfaces();
    check(interfaces).isNotEmpty();
    check(interfaces.first.name).isNotEmpty();
    check(interfaces.first.address).isNotEmpty();
    check(interfaces.first.prefixLength).isGreaterOrEqual(0);
  });
}
