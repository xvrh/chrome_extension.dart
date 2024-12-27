library;

import 'dart:async';
import 'dart:io';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import '../../tool/generator/download/simple_http_client.dart';
import 'simple_http_client_test.mocks.dart';

@GenerateMocks([HttpClient, HttpClientRequest, HttpClientResponse])
void main() => defineTests();

void defineTests() {
  group('SimpleHttpClient', () {
    late SimpleHttpClient simpleClient;
    MockHttpClient mockClient;
    late MockHttpClientRequest mockRequest;
    MockHttpClientResponse mockResponse;
    late List<String> html;

    setUp(() {
      mockClient = MockHttpClient();
      mockRequest = MockHttpClientRequest();
      mockResponse = MockHttpClientResponse();

      when(mockClient.getUrl(any)).thenAnswer((_) async => mockRequest);
      when(mockRequest.done).thenAnswer((_) => Future(() => mockResponse));
      when(mockRequest.close()).thenAnswer((_) => Future.value(mockResponse));
      when(mockResponse.statusCode).thenAnswer((_) => 200);
      when(mockResponse.transform(any)).thenAnswer((_) async* {
        yield html.join('\n');
      });

      simpleClient = SimpleHttpClient(client: mockClient);
    });

    test('returns string', () async {
      var testString = 'this is some great testHtml';
      html = [testString];

      expect(await simpleClient.getHtmlAtUri(Uri.parse('example.com')),
          testString);
    });
  });
}
