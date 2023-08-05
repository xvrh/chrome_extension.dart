import 'package:checks/checks.dart';
import 'package:chrome_apis/system_storage.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('getInfo', () async {
    var info = await chrome.system.storage.getInfo();
    check(info).isNotEmpty();
    var storage = info.firstWhere((e) => e.capacity > 0);
    check(storage.name).isNotEmpty();
    check(storage.capacity).isGreaterThan(0);
    check(storage.type).isNotNull();
  });

  test('getAvailableCapacity', () async {
    var storages = await chrome.system.storage.getInfo();
    var storage = storages.firstWhere((e) => e.capacity > 0);
    var capacity = await chrome.system.storage.getAvailableCapacity(storage.id);
    check(capacity.id).equals(storage.id);
    check(capacity.availableCapacity).isGreaterOrEqual(0);
  });
}
