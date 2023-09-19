# chrome_extension.dart

[![pub package](https://img.shields.io/pub/v/chrome_extension.svg)](https://pub.dartlang.org/packages/chrome_extension)
[![Build Status](https://github.com/xvrh/chrome_extension.dart/workflows/Build/badge.svg)](https://github.com/xvrh/chrome_extension.dart)

A library for accessing the `chrome.*` [APIs](https://developer.chrome.com/docs/extensions/reference/) available in Chrome extensions.

This allows to build [Chrome extension](https://developer.chrome.com/docs/extensions/) with [Dart](https://dart.dev) & [Flutter](https://flutter.dev) and to interop with the native APIs easily with a high-level type-safe interface.

The JS interop is build on top of `dart:js_interop` (static interop) which make it ready for future WASM compilation.

## Using the library

### Example

```dart
import 'package:chrome_extension/alarms.dart';
import 'package:chrome_extension/power.dart';
import 'package:chrome_extension/storage.dart';

void main() async {
  // Use the chrome.power API
  chrome.power.requestKeepAwake(Level.display);

  // Use the chrome.storage API
  await chrome.storage.local.set({'mykey': 'value'});
  var values = await chrome.storage.local.get(null /* all */);
  print(values['mykey']);

  // Use the chrome.alarms API
  await chrome.alarms.create('MyAlarm', AlarmCreateInfo(delayInMinutes: 2));
}
```

### Available APIs

- `package:chrome_extension/accessibility_features.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/accessibilityFeatures/))
- `package:chrome_extension/action.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/action/))
- `package:chrome_extension/alarms.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/alarms/))
- `package:chrome_extension/audio.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/audio/))
- `package:chrome_extension/bookmarks.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/bookmarks/))
- `package:chrome_extension/browser_action.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/browserAction/))
- `package:chrome_extension/browsing_data.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/browsingData/))
- `package:chrome_extension/certificate_provider.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/certificateProvider/))
- `package:chrome_extension/commands.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/commands/))
- `package:chrome_extension/content_settings.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/contentSettings/))
- `package:chrome_extension/context_menus.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/contextMenus/))
- `package:chrome_extension/cookies.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/cookies/))
- `package:chrome_extension/debugger.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/debugger/))
- `package:chrome_extension/declarative_content.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/declarativeContent/))
- `package:chrome_extension/declarative_net_request.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/declarativeNetRequest/))
- `package:chrome_extension/desktop_capture.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/desktopCapture/))
- `package:chrome_extension/devtools_inspected_window.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/devtools_inspectedWindow/))
- `package:chrome_extension/devtools_network.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/devtools_network/))
- `package:chrome_extension/devtools_panels.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/devtools_panels/))
- `package:chrome_extension/devtools_recorder.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/devtools_recorder/))
- `package:chrome_extension/document_scan.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/documentScan/))
- `package:chrome_extension/dom.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/dom/))
- `package:chrome_extension/downloads.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/downloads/))
- `package:chrome_extension/enterprise_device_attributes.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/enterprise_deviceAttributes/))
- `package:chrome_extension/enterprise_hardware_platform.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/enterprise_hardwarePlatform/))
- `package:chrome_extension/enterprise_networking_attributes.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/enterprise_networkingAttributes/))
- `package:chrome_extension/enterprise_platform_keys.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/enterprise_platformKeys/))
- `package:chrome_extension/events.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/events/))
- `package:chrome_extension/extension.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/extension/))
- `package:chrome_extension/extension_types.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/extensionTypes/))
- `package:chrome_extension/file_browser_handler.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/fileBrowserHandler/))
- `package:chrome_extension/file_system_provider.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/fileSystemProvider/))
- `package:chrome_extension/font_settings.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/fontSettings/))
- `package:chrome_extension/gcm.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/gcm/))
- `package:chrome_extension/history.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/history/))
- `package:chrome_extension/i18n.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/i18n/))
- `package:chrome_extension/identity.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/identity/))
- `package:chrome_extension/idle.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/idle/))
- `package:chrome_extension/input_ime.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/input_ime/))
- `package:chrome_extension/instance_id.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/instanceId/))
- `package:chrome_extension/login_state.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/loginState/))
- `package:chrome_extension/management.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/management/))
- `package:chrome_extension/notifications.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/notifications/))
- `package:chrome_extension/offscreen.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/offscreen/))
- `package:chrome_extension/omnibox.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/omnibox/))
- `package:chrome_extension/page_action.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/pageAction/))
- `package:chrome_extension/page_capture.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/pageCapture/))
- `package:chrome_extension/permissions.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/permissions/))
- `package:chrome_extension/platform_keys.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/platformKeys/))
- `package:chrome_extension/power.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/power/))
- `package:chrome_extension/printer_provider.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/printerProvider/))
- `package:chrome_extension/printing.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/printing/))
- `package:chrome_extension/printing_metrics.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/printingMetrics/))
- `package:chrome_extension/privacy.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/privacy/))
- `package:chrome_extension/processes.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/processes/))
- `package:chrome_extension/proxy.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/proxy/))
- `package:chrome_extension/runtime.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/runtime/))
- `package:chrome_extension/scripting.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/scripting/))
- `package:chrome_extension/search.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/search/))
- `package:chrome_extension/sessions.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/sessions/))
- `package:chrome_extension/side_panel.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/sidePanel/))
- `package:chrome_extension/storage.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/storage/))
- `package:chrome_extension/system_cpu.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/system_cpu/))
- `package:chrome_extension/system_display.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/system_display/))
- `package:chrome_extension/system_memory.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/system_memory/))
- `package:chrome_extension/system_network.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/system_network/))
- `package:chrome_extension/system_storage.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/system_storage/))
- `package:chrome_extension/tab_capture.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/tabCapture/))
- `package:chrome_extension/tab_groups.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/tabGroups/))
- `package:chrome_extension/tabs.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/tabs/))
- `package:chrome_extension/top_sites.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/topSites/))
- `package:chrome_extension/tts.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/tts/))
- `package:chrome_extension/tts_engine.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/ttsEngine/))
- `package:chrome_extension/types.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/types/))
- `package:chrome_extension/vpn_provider.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/vpnProvider/))
- `package:chrome_extension/wallpaper.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/wallpaper/))
- `package:chrome_extension/web_authentication_proxy.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/webAuthenticationProxy/))
- `package:chrome_extension/web_navigation.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/webNavigation/))
- `package:chrome_extension/web_request.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/webRequest/))
- `package:chrome_extension/windows.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/windows/))
- `package:chrome_extension/usb.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/usb/))


## Documentation

* [Chrome Extensions API reference](https://developer.chrome.com/docs/extensions/reference/)
* See [example folder](https://github.com/xvrh/chrome_extension/tree/main/extension_examples) for some examples of Flutter and Dart Chrome extensions

## Tips to build Chrome extensions with Flutter

#### Develop the app using Flutter Desktop

In order to develop in a comfortable environment with hot-reload,
most of the app can be developed using Flutter desktop.

This will require an abstraction layer between the UI and the `chrome_extension` APIs.

A fake implementation of this abstraction layer is used in the Desktop entry point:

```dart
// lib/main_desktop.dart
void main() {
  // Inject a fake service that doesn't use the real chrome_extension package.
  var service = FakeBookmarkService();
  runApp(MyExtensionPopup(service));
}

abstract class BookmarkService {
  Future<List<Bookmark>> getBookmarks();
}

class FakeBookmarkService implements BookmarkService {
  @override
  Future<List<Bookmark>> getBookmarks() async => [Bookmark()];
}
```

Launch this entry point in desktop with  
`flutter run -t lib/main_desktop.dart -d macos|windows|linux`

Create the real entry point:

```dart
// lib/main.dart
void main() {
  var service = ChromeBookmarkService();
  runApp(MyExtensionPopup(service));
}

class ChromeBookmarkService implements BookmarkService {
  @override
  Future<List<Bookmark>> getBookmarks() async {
    // Real implementation using chrome.bookmarks
    return (await chrome.bookmarks.getTree()).map(Bookmark.new).toList();
  }
}
```

#### Build script

`web/manifest.json`
```json
{
  "manifest_version": 3,
  "name": "my_extension",
  "permissions": [
    "activeTab"
  ],
  "options_page": "options.html",
  "background": {
    "service_worker": "background.dart.js"
  },
  "action": {
    "default_popup": "index.html",
    "default_icon": {
      "16": "icons-16.png"
    }
  },
  "content_security_policy": {
    "extension_pages": "script-src 'self' 'wasm-unsafe-eval'; object-src 'self';"
  }
}
```

```dart
// tool/build.dart
void main() async {
  await _process.runProcess([
    'flutter',
    'build',
    'web',
    '-t',
    'web/popup.dart',
    '--csp',
    '--web-renderer=canvaskit',
    '--no-web-resources-cdn',
  ]);
  for (var script in [
    'background.dart',
    'content_script.dart',
    'options.dart'
  ]) {
    await _process.runProcess([
      Platform.resolvedExecutable,
      'compile',
      'js',
      'web/$script',
      '--output',
      'build/web/$script.js',
    ]);
  }
}
```

It builds the flutter app and compiles all the other Dart scripts
(for example: options.dart.js, popup.dart.js, background.dart.js)

#### Testing

Write tests for the extension using [`puppeteer-dart`](https://pub.dev/packages/puppeteer).

```dart
import 'package:collection/collection.dart';
import 'package:puppeteer/puppeteer.dart';

void main() async {
  // Compile the extension
  var extensionPath = '...';

  var browser = await puppeteer.launch(
    headless: false,
    args: [
      '--disable-extensions-except=$extensionPath',
      '--load-extension=$extensionPath',
      // Allow to connect to puppeteer from inside your extension if needed for the testing
      '--remote-allow-origins=*',
    ],
  );

  // Find the background page target
  var targetName = 'service_worker';
  var backgroundPageTarget =
      browser.targets.firstWhereOrNull((t) => t.type == targetName);
  backgroundPageTarget ??=
      await browser.waitForTarget((target) => target.type == targetName);
  var worker = (await backgroundPageTarget.worker)!;

  var url = Uri.parse(worker.url!);
  assert(url.scheme == 'chrome-extension');
  var extensionId = url.host;

  // Go to the popup page
  await (await browser.pages)
      .first
      .goto('chrome-extension://$extensionId/popup.html');

  // Etc...
}
```