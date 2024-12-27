library;

import 'dart:async';
import 'dart:io';
import 'generator/download/googlesource.dart';

void main() => IdlDownloader().downloadIdls();

class IdlDownloader {
  static final _version = '122.0.6261.69';
  static final _chromiumBaseUrl = 'https://chromium.googlesource.com';
  static final _chromiumVersionPrefix = '/chromium/src/+/';
  static final _idlDirs = [
    'chrome/common/extensions/api',
    'extensions/common/api'
  ];

  /// Finds the latest version of the Chrome IDL spec and downloads the files
  /// to the appropriate local directories.
  ///
  /// The process is as follows: using the current version of Chrome, as
  /// provided by the [OmahaVersionExtractor], we determine the path to the
  /// source. Then, we crawl the source, with a [GoogleSourceCrawler], starting
  /// in the directories we expect to find IDL and JSON files. Any files we
  /// find, we download.
  Future downloadIdls() async {
    var version = _version;
    print('Downloading IDL and JSON for APIs at Chrome $version');
    var googleSourceCrawler = GoogleSourceCrawler(_chromiumBaseUrl);
    for (var dir in _idlDirs) {
      var relativePath = '$_chromiumVersionPrefix$version/$dir';
      await for (var file
          in googleSourceCrawler.findAllMatchingFiles(relativePath)) {
        try {
          await _downloadFile(file);
        } catch (e) {
          print(
              'Failed to download file: ${file.url}. ${e.runtimeType} $e.\n${file.rawHtml}');
          rethrow;
        }
      }
    }
  }

  Future _downloadFile(GoogleSourceFile file) async {
    var filePath = file.url.replaceFirst('/', '');
    var localFile = File(_resolvePath(filePath));
    await localFile.create(recursive: true);
    await localFile.writeAsString(file.fileContents);
  }

  String _resolvePath(String rawPath) {
    var path = rawPath.replaceFirst(RegExp('^.*[0-9]/'), '');
    var prefix = path.split('/')[0];
    return path.replaceFirst(RegExp('.*/api'), 'idl/$prefix');
  }
}
