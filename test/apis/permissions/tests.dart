import 'package:checks/checks.dart';
import 'package:chrome_apis/permissions.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('getAll', () async {
    var permissions = await chrome.permissions.getAll();
    check(permissions.permissions).isNotNull();
    check(permissions.permissions!).deepEquals(['alarms']);
  });

  test('contains', () async {
    var contains =
        await chrome.permissions.contains(Permissions(permissions: ['tabs']));
    check(contains).isFalse();

    contains =
        await chrome.permissions.contains(Permissions(permissions: ['alarms']));
    check(contains).isTrue();
  });

  test('request', () async {
    var permissions = Permissions(permissions: ['tabs']);
    expect(
        () => chrome.permissions.request(permissions),
        throwsA((e) => '$e'
            .contains('This function must be called during a user gesture')));
  });
}
