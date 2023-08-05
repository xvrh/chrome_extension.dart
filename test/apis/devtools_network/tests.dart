import 'dart:async';
import 'package:checks/checks.dart';
import 'package:chrome_apis/devtools_network.dart';
import 'package:puppeteer/puppeteer.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('getHAR', () async {
    var har = await chrome.devtools.network.getHAR();
    check(har).isNotEmpty();
    check(har)['version'].equals('1.2');
  });

  test('onNavigated', () async {
    late StreamSubscription subscription;
    subscription = chrome.devtools.network.onNavigated.listen(expectAsync1((e) {
      check(e).endsWith('/second_page.html');
      subscription.cancel();
    }));

    late StreamSubscription subscription2;
    subscription2 = chrome.devtools.network.onRequestFinished
        .listen(expectAsync1((e) async {
      check((await e.getContent()).content).contains('Second page');
      await subscription2.cancel();
    }));

    var browser =
        await puppeteer.connect(browserWsEndpoint: context.puppeteerUrl);
    var page = (await browser.pages).first;
    await page.goto(context.staticPath('second_page.html'));
  });
}
