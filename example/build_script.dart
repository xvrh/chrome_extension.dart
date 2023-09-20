import 'dart:io';
import 'package:process_runner/process_runner.dart';

final _process = ProcessRunner(printOutputDefault: true);

// --- example

// tool/build.dart
void main() async {
  await _process.runProcess([
    'flutter',
    'build',
    'web',
    '-t',
    'web/popup.dart',
    '--csp',
    '--web-renderer=canvaskit',
    '--no-web-resources-cdn',
  ]);
  for (var script in [
    'background.dart',
    'content_script.dart',
    'options.dart'
  ]) {
    await _process.runProcess([
      Platform.resolvedExecutable,
      'compile',
      'js',
      'web/$script',
      '--output',
      'build/web/$script.js',
    ]);
  }
}

// ---
