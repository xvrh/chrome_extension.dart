import 'dart:io';
import 'package:project_tools/project_tools.dart';

void main() {
  for (var project in DartProject.find(Directory.current)) {
    for (var modifiedFile in formatProject(project)) {
      print('Formatted: ${modifiedFile.project.packageName}:'
          '${modifiedFile.relativePath}');
    }
  }
}
