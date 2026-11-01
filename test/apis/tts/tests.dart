import 'package:checks/checks.dart';
import 'package:chrome_extension/tts.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('getVoices', () async {
    var voices = await chrome.tts.getVoices();

    // The voices list depends on the OS and the Chrome build, it is empty on
    // the CI and with recent versions of Chrome for Testing.
    if (voices.isNotEmpty) {
      var voice = voices.first;
      check(voice.lang).isNotNull();
      check(voice.voiceName).isNotNull();
    }
  });

  test('speak', () async {
    await chrome.tts.speak('Hello', TtsOptions(lang: 'en-US'));
  });
}
