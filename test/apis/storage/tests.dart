import 'dart:async';
import 'package:checks/checks.dart';
import 'package:chrome_apis/storage.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  tearDown(() async {
    await chrome.storage.local.clear();
    await chrome.storage.sync.clear();
    await chrome.storage.session.clear();
  });

  test('get(null)', () async {
    var storage = chrome.storage.local;
    await storage.set({'mykey': 'myvalue', 1: 2, true: false, null: null});

    var all = await storage.get(null);
    check(all)
      ..containsKey('mykey')
      ..containsKey('1')
      ..containsKey('true')
      ..containsKey('null');

    check(all['mykey']).equals('myvalue');
    check(all['1']).equals(2);
    check(all['true']).equals(false);
    check(all['null']).equals(null);
  });

  test('get(String)', () async {
    var storage = chrome.storage.local;
    await storage.set({'mykey': 'myvalue'});

    var all = await storage.get('mykey');
    check(all).containsKey('mykey');
    check(all['mykey']).equals('myvalue');
  });

  test('get(List)', () async {
    var storage = chrome.storage.local;
    await storage.set({'mykey': 'myvalue', 1: 2});

    var all = await storage.get(<String>['mykey', '1']);
    check(all).length.equals(2);
    check(all['mykey']).equals('myvalue');
    check(all['1']).equals(2);
  });

  test('get(List non String)', () async {
    var storage = chrome.storage.local;
    await storage.set({'mykey': 'myvalue', 1: 2});

    var all = await storage.get(['mykey', 1]);
    check(all).length.equals(2);
    check(all['mykey']).equals('myvalue');
    check(all['1']).equals(2);
  });

  test('get(Map)', () async {
    var storage = chrome.storage.local;
    await storage.set({'mykey': 'myvalue', 1: 2});

    var all = await storage.get({'mykey': 'default', 'otherkey': 'othervalue'});
    check(all).length.equals(2);
    check(all['mykey']).equals('myvalue');
    check(all['otherkey']).equals('othervalue');
    check(all['1']).isNull();
  });

  test('get(non existing)', () async {
    var storage = chrome.storage.local;
    await storage.set({'mykey': 'myvalue'});

    var all = await storage.get('wrongkey');
    check(all).length.equals(0);
  });

  test('Store list', () async {
    var storage = chrome.storage.local;
    await storage.set({
      'mykey': ['1', '2']
    });

    var all = await storage.get('mykey');
    check(all).length.equals(1);
    var array = all['mykey'] as List;
    check(array).deepEquals(['1', '2']);
  });

  test('Store map', () async {
    var storage = chrome.storage.local;
    await storage.set({
      'mykey': {'sub': 'key'}
    });

    var all = await storage.get('mykey');
    check(all).length.equals(1);
    var value = all['mykey'] as Map;
    check(value).deepEquals({'sub': 'key'});
  });

  test('onChanged event with single value', () async {
    var storage = chrome.storage.local;
    late StreamSubscription subscription;

    subscription = storage.onChanged.listen(expectAsync1((e) {
      check(e).deepEquals({
        'mykey': {'newValue': 'value'}
      });
      subscription.cancel();
    }));
    await storage.set({'mykey': 'value'});
  });

  test('onChanged event', () async {
    var storage = chrome.storage.local;
    await storage.set({'mykey': 'value'});
    late StreamSubscription subscription;

    subscription = storage.onChanged.listen(expectAsync1((e) {
      check(e).deepEquals({
        'mykey': {'newValue': 'value2', 'oldValue': 'value'}
      });
      subscription.cancel();
    }));
    await storage.set({'mykey': 'value2'});
  });

  test('properties on specific storages', () async {
    check(chrome.storage.local.quotaBytes).equals(10485760);
    check(chrome.storage.session.quotaBytes).equals(10485760);
    check(chrome.storage.sync.quotaBytes).equals(102400);
    check(chrome.storage.sync.quotaBytesPerItem).equals(8192);
    check(chrome.storage.sync.maxItems).equals(512);
  });
}
