import 'dart:async';
import 'package:chrome_extension/tabs.dart' as tabs;
import 'package:chrome_extension/windows.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  late Window window;

  setUp(() async {
    var windowCreateParams = CreateData(focused: true, type: CreateType.normal);
    window = (await chrome.windows.create(windowCreateParams))!;
  });

  tearDown(() async {
    await chrome.windows.remove(window.id!);
  });

  test('getters', () {
    expect(window.id, isA<int>());
    expect(window.top, isNotNull);
    expect(window.left, isNotNull);
    expect(window.width, isPositive);
    expect(window.height, isPositive);
    expect(window.tabs, hasLength(1));
    expect(window.tabs!.first, isA<tabs.Tab>());
    expect(window.incognito, isFalse);
    expect(window.type, WindowType.normal);
    expect(window.state, WindowState.normal);
    expect(window.alwaysOnTop, isFalse);
  });

  test('get populate true', () async {
    var getInfo = QueryOptions(populate: true);

    var newWindow = await chrome.windows.get(window.id!, getInfo);
    expect(newWindow.id, window.id);
    expect(newWindow.tabs, hasLength(1));
    expect(newWindow.tabs!.first.id, window.tabs!.first.id);
  });

  test('get populate false', () async {
    var getInfo = QueryOptions(populate: false);

    var newWindow = await chrome.windows.get(window.id!, getInfo);
    expect(newWindow.id, window.id);
    expect(newWindow.tabs, isNull);
  });

  test('getCurrent populate true', () async {
    var getInfo = QueryOptions(populate: true);

    var newWindow = await chrome.windows.getCurrent(getInfo);
    expect(newWindow.tabs, hasLength(isPositive));
  });

  test('getCurrent populate false', () async {
    var getInfo = QueryOptions(populate: false);

    var newWindow = await chrome.windows.getCurrent(getInfo);
    expect(newWindow.tabs, isNull);
  });

  test('getLastFocused populate true', () async {
    var getInfo = QueryOptions(populate: true);

    var newWindow = await chrome.windows.getLastFocused(getInfo);
    expect(newWindow.tabs, hasLength(isPositive));
  });

  test('getLastFocused populate false', () async {
    var getInfo = QueryOptions(populate: false);

    var newWindow = await chrome.windows.getLastFocused(getInfo);
    expect(newWindow.tabs, isNull);
  });

  test('getAll populate true', () async {
    var getInfo = QueryOptions(populate: true);

    var allWindows = await chrome.windows.getAll(getInfo);
    expect(allWindows.map((w) => w.id), contains(window.id));
    expect(allWindows.map((w) => w.tabs), everyElement(hasLength(isPositive)));
  });

  test('getAll populate false', () async {
    var getInfo = QueryOptions(populate: false);

    var allWindows = await chrome.windows.getAll(getInfo);
    expect(allWindows.map((w) => w.id), contains(window.id));
    expect(allWindows.map((w) => w.tabs), everyElement(isNull));
  });

  test('create defaults', () async {
    var window = await chrome.windows.create(null);
    expect(window!.tabs, hasLength(1));
    expect(window.tabs!.first.url, '');
    expect(window.incognito, isFalse);
    expect(window.type, WindowType.normal);
    await chrome.windows.remove(window.id!);
  });

  // Requires extension access to incognito windows.
  test('create incognito window', () async {
    var createData = CreateData(
        url: context.staticPath('assets/simple_page.html'),
        left: 10,
        top: 10,
        width: 300,
        height: 300,
        focused: true,
        incognito: true,
        type: CreateType.normal);

    var window = await chrome.windows.create(createData);
    expect(window, isNull);
  });

  // Requires enable panels flag to be set.
  test('create panel', () async {
    var createData = CreateData(type: CreateType.panel);
    var window = await chrome.windows.create(createData);
    expect(window!.tabs, isEmpty);
    expect(window.incognito, isFalse);
    expect(window.type, WindowType.popup);
    expect(window.state, WindowState.normal);
    await chrome.windows.remove(window.id!);
  });

  test('update maximized', () async {
    var updateInfo = UpdateInfo(state: WindowState.maximized);

    // TODO: Figure out better mechanism to validate this
    await chrome.windows.update(window.id!, updateInfo);
  });

  test('update set size', () async {
    var updateInfo = UpdateInfo(
        left: 10,
        top: 10,
        width: 300,
        height: 300,
        drawAttention: true,
        focused: false);

    // TODO: Figure out better mechanism to validate this
    await chrome.windows.update(window.id!, updateInfo);
  });

  test('remove', () async {
    var window = await chrome.windows.create(null);
    await chrome.windows.remove(window!.id!);
    expect(() => chrome.windows.get(window.id!, null), throwsA(anything));
  });

  test('onCreated', () async {
    late StreamSubscription subscription;
    subscription = chrome.windows.onCreated.listen(expectAsync1((window) {
      expect(window, isA<Window>());
      subscription.cancel();
    }));
    var window = await chrome.windows.create(null);
    await chrome.windows.remove(window!.id!);
  });

  test('onRemoved', () async {
    late StreamSubscription subscription;
    subscription = chrome.windows.onRemoved.listen(expectAsync1((windowId) {
      expect(windowId, isPositive);
      subscription.cancel();
    }));
    var window = await chrome.windows.create(null);
    await chrome.windows.remove(window!.id!);
  });

  test('onFocusChanged', () async {
    late StreamSubscription subscription;
    subscription =
        chrome.windows.onFocusChanged.listen(expectAsync1((windowId) {
      expect(windowId, isA<int>());
      subscription.cancel();
    }));

    var updateInfo = CreateData(focused: true);
    var window = await chrome.windows.create(updateInfo);
    await chrome.windows.remove(window!.id!);
  });
}
