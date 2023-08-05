import 'package:checks/checks.dart';
import 'package:chrome_apis/notifications.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('create', () async {
    var id = await chrome.notifications.create(
        'myid',
        NotificationOptions(
            type: TemplateType.basic,
            iconUrl: 'icon.png',
            message: 'Message',
            title: 'Text'));
    check(id).equals('myid');
  }, skip: 'Cannot make the permission working yet');

  test('getAll', () async {
    var all = await chrome.notifications.getAll();
    check(all).isNotNull();
  });

  test('getPermissionLevel', () async {
    var level = await chrome.notifications.getPermissionLevel();
    check(level).isNotNull();
  });
}
