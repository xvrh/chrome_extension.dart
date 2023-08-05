import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:puppeteer/puppeteer.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf;
import 'package:test/test.dart';
import 'communication.dart';

Future<void> runTests(String source,
    {bool? devtools,
    Future Function(RunnerTestContext)? afterBrowserOpen}) async {
  var sourceDir = Directory(source);
  var chromeExtensionDir = Directory(p.join('.dart_tool', 'chrome_extension'))
    ..createSync(recursive: true);
  var extensionDir = chromeExtensionDir.createTempSync();
  var extensionPath = extensionDir.path;

  _copyDirectory(Directory(source), extensionDir,
      filter: (file) => !file.path.endsWith('.dart'));

  var testCompleter = Completer<TerminateRequest>();

  late Browser browser;
  final puppeteerPort = await _getUnusedPort();

  var server = Server(
    onInfo: () => ServerInfo(
        puppeteerUrl: browser.wsEndpoint,
        operatingSystem: Platform.operatingSystem),
    onLog: (log) => print(log.log.trim()),
    onTerminate: testCompleter.complete,
  );
  var httpServer = await shelf.serve(
      shelf.Pipeline()
          .addMiddleware(shelf.createMiddleware(responseHandler: (r) {
        return r.change(
            headers: {...r.headers, 'Access-Control-Allow-Origin': '*'});
      })).addHandler(server.router),
      InternetAddress.anyIPv4,
      0);

  var serverUrl = 'http://${httpServer.address.host}:${httpServer.port}';

  var manifestFile = File(p.join(extensionPath, 'manifest.json'));
  var manifestContent = manifestFile.readAsStringSync();
  manifestContent = manifestContent.replaceAll('@SERVER_URL', serverUrl);
  var manifest = jsonDecode(manifestContent) as Map<String, dynamic>;
  manifest
    ..['manifest_version'] ??= 3
    ..['name'] ??= 'test_extension'
    ..['version'] ??= '1.0'
    ..['description'] ??= 'Extension to run unit tests'
    ..['host_permissions'] ??= [
      "$serverUrl/*",
      "ws://127.0.0.1:$puppeteerPort/*",
    ]
    ..['content_security_policy'] = {
      'extension_pages':
          "script-src 'self' 'wasm-unsafe-eval'; object-src 'self';"
    };
  manifestFile.writeAsStringSync(jsonEncode(manifest));

  for (var dartFile in sourceDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))) {
    var relativePath = p.relative(dartFile.path, from: source);
    var outputPath = '${p.join(extensionPath, relativePath)}.js';

    await _compileJs(dartFile.path, outputPath,
        defines: {'server-url': serverUrl});
  }

  browser = await puppeteer.launch(
    headless: false,
    args: [
      '--disable-extensions-except=${Directory(extensionPath).absolute.path}',
      '--load-extension=${Directory(extensionPath).absolute.path}',
      '--remote-debugging-port=$puppeteerPort',
      '--remote-allow-origins=*',
    ],
    devTools: devtools,
  );
  await afterBrowserOpen
      ?.call(RunnerTestContext(browser: browser, serverUrl: serverUrl));

  var endResult = await testCompleter.future;

  await browser.close();
  await httpServer.close();

  if (!endResult.success) {
    fail('Some tests failed.');
  }
}

Future<void> _compileJs(String input, String output,
    {Map<String, String>? defines}) async {
  var compileResult = await Process.run(Platform.resolvedExecutable, [
    'compile',
    'js',
    input,
    '--csp',
    '--enable-asserts',
    '--output',
    output,
    if (defines != null)
      for (var e in defines.entries) '--define=${e.key}=${e.value}',
  ]);
  if (compileResult.exitCode != 0) {
    throw Exception(
        'Error when compiling JS (${compileResult.exitCode}).\n${compileResult.stdout}\n${compileResult.stderr}');
  }
}

void _copyDirectory(Directory source, Directory destination,
    {bool Function(File)? filter}) {
  if (!destination.existsSync()) {
    destination.createSync(recursive: true);
  }

  for (var entity in source.listSync(recursive: false)) {
    final newPath = p.join(destination.path, p.basename(entity.path));
    if (entity is File) {
      if (filter?.call(entity) ?? true) {
        entity.copySync(newPath);
      }
    } else if (entity is Directory) {
      _copyDirectory(entity, Directory(newPath));
    }
  }
}

Future<int> _getUnusedPort() {
  return ServerSocket.bind(InternetAddress.anyIPv4, 0).then((socket) {
    var port = socket.port;
    socket.close();
    return port;
  });
}

class RunnerTestContext {
  final Browser browser;
  final String serverUrl;

  RunnerTestContext({required this.browser, required this.serverUrl});

  String staticPath(String path) {
    return p.url.join(serverUrl, 'static', path);
  }
}
