import 'dart:async';
import 'package:chrome_extension/tabs.dart';
import 'package:chrome_extension/windows.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  late Window window;

  setUp(() async {
    window = (await chrome.windows
        .create(CreateData(focused: true, type: CreateType.normal)))!;
  });

  tearDown(() {
    Future closeFuture = chrome.windows.remove(window.id!);
    return closeFuture;
  });

  test('tab getters', () {
    var tab = window.tabs!.first;
    expect(tab.id, isPositive);
    expect(tab.index, 0);
    expect(tab.windowId, window.id);
    expect(tab.highlighted, isTrue);
    expect(tab.active, isTrue);
    expect(tab.pinned, isFalse);
    expect(tab.url, '');
    expect(tab.title, 'New Tab');
    expect(tab.favIconUrl, isNull);
    expect(tab.status, TabStatus.loading);
    expect(tab.incognito, isFalse);
    expect(tab.openerTabId, isNull);
  });

  test('get', () async {
    var tab = await chrome.tabs.get(window.tabs!.first.id!);
    expect(tab.windowId, window.id);
    expect(tab.id, window.tabs!.first.id);
  });

  test('getCurrent', () async {
    expect(await chrome.tabs.getCurrent(), isNull);
  });

  test('create -- default options', () async {
    var tab = await chrome.tabs.create(CreateProperties(windowId: window.id));
    expect(tab.id, isPositive);
    expect(tab.index, 1);
    expect(tab.url, '');
    expect(tab.active, isTrue);
    expect(tab.pinned, isFalse);
    expect(tab.openerTabId, isNull);
  });

  test('create -- non-default options', () async {
    var url = context.staticPath('assets/simple_page.html');
    var createProperties = CreateProperties(
        windowId: window.id,
        index: 0,
        url: url,
        active: false,
        pinned: true,
        openerTabId: window.tabs!.first.id);

    var onUpdatedResult =
        chrome.tabs.onUpdated.where((e) => e.tab.url == url).first;
    var tab = await chrome.tabs.create(createProperties);
    expect(tab.id, isPositive);
    expect(tab.index, 0);
    expect(tab.url, '');
    expect(tab.active, isFalse);
    expect(tab.pinned, isTrue);
    expect(tab.openerTabId, window.tabs!.first.id);
    var updatedTab = (await onUpdatedResult).tab;
    expect(tab.id, updatedTab.id);
  });

  test('duplicate', () async {
    var original = window.tabs!.first;
    var tab = await chrome.tabs.duplicate(original.id!);
    expect(tab!.id, isPositive);
    expect(tab.index, 1);
    expect(tab.pinned, original.pinned);
    expect(tab.windowId, original.windowId);
  });

  test('query -- one tab', () async {
    var queryInfo = QueryInfo(windowId: window.id);
    var foundTabs = await chrome.tabs.query(queryInfo);
    expect(foundTabs, hasLength(1));
    expect(foundTabs.first.id, window.tabs!.first.id);
  });

  test('query -- two tabs', () async {
    var createProperties = CreateProperties(windowId: window.id);
    var queryInfo = QueryInfo(windowId: window.id);
    var newTab = await chrome.tabs.create(createProperties);
    var foundTabs = await chrome.tabs.query(queryInfo);
    expect(foundTabs, hasLength(2));
    expect(foundTabs[0].id, anyOf(window.tabs!.first.id, newTab.id));
    expect(foundTabs[1].id, anyOf(window.tabs!.first.id, newTab.id));
  });

  test('highlight', () async {
    var highlightInfo =
        HighlightInfo(windowId: window.id, tabs: [window.tabs!.first.index]);
    var newWindow = await chrome.tabs.highlight(highlightInfo);
    expect(newWindow.id, window.id);
    expect(newWindow.tabs!.first.highlighted, isTrue);
  });

  test('update', () async {
    var url = context.staticPath('assets/simple_page.html');
    var updateProperties = UpdateProperties(
        url: url, active: true, highlighted: true, pinned: true);

    var onUpdatedResult =
        chrome.tabs.onUpdated.where((e) => e.tab.url == url).first;
    var tab = await chrome.tabs.update(window.tabs!.first.id, updateProperties);
    expect(tab!.active, isTrue);
    expect(tab.highlighted, isTrue);
    expect(tab.pinned, isTrue);
    await onUpdatedResult;
  });

  test('move 1 tab', () async {
    var createProperties = CreateProperties(windowId: window.id, index: 0);
    var moveProperties = MoveProperties(index: -1);

    var newTab = await chrome.tabs.create(createProperties);
    var movedTabs = (await chrome.tabs.move(newTab.id!, moveProperties)) as Tab;
    expect(movedTabs.id, newTab.id);
    expect(movedTabs.index, 1);
  });

  test('move 2 tabs', () async {
    var createProperties = CreateProperties(windowId: window.id, index: 0);
    var createProperties2 = CreateProperties(windowId: window.id, index: 1);
    var moveProperties = MoveProperties(index: -1);

    var newTab1 = await chrome.tabs.create(createProperties);
    var newTab2 = await chrome.tabs.create(createProperties2);
    var movedTabs = (await chrome.tabs
        .move(<int>[newTab1.id!, newTab2.id!], moveProperties)) as List<Tab>;
    expect(movedTabs, isNotNull);

    expect(movedTabs, hasLength(2));
    expect(movedTabs[0].id, anyOf(newTab1.id, newTab2.id));
    expect(movedTabs[1].id, anyOf(newTab1.id, newTab2.id));
    expect(movedTabs[0].index, anyOf(1, 2));
    expect(movedTabs[1].index, anyOf(1, 2));
  });

  test('reload', () async {
    await chrome.tabs.reload(window.tabs!.first.id, null);
  });

  test('remove 1 tab', () async {
    var createProperties = CreateProperties(windowId: window.id, index: 0);
    var queryInfo = QueryInfo(windowId: window.id);
    var tab = await chrome.tabs.create(createProperties);
    await chrome.tabs.remove(tab.id!);
    var currentTabs = await chrome.tabs.query(queryInfo);
    expect(currentTabs, hasLength(1));
  });

  test('remove 2 tabs', () async {
    var createProperties = CreateProperties(windowId: window.id, index: 0);
    var createProperties2 = CreateProperties(windowId: window.id, index: 1);
    var queryInfo = QueryInfo(windowId: window.id);
    var newTab1 = await chrome.tabs.create(createProperties);
    var newTab2 = await chrome.tabs.create(createProperties2);
    await chrome.tabs.remove(<int>[newTab1.id!, newTab2.id!]);
    var currentTabs = await chrome.tabs.query(queryInfo);
    expect(currentTabs, hasLength(1));
  });

  test('onCreated', () async {
    late StreamSubscription subscription;
    subscription = chrome.tabs.onCreated.listen(expectAsync1((Tab tab) {
      expect(tab.windowId, window.id);
      subscription.cancel();
    }));

    var createProperties = CreateProperties(windowId: window.id);
    await chrome.tabs.create(createProperties);
  });

  test('onUpdated', () async {
    late StreamSubscription subscription;
    subscription =
        chrome.tabs.onUpdated.listen(expectAsync1((OnUpdatedEvent evt) {
      expect(evt.tab.windowId, window.id);
      expect(evt.changeInfo.status, TabStatus.loading);
      expect(evt.changeInfo.url, contains('www.google.com'));
      subscription.cancel();
    }));
    var updateProperties = UpdateProperties(url: 'https://www.google.com/');
    await chrome.tabs.update(window.tabs!.first.id, updateProperties);
  });

  test('onMoved', () async {
    var createProperties = CreateProperties(windowId: window.id, index: 0);
    var tab = await chrome.tabs.create(createProperties);

    var onMoved = chrome.tabs.onMoved.first;
    var moveProperties = MoveProperties(index: -1);
    await chrome.tabs.move(tab.id!, moveProperties);
    var evt = await onMoved;
    expect(evt.tabId, tab.id);
    expect(evt.moveInfo.windowId, equals(window.id));
    expect(evt.moveInfo.fromIndex, equals(0));
    expect(evt.moveInfo.toIndex, equals(1));
  });

  test('onActivated', () async {
    var createProperties =
        CreateProperties(windowId: window.id, index: 0, active: false);
    var tab = await chrome.tabs.create(createProperties);
    late StreamSubscription subscription;
    subscription = chrome.tabs.onActivated
        .listen(expectAsync1((OnActivatedActiveInfo evt) {
      expect(evt.tabId, tab.id);
      expect(evt.windowId, window.id);
      subscription.cancel();
    }));
    var updateProperties = UpdateProperties(active: true);
    await chrome.tabs.update(tab.id, updateProperties);
  });

  test('highlight throw exception if pass id', () async {
    var newTab1 = await chrome.tabs.create(CreateProperties(
        windowId: window.id,
        index: 0,
        url: context.staticPath('assets/simple_page.html')));
    expect(
        () => chrome.tabs
            .highlight(HighlightInfo(windowId: window.id, tabs: newTab1.id!)),
        throwsA(anything));
  });

  test('onHighlighted', () async {
    var newTab1 = await chrome.tabs.create(CreateProperties(
        windowId: window.id,
        index: 0,
        url: context.staticPath('assets/simple_page.html')));
    var newTab2 = await chrome.tabs
        .create(CreateProperties(windowId: window.id, index: 1));
    var onHighlighted = chrome.tabs.onHighlighted.first;
    await chrome.tabs.highlight(HighlightInfo(
        windowId: window.id, tabs: [newTab1.index, newTab2.index]));
    var result = await onHighlighted;
    expect(result.tabIds, [newTab1.id, newTab2.id]);
  });

  test('onDetached', () async {
    var createProperties = CreateProperties(windowId: window.id);
    var tab = await chrome.tabs.create(createProperties);
    late StreamSubscription subscription;
    subscription =
        chrome.tabs.onDetached.listen(expectAsync1((OnDetachedEvent evt) {
      expect(evt.tabId, tab.id);
      expect(evt.detachInfo.oldWindowId, window.id);
      expect(evt.detachInfo.oldPosition, 1);
      subscription.cancel();
    }));
    var createData = CreateData(tabId: tab.id);
    var newWindow = (await chrome.windows.create(createData))!;
    await chrome.windows.remove(newWindow.id!);
  });

  test('onAttached', () async {
    var createProperties = CreateProperties(windowId: window.id);
    var tab = await chrome.tabs.create(createProperties);
    late StreamSubscription subscription;
    subscription =
        chrome.tabs.onAttached.listen(expectAsync1((OnAttachedEvent evt) {
      expect(evt.tabId, tab.id);
      expect(evt.attachInfo.newWindowId, isNot(window.id));
      expect(evt.attachInfo.newPosition, 0);
      subscription.cancel();
    }));
    var createData = CreateData(tabId: tab.id);
    var newWindow = (await chrome.windows.create(createData))!;
    await chrome.windows.remove(newWindow.id!);
  });

  test('onRemoved', () async {
    var createProperties = CreateProperties(windowId: window.id);
    var tab = await chrome.tabs.create(createProperties);
    late StreamSubscription subscription;
    subscription =
        chrome.tabs.onRemoved.listen(expectAsync1((OnRemovedEvent evt) {
      expect(evt.tabId, tab.id);
      expect(evt.removeInfo.windowId, window.id);
      expect(evt.removeInfo.isWindowClosing, isFalse);
      subscription.cancel();
    }));
    await chrome.tabs.remove(<int>[tab.id!]);
  });

  // TODO: Figure out how to force a tab replacement
  test('onReplaced', () {
    chrome.tabs.onReplaced.listen((_) {}).cancel();
  }, skip: 'Figure out how to force a tab replacement');
}
