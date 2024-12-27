library;

import 'package:petitparser/parser.dart';
import 'package:test/test.dart';
import '../../tool/generator/idl_model.dart';
import '../../tool/generator/idl_parser.dart';

late ChromeIDLParser chromeIDLParser;

void main() {
  setUp(() {
    chromeIDLParser = ChromeIDLParser();
  });

  group('ChromeIDLParser.docString.parse', chromeIDLParserDocStringTests);
  group('ChromeIDLParser.attributeDeclaration.parse',
      chromeIDLParserAttributeDeclarationTests);
  group('ChromeIDLParser.enumBody.parse', chromeIDLParserEnumBodyTests);
  group('ChromeIDLParser.enumDeclaration.parse',
      chromeIDLParserEnumDeclarationTests);
  group('ChromeIDLParser.callbackParameterType.parse',
      chromeIDLParserCallbackParameterTypeTests);
  group('ChromeIDLParser.callbackParameters.parse',
      chromeIDLParserCallbackParameterTests);
  group('ChromeIDLParser.callbackMethod.parse',
      chromeIDLParserCallbackMethodTests);
  group('ChromeIDLParser.callbackDeclaration.parse',
      chromeIDLParserCallbackDeclarationTests);
  group('ChromeIDLParser.fieldType.parse', chromeIDLParserFieldTypeTests);
  group('ChromeIDLParser.fieldOrType.parse', chromeIDLParserFieldOrTypeTests);
  group('ChromeIDLParser.fieldMethodParameters.parse',
      chromeIDLParserFieldMethodParametersTests);
  group('ChromeIDLParser.typeBody.parse', chromeIDLParserTypeBodyTests);
  group('ChromeIDLParser.typeDeclaration.parse',
      chromeIDLParserTypeDeclarationTests);
  group('ChromeIDLParser.methods.parser', chromeIDLParserMethodsTests);
  group('ChromeIDLParser.functionDeclaration.parser',
      chromeIDLParserFunctionDeclarationTests);
  group('ChromeIDLParser.eventDeclaration.parser',
      chromeIDLParserEventDeclarationTests);
  group(
      'chromeIDLParser.namespaceBody.parse', chromeIDLParserNamespaceBodyTests);
  group('ChromeIDLParser.namespaceDeclaration.parser',
      chromeIDLParserNamespaceDeclarationTests);
  group('ChromeIDLParser misc parsing tests', miscParsingTests);
}

void chromeIDLParserDocStringTests() {
  test('comment with **', () {
    var doc = chromeIDLParser.docString.parse("/** Some comment */").value;
    expect(doc.length, equals(1));
    expect(doc[0], equals(" Some comment "));
  });

  test('comment with ** multiline', () {
    var doc = chromeIDLParser.docString.parse("""
/**
 * Some comment
 *
 * Some comment information.
 * Some more comment information.
 *
 */""").value;
    expect(doc.length, equals(1));
    expect(
        doc[0],
        equals('\n'
            ' * Some comment\n'
            ' *\n'
            ' * Some comment information.\n'
            ' * Some more comment information.\n'
            ' *\n'
            ' '));
  });

  test('comment with *', () {
    var doc = chromeIDLParser.docString.parse("/* Some comment */").value;
    expect(doc.length, equals(1));
    expect(doc[0], equals(" Some comment "));
  });

  test('comment with * multiline', () {
    var doc = chromeIDLParser.docString.parse("""
/*
 * Some comment
 *
 * Some comment information.
 * Some more comment information.
 *
 */""").value;
    expect(doc.runtimeType.toString(), equals("List<String>"));
    expect(doc.length, equals(1));
    expect(
        doc[0],
        equals('\n'
            ' * Some comment\n'
            ' *\n'
            ' * Some comment information.\n'
            ' * Some more comment information.\n'
            ' *\n'
            ' '));
  });

  test('comment with //', () {
    var doc = chromeIDLParser.docString.parse("// Some comment\n").value;
    expect(doc.length, equals(1));
    expect(doc[0], equals("Some comment"));
  });

  test('comment with // multiline', () {
    var doc = chromeIDLParser.docString.parse("""
//
// Some comment
//
// Some comment information.
// Some more comment information.
//
//""").value;
    expect(doc.length, equals(7));
    expect(doc[0], equals(''));
    expect(doc[1], equals('Some comment'));
    expect(doc[2], equals(''));
    expect(doc[3], equals('Some comment information.'));
    expect(doc[4], equals('Some more comment information.'));
    expect(doc[5], equals(''));
    expect(doc[6], equals(''));
  });
}

void chromeIDLParserAttributeDeclarationTests() {
  test('attribute with [instanceOf=Window]', () {
    var attributeDeclaration =
        chromeIDLParser.attributeDeclaration.parse("[instanceOf=Window]").value;

    expect(attributeDeclaration, isNotNull);
    var attributes = attributeDeclaration.attributes;
    expect(attributes.length, equals(1));
    var attribute = attributes[0];
    expect(attribute, isNotNull);
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.instanceOf));
    expect(attribute.attributeValue, equals("Window"));
  });

  test('attribute with [nodoc]', () {
    var attributeDeclaration =
        chromeIDLParser.attributeDeclaration.parse("[nodoc]").value;

    expect(attributeDeclaration, isNotNull);
    var attributes = attributeDeclaration.attributes;
    expect(attributes.length, equals(1));
    var attribute = attributes[0];
    expect(attribute, isNotNull);
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.nodoc));
  });

  test('attribute with [legalValues=(16,32)]', () {
    var attributeDeclaration = chromeIDLParser.attributeDeclaration
        .parse("[legalValues=(16,32)]")
        .value;

    expect(attributeDeclaration, isNotNull);
    var attributes = attributeDeclaration.attributes;
    expect(attributes.length, equals(1));
    var attribute = attributes[0];
    expect(attribute, isNotNull);
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.legalValues));
    expect(attribute.attributeValues!.length, equals(2));
    expect(attribute.attributeValues![0], equals(16));
    expect(attribute.attributeValues![1], equals(32));
  });

  test('attribute with [platforms = ("chromeos", "lacros")]', () {
    var attributeDeclaration = chromeIDLParser.attributeDeclaration
        .parse('[platforms = ("chromeos", "lacros")]')
        .value;

    expect(attributeDeclaration, isNotNull);
    var attributes = attributeDeclaration.attributes;
    expect(attributes.length, equals(1));
    var attribute = attributes[0];
    expect(attribute, isNotNull);
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.platforms));
    expect(attribute.attributeValues!.length, equals(2));
    expect(attribute.attributeValues![0], equals('chromeos'));
    expect(attribute.attributeValues![1], equals('lacros'));
  });

  test('attribute with [nocompile, nodoc]', () {
    var attributeDeclaration =
        chromeIDLParser.attributeDeclaration.parse("[nocompile, nodoc]").value;

    expect(attributeDeclaration, isNotNull);
    var attributes = attributeDeclaration.attributes;
    expect(attributeDeclaration.attributes.length, equals(2));
    var attribute = attributes[0];
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.nocompile));
    attribute = attributes[1];
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.nodoc));
  });

  test('attribute with [implemented_in]', () {
    var attributeDeclaration = chromeIDLParser.attributeDeclaration
        .parse('[implemented_in="a/b.c"]')
        .value;

    expect(attributeDeclaration, isNotNull);
  });
}

void chromeIDLParserEnumBodyTests() {
  test('enum value with comments', () {
    var enumValue = chromeIDLParser.enumBody.parse("""
// A comment about a value.
value
""").value;
    expect(enumValue, isNotNull);
    expect(enumValue.name, equals("value"));
    expect(enumValue.documentation.length, equals(1));
    expect(enumValue.documentation[0], equals("A comment about a value."));
  });

  test('enum value with multiline comments', () {
    var enumValue = chromeIDLParser.enumBody.parse("""
// A comment about a value.
// A second line of comments.
value
""").value;
    expect(enumValue, isNotNull);
    expect(enumValue.name, equals("value"));
    expect(enumValue.documentation.length, equals(2));
    expect(enumValue.documentation[0], equals("A comment about a value."));
    expect(enumValue.documentation[1], equals("A second line of comments."));
  });

  test('enum value without comments', () {
    var enumValue = chromeIDLParser.enumBody.parse("value").value;
    expect(enumValue, isNotNull);
    expect(enumValue.name, equals("value"));
    expect(enumValue.documentation, isEmpty);
  });
}

void chromeIDLParserEnumDeclarationTests() {
  test('enum single line declaration', () {
    var enumDeclaration = chromeIDLParser.enumDeclaration
        .parse("enum Values {value1, value_2, VALUE};")
        .value;
    expect(enumDeclaration, isNotNull);
    expect(enumDeclaration.name, equals("Values"));
    expect(enumDeclaration.documentation, isEmpty);
    expect(enumDeclaration.attribute, isNull);
    expect(enumDeclaration.enums.length, equals(3));
    expect(enumDeclaration.enums[0].name, equals("value1"));
    expect(enumDeclaration.enums[0].documentation, isEmpty);
    expect(enumDeclaration.enums[1].name, equals("value_2"));
    expect(enumDeclaration.enums[1].documentation, isEmpty);
    expect(enumDeclaration.enums[2].name, equals("VALUE"));
    expect(enumDeclaration.enums[2].documentation, isEmpty);
  });

  test('enum single line declaration with attribute', () {
    var enumDeclaration = chromeIDLParser.enumDeclaration
        .parse("[nodoc] enum Values {value1, value_2, VALUE};")
        .value;
    expect(enumDeclaration, isNotNull);
    expect(enumDeclaration.name, equals("Values"));
    expect(enumDeclaration.documentation, isEmpty);
    expect(enumDeclaration.attribute, isNotNull);
    expect(enumDeclaration.attribute!.attributes.length, equals(1));
    expect(enumDeclaration.attribute!.attributes[0].attributeType,
        equals(IDLAttributeTypeEnum.nodoc));
    expect(enumDeclaration.enums.length, equals(3));
    expect(enumDeclaration.enums[0].name, equals("value1"));
    expect(enumDeclaration.enums[0].documentation, isEmpty);
    expect(enumDeclaration.enums[1].name, equals("value_2"));
    expect(enumDeclaration.enums[1].documentation, isEmpty);
    expect(enumDeclaration.enums[2].name, equals("VALUE"));
    expect(enumDeclaration.enums[2].documentation, isEmpty);
  });

  test('enum multiline with comments', () {
    var enumDeclaration = chromeIDLParser.enumDeclaration.parse("""
// Comments for Values
enum Values {

// Comments for value1
value1,

// Comments for value_2
// Added second line for comment
value_2,

// Comments for Values
VALUE};""").value;

    expect(enumDeclaration, isNotNull);
    expect(enumDeclaration.name, equals("Values"));
    expect(enumDeclaration.documentation.length, equals(1));
    expect(enumDeclaration.documentation[0], equals("Comments for Values"));

    expect(enumDeclaration.enums.length, equals(3));
    expect(enumDeclaration.enums[0].name, equals("value1"));
    expect(enumDeclaration.enums[0].documentation.length, equals(1));
    expect(enumDeclaration.enums[0].documentation[0],
        equals("Comments for value1"));
    expect(enumDeclaration.enums[1].name, equals("value_2"));
    expect(enumDeclaration.enums[1].documentation.length, equals(2));
    expect(enumDeclaration.enums[1].documentation[0],
        equals("Comments for value_2"));
    expect(enumDeclaration.enums[1].documentation[1],
        equals("Added second line for comment"));
    expect(enumDeclaration.enums[2].name, equals("VALUE"));
    expect(enumDeclaration.enums[2].documentation.length, equals(1));
    expect(enumDeclaration.enums[2].documentation[0],
        equals("Comments for Values"));
  });

  test('enum multiline with comments attribute', () {
    var enumDeclaration = chromeIDLParser.enumDeclaration.parse("""
// Comments for Values
[nocompile, nodoc]
enum Values {

// Comments for value1
value1,

// Comments for value_2
// Added second line for comment
value_2,

// Comments for Values
VALUE};""").value;

    expect(enumDeclaration, isNotNull);

    expect(enumDeclaration.attribute, isNotNull);
    var attributes = enumDeclaration.attribute!.attributes;
    expect(attributes.length, equals(2));
    var attribute = attributes[0];
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.nocompile));
    attribute = attributes[1];
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.nodoc));

    expect(enumDeclaration.name, equals("Values"));
    expect(enumDeclaration.documentation.length, equals(1));
    expect(enumDeclaration.documentation[0], equals("Comments for Values"));

    expect(enumDeclaration.enums.length, equals(3));
    expect(enumDeclaration.enums[0].name, equals("value1"));
    expect(enumDeclaration.enums[0].documentation.length, equals(1));
    expect(enumDeclaration.enums[0].documentation[0],
        equals("Comments for value1"));
    expect(enumDeclaration.enums[1].name, equals("value_2"));
    expect(enumDeclaration.enums[1].documentation.length, equals(2));
    expect(enumDeclaration.enums[1].documentation[0],
        equals("Comments for value_2"));
    expect(enumDeclaration.enums[1].documentation[1],
        equals("Added second line for comment"));
    expect(enumDeclaration.enums[2].name, equals("VALUE"));
    expect(enumDeclaration.enums[2].documentation.length, equals(1));
    expect(enumDeclaration.enums[2].documentation[0],
        equals("Comments for Values"));
  });
}

void chromeIDLParserCallbackParameterTypeTests() {
  test('callback parameter type with array', () {
    var callbackParameterType =
        chromeIDLParser.callbackParameterType.parse("Device[]").value;
    expect(callbackParameterType, isNotNull);
    expect(callbackParameterType.name, equals("Device"));
    expect(callbackParameterType.isArray, isTrue);
  });

  test('callback parameter type without array', () {
    var callbackParameterType =
        chromeIDLParser.callbackParameterType.parse("Device").value;
    expect(callbackParameterType, isNotNull);
    expect(callbackParameterType.name, equals("Device"));
    expect(callbackParameterType.isArray, isFalse);
  });

  test('callback parameter type with object array', () {
    var callbackParameterType =
        chromeIDLParser.callbackParameterType.parse("object[]").value;
    expect(callbackParameterType, isNotNull);
    expect(callbackParameterType.name, equals("object"));
    expect(callbackParameterType.isArray, isTrue);
  });

  test('callback parameter type without object array', () {
    var callbackParameterType =
        chromeIDLParser.callbackParameterType.parse("object").value;
    expect(callbackParameterType, isNotNull);
    expect(callbackParameterType.name, equals("object"));
    expect(callbackParameterType.isArray, isFalse);
  });
}

void chromeIDLParserCallbackParameterTests() {
  test('callback parameter with attribute', () {
    var callbackParameter = chromeIDLParser.callbackParameters
        .parse("[instanceOf=Entry] object entry")
        .value;

    expect(callbackParameter, isNotNull);
    expect(callbackParameter.name, equals("entry"));
    expect(callbackParameter.isCallback, isFalse);
    expect(callbackParameter.isOptional, isFalse);
    expect(callbackParameter.types.isArray, isFalse);
    expect(callbackParameter.types.name, equals("Entry"));
    expect(callbackParameter.attribute!.attributes[0].attributeType,
        equals(IDLAttributeTypeEnum.instanceOf));
    expect(callbackParameter.attribute!.attributes[0].attributeValue,
        equals("Entry"));
  });

  test('callback parameter with attribute object array', () {
    var callbackParameter = chromeIDLParser.callbackParameters
        .parse("[instanceOf=DOMFileSystem] object[] mediaFileSystems")
        .value;

    expect(callbackParameter, isNotNull);
    expect(callbackParameter.name, equals("mediaFileSystems"));
    expect(callbackParameter.isCallback, isFalse);
    expect(callbackParameter.isOptional, isFalse);
    expect(callbackParameter.types.isArray, isTrue);
    expect(callbackParameter.types.name, equals("DOMFileSystem"));
    expect(callbackParameter.attribute!.attributes[0].attributeType,
        equals(IDLAttributeTypeEnum.instanceOf));
    expect(callbackParameter.attribute!.attributes[0].attributeValue,
        equals("DOMFileSystem"));
  });

  test('callback parameter with optional', () {
    var callbackParameter = chromeIDLParser.callbackParameters
        .parse("optional DOMString responseUrl")
        .value;

    expect(callbackParameter, isNotNull);
    expect(callbackParameter.name, equals("responseUrl"));
    expect(callbackParameter.attribute, isNull);
    expect(callbackParameter.isCallback, isFalse);
    expect(callbackParameter.isOptional, isTrue);
    expect(callbackParameter.types.isArray, isFalse);
    expect(callbackParameter.types.name, equals("DOMString"));
  });

  test('callback parameter with array', () {
    var callbackParameter =
        chromeIDLParser.callbackParameters.parse("Device[] result").value;

    expect(callbackParameter, isNotNull);
    expect(callbackParameter.name, equals("result"));
    expect(callbackParameter.attribute, isNull);
    expect(callbackParameter.isCallback, isFalse);
    expect(callbackParameter.isOptional, isFalse);
    expect(callbackParameter.types.isArray, isTrue);
    expect(callbackParameter.types.name, equals("Device"));
  });

  test('callback parameter', () {
    var callbackParameter =
        chromeIDLParser.callbackParameters.parse("Device device").value;

    expect(callbackParameter, isNotNull);
    expect(callbackParameter.name, equals("device"));
    expect(callbackParameter.attribute, isNull);
    expect(callbackParameter.isCallback, isFalse);
    expect(callbackParameter.isOptional, isFalse);
    expect(callbackParameter.types.isArray, isFalse);
    expect(callbackParameter.types.name, equals("Device"));
  });
}

void chromeIDLParserCallbackMethodTests() {
  test('with no parameters', () {
    var parameters = chromeIDLParser.callbackMethod.parse("void()").value;

    expect(parameters, isNotNull);
    expect(parameters.length, equals(0));

    parameters = chromeIDLParser.callbackMethod.parse("void ()").value;

    expect(parameters, isNotNull);
    expect(parameters.length, equals(0));
  });

  test('with one parameter', () {
    var parameters =
        chromeIDLParser.callbackMethod.parse("void (long result)").value;

    expect(parameters, isNotNull);
    expect(parameters.length, equals(1));
    var parameter = parameters[0];
    expect(parameter.name, equals("result"));
    expect(parameter.attribute, isNull);
    expect(parameter.isCallback, isFalse);
    expect(parameter.isOptional, isFalse);
    expect(parameter.types.isArray, isFalse);
    expect(parameter.types.name, equals("long"));
  });

  test('with one attribute parameter', () {
    var parameters = chromeIDLParser.callbackMethod
        .parse("void ([instanceOf=DOMFileSystem] object[] mediaFileSystems)")
        .value;

    expect(parameters, isNotNull);
    expect(parameters.length, equals(1));
    var parameter = parameters[0];
    expect(parameter.name, equals("mediaFileSystems"));
    expect(parameter.attribute, isNotNull);
    expect(parameter.attribute!.attributes, isNotNull);
    expect(parameter.attribute!.attributes.length, equals(1));
    expect(parameter.attribute!.attributes[0].attributeType,
        equals(IDLAttributeTypeEnum.instanceOf));
    expect(parameter.attribute!.attributes[0].attributeValue,
        equals("DOMFileSystem"));
    expect(parameter.isCallback, isFalse);
    expect(parameter.isOptional, isFalse);
    expect(parameter.types.isArray, isTrue);
    expect(parameter.types.name, equals("DOMFileSystem"));
  });

  test('with multiple parameters', () {
    var parameters = chromeIDLParser.callbackMethod
        .parse("""void(OutputDeviceInfo[] outputInfo,
InputDeviceInfo[] inputInfo)""").value;

    expect(parameters, isNotNull);
    expect(parameters.length, equals(2));
    var parameter = parameters[0];
    expect(parameter.name, equals("outputInfo"));
    expect(parameter.attribute, isNull);
    expect(parameter.isCallback, isFalse);
    expect(parameter.isOptional, isFalse);
    expect(parameter.types.isArray, isTrue);
    expect(parameter.types.name, equals("OutputDeviceInfo"));

    parameter = parameters[1];
    expect(parameter.name, equals("inputInfo"));
    expect(parameter.attribute, isNull);
    expect(parameter.isCallback, isFalse);
    expect(parameter.isOptional, isFalse);
    expect(parameter.types.isArray, isTrue);
    expect(parameter.types.name, equals("InputDeviceInfo"));
  });

  test('with mixed type parameters', () {
    var parameters = chromeIDLParser.callbackMethod.parse(
        """void (optional ArrayBuffer result, bool success, DOMString[] codes)""").value;

    expect(parameters, isNotNull);
    expect(parameters.length, equals(3));
    var parameter = parameters[0];
    expect(parameter.name, equals("result"));
    expect(parameter.attribute, isNull);
    expect(parameter.isCallback, isFalse);
    expect(parameter.isOptional, isTrue);
    expect(parameter.types.isArray, isFalse);
    expect(parameter.types.name, equals("ArrayBuffer"));

    parameter = parameters[1];
    expect(parameter.name, equals("success"));
    expect(parameter.attribute, isNull);
    expect(parameter.isCallback, isFalse);
    expect(parameter.isOptional, isFalse);
    expect(parameter.types.isArray, isFalse);
    expect(parameter.types.name, equals("bool"));

    parameter = parameters[2];
    expect(parameter.name, equals("codes"));
    expect(parameter.attribute, isNull);
    expect(parameter.isCallback, isFalse);
    expect(parameter.isOptional, isFalse);
    expect(parameter.types.isArray, isTrue);
    expect(parameter.types.name, equals("DOMString"));
  });

  test('with `or` parameter type', () {
    // void ((long or DOMString) x)
    var parameters = chromeIDLParser.callbackMethod
        .parse("void ((long or DOMString) x)")
        .value;

    expect(parameters, isNotNull);
    expect(parameters.length, equals(1));
    var parameter = parameters[0];
    expect(parameter.name, equals("x"));
    expect(parameter.attribute, isNull);
    expect(parameter.isCallback, isFalse);
    expect(parameter.isOptional, isFalse);
    expect(parameter.types.length, 2);
    expect(parameter.types[0].name, 'long');
    expect(parameter.types[0].isArray, isFalse);
    expect(parameter.types[1].name, 'DOMString');
  });

  test('with `or` parameter optional type', () {
    // void (optional (long or DOMString) x);
    var parameters = chromeIDLParser.callbackMethod
        .parse("void (optional (long or DOMString) x)")
        .value;

    expect(parameters, isNotNull);
    expect(parameters.length, equals(1));
    var parameter = parameters[0];
    expect(parameter.name, equals("x"));
    expect(parameter.attribute, isNull);
    expect(parameter.isCallback, isFalse);
    expect(parameter.isOptional, isTrue);
    expect(parameter.types.types.first.isArray, isFalse);
    expect(parameter.types.types.first.name, equals("long"));
  });
}

void chromeIDLParserCallbackDeclarationTests() {
  test('single line', () {
    var callbackDeclaration = chromeIDLParser.callbackDeclaration.parse("""
callback GetAuthTokenCallback = void (optional DOMString token);
""").value;

    expect(callbackDeclaration.name, equals("GetAuthTokenCallback"));
    expect(callbackDeclaration.documentation, isEmpty);
    expect(callbackDeclaration.parameters.length, equals(1));
    expect(callbackDeclaration.parameters[0].name, equals("token"));
    expect(callbackDeclaration.parameters[0].types.name, equals("DOMString"));
    expect(callbackDeclaration.parameters[0].isOptional, isTrue);
    expect(callbackDeclaration.parameters[0].isCallback, isFalse);
    expect(callbackDeclaration.parameters[0].attribute, isNull);
  });

  test('single line with attributes', () {
    var callbackDeclaration = chromeIDLParser.callbackDeclaration.parse("""
[inline_doc] callback GetAuthTokenCallback = void (optional DOMString token);
""").value;

    expect(callbackDeclaration.name, equals("GetAuthTokenCallback"));
  });

  test('single line with comments', () {
    var callbackDeclaration = chromeIDLParser.callbackDeclaration.parse("""
// Some comment.
callback EntryCallback = void ([instanceOf=Entry] object entry);
""").value;

    expect(callbackDeclaration.name, equals("EntryCallback"));
    expect(callbackDeclaration.documentation.length, equals(1));
    expect(callbackDeclaration.documentation[0], equals("Some comment."));
    expect(callbackDeclaration.parameters.length, equals(1));
    expect(callbackDeclaration.parameters[0].name, equals("entry"));
    expect(callbackDeclaration.parameters[0].types.name, equals("Entry"));
    expect(callbackDeclaration.parameters[0].isOptional, isFalse);
    expect(callbackDeclaration.parameters[0].isCallback, isFalse);
    expect(callbackDeclaration.parameters[0].attribute, isNotNull);
    expect(callbackDeclaration.parameters[0].attribute!.attributes.length,
        equals(1));
    var attribute = callbackDeclaration.parameters[0].attribute!.attributes[0];
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.instanceOf));
    expect(attribute.attributeValue, equals("Entry"));
  });

  test('multiline', () {
    var callbackDeclarations =
        chromeIDLParser.callbackDeclaration.star().parse("""
callback GetAuthTokenCallback = void (optional DOMString token);
callback EntryCallback = void ([instanceOf=Entry] object entry);
""").value;

    expect(callbackDeclarations, isNotNull);
    expect(callbackDeclarations.length, equals(2));
    var callbackDeclaration = callbackDeclarations[0];
    expect(callbackDeclaration.name, equals("GetAuthTokenCallback"));
    expect(callbackDeclaration.documentation, isEmpty);
    expect(callbackDeclaration.parameters.length, equals(1));
    expect(callbackDeclaration.parameters[0].name, equals("token"));
    expect(callbackDeclaration.parameters[0].types.name, equals("DOMString"));
    expect(callbackDeclaration.parameters[0].isOptional, isTrue);
    expect(callbackDeclaration.parameters[0].isCallback, isFalse);
    expect(callbackDeclaration.parameters[0].attribute, isNull);

    callbackDeclaration = callbackDeclarations[1];
    expect(callbackDeclaration.name, equals("EntryCallback"));
    expect(callbackDeclaration.documentation, isEmpty);
    expect(callbackDeclaration.parameters.length, equals(1));
    expect(callbackDeclaration.parameters[0].name, equals("entry"));
    expect(callbackDeclaration.parameters[0].types.name, equals("Entry"));
    expect(callbackDeclaration.parameters[0].isOptional, isFalse);
    expect(callbackDeclaration.parameters[0].isCallback, isFalse);
    expect(callbackDeclaration.parameters[0].attribute, isNotNull);
    expect(callbackDeclaration.parameters[0].attribute!.attributes.length,
        equals(1));
    var attribute = callbackDeclaration.parameters[0].attribute!.attributes[0];
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.instanceOf));
    expect(attribute.attributeValue, equals("Entry"));
  });

  test('multiline with comments', () {
    var callbackDeclarations =
        chromeIDLParser.callbackDeclaration.star().parse("""
// Some comment.
callback GetAuthTokenCallback = void (optional DOMString token);
/* Another comment. */
callback EntryCallback = void ([instanceOf=Entry] object entry);
""").value;

    expect(callbackDeclarations, isNotNull);
    expect(callbackDeclarations.length, equals(2));
    var callbackDeclaration = callbackDeclarations[0];
    expect(callbackDeclaration.name, equals("GetAuthTokenCallback"));
    expect(callbackDeclaration.documentation.length, equals(1));
    expect(callbackDeclaration.parameters.length, equals(1));
    expect(callbackDeclaration.documentation[0], equals("Some comment."));
    expect(callbackDeclaration.parameters[0].name, equals("token"));
    expect(callbackDeclaration.parameters[0].types.name, equals("DOMString"));
    expect(callbackDeclaration.parameters[0].isOptional, isTrue);
    expect(callbackDeclaration.parameters[0].isCallback, isFalse);
    expect(callbackDeclaration.parameters[0].attribute, isNull);

    callbackDeclaration = callbackDeclarations[1];
    expect(callbackDeclaration.name, equals("EntryCallback"));
    expect(callbackDeclaration.documentation.length, equals(1));
    expect(callbackDeclaration.documentation[0], equals(" Another comment. "));
    expect(callbackDeclaration.parameters.length, equals(1));
    expect(callbackDeclaration.parameters[0].name, equals("entry"));
    expect(callbackDeclaration.parameters[0].types.name, equals("Entry"));
    expect(callbackDeclaration.parameters[0].isOptional, isFalse);
    expect(callbackDeclaration.parameters[0].isCallback, isFalse);
    expect(callbackDeclaration.parameters[0].attribute, isNotNull);
    expect(callbackDeclaration.parameters[0].attribute!.attributes.length,
        equals(1));
    var attribute = callbackDeclaration.parameters[0].attribute!.attributes[0];
    expect(attribute.attributeType, equals(IDLAttributeTypeEnum.instanceOf));
    expect(attribute.attributeValue, equals("Entry"));
  });
}

void chromeIDLParserFieldTypeTests() {
  test('field type with array', () {
    var fieldType = chromeIDLParser.fieldType.parse("Device[]").value;
    expect(fieldType, isNotNull);
    expect(fieldType.name, equals("Device"));
    expect(fieldType.isArray, isTrue);
  });

  test('field type without array', () {
    var fieldType = chromeIDLParser.fieldType.parse("Device").value;
    expect(fieldType, isNotNull);
    expect(fieldType.name, equals("Device"));
    expect(fieldType.isArray, isFalse);
  });

  test('field type object with array', () {
    var fieldType = chromeIDLParser.fieldType.parse("object[]").value;
    expect(fieldType, isNotNull);
    expect(fieldType.name, equals("object"));
    expect(fieldType.isArray, isTrue);
  });

  test('field type object without array', () {
    var fieldType = chromeIDLParser.fieldType.parse("object").value;
    expect(fieldType, isNotNull);
    expect(fieldType.name, equals("object"));
    expect(fieldType.isArray, isFalse);
  });
}

void chromeIDLParserFieldOrTypeTests() {
  test('field type `or` two choices', () {
    var fieldType =
        chromeIDLParser.fieldOrType.parse("(Device or DOMString)").value;
    expect(fieldType, isNotNull);
    expect(fieldType[0].name, equals("Device"));
    expect(fieldType[0].isArray, isFalse);
    expect(fieldType[1].name, equals("DOMString"));
    expect(fieldType[1].isArray, isFalse);
  });

  test('field type `or` three choices', () {
    var fieldType = chromeIDLParser.fieldOrType
        .parse("(Device or DOMString or DeviceTwo)")
        .value;
    expect(fieldType, isNotNull);
    expect(fieldType[0].name, equals("Device"));
    expect(fieldType[0].isArray, isFalse);
    expect(fieldType[1].name, equals("DOMString"));
    expect(fieldType[1].isArray, isFalse);
    expect(fieldType[2].name, equals("DeviceTwo"));
    expect(fieldType[2].isArray, isFalse);
  });

  test('field type `or` five choices', () {
    var fieldType = chromeIDLParser.fieldOrType
        .parse(
            "(Device or DOMString or DeviceTwo or DOMStringTwo or DeviceThree)")
        .value;
    expect(fieldType, isNotNull);
    expect(fieldType[0].name, equals("Device"));
    expect(fieldType[0].isArray, isFalse);
  });
}

void chromeIDLParserFieldMethodParametersTests() {
  test('with attribute', () {
    var fieldMethodParameter = chromeIDLParser.fieldMethodParameters
        .parse("[instanceOf=Entry] object entry")
        .value;

    expect(fieldMethodParameter, isNotNull);
    expect(fieldMethodParameter.name, equals("entry"));
    expect(fieldMethodParameter.isCallback, isFalse);
    expect(fieldMethodParameter.isOptional, isFalse);
    expect(fieldMethodParameter.types.isArray, isFalse);
    expect(fieldMethodParameter.types.name, equals("Entry"));
    expect(fieldMethodParameter.attribute!.attributes[0].attributeType,
        equals(IDLAttributeTypeEnum.instanceOf));
    expect(fieldMethodParameter.attribute!.attributes[0].attributeValue,
        equals("Entry"));
  });

  test('without attribute', () {
    var fieldMethodParameter = chromeIDLParser.fieldMethodParameters
        .parse("DOMString responseUrl")
        .value;

    expect(fieldMethodParameter, isNotNull);
    expect(fieldMethodParameter.name, equals("responseUrl"));
    expect(fieldMethodParameter.attribute, isNull);
    expect(fieldMethodParameter.isCallback, isFalse);
    expect(fieldMethodParameter.isOptional, isFalse);
    expect(fieldMethodParameter.types.isArray, isFalse);
    expect(fieldMethodParameter.types.name, equals("DOMString"));
  });

  test('array type without attribute', () {
    var fieldMethodParameter =
        chromeIDLParser.fieldMethodParameters.parse("DOMString[] urls").value;

    expect(fieldMethodParameter, isNotNull);
    expect(fieldMethodParameter.name, equals("urls"));
    expect(fieldMethodParameter.attribute, isNull);
    expect(fieldMethodParameter.isCallback, isFalse);
    expect(fieldMethodParameter.isOptional, isFalse);
    expect(fieldMethodParameter.types.isArray, isTrue);
    expect(fieldMethodParameter.types.name, equals("DOMString"));
  });

  test('with `or` type', () {
    var fieldMethodParameter = chromeIDLParser.fieldMethodParameters
        .parse("(DOMString or Device) thingy")
        .value;
    expect(fieldMethodParameter, isNotNull);
    expect(fieldMethodParameter.name, equals("thingy"));
    expect(fieldMethodParameter.attribute, isNull);
    expect(fieldMethodParameter.isCallback, isFalse);
    expect(fieldMethodParameter.isOptional, isFalse);
    expect(fieldMethodParameter.types[0].isArray, isFalse);
    expect(fieldMethodParameter.types[0].name, equals("DOMString"));
  });

  test('with `or` three type', () {
    var fieldMethodParameter = chromeIDLParser.fieldMethodParameters
        .parse("(DOMString or Device or DOMNode) thingy")
        .value;
    expect(fieldMethodParameter, isNotNull);
    expect(fieldMethodParameter.name, equals("thingy"));
    expect(fieldMethodParameter.attribute, isNull);
    expect(fieldMethodParameter.isCallback, isFalse);
    expect(fieldMethodParameter.isOptional, isFalse);
    expect(fieldMethodParameter.types[0].isArray, isFalse);
    expect(fieldMethodParameter.types[0].name, equals("DOMString"));
  });
}

void chromeIDLParserTypeBodyTests() {
  test('field with attribute', () {
    var typeField = chromeIDLParser.typeBody
        .parse("[instanceOf=FileEntry] object entry;")
        .value
        .cast<IDLField>();
    expect(typeField, isNotNull);
    expect(typeField.length, 1);
    expect(typeField[0].name, equals("entry"));
    expect(typeField[0].types.name, equals("FileEntry"));
    expect(typeField[0].types.isArray, isFalse);
    expect(typeField[0].isOptional, isFalse);
    expect(typeField[0].attribute!.attributes[0].attributeType,
        equals(IDLAttributeTypeEnum.instanceOf));
    expect(typeField[0].attribute!.attributes[0].attributeValue,
        equals("FileEntry"));
  });
  test('field with optional', () {
    var typeField = chromeIDLParser.typeBody
        .parse("DOMString? entry;")
        .value
        .cast<IDLField>();
    expect(typeField, isNotNull);
    expect(typeField.length, 1);
    expect(typeField[0].name, equals("entry"));
    expect(typeField[0].types.name, equals("DOMString"));
    expect(typeField[0].types.isArray, isFalse);
    expect(typeField[0].isOptional, isTrue);
  });

  test('field without optional', () {
    var typeField = chromeIDLParser.typeBody
        .parse("DOMString entry;")
        .value
        .cast<IDLField>();
    expect(typeField, isNotNull);
    expect(typeField.length, 1);
    expect(typeField[0].name, equals("entry"));
    expect(typeField[0].types.name, equals("DOMString"));
    expect(typeField[0].types.isArray, isFalse);
    expect(typeField[0].isOptional, isFalse);
  });

  test('field array with optional', () {
    var typeField = chromeIDLParser.typeBody
        .parse("DOMString[]? entry;")
        .value
        .cast<IDLField>();
    expect(typeField, isNotNull);
    expect(typeField.length, 1);
    expect(typeField[0].name, equals("entry"));
    expect(typeField[0].types.name, equals("DOMString"));
    expect(typeField[0].types.isArray, isTrue);
    expect(typeField[0].isOptional, isTrue);
  });

  test('field array without optional', () {
    var typeField = chromeIDLParser.typeBody
        .parse("DOMString[] entry;")
        .value
        .cast<IDLField>();
    expect(typeField, isNotNull);
    expect(typeField.length, 1);
    expect(typeField[0].name, equals("entry"));
    expect(typeField[0].types.name, equals("DOMString"));
    expect(typeField[0].types.isArray, isTrue);
    expect(typeField[0].isOptional, isFalse);
  });

  test('field type with `or` for choice types', () {
    var typeField = chromeIDLParser.typeBody
        .parse("(DOMString or FrameOptions)? frame;")
        .value
        .cast<IDLField>();
    expect(typeField, isNotNull);
    expect(typeField.length, 1);
    expect(typeField[0].name, equals("frame"));
    // TODO(adam): Maybe type needs to be an array of possible types.
    expect(typeField[0].types[0].name, equals("DOMString"));
    expect(typeField[0].types[0].isArray, isFalse);
    expect(typeField[0].isOptional, isTrue);
  });

  test('field type outer attribute with `or` for choice types', () {
    var typeField = chromeIDLParser.typeBody
        .parse("[nodoc] (DOMString or FrameOptions)? frame;")
        .value
        .cast<IDLField>();
    expect(typeField, isNotNull);
    expect(typeField.length, 1);
    expect(typeField[0].name, equals("frame"));
    // TODO(adam): Maybe type needs to be an array of possible types.
    expect(typeField[0].types[0].name, equals("DOMString"));
    expect(typeField[0].types[0].isArray, isFalse);
    expect(typeField[0].isOptional, isTrue);
    expect(typeField[0].attribute!.attributes[0].attributeType,
        equals(IDLAttributeTypeEnum.nodoc));
  });

  test('field void method no parameters', () {
    var typeFieldMethod = chromeIDLParser.typeBody
        .parse("static void size();")
        .value
        .cast<IDLMethod>();
    expect(typeFieldMethod, isNotNull);
    expect(typeFieldMethod.length, 1);
    expect(typeFieldMethod[0].name, equals("size"));
    expect(typeFieldMethod[0].parameters, isEmpty);
    expect(typeFieldMethod[0].attribute, isNull);
    expect(typeFieldMethod[0].returnType.name, equals("void"));
    expect(typeFieldMethod[0].returnType.isArray, isFalse);
    expect(typeFieldMethod[0].documentation, isEmpty);
  });

  test('field void method with multiple parameters', () {
    var typeFieldMethod = chromeIDLParser.typeBody
        .parse("static Sizes[] resizeTo(long width, long height);")
        .value
        .cast<IDLMethod>();
    expect(typeFieldMethod, isNotNull);
    expect(typeFieldMethod.length, 1);
    expect(typeFieldMethod[0].name, equals("resizeTo"));
    expect(typeFieldMethod[0].parameters.length, 2);
    var parameter = typeFieldMethod[0].parameters[0];
    expect(parameter.name, equals("width"));
    expect(parameter.types.name, equals("long"));
    parameter = typeFieldMethod[0].parameters[1];
    expect(parameter.name, equals("height"));
    expect(parameter.types.name, equals("long"));
    expect(typeFieldMethod[0].attribute, isNull);
    expect(typeFieldMethod[0].returnType.name, equals("Sizes"));
    expect(typeFieldMethod[0].returnType.isArray, isTrue);
    expect(typeFieldMethod[0].documentation, isEmpty);
  });

  test('field void method with attribute', () {
    var typeFieldMethod = chromeIDLParser.typeBody
        .parse("[nodoc] static void size();")
        .value
        .cast<IDLMethod>();
    expect(typeFieldMethod, isNotNull);
    expect(typeFieldMethod.length, 1);
    expect(typeFieldMethod[0].name, equals("size"));
    expect(typeFieldMethod[0].parameters, isEmpty);
    expect(typeFieldMethod[0].attribute!.attributes.length, equals(1));
    var attribute = typeFieldMethod[0].attribute!.attributes[0];
    expect(attribute.attributeType, IDLAttributeTypeEnum.nodoc);
    expect(typeFieldMethod[0].returnType.name, equals("void"));
    expect(typeFieldMethod[0].returnType.isArray, isFalse);
    expect(typeFieldMethod[0].documentation, isEmpty);
  });

  test('field type returned method with no parameters', () {
    var typeFieldMethod = chromeIDLParser.typeBody
        .parse("static Bounds getBounds();")
        .value
        .cast<IDLMethod>();
    expect(typeFieldMethod, isNotNull);
    expect(typeFieldMethod.length, 1);
    expect(typeFieldMethod[0].name, equals("getBounds"));
    expect(typeFieldMethod[0].parameters, isEmpty);
    expect(typeFieldMethod[0].attribute, isNull);
    expect(typeFieldMethod[0].returnType.name, equals("Bounds"));
    expect(typeFieldMethod[0].returnType.isArray, isFalse);
    expect(typeFieldMethod[0].documentation, isEmpty);
  });

  test('field type returned method with mixed parameters', () {
    var types = chromeIDLParser.typeBody.parse("""
// Some comments
static Bounds getBounds();

// Some other comments
// Multiline
[nodoc] static void size();

static Sizes[] resizeTo(long width, long height);

DOMString[] entry1;

DOMString[]? entry2;

DOMString? entry3;

DOMString entry4;
""").value;
    expect(types, isNotNull);
    expect(types[0].runtimeType.toString(), equals("IDLMethod"));
    expect((types[0] as IDLMethod).documentation.length, equals(1));
    expect(types[1].runtimeType.toString(), equals("IDLMethod"));
    expect((types[1] as IDLMethod).documentation.length, equals(2));
    expect(types[2].runtimeType.toString(), equals("IDLMethod"));
    expect(types[3].runtimeType.toString(), equals("IDLField"));
    expect(types[4].runtimeType.toString(), equals("IDLField"));
    expect(types[5].runtimeType.toString(), equals("IDLField"));
    expect(types[6].runtimeType.toString(), equals("IDLField"));
  });
}

void chromeIDLParserTypeDeclarationTests() {
  test('dictionary with no members or methods', () {
    var typeDeclaration = chromeIDLParser.typeDeclaration
        .parse("""// Options for the getServices function.
  dictionary GetServicesOptions {
  };
""").value;

    expect(typeDeclaration, isNotNull);
    expect(typeDeclaration.name, equals("GetServicesOptions"));
    expect(typeDeclaration.documentation.length, equals(1));
    expect(typeDeclaration.members, isEmpty);
    expect(typeDeclaration.methods, isEmpty);
    expect(typeDeclaration.attribute, isNull);
  });

  test('dictionary with one member', () {
    var typeDeclaration = chromeIDLParser.typeDeclaration
        .parse("""// Options for the getServices function.
dictionary GetServicesOptions {
  // The address of the remote device that the data should be associated
  // with. |deviceAddress| should be in the format 'XX:XX:XX:XX:XX:XX'.
  DOMString deviceAddress;
};
""").value;

    expect(typeDeclaration, isNotNull);
    expect(typeDeclaration.name, equals("GetServicesOptions"));
    expect(typeDeclaration.documentation.length, equals(1));
    expect(typeDeclaration.members.length, equals(1));
    expect(typeDeclaration.members[0].documentation.length, equals(2));
    expect(typeDeclaration.members[0].name, equals("deviceAddress"));
    expect(typeDeclaration.members[0].types.name, equals("DOMString"));
    expect(typeDeclaration.methods, isEmpty);
    expect(typeDeclaration.attribute, isNull);
  });

  test('dictionary with one method', () {
    var typeDeclaration = chromeIDLParser.typeDeclaration
        .parse("""// Options for the getServices function.
  dictionary GetServicesOptions {
    static Device getDevice();
  };
""").value;

    expect(typeDeclaration, isNotNull);
    expect(typeDeclaration.name, equals("GetServicesOptions"));
    expect(typeDeclaration.documentation.length, equals(1));
    expect(typeDeclaration.members, isEmpty);
    expect(typeDeclaration.methods.length, equals(1));
    expect(typeDeclaration.methods[0].documentation, isEmpty);
    expect(typeDeclaration.methods[0].name, equals("getDevice"));
    expect(typeDeclaration.methods[0].returnType.name, equals("Device"));
  });

  test('dictionary with multiple members', () {
    var typeDeclaration = chromeIDLParser.typeDeclaration.parse(
        """// Options for the getDevices function. If |profile| is not provided, all
// devices known to the system are returned.
  dictionary GetDevicesOptions {
    // Only devices providing |profile| will be returned.
    Profile? profile;

    // Called for each matching device.  Note that a service discovery request
    DeviceCallback deviceCallback;
  };
""").value;

    expect(typeDeclaration, isNotNull);
    expect(typeDeclaration.name, equals("GetDevicesOptions"));
    expect(typeDeclaration.documentation.length, equals(2));
    expect(typeDeclaration.methods, isEmpty);
    expect(typeDeclaration.members.length, equals(2));
    expect(typeDeclaration.members[0].name, equals("profile"));
    expect(typeDeclaration.members[0].types.name, equals("Profile"));
    expect(typeDeclaration.members[0].isOptional, isTrue);

    expect(typeDeclaration.members[1].name, equals("deviceCallback"));
    expect(typeDeclaration.members[1].types.name, equals("DeviceCallback"));
    expect(typeDeclaration.members[1].isOptional, isFalse);
  });

  test('dictionary with multiple methods', () {
    var typeDeclaration = chromeIDLParser.typeDeclaration
        .parse("""[noinline_doc] dictionary AppWindow {
    // Focus the window.
    static void focus();

    // Fullscreens the window.
    static void fullscreen();


    static boolean isFullscreen();
};
""").value;

    expect(typeDeclaration, isNotNull);
    expect(typeDeclaration.name, equals("AppWindow"));
    expect(typeDeclaration.attribute!.attributes[0].attributeType,
        equals(IDLAttributeTypeEnum.noinlineDoc));
    expect(typeDeclaration.documentation, isEmpty);
    expect(typeDeclaration.members, isEmpty);
    expect(typeDeclaration.methods.length, equals(3));
    expect(typeDeclaration.methods[0].name, equals("focus"));
    expect(typeDeclaration.methods[0].returnType.name, equals("void"));

    expect(typeDeclaration.methods[1].name, equals("fullscreen"));
    expect(typeDeclaration.methods[1].returnType.name, equals("void"));

    expect(typeDeclaration.methods[2].name, equals("isFullscreen"));
    expect(typeDeclaration.methods[2].returnType.name, equals("boolean"));
  });

  test('dictionary with attribute, members, methods', () {
    var typeDeclaration = chromeIDLParser.typeDeclaration
        .parse(r"""[noinline_doc] dictionary AppWindow {
    // Focus the window.
    static void focus();

    // Move the window to the position (|left|, |top|).
    static void moveTo(long left, long top);

    // Resize the window to |width|x|height| pixels in size.
    static void resizeTo(long width, long height);

    // Draw attention to the window.
    static void drawAttention();

    // Get the window's bounds as a $ref:Bounds object.
    [nocompile] static Bounds getBounds();

    // Set the window's bounds.
    static void setBounds(Bounds bounds);

    // Set the app icon for the window (experimental).
    [nodoc] static void setIcon(DOMString icon_url);

    // The JavaScript 'window' object for the created child.
    [instanceOf=Window] object contentWindow;

    // Type of window to create.
    [nodoc] WindowType? type;
    // The connection is made to |profile|.
    Profile profile;
  };
""").value;

    expect(typeDeclaration, isNotNull);
    expect(typeDeclaration.name, equals("AppWindow"));
    expect(typeDeclaration.attribute!.attributes[0].attributeType,
        equals(IDLAttributeTypeEnum.noinlineDoc));
    expect(typeDeclaration.documentation, isEmpty);
    expect(typeDeclaration.members.length, equals(3));
    expect(typeDeclaration.methods.length, equals(7));
  });
}

void chromeIDLParserMethodsTests() {
  test('simple method defined', () {
    var methods = chromeIDLParser.methods
        .parse("static Sizes[] resizeTo(long width, long height);")
        .value;

    expect(methods, isNotNull);
    expect(methods.length, 1);
    expect(methods[0].name, equals("resizeTo"));
    expect(methods[0].parameters.length, 2);
    var parameter = methods[0].parameters[0];
    expect(parameter.name, equals("width"));
    expect(parameter.types.name, equals("long"));
    parameter = methods[0].parameters[1];
    expect(parameter.name, equals("height"));
    expect(parameter.types.name, equals("long"));
    expect(methods[0].attribute, isNull);
    expect(methods[0].returnType.name, equals("Sizes"));
    expect(methods[0].returnType.isArray, isTrue);
    expect(methods[0].documentation, isEmpty);
  });

  test('method defined with `or` type', () {
    // static void union_params((long or DOMString) x);
    var methods = chromeIDLParser.methods
        .parse("static void union_params((long or DOMString) x);")
        .value;

    expect(methods, isNotNull);
    expect(methods.length, 1);
    expect(methods[0].name, equals("union_params"));
    expect(methods[0].parameters.length, 1);
    var parameter = methods[0].parameters[0];
    expect(parameter.name, equals("x"));
    expect(parameter.types[0].name, equals("long"));
    expect(parameter.types[1].name, equals("DOMString"));
    expect(methods[0].attribute, isNull);
    expect(methods[0].returnType.name, equals("void"));
    expect(methods[0].returnType.isArray, isFalse);
    expect(methods[0].documentation, isEmpty);
  });
}

void chromeIDLParserFunctionDeclarationTests() {
  test('test Functions declaration single function', () {
    var functionDeclaration =
        chromeIDLParser.functionDeclaration.parse("""interface Functions {
    // Gets resources required to render the API.
    //
    static void getResources(GetResourcesCallback callback);
  };
""").value;

    expect(functionDeclaration, isNotNull);
    expect(functionDeclaration.name, equals("Functions"));
    expect(functionDeclaration.methods.length, equals(1));
    expect(functionDeclaration.methods[0].name, equals("getResources"));
  });

  test('test Functions declaration single function not marked status', () {
    var functionDeclaration =
        chromeIDLParser.functionDeclaration.parse("""interface Functions {
    // Gets resources required to render the API.
    //
    void getResources(GetResourcesCallback callback);
  };
""").value;

    expect(functionDeclaration, isNotNull);
    expect(functionDeclaration.name, equals("Functions"));
    expect(functionDeclaration.methods.length, equals(1));
    expect(functionDeclaration.methods[0].name, equals("getResources"));
  });

  test('test Functions parameters are callbacks', () {
    var functionDeclaration =
        chromeIDLParser.functionDeclaration.parse("""interface Functions {
    // Get the media galleries configured in this user agent. If none are
    // configured or available, the callback will receive an empty array.
    static void getMediaFileSystems(optional MediaFileSystemsDetails details,
                                    MediaFileSystemsCallback callback);

    // Get metadata about a specific media file system.
    [nocompile] static MediaFileSystemMetadata getMediaFileSystemMetadata(
        [instanceOf=DOMFileSystem] object mediaFileSystem);
  };
""").value;

    expect(functionDeclaration, isNotNull);
    expect(functionDeclaration.name, equals("Functions"));
    expect(functionDeclaration.methods.length, equals(2));
    expect(functionDeclaration.methods[0].name, equals("getMediaFileSystems"));
    expect(functionDeclaration.methods[0].parameters, hasLength(2));
    expect(
        functionDeclaration.methods[0].parameters[0].name, equals("details"));
    expect(functionDeclaration.methods[0].parameters[0].types.name,
        equals("MediaFileSystemsDetails"));
    expect(functionDeclaration.methods[0].parameters[1].types.name,
        equals("MediaFileSystemsCallback"));
    expect(
        functionDeclaration.methods[0].parameters[1].name, equals("callback"));
    expect(functionDeclaration.methods[0].parameters[1].isCallback, isTrue);
    expect(functionDeclaration.methods[1].parameters[0].name,
        equals("mediaFileSystem"));
    expect(functionDeclaration.methods[1].parameters[0].types.name,
        equals("DOMFileSystem"));
  });
}

void chromeIDLParserEventDeclarationTests() {
  test('test Events declaration single event', () {
    var eventDeclaration =
        chromeIDLParser.eventDeclaration.parse("""interface Events {
    // Fired when a web flow dialog should be displayed.
    static void onWebFlowRequest(DOMString key, DOMString url, DOMString mode);
  };
""").value;

    expect(eventDeclaration, isNotNull);
    expect(eventDeclaration.name, equals("Events"));
    expect(eventDeclaration.methods.length, equals(1));
    expect(eventDeclaration.methods[0].name, equals("onWebFlowRequest"));
    expect(eventDeclaration.methods[0].parameters.length, equals(3));
  });
}

void chromeIDLParserNamespaceBodyTests() {
  test('single dictionary in body', () {
    List namespaceBody = chromeIDLParser.namespaceBody.parse("""
      dictionary AdapterState {
    // The address of the adapter, in the format 'XX:XX:XX:XX:XX:XX'.
    DOMString address;

    // The human-readable name of the adapter.
    DOMString name;

    // Indicates whether or not the adapter has power.
    boolean powered;

    // Indicates whether or not the adapter is available (i.e. enabled).
    boolean available;

    // Indicates whether or not the adapter is currently discovering.
    boolean discovering;
  };
""").value;

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(1));
    expect(namespaceBody[0] is IDLTypeDeclaration, isTrue);
    expect(
        (namespaceBody[0] as IDLTypeDeclaration).name, equals("AdapterState"));
    expect((namespaceBody[0] as IDLTypeDeclaration).members.length, equals(5));
  });

  test('multiple dictionary in body', () {
    List namespaceBody =
        chromeIDLParser.namespaceBody.parse("""dictionary AdapterState {
    // The address of the adapter, in the format 'XX:XX:XX:XX:XX:XX'.
    DOMString address;

    // The human-readable name of the adapter.
    DOMString name;

    // Indicates whether or not the adapter has power.
    boolean powered;

    // Indicates whether or not the adapter is available (i.e. enabled).
    boolean available;

    // Indicates whether or not the adapter is currently discovering.
    boolean discovering;
  };

  dictionary Device {
    // The address of the device, in the format 'XX:XX:XX:XX:XX:XX'.
    DOMString address;

    // The human-readable name of the device.
    DOMString? name;

    // Indicates whether or not the device is paired with the system.
    boolean? paired;

    // Indicates whether the device is currently connected to the system.
    boolean? connected;
  };

""").value;

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(2));
    expect(namespaceBody[0] is IDLTypeDeclaration, isTrue);
    expect(
        (namespaceBody[0] as IDLTypeDeclaration).name, equals("AdapterState"));
    expect((namespaceBody[0] as IDLTypeDeclaration).members.length, equals(5));
    expect(namespaceBody[1] is IDLTypeDeclaration, isTrue);
    expect((namespaceBody[1] as IDLTypeDeclaration).name, equals("Device"));
    expect((namespaceBody[1] as IDLTypeDeclaration).members.length, equals(4));
  });

  test('single interface in body', () {
    List namespaceBody = chromeIDLParser.namespaceBody.parse("""
  // These functions all report failures via chrome.runtime.lastError.
  interface Functions {
    // Registers the JavaScript application as an implementation for the given
    // Profile; if a channel or PSM is specified, the profile will be exported
    // in the host's SDP and GATT tables and advertised to other devices.
    static void addProfile(Profile profile, ResultCallback callback);
};
""").value;

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(1));
    expect(namespaceBody[0] is IDLFunctionDeclaration, isTrue);
    expect(
        (namespaceBody[0] as IDLFunctionDeclaration).name, equals("Functions"));
    expect(
        (namespaceBody[0] as IDLFunctionDeclaration).methods.length, equals(1));
  });

  test('multiple interface in body', () {
    List namespaceBody = chromeIDLParser.namespaceBody.parse("""
  // These functions all report failures via chrome.runtime.lastError.
  interface Functions {
    // Registers the JavaScript application as an implementation for the given
    // Profile; if a channel or PSM is specified, the profile will be exported
    // in the host's SDP and GATT tables and advertised to other devices.
    static void addProfile(Profile profile, ResultCallback callback);
  };


  interface Events {
    // Fired when the state of the Bluetooth adapter changes.
    // |state| : The new state of the adapter.
    static void onAdapterStateChanged(AdapterState state);

    // Fired when a connection has been made for a registered profile.
    // |socket| : The socket for the connection.
    static void onConnection(Socket socket);
  };
""").value;

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(2));
    expect(namespaceBody[0] is IDLFunctionDeclaration, isTrue);
    expect(
        (namespaceBody[0] as IDLFunctionDeclaration).name, equals("Functions"));
    expect(
        (namespaceBody[0] as IDLFunctionDeclaration).methods.length, equals(1));
    expect(namespaceBody[1] is IDLEventDeclaration, isTrue);
    expect((namespaceBody[1] as IDLEventDeclaration).name, equals("Events"));
    expect((namespaceBody[1] as IDLEventDeclaration).methods.length, equals(2));
  });

  test('single enum in body', () {
    List namespaceBody = chromeIDLParser.namespaceBody.parse("""
  enum SocketType {
    tcp,
    udp
  };
""").value;

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(1));
    expect(namespaceBody[0] is IDLEnumDeclaration, isTrue);
    expect((namespaceBody[0] as IDLEnumDeclaration).name, equals("SocketType"));
    expect((namespaceBody[0] as IDLEnumDeclaration).enums.length, equals(2));
  });

  test('multiple enum in body', () {
    List namespaceBody = chromeIDLParser.namespaceBody.parse("""
  enum DataBit { sevenbit, eightbit };
  enum ParityBit { noparity, oddparity, evenparity };
  enum StopBit { onestopbit, twostopbit };
""").value;

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(3));
    expect(namespaceBody[0] is IDLEnumDeclaration, isTrue);
    expect((namespaceBody[0] as IDLEnumDeclaration).name, equals("DataBit"));
    expect((namespaceBody[0] as IDLEnumDeclaration).enums.length, equals(2));

    expect(namespaceBody[1] is IDLEnumDeclaration, isTrue);
    expect((namespaceBody[1] as IDLEnumDeclaration).name, equals("ParityBit"));
    expect((namespaceBody[1] as IDLEnumDeclaration).enums.length, equals(3));

    expect(namespaceBody[2] is IDLEnumDeclaration, isTrue);
    expect((namespaceBody[2] as IDLEnumDeclaration).name, equals("StopBit"));
    expect((namespaceBody[2] as IDLEnumDeclaration).enums.length, equals(2));
  });

  test('single callback in body', () {
    List namespaceBody = chromeIDLParser.namespaceBody.parse("""
callback OpenCallback = void (OpenInfo openInfo);
""").value;

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(1));
    expect(namespaceBody[0] is IDLCallbackDeclaration, isTrue);
    expect((namespaceBody[0] as IDLCallbackDeclaration).name,
        equals("OpenCallback"));
    expect((namespaceBody[0] as IDLCallbackDeclaration).parameters.length,
        equals(1));
  });

  test('multiple callback in body', () {
    List namespaceBody = chromeIDLParser.namespaceBody.parse("""
  callback OpenCallback = void (OpenInfo openInfo);

  // Returns true if operation was successful.
  callback CloseCallback = void (boolean result);
""").value;

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(2));
    expect(namespaceBody[0] is IDLCallbackDeclaration, isTrue);
    expect((namespaceBody[0] as IDLCallbackDeclaration).name,
        equals("OpenCallback"));
    expect((namespaceBody[0] as IDLCallbackDeclaration).parameters.length,
        equals(1));

    expect(namespaceBody[1] is IDLCallbackDeclaration, isTrue);
    expect((namespaceBody[1] as IDLCallbackDeclaration).name,
        equals("CloseCallback"));
    expect((namespaceBody[1] as IDLCallbackDeclaration).parameters.length,
        equals(1));
  });

  test('mixed body', () {
    List namespaceBody = chromeIDLParser.namespaceBody.parse("""
  callback GetPortsCallback = void (DOMString[] ports);

  enum DataBit { sevenbit, eightbit };
  enum ParityBit { noparity, oddparity, evenparity };
  enum StopBit { onestopbit, twostopbit };

  dictionary OpenOptions {
    // The requested bitrate of the connection to be opened. For compatibility
    // with the widest range of hardware, this number should match one of
    // commonly-available bitrates, such as 110, 300, 1200, 2400, 4800, 9600,
    // 14400, 19200, 38400, 57600, 115200. There is no guarantee, of course,
    // that the device connected to the serial port will support the requested
    // bitrate, even if the port itself supports that bitrate. <code>9600</code>
    // will be passed by default.
    long? bitrate;
    // <code>"eightbit"</code> will be passed by default.
    DataBit? dataBit;
    // <code>"noparity"</code> will be passed by default.
    ParityBit? parityBit;
    // <code>"onestopbit"</code> will be passed by default.
    StopBit? stopBit;
  };

  dictionary OpenInfo {
    // The id of the opened connection.
    long connectionId;
  };

  callback OpenCallback = void (OpenInfo openInfo);

  // Returns true if operation was successful.
  callback CloseCallback = void (boolean result);

  dictionary ReadInfo {
    // The number of bytes received, or a negative number if an error occurred.
    // This number will be smaller than the number of bytes requested in the
    // original read call if the call would need to block to read that number
    // of bytes.
    long bytesRead;

    // The data received.
    ArrayBuffer data;
  };

  callback ReadCallback = void (ReadInfo readInfo);

  dictionary WriteInfo {
    // The number of bytes written.
    long bytesWritten;
  };

  callback WriteCallback = void (WriteInfo writeInfo);

  // Returns true if operation was successful.
  callback FlushCallback = void (boolean result);

  // Boolean true = mark signal (negative serial voltage).
  // Boolean false = space signal (positive serial voltage).
  //
  // For SetControlSignals, include the sendable signals that you wish to
  // change. Signals not included in the dictionary will be left unchanged.
  //
  // GetControlSignals includes all receivable signals.
  dictionary ControlSignalOptions {
    // Serial control signals that your machine can send. Missing fields will
    // be set to false.
    boolean? dtr;
    boolean? rts;

    // Serial control signals that your machine can receive. If a get operation
    // fails, success will be false, and these fields will be absent.
    //
    // DCD (Data Carrier Detect) is equivalent to RLSD (Receive Line Signal
    // Detect) on some platforms.
    boolean? dcd;
    boolean? cts;
  };

  // Returns a snapshot of current control signals.
  callback GetControlSignalsCallback = void (ControlSignalOptions options);

  // Returns true if operation was successful.
  callback SetControlSignalsCallback = void (boolean result);

  interface Functions {
    // Returns names of valid ports on this machine, each of which is likely to
    // be valid to pass as the port argument to open(). The list is regenerated
    // each time this method is called, as port validity is dynamic.
    //
    // |callback| : Called with the list of ports.
    static void getPorts(GetPortsCallback callback);

    // Opens a connection to the given serial port.
    // |port| : The name of the serial port to open.
    // |options| : Connection options.
    // |callback| : Called when the connection has been opened.
    static void open(DOMString port,
                     optional OpenOptions options,
                     OpenCallback callback);

    // Closes an open connection.
    // |connectionId| : The id of the opened connection.
    // |callback| : Called when the connection has been closed.
    static void close(long connectionId,
                      CloseCallback callback);

    // Reads a byte from the given connection.
    // |connectionId| : The id of the connection.
    // |bytesToRead| : The number of bytes to read.
    // |callback| : Called when all the requested bytes have been read or
    //              when the read blocks.
    static void read(long connectionId,
                     long bytesToRead,
                     ReadCallback callback);

    // Writes a string to the given connection.
    // |connectionId| : The id of the connection.
    // |data| : The string to write.
    // |callback| : Called when the string has been written.
    static void write(long connectionId,
                      ArrayBuffer data,
                      WriteCallback callback);

    // Flushes all bytes in the given connection's input and output buffers.
    // |connectionId| : The id of the connection.
    // |callback| : Called when the flush is complete.
    static void flush(long connectionId,
                      FlushCallback callback);

    static void getControlSignals(long connectionId,
                                  GetControlSignalsCallback callback);

    static void setControlSignals(long connectionId,
                                  ControlSignalOptions options,
                                  SetControlSignalsCallback callback);
  };
""").value;

    expect(namespaceBody, isNotNull);
    expect(namespaceBody.length, equals(17));
  });
}

void chromeIDLParserNamespaceDeclarationTests() {
  test('complete namespace test', () {
    var namespaceDeclaration = chromeIDLParser.namespaceDeclaration.parse(
        r"""// Copyright (c) 2012 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Use the <code>chrome.syncFileSystem</code> API to save and synchronize data
// on Google Drive. This API is NOT for accessing arbitrary user docs stored in
// Google Drive. It provides app-specific syncable storage for offline and
// caching usage so that the same data can be available across different
// clients. Read <a href="app_storage.html">Manage Data</a> for more on using
// this API.
namespace syncFileSystem {
  enum SyncAction {
    added, updated, deleted
  };

  enum ServiceStatus {
    // The sync service is being initialized (e.g. restoring data from the
    // database, checking connectivity and authenticating to the service etc).
    initializing,

    // The sync service is up and running.
    running,

    // The sync service is not synchronizing files because the remote service
    // needs to be authenticated by the user to proceed.
    authentication_required,

    // The sync service is not synchronizing files because the remote service
    // is (temporarily) unavailable due to some recoverable errors, e.g.
    // network is offline, the remote service is down or not
    // reachable etc. More details should be given by |description| parameter
    // in OnServiceInfoUpdated (which could contain service-specific details).
    temporary_unavailable,

    // The sync service is disabled and the content will never sync.
    // (E.g. this could happen when the user has no account on
    // the remote service or the sync service has had an unrecoverable
    // error.)
    disabled
  };

  enum FileStatus {
    // Not conflicting and has no pending local changes.
    synced,

    // Has one or more pending local changes that haven't been synchronized.
    pending,

    // File conflicts with remote version and must be resolved manually.
    conflicting
  };

  enum SyncDirection {
    local_to_remote, remote_to_local
  };

  enum ConflictResolutionPolicy {
    last_write_win, manual
  };

  dictionary FileInfo {
    // <code>fileEntry</code> for the target file whose status has changed.
    // Contains name and path information of synchronized file.
    // On file deletion,
    // <code>fileEntry</code> information will still be available
    // but file will no longer exist.
    [instanceOf=Entry] object fileEntry;

    // Resulting file status after $ref:onFileStatusChanged event.
    // The status value can be <code>'synced'</code>,
    // <code>'pending'</code> or <code>'conflicting'</code>.
    FileStatus status;

    // Sync action taken to fire $ref:onFileStatusChanged event.
    // The action value can be
    // <code>'added'</code>, <code>'updated'</code> or <code>'deleted'</code>.
    // Only applies if status is <code>'synced'</code>.
    SyncAction? action;

    // Sync direction for the $ref:onFileStatusChanged event.
    // Sync direction value can be
    // <code>'local_to_remote'</code> or <code>'remote_to_local'</code>.
    // Only applies if status is <code>'synced'</code>.
    SyncDirection? direction;
  };

  dictionary FileStatusInfo {
    // One of the Entry's originally given to getFileStatuses.
    [instanceOf=Entry] object fileEntry;

    // The status value can be <code>'synced'</code>,
    // <code>'pending'</code> or <code>'conflicting'</code>.
    FileStatus status;

    // Optional error that is only returned if there was a problem retrieving
    // the FileStatus for the given file.
    DOMString? error;
  };

  dictionary StorageInfo {
    long usageBytes;
    long quotaBytes;
  };

  dictionary ServiceInfo {
    ServiceStatus state;
    DOMString description;
  };

  // A callback type for requestFileSystem.
  callback GetFileSystemCallback =
      void ([instanceOf=DOMFileSystem] object fileSystem);

  // A callback type for getUsageAndQuota.
  callback QuotaAndUsageCallback = void (StorageInfo info);

  // Returns true if operation was successful.
  callback DeleteFileSystemCallback = void (boolean result);

  // A callback type for getFileStatus.
  callback GetFileStatusCallback = void (FileStatus status);

  // A callback type for getFileStatuses.
  callback GetFileStatusesCallback = void (FileStatusInfo[] status);

  // A callback type for getServiceStatus.
  callback GetServiceStatusCallback = void (ServiceStatus status);

  // A callback type for getConflictResolutionPolicy.
  callback GetConflictResolutionPolicyCallback =
      void (ConflictResolutionPolicy policy);

  // A generic result callback to indicate success or failure.
  callback ResultCallback = void ();

  interface Functions {
    // Returns a syncable filesystem backed by Google Drive.
    // The returned <code>DOMFileSystem</code> instance can be operated on
    // in the same way as the Temporary and Persistant file systems (see
    // <a href="http://www.w3.org/TR/file-system-api/">http://www.w3.org/TR/file-system-api/</a>).
    // Calling this multiple times from
    // the same app will return the same handle to the same file system.
    static void requestFileSystem(GetFileSystemCallback callback);

    // Sets the default conflict resolution policy
    // for the <code>'syncable'</code> file storage for the app.
    // By default it is set to <code>'last_write_win'</code>.
    // When conflict resolution policy is set to <code>'last_write_win'</code>
    // conflicts for existing files are automatically resolved next time
    // the file is updated.
    // |callback| can be optionally given to know if the request has
    // succeeded or not.
    static void setConflictResolutionPolicy(
        ConflictResolutionPolicy policy,
        optional ResultCallback callback);

    // Gets the current conflict resolution policy.
    static void getConflictResolutionPolicy(
        GetConflictResolutionPolicyCallback callback);

    // Returns the current usage and quota in bytes
    // for the <code>'syncable'</code> file storage for the app.
    static void getUsageAndQuota([instanceOf=DOMFileSystem] object fileSystem,
                                 QuotaAndUsageCallback callback);

    // Returns the $ref:FileStatus for the given <code>fileEntry</code>.
    // The status value can be <code>'synced'</code>,
    // <code>'pending'</code> or <code>'conflicting'</code>.
    // Note that <code>'conflicting'</code> state only happens when
    // the service's conflict resolution policy is set to <code>'manual'</code>.
    static void getFileStatus([instanceOf=Entry] object fileEntry,
                              GetFileStatusCallback callback);

    // Returns each $ref:FileStatus for the given <code>fileEntry</code> array.
    // Typically called with the result from dirReader.readEntries().
    static void getFileStatuses(object[] fileEntries,
                                GetFileStatusesCallback callback);

    // Returns the current sync backend status.
    static void getServiceStatus(GetServiceStatusCallback callback);
  };

  interface Events {
    // Fired when an error or other status change has happened in the
    // sync backend (for example, when the sync is temporarily disabled due to
    // network or authentication error).
    static void onServiceStatusChanged(ServiceInfo detail);

    // Fired when a file has been updated by the background sync service.
    static void onFileStatusChanged(FileInfo detail);
  };

};""").value;

    expect(namespaceDeclaration, isNotNull);
    expect(namespaceDeclaration.name, equals("syncFileSystem"));
  });
}

void miscParsingTests() {
  test('object used in dictionary', () {
    var testData = """dictionary MediaStreamConstraint {
    object mandatory;
};
""";

    var result = chromeIDLParser.typeDeclaration.parse(testData);

    expect(result, isNotNull);
  });

  test('object used in callback definition', () {
    var testData =
        """callback GetAllCallback = void (object notifications); """;

    var callbackDeclaration =
        chromeIDLParser.callbackDeclaration.parse(testData).value;

    expect(callbackDeclaration, isNotNull);
    expect(callbackDeclaration.name, equals("GetAllCallback"));
    expect(callbackDeclaration.documentation, isEmpty);
    expect(callbackDeclaration.parameters.length, equals(1));
    expect(callbackDeclaration.parameters[0].name, equals("notifications"));
    expect(callbackDeclaration.parameters[0].types.name, equals("object"));
    expect(callbackDeclaration.parameters[0].isOptional, isFalse);
    expect(callbackDeclaration.parameters[0].isCallback, isFalse);
    expect(callbackDeclaration.parameters[0].attribute, isNull);
  });

  test('optional object array with type attribute defined instanceOf callback',
      () {
    var testData = """callback MediaFileSystemsCallback =
      void ([instanceOf=DOMFileSystem] optional object[] mediaFileSystems);""";

    var callbackDeclaration =
        chromeIDLParser.callbackDeclaration.parse(testData).value;

    expect(callbackDeclaration, isNotNull);
    expect(callbackDeclaration.name, equals("MediaFileSystemsCallback"));
    expect(callbackDeclaration.documentation, isEmpty);
    var parameters = callbackDeclaration.parameters;
    expect(parameters.length, equals(1));
    expect(parameters[0].name, equals("mediaFileSystems"));
    expect(parameters[0].types.name, equals("DOMFileSystem"));
    expect(parameters[0].isOptional, isTrue);
    expect(parameters[0].isCallback, isFalse);
    expect(parameters[0].attribute, isNotNull);
  });

  test('object optional by ? with attribute defined instanceOf', () {
    var testData = """dictionary AttachedFile {
    DOMString name;
    [instanceOf=Blob] object? data;
  };
""";

    var result = chromeIDLParser.typeDeclaration.parse(testData);

    expect(result, isNotNull);
  });

  test('attribute with name=1', () {
    var testData = """[maxListeners=1] static void onDeterminingFilename(
DownloadItem downloadItem, SuggestFilenameCallback suggest);
""";

    var result = chromeIDLParser.methods.parse(testData).value;

    expect(result, isNotNull);
    expect(result, hasLength(1));
  });

  test('object passed as method parameter', () {
    var testData = """interface Functions {
[nocompile, nodoc] static void initializeAppWindow(object state);
  };""";

    var result = chromeIDLParser.functionDeclaration.parse(testData);

    expect(result, isNotNull);
  });

  test('object as parameter for callback', () {
    var testData = """callback GetStringsCallback = void (object result);""";

    var callbackDeclaration =
        chromeIDLParser.callbackDeclaration.parse(testData).value;

    expect(callbackDeclaration, isNotNull);
  });

  test('namespace with dot in identifier', () {
    var testData = """namespace enterprise.deviceAttributes { };""";

    var namespace = chromeIDLParser.namespaceDeclaration.parse(testData).value;

    expect(namespace, isNotNull);
  });

  test('enum value with attribute', () {
    var testData = """
namespace notifications {
  enum TemplateType {
    // icon, title, message, expandedMessage, up to two buttons
    basic,

    // icon, title, message, expandedMessage, image, up to two buttons
    [deprecated="The image is not visible for Mac OS X users."]
    image
  };
};
""";

    var namespace = chromeIDLParser.namespaceDeclaration.parse(testData).value;
    expect(namespace, isNotNull);
  });
}
