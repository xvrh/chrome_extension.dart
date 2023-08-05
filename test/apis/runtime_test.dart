import 'package:collection/collection.dart';
import 'package:test/test.dart';
import '../runner/runner.dart';

void main() {
  test(
    'chrome.runtime background',
    () => runTests('test/apis/runtime'),
  );
  test(
    'chrome.runtime foreground',
    () {
      return runTests(
        'test/apis/runtime_foreground',
        afterBrowserOpen: (context) async {
          var browser = context.browser;
          var targetName = 'service_worker';
          var backgroundPageTarget =
              browser.targets.firstWhereOrNull((t) => t.type == targetName);
          backgroundPageTarget ??= await browser
              .waitForTarget((target) => target.type == targetName);
          expect(backgroundPageTarget.isPage, isFalse);
          var worker = (await backgroundPageTarget.worker)!;

          var url = Uri.parse(worker.url!);
          assert(url.scheme == 'chrome-extension');
          var extensionId = url.host;

          await (await browser.pages)
              .first
              .goto('chrome-extension://$extensionId/popup.html');
        },
      );
    },
  );
}
