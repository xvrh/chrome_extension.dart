import 'package:checks/checks.dart';
import 'package:chrome_apis/devtools_inspected_window.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('tabId', () async {
    var tabId = chrome.devtools.inspectedWindow.tabId;
    check(tabId).isGreaterThan(0);
  });

  test('getResources', () async {
    var resources = await chrome.devtools.inspectedWindow.getResources();
    check(resources).isNotEmpty();
    check(resources.first.url).isNotEmpty();

    var content = await resources.first.getContent();
    check(content.content).length.isGreaterThan(0);
    check(content.content).contains('Simple page');
  });

  test('reload', () async {
    chrome.devtools.inspectedWindow.reload(ReloadOptions(
      ignoreCache: true,
    ));
  });

  test('eval', () async {
    var result = await chrome.devtools.inspectedWindow
        .eval('true', EvalOptions(useContentScriptContext: true));
    check(result.result).isNotNull();
    check(result.exceptionInfo).isNull();
  }, skip: 'Callback is never called, need to investigate');
}
