import 'package:chrome_extension/context_menus.dart';
import 'package:chrome_extension/runtime.dart' as runtime;
import 'package:chrome_extension/src/internal_helpers.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  var id = 'setupMenuItem';

  setUp(() {
    var createProperties = CreateProperties(id: id, title: 'setup menu item');
    chrome.contextMenus.create(createProperties, () {}.toJS);
  });

  tearDown(() async {
    await chrome.contextMenus.removeAll();
  });

  test('create -- defaults', () {
    var createProperties = CreateProperties(title: 'create -- defaults');

    var newId = chrome.contextMenus.create(createProperties, null) as int;
    expect(newId, greaterThan(0));
  });

  test('create -- with listener', () {
    var createProperties = CreateProperties(title: 'create -- with listener');

    // TODO: figure out a mechanism for selecting menu
    var newId = chrome.contextMenus.create(createProperties, () {}.toJS) as int;
    expect(newId, greaterThan(0));
  });

  test('create -- with many options specified', () {
    var createProperties = CreateProperties(
        type: ItemType.checkbox,
        id: 'testId',
        title: 'create -- with many options specified',
        checked: true,
        contexts: [ContextType.frame, ContextType.selection],
        parentId: id,
        documentUrlPatterns: ['https://www.google.com/'],
        targetUrlPatterns: ['https://www.google.com/'],
        enabled: false);

    var newId = chrome.contextMenus.create(
        createProperties,
        expectAsync0(() {
          expect(chrome.runtime.lastError, isNull);
        }).toJS) as String;
    expect(newId, equals("testId"));
  });

  test('update -- title', () async {
    var updateProperties = UpdateProperties(title: 'update -- title');

    await chrome.contextMenus.update(id, updateProperties);
  });

  test('update -- listener', () async {
    var updateProperties = UpdateProperties();

    // TODO: figure out a mechanism for selecting menu
    await chrome.contextMenus.update(id, updateProperties);
  });

  test('update -- with many options specified', () async {
    var createProperties = CreateProperties(
        id: 'testId', title: 'update -- with many options specified');

    var updateProperties = UpdateProperties(
        type: ItemType.checkbox,
        checked: true,
        contexts: [ContextType.frame, ContextType.selection],
        parentId: id,
        documentUrlPatterns: ['https://www.google.com/'],
        targetUrlPatterns: ['https://www.google.com/'],
        enabled: false);

    var newId = chrome.contextMenus.create(createProperties, null);
    expect(newId, equals("testId"));

    await chrome.contextMenus.update(newId, updateProperties);
  });

  test('update -- failure', () async {
    var updateProperties = UpdateProperties();

    expect(
        () async =>
            await chrome.contextMenus.update('not a real id', updateProperties),
        throwsA(isA<Exception>()));
  });

  test('remove -- successful', () async {
    await chrome.contextMenus.remove(id);
  });

  test('remove -- failure', () async {
    expect(() async => await chrome.contextMenus.remove('not a real id'),
        throwsA(isA<Exception>()));
  });
}
