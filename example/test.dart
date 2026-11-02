import 'package:puppeteer/puppeteer.dart';

void main() async {
  // Compile the extension
  var extensionPath = '...';

  var browser = await puppeteer.launch(
    enableExtensions: true,
    args: [
      // Allow to connect to puppeteer from inside your extension if needed for the testing
      '--remote-allow-origins=*',
    ],
  );
  var extensionId = await browser.installExtension(extensionPath);

  // Go to the popup page
  var page = await browser.newPage();
  await page.goto('chrome-extension://$extensionId/popup.html');

  // Etc...

  await browser.close();
}
