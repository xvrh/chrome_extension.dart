import 'package:checks/checks.dart';
import 'package:chrome_apis/chrome.dart';
import 'package:test/test.dart';
import '../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('available', () async {
    check(chrome.action.isAvailable, because: 'action').isFalse();
    check(chrome.alarms.isAvailable, because: 'alarms').isFalse();
    check(chrome.audio.isAvailable, because: 'audio').isFalse();
    check(chrome.bookmarks.isAvailable, because: 'bookmarks').isFalse();
    check(chrome.browsingData.isAvailable, because: 'browsingData').isFalse();
    check(chrome.certificateProvider.isAvailable,
            because: 'certificateProvider')
        .isFalse();
    check(chrome.commands.isAvailable, because: 'commands').isFalse();
    check(chrome.contentSettings.isAvailable, because: 'contentSettings')
        .isFalse();
    check(chrome.contextMenus.isAvailable, because: 'contextMenus').isFalse();
    check(chrome.cookies.isAvailable, because: 'cookies').isFalse();
    check(chrome.debugger.isAvailable, because: 'debugger').isFalse();
    check(chrome.declarativeContent.isAvailable, because: 'declarativeContent')
        .isFalse();
    check(chrome.declarativeNetRequest.isAvailable,
            because: 'declarativeNetRequest')
        .isFalse();
    check(chrome.desktopCapture.isAvailable, because: 'desktopCapture')
        .isFalse();
    check(chrome.devtools.inspectedWindow.isAvailable,
            because: 'devtools.inspectedWindow')
        .isFalse();
    check(chrome.devtools.network.isAvailable, because: 'devtools.network')
        .isFalse();
    check(chrome.devtools.panels.isAvailable, because: 'devtools.panels')
        .isFalse();
    check(chrome.devtools.recorder.isAvailable, because: 'devtools.recorder')
        .isFalse();
    check(chrome.documentScan.isAvailable, because: 'documentScan').isFalse();
    check(chrome.dom.isAvailable, because: 'dom').isTrue();
    check(chrome.downloads.isAvailable, because: 'downloads').isFalse();
    check(chrome.enterprise.deviceAttributes.isAvailable,
            because: 'enterprise.deviceAttributes')
        .isFalse();
    check(chrome.enterprise.hardwarePlatform.isAvailable,
            because: 'enterprise.hardwarePlatform')
        .isFalse();
    check(chrome.enterprise.networkingAttributes.isAvailable,
            because: 'enterprise.networkingAttributes')
        .isFalse();
    check(chrome.enterprise.platformKeys.isAvailable,
            because: 'enterprise.platformKeys')
        .isFalse();
    check(chrome.extension.isAvailable, because: 'extension').isTrue();
    check(chrome.extensionTypes.isAvailable, because: 'extensionTypes')
        .isFalse();
    check(chrome.fileBrowserHandler.isAvailable, because: 'fileBrowserHandler')
        .isFalse();
    check(chrome.fileSystemProvider.isAvailable, because: 'fileSystemProvider')
        .isFalse();
    check(chrome.fontSettings.isAvailable, because: 'fontSettings').isFalse();
    check(chrome.gcm.isAvailable, because: 'gcm').isFalse();
    check(chrome.history.isAvailable, because: 'history').isFalse();
    check(chrome.i18n.isAvailable, because: 'i18n').isTrue();
    check(chrome.identity.isAvailable, because: 'identity').isFalse();
    check(chrome.idle.isAvailable, because: 'idle').isFalse();
    check(chrome.input.ime.isAvailable, because: 'input.ime').isFalse();
    check(chrome.instanceId.isAvailable, because: 'instanceId').isFalse();
    check(chrome.loginState.isAvailable, because: 'loginState').isFalse();
    check(chrome.management.isAvailable, because: 'management').isTrue();
    check(chrome.notifications.isAvailable, because: 'notifications').isFalse();
    check(chrome.offscreen.isAvailable, because: 'offscreen').isFalse();
    check(chrome.omnibox.isAvailable, because: 'omnibox').isFalse();
    check(chrome.pageAction.isAvailable, because: 'pageAction').isFalse();
    check(chrome.pageCapture.isAvailable, because: 'pageCapture').isFalse();
    check(chrome.permissions.isAvailable, because: 'permissions').isTrue();
    check(chrome.platformKeys.isAvailable, because: 'platformKeys').isFalse();
    check(chrome.power.isAvailable, because: 'power').isFalse();
    check(chrome.printerProvider.isAvailable, because: 'printerProvider')
        .isFalse();
    check(chrome.printing.isAvailable, because: 'printing').isFalse();
    check(chrome.printingMetrics.isAvailable, because: 'printingMetrics')
        .isFalse();
    check(chrome.privacy.isAvailable, because: 'privacy').isFalse();
    check(chrome.processes.isAvailable, because: 'processes').isFalse();
    check(chrome.proxy.isAvailable, because: 'proxy').isFalse();
    check(chrome.runtime.isAvailable, because: 'runtime').isTrue();
    check(chrome.scripting.isAvailable, because: 'scripting').isFalse();
    check(chrome.search.isAvailable, because: 'search').isFalse();
    check(chrome.sessions.isAvailable, because: 'sessions').isFalse();
    check(chrome.sidePanel.isAvailable, because: 'sidePanel').isFalse();
    check(chrome.storage.isAvailable, because: 'storage').isFalse();
    check(chrome.system.cpu.isAvailable, because: 'system.cpu').isFalse();
    check(chrome.system.display.isAvailable, because: 'system.display')
        .isFalse();
    check(chrome.system.memory.isAvailable, because: 'system.memory').isFalse();
    check(chrome.system.network.isAvailable, because: 'system.network')
        .isFalse();
    check(chrome.system.storage.isAvailable, because: 'system.storage')
        .isFalse();
    check(chrome.tabCapture.isAvailable, because: 'tabCapture').isFalse();
    check(chrome.tabGroups.isAvailable, because: 'tabGroups').isFalse();
    check(chrome.tabs.isAvailable, because: 'tabs').isTrue();
    check(chrome.tts.isAvailable, because: 'tts').isFalse();
    check(chrome.ttsEngine.isAvailable, because: 'ttsEngine').isFalse();
    check(chrome.vpnProvider.isAvailable, because: 'vpnProvider').isFalse();
    check(chrome.wallpaper.isAvailable, because: 'wallpaper').isFalse();
    check(chrome.webAuthenticationProxy.isAvailable,
            because: 'webAuthenticationProxy')
        .isFalse();
    check(chrome.webNavigation.isAvailable, because: 'webNavigation').isFalse();
    check(chrome.webRequest.isAvailable, because: 'webRequest').isFalse();
    check(chrome.windows.isAvailable, because: 'windows').isTrue();
    await check(chrome.system.storage.getInfo()).throws<Exception>();
  });
}
