import 'package:chrome_extension/scripting.dart';
import 'package:chrome_extension/src/internal_helpers.dart';
import 'package:chrome_extension/tabs.dart';
import 'package:puppeteer/puppeteer.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) async {
  test('chrome.scripting.executeScript with files', () async {
    var browser =
        await puppeteer.connect(browserWsEndpoint: context.puppeteerUrl);
    var page = (await browser.pages).first;
    expect(page.url, endsWith('simple_page.html'));

    var currentTab =
        (await chrome.tabs.query(QueryInfo(active: true, currentWindow: true)))
            .first;

    var completer = Completer();
    var consoleSubscription = page.onConsole.listen((e) {
      if (e.text == 'Hello from script.js') {
        completer.complete();
      }
    });

    await chrome.scripting.executeScript(ScriptInjection(
        target: InjectionTarget(tabId: currentTab.id!), files: ['script.js']));

    await completer.future;

    await consoleSubscription.cancel();
  });

  test('chrome.scripting.executeScript with function', () async {
    var browser =
        await puppeteer.connect(browserWsEndpoint: context.puppeteerUrl);
    var page = (await browser.pages).first;
    expect(page.url, endsWith('simple_page.html'));

    var currentTab =
        (await chrome.tabs.query(QueryInfo(active: true, currentWindow: true)))
            .first;

    var completer = Completer();
    var consoleSubscription = page.onConsole.listen((e) {
      print("console message ${e.text} ${e.url}");
      if (e.text == 'Hello from dart script') {
        completer.complete();
      }
    });
    page.onError.listen((e) {
      print("error message ${e.message} ${e.details}");
    });

    await chrome.scripting.executeScript(ScriptInjection(
        target: InjectionTarget(tabId: currentTab.id!), func: _myFunc.toJS));

    await completer.future;

    await consoleSubscription.cancel();
  }, skip: 'Not working');
}

void _myFunc() {
  print('Hello from dart script');
}
