library;

import 'dart:convert';
import 'package:http/http.dart' as http;

/// Lists and downloads the files of a GitHub repository at a given ref.
class GitHubDownloader {
  final String repository;
  final String ref;
  final String? token;
  final http.Client _client;

  GitHubDownloader(
      {required this.repository,
      required this.ref,
      this.token,
      http.Client? client})
      : _client = client ?? http.Client();

  /// Lists recursively the files in [directory] whose path matches [filter].
  Stream<GitHubFile> listFiles(String directory,
      {required bool Function(String path) filter}) async* {
    var uri = Uri.https('api.github.com',
        '/repos/$repository/contents/$directory', {'ref': ref});
    var entries = jsonDecode(await _get(uri, headers: {
      'Accept': 'application/vnd.github+json',
      if (token case var token?) 'Authorization': 'Bearer $token',
    })) as List;
    for (var entry in entries.cast<Map<String, dynamic>>()) {
      var path = entry['path'] as String;
      if (entry['type'] == 'dir') {
        yield* listFiles(path, filter: filter);
      } else if (entry['type'] == 'file' && filter(path)) {
        yield GitHubFile(path, Uri.parse(entry['download_url'] as String));
      }
    }
  }

  Future<String> download(GitHubFile file) => _get(file.downloadUrl);

  Future<String> _get(Uri uri, {Map<String, String>? headers}) async {
    var response = await _client.get(uri, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch $uri: ${response.statusCode}\n'
          '${response.body}');
    }
    return response.body;
  }

  void close() => _client.close();
}

class GitHubFile {
  final String path;
  final Uri downloadUrl;

  GitHubFile(this.path, this.downloadUrl);
}
