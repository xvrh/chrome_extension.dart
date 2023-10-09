import 'dart:io';
import 'package:process_runner/process_runner.dart';

final _process = ProcessRunner(printOutputDefault: true);

void main() async {
  await _process.runProcess([
    Platform.resolvedExecutable,
    'compile',
    'js',
    'web/main.dart',
    '-o',
    'web/_main.dart.js',
  ]);
}
