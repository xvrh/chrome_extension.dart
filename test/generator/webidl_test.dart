import 'dart:io';
import 'package:collection/collection.dart';
import 'package:test/test.dart';
import '../../tool/generator/idl_model.dart';
import '../../tool/generator/idl_parser.dart';
import '../../tool/generator/webidl_convert.dart';

void main() {
  // When Chromium converts a legacy .idl schema to WebIDL, it keeps both files
  // in tools/json_schema_compiler/test/converted_schemas and checks that they
  // describe the same API. We check the same with our parsers.
  group('WebIDL and legacy IDL describe the same API', () {
    var directory = Directory('test/generator/webidl/converted_schemas');
    var webIdlFiles = directory
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.webidl'))
        .sortedBy((f) => f.path);
    for (var webIdlFile in webIdlFiles) {
      var name = webIdlFile.uri.pathSegments.last;
      var webIdl = webIdlFile.readAsStringSync();
      test(name, () {
        var idl =
            File(webIdlFile.path.replaceFirst(RegExp(r'\.webidl$'), '.idl'))
                .readAsStringSync();
        var expected = describeNamespace(
            ChromeIDLParser().namespaceDeclaration.parse(idl).value);
        var actual = describeNamespace(parseWebIdlNamespace(webIdl));
        _expectSameApi(actual, expected);
      },
          skip: webIdl.contains('partial interface Browser')
              ? false
              : 'Only defines manifest keys');
    }
  });

  group('Parse the WebIDL schemas', () {
    var files = Directory('idl')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.webidl'))
        .sortedBy((f) => f.path);
    for (var file in files) {
      var webIdl = file.readAsStringSync();
      test(file.path, () {
        parseWebIdlNamespace(webIdl);
      },
          skip: webIdl.contains('partial interface Browser')
              ? false
              : 'Only defines manifest keys');
    }
  });
}

/// A normalized description of the parts of the model used by the generator.
List<String> describeNamespace(IDLNamespaceDeclaration namespace) {
  var callbacks = {for (var c in namespace.callbackDeclarations) c.name: c};

  String parameters(List<IDLParameter> parameters) => parameters
      .map((p) => '${p.name}${p.isOptional ? '?' : ''}: ${_types(p.types)}')
      .join(', ');

  String method(String kind, IDLMethod method) {
    var buffer = StringBuffer('$kind ${method.name}');
    var callback = method.returnType.name == 'void'
        ? method.parameters.firstWhereOrNull((p) => p.isCallback)
        : null;
    buffer.write('(${parameters([
          for (var p in method.parameters)
            if (p != callback) p
        ])})');
    if (method.returnType.name != 'void') {
      buffer.write(' -> ${method.returnType.name}'
          '${method.returnType.isArray ? '[]' : ''}');
    }
    if (callback != null) {
      var promises = !_hasAttribute(
          method.attribute, IDLAttributeTypeEnum.doesNotSupportPromises);
      // Whether the callback is optional doesn't matter with promises.
      buffer.write(' async'
          '(${parameters(callbacks[callback.types.name]!.parameters)})'
          '${promises ? '' : ' no-promise'}');
    }
    buffer.write(_attributes(method.attribute));
    return buffer.toString();
  }

  return [
    'namespace ${namespace.name}${_attributes(namespace.attribute)}',
    'doc: ${_documentation(namespace.documentation)}',
    for (var function
        in (namespace.functionDeclaration?.methods ?? <IDLMethod>[])
            .sortedBy((e) => e.name)) ...[
      method('function', function),
      'doc: ${_documentation(function.documentation)}',
    ],
    for (var event in (namespace.eventDeclaration?.methods ?? <IDLMethod>[])
        .sortedBy((e) => e.name)) ...[
      method('event', event),
      'doc: ${_documentation(event.documentation)}',
    ],
    for (var property
        in (namespace.propertiesDeclaration?.methods ?? <IDLMethod>[])
            .sortedBy((e) => e.name))
      describeProperty(property),
    // The manifest keys moved to a "partial dictionary ExtensionManifest".
    for (var type in namespace.typeDeclarations
        .where((e) => e.name != 'ManifestKeys')
        .sortedBy((e) => e.name)) ...[
      'dictionary ${type.name}${_attributes(type.attribute)}',
      'doc: ${_documentation(type.documentation)}',
      for (var field in type.members) ...[
        describeField(field),
        '  doc: ${_documentation(field.documentation)}',
      ],
      for (var m in type.methods.sortedBy((e) => e.name))
        '  ${method('method', m)}',
    ],
    for (var enumeration
        in namespace.enumDeclarations.sortedBy((e) => e.name)) ...[
      'enum ${enumeration.name}${_attributes(enumeration.attribute)}',
      'doc: ${_documentation(enumeration.documentation)}',
      for (var value in enumeration.enums) describeEnumValue(value),
    ],
  ];
}

String describeProperty(IDLMethod property) =>
    'property ${property.name}: ${property.returnType.name}'
    '${_attributes(property.attribute)}';

// The legacy format escapes reserved words (_interface).
String _unescape(String name) => name.replaceFirst(RegExp('^_'), '');

String describeField(IDLField field) =>
    '  ${_unescape(field.name)}${field.isOptional ? '?' : ''}: '
    '${_types(field.types)}${_attributes(field.attribute)}';

String describeEnumValue(IDLEnumValue value) =>
    '  ${_unescape(value.name)}: ${_documentation(value.documentation)}';

String _types(IDLTypeOrUnion types) =>
    types.types.map((t) => '${t.name}${t.isArray ? '[]' : ''}').join(' or ');

void _expectSameApi(List<String> actual, List<String> expected) {
  for (var i = 0; i < actual.length || i < expected.length; i++) {
    var actualLine = i < actual.length ? actual[i] : '<missing>';
    var expectedLine = i < expected.length ? expected[i] : '<missing>';
    // Chromium dropped a few comments during the conversion, and the legacy
    // parser also keeps the comments separated from a definition by a blank
    // line.
    if (actualLine.trimLeft().startsWith('doc:') &&
        expectedLine.trimLeft().startsWith('doc:') &&
        expectedLine.endsWith(actualLine.trimLeft().substring(4).trim())) {
      continue;
    }
    expect(
        actualLine, expectedLine.replaceAll('ArrayBufferView', 'ArrayBuffer'),
        reason: 'Line $i');
  }
}

/// The attributes used by the generator. Chromium also changed some [nodoc]
/// and [nocompile] attributes during the conversion.
const _comparedAttributes = {
  IDLAttributeTypeEnum.deprecated,
  IDLAttributeTypeEnum.platforms,
  IDLAttributeTypeEnum.maxListeners,
  IDLAttributeTypeEnum.supportsFilter,
  IDLAttributeTypeEnum.serializableFunction,
};

String _attributes(IDLAttributeDeclaration? declaration) {
  var attributes = [
    for (var a in declaration?.attributes ?? <IDLAttribute>[])
      if (_comparedAttributes.contains(a.attributeType))
        // The legacy parser drops numbers and booleans (maxListeners=1,
        // nodoc=true), only compare the other values.
        switch (a.attributeType) {
          IDLAttributeTypeEnum.deprecated ||
          IDLAttributeTypeEnum.platforms =>
            '${a.attributeType.type}='
                '${a.attributeValue ?? a.attributeValues}',
          _ => a.attributeType.type,
        },
  ]..sort();
  return attributes.isEmpty ? '' : ' [${attributes.join(', ')}]';
}

bool _hasAttribute(
        IDLAttributeDeclaration? declaration, IDLAttributeTypeEnum type) =>
    declaration?.attributes.any((a) => a.attributeType == type) ?? false;

/// The description without the parameter annotations (`|name|: ...`), which
/// changed with the move to promises.
String _documentation(List<String> lines) {
  var text = lines.join(' ');
  var annotation = RegExp(r'\|[^|]*\|\s*:').firstMatch(text);
  if (annotation != null) text = text.substring(0, annotation.start);
  // Chromium removed some HTML paragraphs during the conversion.
  return text
      .replaceAll(RegExp(r'</?p>'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}
