import 'package:checks/checks.dart';
import 'package:chrome_apis/accessibility_features.dart';
import 'package:chrome_apis/types.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('animationPolicy', () async {
    var setting = chrome.accessibilityFeatures.animationPolicy;
    var detail = await setting.get(GetDetails());
    check(detail.value).equals('allowed');
    check(detail.incognitoSpecific).equals(null);

    await setting.set(SetDetails(value: 'once'));
    detail = await setting.get(GetDetails());
    check(detail.value).equals('once');
    check(detail.incognitoSpecific).equals(null);

    await setting.clear(ClearDetails());
    detail = await setting.get(GetDetails());
    check(detail.value).equals('allowed');
    check(detail.incognitoSpecific).equals(null);
  });

  test('Nullable', () async {
    check(chrome.accessibilityFeatures.largeCursor).isNull();
  });
}
