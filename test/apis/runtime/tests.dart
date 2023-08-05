import 'dart:async';
import 'package:checks/checks.dart';
import 'package:chrome_apis/runtime.dart';
import 'package:chrome_apis/tabs.dart' as tabs;
import 'package:puppeteer/puppeteer.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) async {
  var browser =
      await puppeteer.connect(browserWsEndpoint: context.puppeteerUrl);
  var page = (await browser.pages).first;

  var staticPath = 'assets/simple_page.html';
  var onReady = page.onConsole
      .where((e) =>
          e.text?.contains('Content script ready /static/$staticPath') ?? false)
      .first;
  await page.goto(context.staticPath(staticPath));
  await onReady;

  test('getURL', () async {
    var url = chrome.runtime.getURL('page.html');
    check(url)
      ..endsWith('page.html')
      ..startsWith('chrome-extension://');
  });

  test('getManifest', () async {
    var manifest = chrome.runtime.getManifest();
    check(manifest)
      ..['manifest_version'].equals(3)
      ..['version'].equals('2.0');
    check(manifest['background'] as Map).containsKey('service_worker');
    check(manifest['permissions'] as List).contains('tabs');
  });

  test('sendMessage string to content script', () async {
    var [tab] = await chrome.tabs
        .query(tabs.QueryInfo(active: true, lastFocusedWindow: true));

    var response = await chrome.tabs.sendMessage(tab.id!, 'My message', null);

    check(response as Map).deepEquals({'response': 'My message'});
  });

  test('sendMessage complex to content script', () async {
    var [tab] = await chrome.tabs
        .query(tabs.QueryInfo(active: true, lastFocusedWindow: true));
    var response =
        await chrome.tabs.sendMessage(tab.id!, {'a': 1, 'b': true}, null);

    check(response as Map).deepEquals({
      'response': {'a': 1, 'b': true}
    });
  });

  test('sendMessage with async', () async {
    var [tab] = await chrome.tabs
        .query(tabs.QueryInfo(active: true, lastFocusedWindow: true));
    var response = await chrome.tabs.sendMessage(tab.id!, 'async', null);

    check(response as Map).deepEquals({'response': 'async'});
  });

  test('sendMessage no response', () async {
    var [tab] = await chrome.tabs
        .query(tabs.QueryInfo(active: true, lastFocusedWindow: true));
    expect(
        () => chrome.tabs
            .sendMessage(tab.id!, 'no_response', null)
            .timeout(Duration(milliseconds: 200)),
        throwsA(isA<TimeoutException>()));
  });
}
