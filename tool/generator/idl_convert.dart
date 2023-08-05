import 'package:collection/collection.dart';
import 'chrome_model.dart';
import 'idl_model.dart';
import 'idl_parser.dart';
import 'utils/string.dart';

class IdlModelConverter {
  final Context context;
  final IDLNamespaceDeclaration model;
  final _syntheticDictionaries = <Dictionary>[];
  final _syntheticTypedefs = <Typedef>[];

  IdlModelConverter(this.context, this.model);

  String get _targetFileName => '${model.name.snakeCase}.dart';

  factory IdlModelConverter.fromString(Context context, String content) {
    var parser = ChromeIDLParser();
    var namespace = parser.namespaceDeclaration.parse(content).value;
    return IdlModelConverter(context, namespace);
  }

  ChromeApi convert() {
    return ChromeApi(
      name: model.name,
      documentation: _toDocumentation(model.documentation),
      events: _convertEvents().toList(),
      properties: _convertProperties().toList(),
      functions: _convertMethods().toList(),
      dictionaries: [..._convertDictionaries(), ..._syntheticDictionaries],
      enumerations: _convertEnums().toList(),
      typedefs: _syntheticTypedefs,
    );
  }

  AsyncReturnType _asyncTypeFromParameter(List<IDLParameter> parameters,
      {required String parentName, required bool jsIsNullable}) {
    ChromeType? dartType;
    var allParameters = <FunctionParameter>[];
    if (parameters.length == 1) {
      var createdProperty = _convertSyntheticParam(parameters.first);
      dartType = createdProperty.type;
      allParameters.add(
          FunctionParameter(createdProperty.rawName, createdProperty.type));
    } else if (parameters.length > 1) {
      var newTypeName = parentName;

      var properties = <Property>[];
      for (var param in parameters) {
        var syntheticProperty = _convertSyntheticParam(param);
        properties.add(syntheticProperty);
        allParameters.add(FunctionParameter(
            syntheticProperty.rawName, syntheticProperty.type));
      }

      var syntheticType = Dictionary(newTypeName,
          properties: properties,
          methods: [],
          events: [],
          documentation: '',
          isAnonymous: false,
          isSyntheticEvent: true);
      dartType = DictionaryType(newTypeName,
          locationFile: _targetFileName, isNullable: false);
      _syntheticDictionaries.add(syntheticType);
    }
    var jsCallback =
        FunctionType(null, allParameters, isNullable: jsIsNullable);
    return AsyncReturnType(dartType, jsCallback);
  }

  Iterable<Event> _convertEvents() sync* {
    if (model.eventDeclaration == null) return;

    for (var e in model.eventDeclaration!.methods) {
      var callback = _asyncTypeFromParameter(e.parameters,
          parentName: '${e.name.upperCamel}Event', jsIsNullable: false);
      yield Event(e.name,
          type: callback, documentation: _toDocumentation(e.documentation));
    }
  }

  Property _convertSyntheticParam(IDLParameter param) {
    ChromeType type;
    var callback = model.callbackDeclarations
        .singleWhereOrNull((e) => e.name == param.types.name);

    if (callback != null) {
      var positionalParameters = callback.parameters.map((p) {
        var innerParam = _convertSyntheticParam(p);

        return FunctionParameter(innerParam.rawName, innerParam.type);
      }).toList();
      type = FunctionType(null, positionalParameters,
          isNullable: param.isOptional);
      if (_syntheticTypedefs.none((e) => e.alias == callback.name)) {
        _syntheticTypedefs.add(Typedef(callback.name,
            target: type,
            documentation: _toDocumentation(callback.documentation)));
      }
      type = AliasedType(callback.name, type,
          locationFile: _targetFileName, isNullable: param.isOptional);
    } else {
      type = _typeFromName(param.types, isNullable: param.isOptional);
    }

    return Property(
      param.name,
      type: type,
      documentation: '',
    );
  }

  Iterable<Property> _convertProperties() sync* {
    if (model.propertiesDeclaration == null) return;

    for (var prop in model.propertiesDeclaration!.methods) {
      var nullable = false;
      if (_hasPlatforms(prop.attribute)) {
        nullable = true;
      }
      yield Property(
        prop.name,
        type: _singleTypeFromName(prop.returnType, isNullable: nullable),
        documentation: _toDocumentation(prop.documentation),
      );
    }
  }

  Iterable<Dictionary> _convertDictionaries() sync* {
    for (var declaration in model.typeDeclarations) {
      var properties = <Property>[];
      for (var member in declaration.members) {
        if (member.name.startsWith('_')) continue;

        var p = Property(member.name,
            type: _typeFromName(member.types,
                isNullable:
                    member.isOptional || _hasPlatforms(member.attribute)),
            documentation: _toDocumentation(member.documentation));
        properties.add(p);
      }

      if (declaration.methods.isNotEmpty) {
        throw UnimplementedError(
            '${model.name} / ${declaration.name} has methods');
      }
      if (declaration.methods.isNotEmpty) {
        throw UnimplementedError(
            '${model.name} / ${declaration.name} has methods');
      }

      yield Dictionary(
        declaration.name,
        properties: properties,
        methods: [],
        events: [],
        documentation: _toDocumentation(declaration.documentation),
        //TODO: make it anonymous if this is a "input" only type?
        isAnonymous: false,
      );
    }
  }

  Iterable<Method> _convertMethods() sync* {
    for (var function in model.functionDeclaration?.methods ?? <IDLMethod>[]) {
      var parameters = <Property>[];
      AsyncReturnType? callback;
      for (var paramDecl in function.parameters) {
        if (paramDecl.isCallback && function.returnType.name == 'void') {
          if (callback != null) {
            throw UnimplementedError(
                'Multiple callback for ${model.name} ${function.name}');
          }
          var callbackDeclaration = model.callbackDeclarations.singleWhere(
              (c) => c.name == paramDecl.types.name,
              orElse: () => throw StateError(
                  'Look for callback ${paramDecl.types.name} ${model.name} ${function.name}'));

          callback = _asyncTypeFromParameter(callbackDeclaration.parameters,
              parentName: '${function.name.upperCamel}Result',
              jsIsNullable: paramDecl.isOptional)
            ..supportsPromises = function.attribute.supportsPromises;
          if (function.returnType.name != 'void') {
            throw UnimplementedError(
                'Async with non void function ${model.name} / ${function.name}');
          }
        } else {
          var property = Property(
            paramDecl.name,
            type: _typeFromName(paramDecl.types,
                isNullable: paramDecl.isOptional),
            documentation: '',
          );
          parameters.add(property);
        }
      }
      var returns = MethodReturn(
        type: callback ??
            (function.returnType.name != 'void'
                ? _singleTypeFromName(function.returnType, isNullable: false)
                : null),
        documentation: null,
      );

      yield Method(
        function.name,
        parameters: parameters,
        documentation: _toDocumentation(function.documentation),
        returns: returns,
        deprecated: function.attribute?.attributes
            .firstWhereOrNull(
                (e) => e.attributeType == IDLAttributeTypeEnum.deprecated)
            ?.attributeValue,
      );
    }
  }

  Iterable<Enumeration> _convertEnums() sync* {
    for (var declaration in model.enumDeclarations) {
      yield Enumeration(
        declaration.name,
        documentation: _toDocumentation(declaration.documentation),
        values: declaration.enums
            .map((v) => EnumerationValue(
                name: v.name, documentation: _toDocumentation(v.documentation)))
            .toList(),
      );
    }
  }

  ChromeType _typeFromName(IDLTypeOrUnion type, {required bool isNullable}) {
    if (type.length > 1) {
      return ChoiceType([
        for (var type in type.types)
          _singleTypeFromName(type, isNullable: false),
      ], isNullable: isNullable);
    } else {
      return _singleTypeFromName(type.types.first, isNullable: isNullable);
    }
  }

  ChromeType _singleTypeFromName(IDLType type, {required bool isNullable}) {
    var name = type.name;
    var arrayIsNullable = isNullable;
    if (type.isArray) {
      isNullable = false;
    }
    var chromeType = context.createType(name,
        locationFile: _targetFileName, isNullable: isNullable);
    if (type.isArray) {
      return ListType(chromeType, isNullable: arrayIsNullable);
    }
    return chromeType;
  }
}

//TODO(xha): keep the raw documentation and now re-wrap it in code-generation
String _toDocumentation(List<String> documentation) => documentation.join('\n');

bool _hasPlatforms(IDLAttributeDeclaration? attribute) {
  return attribute?.attributes
          .any((a) => a.attributeType == IDLAttributeTypeEnum.platforms) ??
      false;
}
