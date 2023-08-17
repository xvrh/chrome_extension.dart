import 'dart:async';
import 'package:chrome_extension/search.dart';
import 'package:chrome_extension/tabs.dart' as tabs;
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('query', () async {
    late StreamSubscription subscription;
    subscription = chrome.tabs.onCreated.listen(expectAsync1((e) {
      subscription.cancel();
    }));
    await chrome.search.query(
        QueryInfo(text: 'who is the rabbit?', disposition: Disposition.newTab));
  });
}
