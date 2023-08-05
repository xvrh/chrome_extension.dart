library googlesource;

import 'dart:async';
import 'dart:convert';
import 'simple_http_client.dart';
import 'tag_matcher.dart';

/// A [GoogleSourceEntity] represents either a file or a directory in the file
/// system at chromium.googlesource.com. It knows its own [Uri] and the html
/// source for the page at that Uri.
abstract class GoogleSourceEntity {
  final String _rawHtml;
  final String _url;

  GoogleSourceEntity(this._rawHtml, this._url);
  String get url => _url;
}

/// A [GoogleSourceFile] is a [GoogleSourceEntity] that represents a file. As
/// such, it knows how to access its own contents.
class GoogleSourceFile extends GoogleSourceEntity {
  static const _encodedCharacters = ["'", '&', '<', '>', '"'];
  static final encodings = {
    for (var c in _encodedCharacters) htmlEscape.convert(c): c
  };

  GoogleSourceFile(String rawHtml, String url) : super(rawHtml, url);

  /// Parse this file's raw html and return its contents.
  String get fileContents {
    return _unescapeHtml(TagMatcher('tr').allContents(_lines).map((tableRow) {
      var line = TagMatcher('td').allContents(tableRow).toList()[1];
      var lineStripped = line.replaceFirst(TagMatcher.aMatcher, '');
      return TagMatcher.spanMatcher.allContents(lineStripped).join('');
    }).join('\n'));
  }

  String _unescapeHtml(String escapedHtml) {
    encodings.forEach((encodedString, decodedString) {
      escapedHtml = escapedHtml.replaceAll(encodedString, decodedString);
    });
    return escapedHtml;
  }

  String get _lines => TagMatcher('table').allContents(_rawHtml).single;
}

/// A [GoogleSourceDirectory] represents a directory and can access the [Uri]s
/// of its child [GoogleSourceEntity]s.
class GoogleSourceDirectory extends GoogleSourceEntity {
  GoogleSourceDirectory(String rawHtml, String url) : super(rawHtml, url);

  String get _lines => TagMatcher.olMatcher.allContents(_rawHtml).single;

  Iterable<String> get listUris => TagMatcher.aMatcher
      .allAttributes(_lines)
      .map((Map<String, String> attributes) => attributes['href']!);
}

/// A crawler that can take a [Uri] to a [GoogleSourceEntity], then traverse the
/// directory (or file) that entity represents.
class GoogleSourceCrawler {
  static const matchingExtensions = ['.idl', '.json'];

  final SimpleHttpClient _client;
  final String _baseUri;

  GoogleSourceCrawler(this._baseUri, {SimpleHttpClient? client})
      : _client = client ?? SimpleHttpClient();

  /// Asynchronously traverses the google source file system, starting from the
  /// [GoogleSourceEntity] at [relativeUri], to find all [GoogleSourceFile]s
  /// with extensions matching [matchingExtensions].
  Stream<GoogleSourceFile> findAllMatchingFiles(String relativeUri) async* {
    var directory = GoogleSourceDirectory(
        await _client.getHtmlAtUri(_absoluteUri(relativeUri)), relativeUri);
    for (var childUrl in directory.listUris) {
      if (childUrl.endsWith('/')) {
        yield* findAllMatchingFiles(childUrl);
      } else if (matchingExtensions.any((ext) => childUrl.endsWith(ext))) {
        yield GoogleSourceFile(
            await _client.getHtmlAtUri(_absoluteUri(childUrl)), childUrl);
      }
    }
  }

  Uri _absoluteUri(String relativeUri) => Uri.parse('$_baseUri$relativeUri');
}
