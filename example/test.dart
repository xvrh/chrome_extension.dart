import 'package:collection/collection.dart';
import 'package:puppeteer/puppeteer.dart';

void main() async {
  // Compile the extension
  var extensionPath = '...';

  var browser = await puppeteer.launch(
    headless: false,
    args: [
      '--disable-extensions-except=$extensionPath',
      '--load-extension=$extensionPath',
      // Allow to connect to puppeteer from inside your extension if needed for the testing
      '--remote-allow-origins=*',
    ],
  );

  // Find the background page target
  var targetName = 'service_worker';
  var backgroundPageTarget =
      browser.targets.firstWhereOrNull((t) => t.type == targetName);
  backgroundPageTarget ??=
      await browser.waitForTarget((target) => target.type == targetName);
  var worker = (await backgroundPageTarget.worker)!;

  var url = Uri.parse(worker.url!);
  assert(url.scheme == 'chrome-extension');
  var extensionId = url.host;

  // Go to the popup page
  await (await browser.pages)
      .first
      .goto('chrome-extension://$extensionId/popup.html');

  // Etc...
}
