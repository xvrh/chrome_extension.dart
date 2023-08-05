import 'package:checks/checks.dart';
import 'package:chrome_apis/privacy.dart';
import 'package:chrome_apis/types.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('websites.protectedContentEnabled', () async {
    var setting = chrome.privacy.websites.protectedContentEnabled;
    if (context.info.operatingSystem == 'windows') {
      check(setting).isNotNull();
    } else {
      check(setting).isNull();
    }
  });

  test('services.autofillEnabled', () async {
    var setting = chrome.privacy.services.autofillEnabled;
    var detail = await setting.get(GetDetails());
    check(detail.value).equals(true);
    check(detail.incognitoSpecific).equals(null);

    await setting.set(SetDetails(value: false));
    detail = await setting.get(GetDetails());
    check(detail.value).equals(false);
    check(detail.incognitoSpecific).equals(null);

    await setting.clear(ClearDetails());
    detail = await setting.get(GetDetails());
    check(detail.value).equals(true);
    check(detail.incognitoSpecific).equals(null);
  });
}
