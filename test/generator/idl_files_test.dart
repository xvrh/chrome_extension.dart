import 'dart:io';
import 'package:test/test.dart';
import '../../tool/generator/chrome_type.dart';
import '../../tool/generator/idl_convert.dart';
import '../../tool/generator/idl_parser.dart';

void main() {
  group('ChromeIDLParser', () {
    bool idlFileExtTest(File file) => file.path.endsWith('.idl');
    var chromeIdlFileEntities = Directory('idl')
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .where(idlFileExtTest);

    // TODO: make async
    for (var file in chromeIdlFileEntities) {
      test(file.path, () {
        var webIdl = file.readAsStringSync();
        var chromeIDLParser = ChromeIDLParser();
        var namespace =
            chromeIDLParser.namespaceDeclaration.parse(webIdl).value;
        var context = Context();
        IdlModelConverter(context, namespace);
      });
    }
  });
}
