import 'dart:async';
import 'package:checks/checks.dart';
import 'package:chrome_apis/downloads.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('download', () async {
    late StreamSubscription subscription;
    subscription = chrome.downloads.onCreated.listen(expectAsync1((e) {
      check(e.url).endsWith('icon.svg');
      subscription.cancel();
    }));

    var completer = Completer();
    var onChangedSubscription = chrome.downloads.onChanged.listen((e) {
      if (e.state?.current == State.complete.value) {
        completer.complete();
      }
    });

    var result = await chrome.downloads
        .download(DownloadOptions(url: context.staticPath('assets/icon.svg')));
    check(result).isGreaterThan(0);

    await completer.future;

    await onChangedSubscription.cancel();

    var downloads = await chrome.downloads.search(DownloadQuery(id: result));
    check(downloads).length.equals(1);
    var download = downloads.first;

    check(download.fileSize).equals(688);

    await chrome.downloads.removeFile(download.id);
  });

  test('onDeterminingFilename', () async {
    var suggestionSubscription =
        chrome.downloads.onDeterminingFilename.listen((e) {
      e.suggest(FilenameSuggestion(
          filename: 'toto.png',
          conflictAction: FilenameConflictAction.overwrite));
    });

    late StreamSubscription subscription;
    subscription = chrome.downloads.onCreated.listen(expectAsync1((e) {
      check(e.url).endsWith('icon.svg');
      subscription.cancel();
    }));

    var completer = Completer();
    var onChangedSubscription = chrome.downloads.onChanged.listen((e) {
      if (e.state?.current == State.complete.value) {
        completer.complete();
      }
    });

    var id = await chrome.downloads
        .download(DownloadOptions(url: context.staticPath('assets/icon.svg')));

    await completer.future;

    await onChangedSubscription.cancel();
    await suggestionSubscription.cancel();

    var downloads = await chrome.downloads.search(DownloadQuery(id: id));
    check(downloads).length.equals(1);
    var download = downloads.first;

    check(download.filename).endsWith('toto.svg');
    await chrome.downloads.removeFile(download.id);
  });
}
