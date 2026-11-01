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
  var futureBrowser = Completer<Browser>();
  final puppeteerPort = await _getUnusedPort();

  var server = Server(
    onInfo: () async {
      var browser = await futureBrowser.future;
      return ServerInfo(
          puppeteerUrl: browser.wsEndpoint,
          operatingSystem: Platform.operatingSystem);
    },
    onLog: (log) => print(log.log.trim()),
    onTerminate: testCompleter.complete,
  );
  var httpServer = await shelf.serve(
      shelf.Pipeline()
          .addMiddleware(shelf.createMiddleware(responseHandler: (r) {
        return r.change(
            headers: {...r.headers, 'Access-Control-Allow-Origin': '*'});
      })).addHandler(server.router.call),
      InternetAddress.loopbackIPv4,
      0);
  addTearDown(httpServer.close);

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

  var background = manifest['background'] as Map<String, dynamic>?;
  var serviceWorker = background?['service_worker'] as String?;
  var contentScripts = {
    for (var script in manifest['content_scripts'] as List? ?? [])
      ...(script as Map)['js'] as List
  };

  for (var dartFile in sourceDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))) {
    var relativePath = p.relative(dartFile.path, from: source);
    var outputPath = '${p.join(extensionPath, relativePath)}.js';
    var outputUrl = '${p.posix.joinAll(p.split(relativePath))}.js';
    var defines = {'server-url': serverUrl};

    // Content scripts can't be ES modules, they are always compiled to JS.
    if (_compiler == _Compiler.wasm && !contentScripts.contains(outputUrl)) {
      var isServiceWorker = outputUrl == serviceWorker;
      if (isServiceWorker) {
        background!['type'] = 'module';
      }
      await _compileWasm(dartFile.path, outputPath,
          isServiceWorker: isServiceWorker, defines: defines);
    } else {
      await _compileJs(dartFile.path, outputPath, defines: defines);
    }
  }
  manifestFile.writeAsStringSync(jsonEncode(manifest));

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
  // Tear-downs also run when the test times out, which would otherwise leave
  // the browser open.
  addTearDown(browser.close);
  futureBrowser.complete(browser);
  await afterBrowserOpen
      ?.call(RunnerTestContext(browser: browser, serverUrl: serverUrl));

  var endResult = await testCompleter.future;

  if (!endResult.success) {
    fail('Some tests failed.');
  }
}

enum _Compiler { js, wasm }

/// Run the tests with `TEST_COMPILER=wasm dart test` to compile the extension
/// with dart2wasm instead of dart2js.
final _compiler = Platform.environment['TEST_COMPILER'] == 'wasm'
    ? _Compiler.wasm
    : _Compiler.js;

/// Compiles [input] to Wasm and writes a JS loader at [output] so the file can
/// be referenced the same way as the dart2js output.
Future<void> _compileWasm(String input, String output,
    {required bool isServiceWorker, Map<String, String>? defines}) async {
  var base = p.withoutExtension(output);
  var compileResult = await Process.run(Platform.resolvedExecutable, [
    'compile',
    'wasm',
    input,
    '--enable-asserts',
    '--output',
    '$base.wasm',
    if (defines != null)
      for (var e in defines.entries) '--define=${e.key}=${e.value}',
  ]);
  if (compileResult.exitCode != 0) {
    throw Exception(
        'Error when compiling Wasm (${compileResult.exitCode}).\n${compileResult.stdout}\n${compileResult.stderr}');
  }

  var name = p.basename(base);
  // Service workers don't support dynamic import() and top-level await, while
  // classic scripts in extension pages don't support static imports.
  String loader;
  if (isServiceWorker) {
    loader = '''
import { compileStreaming } from './$name.mjs';
compileStreaming(fetch(new URL('./$name.wasm', import.meta.url)))
  .then((app) => app.instantiate())
  .then((instance) => instance.invokeMain());
''';
  } else {
    loader = '''
(() => {
  const base = document.currentScript.src;
  import(new URL('./$name.mjs', base))
    .then(({ compileStreaming }) =>
      compileStreaming(fetch(new URL('./$name.wasm', base))))
    .then((app) => app.instantiate())
    .then((instance) => instance.invokeMain());
})();
''';
  }
  File(output).writeAsStringSync(loader);
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
