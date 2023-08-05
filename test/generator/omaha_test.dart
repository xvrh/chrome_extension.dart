library omaha_test;

import 'dart:async';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import '../../tool/generator/download/omaha.dart';
import '../../tool/generator/download/simple_http_client.dart';
import 'omaha_test.mocks.dart';

@GenerateMocks([SimpleHttpClient])
void main() => defineTests();

void defineTests() {
  group('OmahaVersionExtractor', () {
    late OmahaVersionExtractor extractor;
    MockSimpleHttpClient client;
    late String html;

    setUp(() {
      client = MockSimpleHttpClient();
      when(client.getHtmlAtUri(any)).thenAnswer((_) => Future.value(html));
      extractor = OmahaVersionExtractor(client: client);
    });

    test('correctly parses good, simple input', () async {
      var version = 'alpha';
      html = 'mac,stable,$version';

      expect(await extractor.stableVersion, version);
    });
  });
}
