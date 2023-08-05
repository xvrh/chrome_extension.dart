import 'dart:async';
import 'package:path/path.dart' as p;
import 'communication.dart';
import 'communication_client.dart';

final _endDetector = RegExp(r'[0-9]{2}:[0-9]{2}.*:(.*)');

Future<void> setup(void Function(TestContext) callback) async {
  try {
    var client = Client();
    var serverInfo = await client.serverInfo();
    var context = TestContext(info: serverInfo, serverUrl: client.baseUrl);

    runZoned(() {
      callback(context);
    }, zoneSpecification: ZoneSpecification(print: (self, parent, zone, line) {
      client.log(line);

      if (_endDetector.firstMatch(line) case var match?) {
        var testName = match.group(1)!.trim();
        if (testName.contains('Some tests failed.')) {
          client.terminate(success: false);
        } else if (testName.startsWith('All tests passed!')) {
          client.terminate(success: true);
        } else if (testName.startsWith('All tests skipped.')) {
          client.terminate(success: true);
        }
      }
    }));
  } catch (e) {
    print("Global error $e");
  }
}

class TestContext {
  final ServerInfo info;
  final String serverUrl;

  TestContext({required this.info, required this.serverUrl});

  String get puppeteerUrl => info.puppeteerUrl;

  String staticPath(String path) {
    return p.url.join(serverUrl, 'static', path);
  }
}
