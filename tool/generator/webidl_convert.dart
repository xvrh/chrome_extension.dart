library;

import 'package:collection/collection.dart';
import 'idl_model.dart';
import 'idl_parser.dart' show isCallback;
import 'utils/string.dart';
import 'webidl_parser.dart';

/// Parses a `.webidl` schema into the same model as the legacy `.idl`
/// schemas, following the conversion rules of Chromium's
/// `tools/json_schema_compiler/web_idl_schema.py`.
IDLNamespaceDeclaration parseWebIdlNamespace(String source) =>
    _WebIdlConverter(parseWebIdl(source)).convert();

class _WebIdlConverter {
  final List<WebIdlDefinition> definitions;
  final _syntheticCallbacks = <IDLCallbackDeclaration>[];

  _WebIdlConverter(this.definitions);

  T? _find<T extends WebIdlDefinition>(String name) =>
      definitions.whereType<T>().firstWhereOrNull((e) => e.name == name);

  IDLNamespaceDeclaration convert() {
    var browser = definitions
        .whereType<WebIdlInterface>()
        .firstWhereOrNull((e) => e.name == 'Browser');
    if (browser == null) {
      throw UnsupportedError('Schema without a "partial interface Browser"');
    }

    // APIs with a dot in their name (system.cpu) are exposed through nested
    // partial interfaces.
    var attribute = browser.members.whereType<WebIdlAttribute>().single;
    var name = attribute.name;
    var namespace = _find<WebIdlInterface>(attribute.type.name)!;
    while (namespace.isPartial) {
      attribute = namespace.members.whereType<WebIdlAttribute>().first;
      name += '.${attribute.name}';
      namespace = _find<WebIdlInterface>(attribute.type.name)!;
    }

    var functions = <IDLMethod>[];
    var events = <IDLMethod>[];
    var properties = <IDLMethod>[];
    for (var member in namespace.members) {
      switch (member) {
        case WebIdlOperation():
          functions.add(_function(member));
        case WebIdlAttribute():
          var event = _event(member);
          if (event != null) {
            events.add(event);
          } else {
            properties.add(IDLMethod(
                member.name, _singleType(member.type, const []), [],
                attribute: _attributes(member.extendedAttributes),
                documentation: _documentation(member.documentation)));
          }
        case WebIdlConst():
          properties.add(IDLMethod(
              member.name, _singleType(member.type, const []), [],
              attribute: _attributes(member.extendedAttributes),
              documentation: _documentation(member.documentation)));
      }
    }

    return IDLNamespaceDeclaration(
      name,
      documentation: _documentation(namespace.documentation),
      attribute: _attributes(namespace.extendedAttributes),
      functionDeclaration: IDLFunctionDeclaration(functions, documentation: []),
      eventDeclaration: IDLEventDeclaration(events, documentation: []),
      propertiesDeclaration:
          IDLPropertiesDeclaration(properties, documentation: []),
      typeDeclarations: [
        for (var dictionary in definitions.whereType<WebIdlDictionary>())
          // Manifest keys are not part of the API.
          if (dictionary.name != 'ExtensionManifest') _dictionary(dictionary),
      ],
      enumDeclarations: [
        for (var enumDefinition in definitions.whereType<WebIdlEnum>())
          IDLEnumDeclaration(
            enumDefinition.name,
            [
              for (var value in enumDefinition.values)
                IDLEnumValue(value.name,
                    documentation: _documentation(value.documentation)),
            ],
            attribute: _attributes(enumDefinition.extendedAttributes),
            documentation: _documentation(enumDefinition.documentation),
          ),
      ],
      callbackDeclarations: [
        for (var callback in definitions.whereType<WebIdlCallback>())
          IDLCallbackDeclaration(callback.name, _parameters(callback.arguments),
              documentation: _documentation(callback.documentation)),
        ..._syntheticCallbacks,
      ],
    );
  }

  IDLMethod _function(WebIdlOperation operation) {
    var attributes = [...operation.extendedAttributes];
    var parameters = _parameters(operation.arguments);
    var returnType = operation.returnType;

    if (returnType.name == 'Promise') {
      // The legacy model describes asynchronous results with a trailing
      // callback parameter.
      var value = returnType.arguments.single;
      var callbackName = '${operation.name.upperCamel}Callback';
      while (definitions.any((d) => d.name == callbackName) ||
          _syntheticCallbacks.any((c) => c.name == callbackName)) {
        callbackName = '_$callbackName';
      }
      _syntheticCallbacks.add(IDLCallbackDeclaration(callbackName, [
        if (value.name != 'undefined')
          IDLParameter(_promiseValueName(operation.documentation),
              _types(value, const []),
              isOptional: value.isNullable),
      ], documentation: []));
      parameters.add(IDLParameter(
          'callback', IDLTypeOrUnion([IDLType(callbackName)]),
          isOptional: !attributes.has('requiredCallback'), isCallback: true));
      return IDLMethod(operation.name, IDLType('void'), parameters,
          attribute: _attributes(attributes),
          documentation: _documentation(operation.documentation));
    }

    // A few functions don't support promises and keep a trailing callback.
    if (!attributes.has('trailingCallbackIsFunctionParameter') &&
        operation.arguments.isNotEmpty &&
        _find<WebIdlCallback>(operation.arguments.last.type.name) != null) {
      var callback = parameters.removeLast();
      parameters.add(IDLParameter(callback.name, callback.types,
          attribute: callback.attribute,
          isOptional: callback.isOptional,
          isCallback: true));
      attributes.add(WebIdlExtendedAttribute('doesNotSupportPromises', null));
    }

    return IDLMethod(
        operation.name, _singleType(returnType, const []), parameters,
        attribute: _attributes(attributes),
        documentation: _documentation(operation.documentation));
  }

  /// Converts an attribute of type `interface X : ExtensionEvent` to an event
  /// with the parameters of its listener.
  IDLMethod? _event(WebIdlAttribute attribute) {
    var eventInterface = _find<WebIdlInterface>(attribute.type.name);
    if (eventInterface == null || eventInterface.inherits != 'ExtensionEvent') {
      return null;
    }
    var addListener = eventInterface.members
        .whereType<WebIdlOperation>()
        .singleWhere((e) => e.name == 'addListener');
    var listener =
        _find<WebIdlCallback>(addListener.arguments.single.type.name)!;
    return IDLMethod(
        attribute.name, IDLType('void'), _parameters(listener.arguments),
        attribute: _attributes(attribute.extendedAttributes),
        documentation: _documentation(attribute.documentation));
  }

  IDLTypeDeclaration _dictionary(WebIdlDictionary dictionary) {
    var fields = <IDLField>[];
    var methods = <IDLMethod>[];
    for (var member in dictionary.members) {
      // The methods of the legacy model are required members with a callback
      // type.
      if (_find<WebIdlCallback>(member.type.name) case var callback?
          when member.isRequired) {
        methods.add(IDLMethod(
            member.name,
            _singleType(callback.returnType, const []),
            _parameters(callback.arguments),
            attribute: _attributes(member.extendedAttributes),
            documentation: _documentation(member.documentation)));
      } else {
        fields.add(IDLField(
            member.name, _types(member.type, member.extendedAttributes),
            attribute: _attributes(member.extendedAttributes),
            isOptional: !member.isRequired,
            documentation: _documentation(member.documentation)));
      }
    }
    return IDLTypeDeclaration(dictionary.name, fields,
        methods: methods,
        attribute: _attributes(dictionary.extendedAttributes),
        documentation: _documentation(dictionary.documentation));
  }

  List<IDLParameter> _parameters(List<WebIdlArgument> arguments) => [
        for (var argument in arguments)
          IDLParameter(
              argument.name, _types(argument.type, argument.extendedAttributes),
              attribute: _attributes(argument.extendedAttributes),
              isOptional: argument.isOptional,
              isCallback: isCallback(argument.name)),
      ];

  IDLTypeOrUnion _types(
      WebIdlType type, List<WebIdlExtendedAttribute> holderAttributes) {
    if (_find<WebIdlTypedef>(type.name) case var typedef?
        when !typedef.extendedAttributes.has('ExternalExtensionType')) {
      return _types(
          typedef.type, [...holderAttributes, ...typedef.extendedAttributes]);
    }
    if (type.isUnion) {
      return IDLTypeOrUnion([
        for (var member in type.arguments)
          ..._types(member, holderAttributes).types,
      ]);
    }
    return IDLTypeOrUnion([_singleType(type, holderAttributes)]);
  }

  IDLType _singleType(
      WebIdlType type, List<WebIdlExtendedAttribute> holderAttributes) {
    if (_find<WebIdlTypedef>(type.name) case var typedef?) {
      if (typedef.extendedAttributes.valueOf('ExternalExtensionType')
          case String externalType) {
        return IDLType(externalType);
      }
      return _singleType(
          typedef.type, [...holderAttributes, ...typedef.extendedAttributes]);
    }
    switch (type.name) {
      case 'sequence':
        var item = _singleType(type.arguments.single, const []);
        if (item.isArray) {
          throw UnsupportedError('Nested sequence: $type');
        }
        return IDLType(item.name, isArray: true);
      case 'undefined':
        return IDLType('void');
      case 'Uint8Array':
        return IDLType('ArrayBuffer');
      case 'object':
        if (holderAttributes.valueOf('instanceOf') case String instanceOf) {
          return IDLType(instanceOf);
        }
        return IDLType('object');
      case 'union' || 'Promise':
        throw UnsupportedError('Unexpected type $type');
    }
    return IDLType(type.name);
  }

  IDLAttributeDeclaration? _attributes(
      List<WebIdlExtendedAttribute> attributes) {
    var converted = <IDLAttribute>[];
    for (var attribute in attributes) {
      var type = IDLAttributeTypeEnum.values
          .firstWhereOrNull((e) => e.type == attribute.name);
      if (type == null) continue;
      converted.add(switch (attribute.value) {
        List<String> values => IDLAttribute(type, attributeValues: values),
        String value => IDLAttribute(type,
            attributeValue:
                value.split('\n').map((line) => line.trim()).join(' ')),
        _ => IDLAttribute(type),
      });
    }
    return converted.isEmpty ? null : IDLAttributeDeclaration(converted);
  }
}

final _promiseValue = RegExp(r'\|PromiseValue\|\s*:\s*([A-Za-z_]\w*)');

String _promiseValueName(List<String> documentation) =>
    _promiseValue.firstMatch(documentation.join('\n'))?.group(1) ?? 'result';

/// Removes the `|PromiseValue|: name` annotation, it names the value of the
/// promise and isn't meant to be read.
List<String> _documentation(List<String> lines) {
  var result = <String>[];
  var skip = false;
  for (var line in lines) {
    var trimmed = line.trimLeft();
    if (trimmed.startsWith('|')) {
      skip = trimmed.startsWith('|PromiseValue|');
    }
    if (!skip) result.add(line);
  }
  while (result.isNotEmpty && result.last.trim().isEmpty) {
    result.removeLast();
  }
  return result;
}
