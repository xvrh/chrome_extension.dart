# chrome_apis

A library for accessing the `chrome.*` [APIs](https://developer.chrome.com/docs/extensions/reference/) available in Chrome extensions.

This allows to build [Chrome extension](https://developer.chrome.com/docs/extensions/) with [Dart](https://dart.dev) & [Flutter](https://flutter.dev) and to interop with the native APIs easily with a high-level type-safe interface.

The JS interop is build on top of `dart:js_interop` (static interop) which make it ready for future WASM compilation.

## Using the library

### Example

```dart
import 'package:chrome_apis/alarms.dart';
import 'package:chrome_apis/power.dart';
import 'package:chrome_apis/storage.dart';

void main() async {
  // Use the chrome.power API
  chrome.power.requestKeepAwake(Level.display);

  // Use the chrome.storage API
  await chrome.storage.sync.set({'mykey': 'value'});
  var values = await chrome.storage.sync.get(null /* all */);
  print(values['mykey']);

  // Use the chrome.alarms API
  await chrome.alarms.create('MyAlarm', AlarmCreateInfo(delayInMinutes: 2));
}
```

### Available APIs

- `package:chrome_apis/accessibility_features.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/accessibilityFeatures/))
- `package:chrome_apis/action.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/action/))
- `package:chrome_apis/alarms.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/alarms/))
- `package:chrome_apis/audio.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/audio/))
- `package:chrome_apis/bookmarks.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/bookmarks/))
- `package:chrome_apis/browser_action.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/browserAction/))
- `package:chrome_apis/browsing_data.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/browsingData/))
- `package:chrome_apis/certificate_provider.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/certificateProvider/))
- `package:chrome_apis/commands.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/commands/))
- `package:chrome_apis/content_settings.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/contentSettings/))
- `package:chrome_apis/context_menus.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/contextMenus/))
- `package:chrome_apis/cookies.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/cookies/))
- `package:chrome_apis/debugger.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/debugger/))
- `package:chrome_apis/declarative_content.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/declarativeContent/))
- `package:chrome_apis/declarative_net_request.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/declarativeNetRequest/))
- `package:chrome_apis/desktop_capture.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/desktopCapture/))
- `package:chrome_apis/devtools_inspected_window.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/devtools_inspectedWindow/))
- `package:chrome_apis/devtools_network.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/devtools_network/))
- `package:chrome_apis/devtools_panels.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/devtools_panels/))
- `package:chrome_apis/devtools_recorder.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/devtools_recorder/))
- `package:chrome_apis/document_scan.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/documentScan/))
- `package:chrome_apis/dom.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/dom/))
- `package:chrome_apis/downloads.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/downloads/))
- `package:chrome_apis/enterprise_device_attributes.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/enterprise_deviceAttributes/))
- `package:chrome_apis/enterprise_hardware_platform.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/enterprise_hardwarePlatform/))
- `package:chrome_apis/enterprise_networking_attributes.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/enterprise_networkingAttributes/))
- `package:chrome_apis/enterprise_platform_keys.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/enterprise_platformKeys/))
- `package:chrome_apis/events.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/events/))
- `package:chrome_apis/extension.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/extension/))
- `package:chrome_apis/extension_types.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/extensionTypes/))
- `package:chrome_apis/file_browser_handler.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/fileBrowserHandler/))
- `package:chrome_apis/file_system_provider.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/fileSystemProvider/))
- `package:chrome_apis/font_settings.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/fontSettings/))
- `package:chrome_apis/gcm.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/gcm/))
- `package:chrome_apis/history.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/history/))
- `package:chrome_apis/i18n.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/i18n/))
- `package:chrome_apis/identity.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/identity/))
- `package:chrome_apis/idle.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/idle/))
- `package:chrome_apis/input_ime.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/input_ime/))
- `package:chrome_apis/instance_id.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/instanceId/))
- `package:chrome_apis/login_state.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/loginState/))
- `package:chrome_apis/management.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/management/))
- `package:chrome_apis/notifications.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/notifications/))
- `package:chrome_apis/offscreen.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/offscreen/))
- `package:chrome_apis/omnibox.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/omnibox/))
- `package:chrome_apis/page_action.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/pageAction/))
- `package:chrome_apis/page_capture.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/pageCapture/))
- `package:chrome_apis/permissions.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/permissions/))
- `package:chrome_apis/platform_keys.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/platformKeys/))
- `package:chrome_apis/power.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/power/))
- `package:chrome_apis/printer_provider.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/printerProvider/))
- `package:chrome_apis/printing.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/printing/))
- `package:chrome_apis/printing_metrics.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/printingMetrics/))
- `package:chrome_apis/privacy.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/privacy/))
- `package:chrome_apis/processes.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/processes/))
- `package:chrome_apis/proxy.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/proxy/))
- `package:chrome_apis/runtime.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/runtime/))
- `package:chrome_apis/scripting.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/scripting/))
- `package:chrome_apis/search.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/search/))
- `package:chrome_apis/sessions.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/sessions/))
- `package:chrome_apis/side_panel.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/sidePanel/))
- `package:chrome_apis/storage.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/storage/))
- `package:chrome_apis/system_cpu.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/system_cpu/))
- `package:chrome_apis/system_display.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/system_display/))
- `package:chrome_apis/system_memory.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/system_memory/))
- `package:chrome_apis/system_network.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/system_network/))
- `package:chrome_apis/system_storage.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/system_storage/))
- `package:chrome_apis/tab_capture.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/tabCapture/))
- `package:chrome_apis/tab_groups.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/tabGroups/))
- `package:chrome_apis/tabs.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/tabs/))
- `package:chrome_apis/top_sites.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/topSites/))
- `package:chrome_apis/tts.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/tts/))
- `package:chrome_apis/tts_engine.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/ttsEngine/))
- `package:chrome_apis/types.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/types/))
- `package:chrome_apis/vpn_provider.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/vpnProvider/))
- `package:chrome_apis/wallpaper.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/wallpaper/))
- `package:chrome_apis/web_authentication_proxy.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/webAuthenticationProxy/))
- `package:chrome_apis/web_navigation.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/webNavigation/))
- `package:chrome_apis/web_request.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/webRequest/))
- `package:chrome_apis/windows.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/windows/))
- `package:chrome_apis/usb.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/usb/))


## Documentation

* [Chrome Extensions API reference](https://developer.chrome.com/docs/extensions/reference/)
* See [example folder](https://github.com/xvrh/chrome.dart/tree/master/chrome_apis/example/)