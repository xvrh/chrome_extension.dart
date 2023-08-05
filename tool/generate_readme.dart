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

    var fileContent = File(filePath).readAsStringSync();
    fileContent = fileContent.replaceAll(_ignoreForFileRegex, '');

    fileContent = _dartFormatter.format(fileContent);

    return fileContent;
  });

  var apiList = StringBuffer();
  for (var api in extensionApis) {
    apiList.writeln(
        '- `package:chrome_apis/${api.snakeCase}.dart` ([API reference](https://developer.chrome.com/docs/extensions/reference/${api.replaceAll('.', '_')}/))');
  }

  readme = readme.replaceAll('<!-- LIST APIS -->', '$apiList');

  return readme;
}
