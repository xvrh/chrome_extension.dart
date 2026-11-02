library;

import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'generator/download/github.dart';

void main() => IdlDownloader().downloadIdls();

class IdlDownloader {
  static final _version = '156.0.8078.73';

  /// The directories of the Chromium source with the API schemas, and the
  /// local directory (in `idl/`) to download them to.
  static final _idlDirs = {
    'chrome/common/extensions/api': 'chrome',
    'extensions/common/api': 'extensions',
    'chromeos/ash/experiences/extensions/common/api': 'chromeos',
  };
  static final _extensions = ['.idl', '.webidl', '.json'];

  /// Downloads the API schemas of Chrome [_version] from the GitHub mirror of
  /// the Chromium source.
  ///
  /// Set the `GITHUB_TOKEN` environment variable if the GitHub API rate limit
  /// for anonymous requests is exceeded.
  Future downloadIdls() async {
    print('Downloading IDL and JSON for APIs at Chrome $_version');
    var github = GitHubDownloader(
        repository: 'chromium/chromium',
        ref: _version,
        token: Platform.environment['GITHUB_TOKEN']);
    try {
      for (var MapEntry(key: sourceDir, value: localDir) in _idlDirs.entries) {
        var targetDir = Directory(p.join('idl', localDir));
        // Start from scratch so that the files removed or renamed upstream
        // (for example .idl converted to .webidl) don't linger.
        if (targetDir.existsSync()) targetDir.deleteSync(recursive: true);

        await for (var file in github.listFiles(sourceDir,
            filter: (path) => _extensions.any(path.endsWith))) {
          var localFile = File(p.join(
              targetDir.path, p.posix.relative(file.path, from: sourceDir)));
          localFile.parent.createSync(recursive: true);
          localFile.writeAsStringSync(await github.download(file));
        }
      }
    } finally {
      github.close();
    }
  }
}
