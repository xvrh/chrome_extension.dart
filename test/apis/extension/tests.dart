import 'package:checks/checks.dart';
import 'package:chrome_apis/extension.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('isAllowedIncognitoAccess', () async {
    var isAllowedIncognitoAccess =
        await chrome.extension.isAllowedIncognitoAccess();
    check(isAllowedIncognitoAccess).isFalse();
  });
}
