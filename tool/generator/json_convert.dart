import 'chrome_model.dart';
import 'json_model.dart';
import 'utils/string.dart';

final _autoCallbackToReturnFalsePositives = <String>{
  'devtools.panels.setOpenResourceHandler',
};

class JsonModelConverter {
  final Context context;
  final JsonNamespace model;
  late final _enumsToConvert =
      model.types.where((e) => e.enums != null).toList();
  late final _dictionariesToGenerate = model.types
      .where((e) =>
          e.enums == null && e.type == 'object' && e.isInstanceOf == null)
      .toList();
  final _syntheticDictionaries = <Dictionary>[];

  JsonModelConverter(this.context, this.model);

  String get _targetFileName => '${model.namespace.snakeCase}.dart';

  ChromeApi convert() {
    return ChromeApi(
      name: model.namespace,
      documentation: model.description,
      events: _convertEvents().toList(),
      functions: _convertFunctions().toList(),
      properties: _convertProperties().toList(),
      typedefs: _convertTypedefs().toList(),
      dictionaries: [..._convertDictionaries(), ..._syntheticDictionaries],
      enumerations: _convertEnums().toList(),
    );
  }

  Iterable<Event> _convertEvents() sync* {
    for (var e in model.events) {
      yield _toEvent(e);
    }
  }

  AsyncReturnType _asyncFromParameters(List<JsonProperty> functionParameters,
      {required String parentName,
      required String syntheticTypeName,
      required bool jsIsNullable,
      required String? returnName}) {
    FunctionParameter? singleParameter;
    var allParameters = <FunctionParameter>[];
    if (functionParameters.length > 1) {
      var syntheticProperties = <Property>[];
      for (var param in functionParameters) {
        var syntheticProperty = _addSyntheticTypeIfNeeded(
                param, param.name!, parentName,
                anonymous: false, isNullable: param.optional ?? false) ??
            _propertyType(param);
        syntheticProperties.add(Property(param.name!,
            type: syntheticProperty, documentation: param.description));
        allParameters
            .add(FunctionParameter(param.name ?? 'e', syntheticProperty));
      }

      singleParameter = FunctionParameter(
          'e',
          DictionaryType(syntheticTypeName,
              locationFile: _targetFileName, isNullable: false));
      var syntheticType = Dictionary(syntheticTypeName,
          properties: syntheticProperties,
          methods: [],
          events: [],
          documentation: '',
          isAnonymous: false,
          isSyntheticEvent: true);
      _syntheticDictionaries.add(syntheticType);
    } else if (functionParameters case [var p]) {
      var type = _addSyntheticTypeIfNeeded(
              p, '${returnName ?? ''}_${p.name!}', parentName,
              anonymous: false, isNullable: p.optional ?? false) ??
          _propertyType(p);
      singleParameter = FunctionParameter(p.name!.lowerCamel, type);
      allParameters.add(singleParameter);
    }
    var jsReturnType =
        FunctionType(null, allParameters, isNullable: jsIsNullable);
    return AsyncReturnType(singleParameter?.type, jsReturnType);
  }

  Event _toEvent(JsonFunction event, {String? parent}) {
    var returnType = _asyncFromParameters(event.parameters,
        parentName: event.name,
        syntheticTypeName: '${parent ?? ''} ${event.name} Event'.upperCamel,
        returnName: null,
        jsIsNullable: false);
    return Event(event.name,
        type: returnType, documentation: event.description);
  }

  Iterable<Method> _convertFunctions() sync* {
    for (var f in model.functions) {
      yield _convertFunction(f);
    }
  }

  Method _convertFunction(JsonFunction function) {
    var jsonReturns = function.returnsAsync ?? function.returns;

    if (jsonReturns == null) {
      var callbacks = function.parameters
          .where((p) => p.type == 'function' && p.parameters != null)
          .toList();
      if (callbacks.length == 1) {
        if (!_autoCallbackToReturnFalsePositives
            .contains('${model.namespace}.${function.name}')) {
          jsonReturns = callbacks.first;
        }
      }
    }

    var returns =
        MethodReturn(type: null, documentation: jsonReturns?.description);

    ChromeType returnType;
    if (jsonReturns != null) {
      if (function.returnsAsync != null && jsonReturns.parameters == null) {
        throw StateError(
            'Not a function in ${model.namespace} ${function.name}');
      }

      if (jsonReturns.parameters != null) {
        returnType = _asyncFromParameters(jsonReturns.parameters!,
            parentName: function.name,
            returnName: jsonReturns.name!,
            syntheticTypeName: '${function.name.upperCamel}Result',
            jsIsNullable: jsonReturns.optional ?? false)
          ..supportsPromises = function.returnsAsync != null;
      } else {
        returnType = _addSyntheticTypeIfNeeded(
                jsonReturns, 'Return', function.name,
                anonymous: false, isNullable: jsonReturns.optional ?? false) ??
            _propertyType(jsonReturns);
      }

      returns = MethodReturn(
        name: jsonReturns.name,
        type: returnType,
        documentation: jsonReturns.description,
      );
    }

    return Method(
      function.name,
      returns: returns,
      parameters: _functionParameters(function, returns: jsonReturns).toList(),
      documentation: function.description,
      deprecated: function.deprecated,
    );
  }

  Iterable<Property> _functionParameters(JsonFunction function,
      {required JsonProperty? returns}) sync* {
    for (var param in function.parameters) {
      if (param == returns) {
        continue;
      }

      var name = param.name!;
      var parameterType = _addSyntheticTypeIfNeeded(param, name, function.name,
              anonymous: true, isNullable: param.optional ?? false) ??
          _propertyType(param, parentName: function.name);

      yield Property(
        name,
        type: parameterType,
        documentation: param.description,
      );
    }
  }

  ChromeType? _addSyntheticTypeIfNeeded(
      JsonProperty property, String name, String parent,
      {required bool anonymous, required bool isNullable}) {
    ChromeType? type;
    if (property.properties != null) {
      if (property.properties!.isEmpty &&
          property.additionalProperties != null) {
        return null;
      }
      var typeName =
          '${name.startsWith(parent) ? '' : parent} $name'.upperCamel;
      _dictionariesToGenerate.add(JsonDeclaredType(
          typeName, property.description,
          properties: property.properties)
        ..isAnonymous = anonymous
        ..extend = property.$ref);
      type = DictionaryType(typeName,
          locationFile: _targetFileName, isNullable: isNullable);
    } else if (property.enums != null) {
      var typeName =
          '${name.startsWith(parent) ? '' : parent} $name'.upperCamel;
      _dictionariesToGenerate.add(JsonDeclaredType(
          typeName, property.description,
          enums: property.enums));
      type = EnumType(typeName,
          locationFile: _targetFileName, isNullable: isNullable);
    } else if (property.items case var items?) {
      if (items.$ref == null) {
        if (items.properties != null) {
          var itemType = _addSyntheticTypeIfNeeded(items, name, parent,
              anonymous: anonymous, isNullable: false)!;
          type = ListType(itemType, isNullable: isNullable);
        } else if (items.enums != null) {
          throw UnimplementedError('$parent $name');
        }
      }
    }
    return type;
  }

  Iterable<Dictionary> _convertDictionaries() sync* {
    while (_dictionariesToGenerate.isNotEmpty) {
      var t = _dictionariesToGenerate.removeAt(0);
      var properties = <Property>[];
      if (t.properties != null) {
        for (var e in t.properties!.entries) {
          var propertyType = _addSyntheticTypeIfNeeded(e.value, e.key, t.id,
                  anonymous: t.isAnonymous,
                  isNullable: e.value.optional ?? false) ??
              _propertyType(e.value);

          if (e.value.parameters != null) {
            //TODO(xha): support function parameter
          }

          var property = Property(
            e.key,
            type: propertyType,
            documentation: e.value.description,
          );
          properties.add(property);
        }
      }

      var methods = <Method>[];
      if (t.functions != null) {
        for (var f in t.functions!) {
          methods.add(_convertFunction(f));
        }
      }

      var events = <Event>[];
      if (t.events != null) {
        for (var event in t.events!) {
          events.add(_toEvent(event, parent: t.id));
        }
      }

      yield Dictionary(
        t.id,
        properties: properties,
        methods: methods,
        events: events,
        documentation: t.description,
        isAnonymous: t.isAnonymous,
        extend: t.extend,
      );
    }
  }

  Iterable<Enumeration> _convertEnums() sync* {
    for (var e in _enumsToConvert) {
      var values = <EnumerationValue>[];
      for (var v in e.enums!) {
        values.add(EnumerationValue(
          name: v.name,
          documentation: v.description,
        ));
      }
      yield Enumeration(
        e.id,
        documentation: e.description,
        values: values,
      );
    }
  }

  Iterable<Property> _convertProperties() sync* {
    for (var prop in model.properties.entries) {
      var type = _addSyntheticTypeIfNeeded(
              prop.value, prop.key, model.namespace,
              anonymous: false, isNullable: prop.value.optional ?? false) ??
          _propertyType(prop.value);

      yield Property(
        prop.key,
        type: type,
        documentation: prop.value.description,
      );
    }
  }

  Iterable<Typedef> _convertTypedefs() sync* {
    for (var type in model.types.where((t) =>
        t.type != 'object' && t.enums == null && t.choices == null ||
        t.isInstanceOf != null)) {
      ChromeType? target;

      if (type.type == 'array') {
        var items = type.items!;
        var typeRef = _addSyntheticTypeIfNeeded(items, 'Items', type.id,
                anonymous: false, isNullable: false) ??
            _propertyType(items);
        target = ListType(typeRef, isNullable: false);
      } else {
        String typeName;
        if (type.isInstanceOf case var isInstanceOf?) {
          typeName = isInstanceOf;
        } else if (type.type case var type?) {
          typeName = type;
        } else {
          throw UnimplementedError(
              'Unknown type in ${model.namespace} ${type.id}');
        }
        target = context.createType(typeName,
            locationFile: _targetFileName, isNullable: false);
      }

      yield Typedef(type.id, target: target, documentation: type.description);
    }
  }

  ChromeType _propertyType(JsonProperty prop, {String? parentName}) {
    ChromeType type;
    var nullable = prop.optional ?? false;
    if (!nullable && prop.platforms != null) {
      nullable = true;
    }

    var arrayNullable = nullable;
    var isArray = false;
    if (prop.choices case var choices?) {
      type = ChoiceType([
        for (var choice in choices)
          _addSyntheticTypeIfNeeded(choice, prop.name ?? '', parentName ?? '',
                  anonymous: true, isNullable: false) ??
              _propertyType(choice)
      ], isNullable: nullable);
    } else if (prop.items case var items?) {
      isArray = true;
      type = _propertyType(items);
    } else if (prop.additionalProperties != null && prop.isInstanceOf == null) {
      type = MapType(isNullable: nullable);
    } else {
      type = context.createType(_extractType(prop),
          locationFile: _targetFileName, isNullable: nullable);
    }

    if (isArray) {
      return ListType(type, isNullable: arrayNullable);
    }
    return type;
  }

  String _extractType(JsonProperty prop) {
    assert(prop.items == null && prop.type != 'array');
    assert(prop.properties == null || prop.$ref != null,
        '${model.namespace} ${prop.properties}');

    var typeName = prop.isInstanceOf ?? prop.type ?? prop.$ref;
    if (typeName == null) {
      if (prop.value is int) {
        typeName = 'integer';
      }
    }
    return typeName!;
  }
}
