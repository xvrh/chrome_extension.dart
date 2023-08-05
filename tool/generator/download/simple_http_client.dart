import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// Encapsulates an [HttpClient] for accessing HTML at a given [URI].
class SimpleHttpClient {
  final HttpClient _client;

  SimpleHttpClient({HttpClient? client}) : _client = client ?? HttpClient();

  /// Download the HTML source of the page at the given [Uri].
  Future<String> getHtmlAtUri(Uri uri) async {
    var request = await _client.getUrl(uri);
    await request.close();
    var response = await request.done;
    return await response.transform(utf8.decoder).join('');
  }
}
