import 'dart:async';
import 'package:checks/checks.dart';
import 'package:chrome_apis/bookmarks.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('create', () async {
    var node = await chrome.bookmarks.create(
        CreateDetails(title: 'One bookmark', url: 'https://google.com'));
    check(node.url).equals('https://google.com/');
    check(node.title).equals('One bookmark');

    var nodes = await chrome.bookmarks.get(node.id);
    check(nodes).length.equals(1);
    check(nodes.first.url).equals('https://google.com/');

    await chrome.bookmarks.remove(node.id);
  });

  test('getTree', () async {
    var node = await chrome.bookmarks.create(
        CreateDetails(title: 'One bookmark', url: 'https://google.com'));
    var tree = await chrome.bookmarks.getTree();

    check(tree).isNotEmpty();
    await chrome.bookmarks.remove(node.id);
  });

  test('Events', () async {
    late StreamSubscription s1;
    s1 = chrome.bookmarks.onCreated.listen(expectAsync1((e) {
      check(e.id).isNotNull();
      check(e.bookmark.id).isNotNull();
      check(e.bookmark.title).isNotNull();

      s1.cancel();
    }));
    late StreamSubscription s2;
    s2 = chrome.bookmarks.onRemoved.listen(expectAsync1((e) {
      check(e.id).isNotNull();
      check(e.removeInfo.index).isNotNull();
      s2.cancel();
    }));
    var node = await chrome.bookmarks.create(
        CreateDetails(title: 'One bookmark', url: 'https://google.com'));
    await chrome.bookmarks.remove(node.id);
  });

  test('Search by SearchQuery', () async {
    var node = await chrome.bookmarks.create(
        CreateDetails(title: 'One bookmark', url: 'https://google.com'));
    var found =
        await chrome.bookmarks.search(SearchQuery(url: 'https://google.com'));

    check(found.length).equals(1);
    check(found.first.id).equals(node.id);

    await chrome.bookmarks.remove(node.id);
  });

  test('Search by String', () async {
    var node = await chrome.bookmarks.create(
        CreateDetails(title: 'One bookmark', url: 'https://google.com'));
    var found = await chrome.bookmarks.search('google.com');

    check(found.length).equals(1);
    check(found.first.id).equals(node.id);

    await chrome.bookmarks.remove(node.id);
  });
}
