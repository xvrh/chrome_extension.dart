import 'package:checks/checks.dart';
import 'package:chrome_apis/tts.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('getVoices', () async {
    var voices = await chrome.tts.getVoices();

    // The voices list is empty in the linux CI
    if (context.info.operatingSystem != 'linux') {
      check(voices).isNotEmpty();
      var voice = voices.first;
      check(voice.lang).isNotNull();
      check(voice.voiceName).isNotNull();
    }
  });

  test('speak', () async {
    await chrome.tts.speak('Hello', TtsOptions(lang: 'en-US'));
  });
}
