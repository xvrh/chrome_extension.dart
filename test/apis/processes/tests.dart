import 'package:checks/checks.dart';
import 'package:chrome_apis/processes.dart';
import 'package:chrome_apis/tabs.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('getProcessIdForTab', () async {
    var tab = await chrome.tabs.create(CreateProperties());

    var process = await chrome.processes.getProcessIdForTab(tab.id!);
    check(process).isGreaterThan(0);

    var info = await chrome.processes.getProcessInfo([process], false);
    check(info).isNotEmpty();
    await chrome.tabs.remove(tab.id!);
  });
}
