import 'dart:io';
import 'package:process_runner/process_runner.dart';
import 'package:project_tools/project_tools.dart';

void main() async {
  var process = ProcessRunner(printOutputDefault: true);
  var flutterSdk = FlutterSdk.current;
  for (var project in DartProject.find(Directory.current)) {
    await process.runProcess([flutterSdk.flutter, 'pub', 'upgrade'],
        workingDirectory: project.directory, failOk: true);
  }
}
