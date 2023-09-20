import 'dart:convert';
import 'dart:io';
import 'package:dart_style/dart_style.dart';
import 'apis.dart';
import 'generator/utils/string.dart';

final RegExp _importRegex = RegExp(r"import '([^']+)';\r?\n");
final RegExp _ignoreForFileRegex =
    RegExp(r'^// ignore_for_file:.*$', multiLine: true);

final DartFormatter _dartFormatter =
    DartFormatter(lineEnding: Platform.isWindows ? '\r\n' : '\n');

void main() {
  var readme = generateReadme();
  File('README.md').writeAsStringSync(readme);
}

String generateReadme() {
  var template = File('README.template.md').readAsStringSync();

  var readme = template.replaceAllMapped(_importRegex, (match) {
    var filePath = match.group(1)!;

    var splitPath = filePath.split('#');
    var actualPath = splitPath.first;

    var fileContent = File(actualPath).readAsStringSync();
    fileContent = fileContent.replaceAll(_ignoreForFileRegex, '');
    if (splitPath.length > 1) {
      var sectionName = splitPath[1];

      fileContent = _extractSection(fileContent, sectionName.trim());
    }

    fileContent = _dartFormatter.format(fileContent);

    return fileContent;
  });

  var apiList = StringBuffer();
  for (var api in extensionApis) {
    apiList.writeln(
        '- `package:chrome_extension/${api.snakeCase}.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/${api.replaceAll('.', '_')}/))');
  }

  readme = readme.replaceAll('<!-- LIST APIS -->', '$apiList');

  return readme;
}

String _extractSection(String content, String sectionName) {
  var lines = LineSplitter.split(content);
  bool isBlockStarter(String line, String section) =>
      line.trim().startsWith(RegExp(r'\/\/\s*-{2,}\s*' '$section'));
  lines = lines
      .skipWhile((l) => !isBlockStarter(l, sectionName))
      .skip(1)
      .takeWhile((l) => !isBlockStarter(l, ''))
      .toList();

  return lines.join('\n');
}
