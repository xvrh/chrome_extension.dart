import 'dart:io';
import 'package:project_tools/project_tools.dart';

void main() {
  final formatter = DartFormatter(languageVersion: Version(3, 5, 0));
  for (var project in DartProject.find(Directory.current)) {
    for (var modifiedFile in formatProject(project, formatter)) {
      print('Formatted: ${modifiedFile.project.packageName}:'
          '${modifiedFile.relativePath}');
    }
  }
}
