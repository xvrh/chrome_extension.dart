import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// Encapsulates an [HttpClient] for accessing HTML at a given [URI].
class SimpleHttpClient {
  final HttpClient _client;

  SimpleHttpClient({HttpClient? client}) : _client = client ?? HttpClient();

  /// Download the HTML source of the page at the given [Uri].
  Future<String> getHtmlAtUri(Uri uri) async {
    // Inject a delay before any request to prevent RESOURCE_EXHAUSTED error.
    await Future.delayed(const Duration(milliseconds: 200));
    var request = await _client.getUrl(uri);
    await request.close();
    var response = await request.done;
    if (response.statusCode >= 400) {
      throw Exception('Failed to fetch $uri: ${response.statusCode}');
    }
    return await response.transform(utf8.decoder).join('');
  }
}
