import 'package:checks/checks.dart';
import 'package:chrome_apis/runtime.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('getPackageDirectoryEntry', () async {
    var directoryEntry = (await chrome.runtime.getPackageDirectoryEntry())
        as web.FileSystemDirectoryEntry;
    check(directoryEntry.name).isNotEmpty();
  });

  test('getBackgroundPage', () async {
    expect(
        () => chrome.runtime.getBackgroundPage(),
        throwsA((e) => e
            .toString()
            .contains('Error: You do not have a background page.')));
  });
}
