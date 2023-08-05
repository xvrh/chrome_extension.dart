import 'dart:async';
import 'package:chrome_apis/tabs.dart';
import 'package:puppeteer/puppeteer.dart';
import 'package:test/test.dart';
import '../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('connect to puppeteer', () async {
    var onNewTab = chrome.tabs.onCreated.first;

    var browser =
        await puppeteer.connect(browserWsEndpoint: context.puppeteerUrl);
    var page = await browser.newPage();
    await onNewTab;

    var onRemovedTab = chrome.tabs.onRemoved.first;
    await page.close();
    await onRemovedTab;
  });

  test('use static assets server', () async {
    var browser =
        await puppeteer.connect(browserWsEndpoint: context.puppeteerUrl);

    var completer = Completer();
    chrome.tabs.onUpdated.listen((event) {
      if (event.changeInfo.title == 'Simple page') {
        completer.complete();
      }
    });

    var page = await browser.newPage();
    await page.goto(context.staticPath('assets/simple_page.html'));

    await completer.future;
  });
}
