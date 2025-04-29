import 'package:chrome_extension/devtools_panels.dart';
import 'package:chrome_extension/src/internal_helpers.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('create', () async {
    var panel = await chrome.devtools.panels.create(
      'My panel',
      'icon.png',
      'panel.html',
    );
    var button = panel.createStatusBarButton('icon2.png', 'Tooltip', false);
    button.update('newicon.png', 'New tooltip', true);
  });

  test('create elements.sidebar', () async {
    var sidebar = await chrome.devtools.panels.elements.createSidebarPane(
      'My sidebar',
    );
    sidebar.setHeight('100px');
  });

  test('create source.sidebar', () async {
    var sidebar = await chrome.devtools.panels.sources.createSidebarPane(
      'My sidebar',
    );
    sidebar.setHeight('100px');
    sidebar.setPage('panel.html');
  });

  test('themeName', () async {
    var themeName = chrome.devtools.panels.themeName;
    expect(['default', 'dark'], contains(themeName));
  });

  test('setOpenResourceHandler', () async {
    chrome.devtools.panels.setOpenResourceHandler(() {}.toJS);
    chrome.devtools.panels.setOpenResourceHandler(null);
  });
}
