import 'package:code_builder/code_builder.dart' as code;
import 'chrome_model.dart';
import 'utils/string.dart';

class Context {
  final apis = <ChromeApi>[];
  final _lazyTypes = <LazyType>[];

  void resolveLazyTypes() {
    while (_lazyTypes.isNotEmpty) {
      var type = _lazyTypes.removeAt(0);
      type.resolve(apis);
    }
  }

  ChromeType createType(String input,
      {required String locationFile, required bool isNullable}) {
    var split = input.split('.');
    String? prefix;
    if (split.length > 1) {
      prefix = split.first;
    }
    var name = split.last;

    if (prefix == null) {
      var primitive = _PrimitiveType.tryParse(input, isNullable: isNullable);
      if (primitive != null) {
        return primitive;
      }
    }
    return LazyType(
        context: this,
        name: name,
        prefix: prefix,
        locationFile: locationFile,
        isNullable: isNullable);
  }
}

sealed class ChromeType {
  final bool isNullable;

  ChromeType({required this.isNullable});

  // TODO: split Dart & JS type
  code.Reference get dartType;

  code.Reference get jsType;

  // TODO: remove this hack
  code.Reference get jsTypeReferencedFromDart => jsType;

  code.Expression toJS(code.Expression accessor);

  code.Expression toDart(code.Expression accessor);

  String get questionMark => isNullable ? '?' : '';

  ChromeType copyWith({required bool isNullable});
}

class LazyType extends ChromeType {
  final Context context;
  final String name;
  final String? prefix;
  final String locationFile;
  ChromeType? _resolved;

  LazyType({
    required this.context,
    required this.name,
    required this.prefix,
    required this.locationFile,
    required bool isNullable,
  }) : super(isNullable: isNullable) {
    context._lazyTypes.add(this);
  }

  @override
  ChromeType copyWith({required bool isNullable}) {
    if (_resolved case var resolved?) {
      return resolved.copyWith(isNullable: isNullable);
    } else {
      return LazyType(
          context: context,
          name: name,
          prefix: prefix,
          locationFile: locationFile,
          isNullable: isNullable);
    }
  }

  String? get _prefixUrl => prefix != null ? '${prefix!.snakeCase}.dart' : null;

  void resolve(List<ChromeApi> apis) {
    _resolved = _resolve(apis);
  }

  ChromeType _resolve(List<ChromeApi> apis) {
    ChromeType? searchTypeInApi(String name, ChromeApi api) {
      for (var dict in api.dictionaries) {
        if (dict.name == name) {
          return DictionaryType(name,
              url: _prefixUrl,
              locationFile: locationFile,
              isNullable: isNullable);
        }
      }
      if (api.enumerations.any((e) => e.name == name)) {
        return EnumType(name,
            url: _prefixUrl,
            locationFile: locationFile,
            isNullable: isNullable);
      }
      for (var typedef in api.typedefs) {
        if (typedef.alias == name) {
          return AliasedType(name, typedef.target,
              url: _prefixUrl,
              locationFile: locationFile,
              isNullable: isNullable);
        }
      }
      return null;
    }

    ChromeType? tryParse(String input) {
      if (input == 'object') return MapType(isNullable: isNullable);
      return _WebType.tryParse(input, isNullable: isNullable) ??
          DynamicFunctionType.tryParse(input, isNullable: isNullable) ??
          _AnyType.tryParse(input, isNullable: isNullable) ??
          _VariousType.tryParse(input, isNullable: isNullable);
    }

    if (prefix != null) {
      for (var api in apis) {
        if (api.group == prefix && api.fileName != locationFile ||
            api.name == prefix) {
          var found = searchTypeInApi(name, api);
          if (found != null) return found;
        }
      }
      throw Exception('Type $name not found');
    } else {
      var thisApi = apis.singleWhere((e) => e.fileName == locationFile);
      var found = searchTypeInApi(name, thisApi) ?? tryParse(name);
      if (found != null) return found;

      throw Exception('Type $name not found');
    }
  }

  @override
  code.Reference get dartType => _resolved!.dartType;

  @override
  code.Reference get jsType => _resolved!.jsType;

  @override
  code.Reference get jsTypeReferencedFromDart =>
      _resolved!.jsTypeReferencedFromDart;

  @override
  code.Expression toDart(code.Expression accessor) =>
      _resolved!.toDart(accessor);

  @override
  code.Expression toJS(code.Expression accessor) => _resolved!.toJS(accessor);
}

sealed class _PrimitiveType extends ChromeType {
  _PrimitiveType({required super.isNullable});

  static ChromeType? tryParse(String input, {required bool isNullable}) {
    return switch (input) {
      'DOMString' || 'string' => _StringType(isNullable: isNullable),
      'integer' || 'long' => _IntegerType(isNullable: isNullable),
      'number' || 'double' => _DoubleType(isNullable: isNullable),
      'boolean' => _BooleanType(isNullable: isNullable),
      'ArrayBuffer' || 'binary' => _ArrayBufferType(isNullable: isNullable),
      _ => null,
    };
  }

  String get toDartMethod => 'toDart';

  String get dartTypeWithoutNullable;

  @override
  code.Reference get dartType => code.TypeReference((b) => b
    ..symbol = dartTypeWithoutNullable
    ..isNullable = isNullable);

  // Primitive types are converted automatically
  @override
  code.Reference get jsType => dartType;

  @override
  code.Expression toDart(code.Expression accessor) {
    return accessor;
  }

  @override
  code.Expression toJS(code.Expression accessor) {
    return accessor;
  }
}

class _StringType extends _PrimitiveType {
  _StringType({required super.isNullable});

  @override
  String get dartTypeWithoutNullable => 'String';

  @override
  ChromeType copyWith({required bool isNullable}) =>
      _StringType(isNullable: isNullable);
}

class _IntegerType extends _PrimitiveType {
  _IntegerType({required super.isNullable});

  @override
  String get toDartMethod => 'toDartInt';

  @override
  String get dartTypeWithoutNullable => 'int';

  @override
  ChromeType copyWith({required bool isNullable}) =>
      _IntegerType(isNullable: isNullable);
}

class _DoubleType extends _PrimitiveType {
  _DoubleType({required super.isNullable});

  @override
  String get toDartMethod => 'toDartDouble';

  @override
  String get dartTypeWithoutNullable => 'double';

  @override
  ChromeType copyWith({required bool isNullable}) =>
      _DoubleType(isNullable: isNullable);
}

class _BooleanType extends _PrimitiveType {
  _BooleanType({required super.isNullable});

  @override
  String get dartTypeWithoutNullable => 'bool';

  @override
  ChromeType copyWith({required bool isNullable}) =>
      _BooleanType(isNullable: isNullable);
}

class _ArrayBufferType extends ChromeType {
  _ArrayBufferType({required super.isNullable});

  @override
  code.Reference get dartType => code.TypeReference((b) => b
    ..symbol = 'ByteBuffer'
    ..url = 'dart:typed_data'
    ..isNullable = isNullable);

  @override
  code.Reference get jsType => code.TypeReference((b) => b
    ..symbol = 'JSArrayBuffer'
    ..isNullable = isNullable);

  @override
  code.Expression toDart(code.Expression accessor) =>
      accessor.nullSafePropertyIf('toDart', isNullable);

  @override
  code.Expression toJS(code.Expression accessor) =>
      accessor.nullSafePropertyIf('toJS', isNullable);

  @override
  ChromeType copyWith({required bool isNullable}) =>
      _ArrayBufferType(isNullable: isNullable);
}

class _WebType extends ChromeType {
  _WebType({required super.isNullable});

  static ChromeType? tryParse(String input, {required bool isNullable}) {
    if (const {
      'HTMLElement',
      "Window",
      'SubtleCrypto',
      'Blob',
      'ImageData',
      'LocalMediaStream',
      'DirectoryEntry',
      'global',
    }.contains(input)) {
      return _WebType(isNullable: isNullable);
    }
    return null;
  }

  //TODO: point to package:web at some point
  @override
  code.Reference get dartType => code.TypeReference((b) => b
    ..symbol = 'JSObject'
    ..isNullable = isNullable);

  @override
  code.Reference get jsType => dartType;

  @override
  code.Expression toDart(code.Expression accessor) => accessor;

  @override
  code.Expression toJS(code.Expression accessor) => accessor;

  @override
  ChromeType copyWith({required bool isNullable}) =>
      _WebType(isNullable: isNullable);
}

class _VariousType extends ChromeType {
  _VariousType({required super.isNullable});

  static ChromeType? tryParse(String input, {required bool isNullable}) {
    if (const {
      //TODO: convert the date
      'Date',

      // TODO: check if we can have something better than JSAny
      "InjectedFunction",
    }.contains(input)) {
      return _VariousType(isNullable: isNullable);
    }
    return null;
  }

  @override
  code.Reference get dartType => jsType;

  @override
  code.Reference get jsType => code.TypeReference((b) => b
    ..symbol = 'JSAny'
    ..isNullable = isNullable);

  @override
  code.Expression toDart(code.Expression accessor) => accessor;

  @override
  code.Expression toJS(code.Expression accessor) {
    return accessor;
  }

  @override
  ChromeType copyWith({required bool isNullable}) =>
      _VariousType(isNullable: isNullable);
}

class _AnyType extends ChromeType {
  _AnyType({required super.isNullable});

  static ChromeType? tryParse(String input, {required bool isNullable}) {
    if (const {
      'any',
    }.contains(input)) {
      return _AnyType(isNullable: isNullable);
    }
    return null;
  }

  @override
  code.Reference get dartType => code.TypeReference((b) => b
    ..symbol = 'Object'
    ..isNullable = isNullable);

  @override
  code.Reference get jsType => code.TypeReference((b) => b
    ..symbol = 'JSAny'
    ..isNullable = isNullable);

  @override
  code.Expression toDart(code.Expression accessor) {
    var expr = accessor.nullSafePropertyIf('dartify', isNullable).call([]);
    if (!isNullable) {
      expr = expr.nullChecked;
    }
    return expr;
  }

  @override
  code.Expression toJS(code.Expression accessor) {
    var expr = accessor.nullSafePropertyIf('jsify', isNullable).call([]);
    if (!isNullable) {
      expr = expr.nullChecked;
    }
    return expr;
  }

  @override
  ChromeType copyWith({required bool isNullable}) =>
      _AnyType(isNullable: isNullable);
}

class MapType extends ChromeType {
  MapType({required super.isNullable});

  @override
  code.Reference get dartType => code.TypeReference((b) => b
    ..symbol = 'Map'
    ..isNullable = isNullable);

  @override
  code.Reference get jsType => code.TypeReference((b) => b
    ..symbol = 'JSAny'
    ..isNullable = isNullable);

  @override
  code.Expression toDart(code.Expression accessor) =>
      accessor.nullSafePropertyIf('toDartMap', isNullable).call([]);

  @override
  code.Expression toJS(code.Expression accessor) {
    var expression = accessor.nullSafePropertyIf('jsify', isNullable).call([]);
    if (!isNullable) {
      expression = expression.nullChecked;
    }
    return expression;
  }

  @override
  ChromeType copyWith({required bool isNullable}) =>
      MapType(isNullable: isNullable);
}

abstract class _LocalType extends ChromeType {
  final String name;
  final String? url;
  final String locationFile;

  _LocalType(this.name,
      {this.url, required this.locationFile, required super.isNullable});

  @override
  code.Reference get dartType => code.TypeReference((b) => b
    ..symbol = name
    ..isNullable = isNullable
    ..url = url);

  @override
  code.Reference get jsType => code.TypeReference((b) => b
    ..symbol = name
    ..isNullable = isNullable
    ..url = url);

  @override
  code.Reference get jsTypeReferencedFromDart {
    return code.TypeReference((b) => b
      ..symbol = name
      ..isNullable = isNullable
      ..url = 'src/js/${url ?? locationFile}');
  }

  @override
  code.Expression toDart(code.Expression accessor) {
    if (isNullable) {
      return accessor
          .nullSafeProperty('let')
          .call([code.refer(name).property('fromJS')]);
    } else {
      return code.refer(name).property('fromJS').call([accessor]);
    }
  }

  @override
  code.Expression toJS(code.Expression accessor) {
    return accessor.nullSafePropertyIf('toJS', isNullable);
  }
}

class DictionaryType extends _LocalType {
  DictionaryType(super.name,
      {super.url, required super.locationFile, required super.isNullable});

  @override
  ChromeType copyWith({required bool isNullable}) => DictionaryType(name,
      url: url, locationFile: locationFile, isNullable: isNullable);
}

class EnumType extends _LocalType {
  EnumType(super.name,
      {super.url, required super.locationFile, required super.isNullable});

  @override
  ChromeType copyWith({required bool isNullable}) => EnumType(name,
      url: url, locationFile: locationFile, isNullable: isNullable);
}

class ListType extends ChromeType {
  final ChromeType item;

  ListType(this.item, {required super.isNullable});

  @override
  ChromeType copyWith({required bool isNullable}) =>
      ListType(item, isNullable: isNullable);

  @override
  code.Reference get jsType => code.TypeReference((b) => b
    ..symbol = 'JSArray'
    ..isNullable = isNullable);

  @override
  code.Reference get dartType {
    return code.TypeReference((b) => b
      ..symbol = 'List'
      ..isNullable = isNullable
      ..types.add(item.dartType));
  }

  @override
  code.Expression toDart(code.Expression accessor) {
    return accessor
        .nullSafePropertyIf('toDart', isNullable)
        .property('cast')
        .call([], {}, [item.jsTypeReferencedFromDart])
        .property('map')
        .call([
          code.Method((b) => b
            ..requiredParameters.add(code.Parameter((b) => b..name = 'e'))
            ..lambda = true
            ..body = item.toDart(code.refer('e')).code).closure
        ])
        .property('toList')
        .call([]);

    // TODO:
    // remove map((e) => e)
    // try to tear-off result (when end with (e))
  }

  @override
  code.Expression toJS(code.Expression accessor) {
    return accessor.nullSafePropertyIf('toJSArray', isNullable).call([
      code.Method((b) => b
        ..requiredParameters.add(code.Parameter((b) => b..name = 'e'))
        ..lambda = true
        ..body = item.toJS(code.refer('e')).code).closure
    ]);
  }
}

class AliasedType extends ChromeType {
  final String alias;
  final ChromeType original;
  final String locationFile;
  final String? url;

  AliasedType(this.alias, ChromeType original,
      {this.url, required this.locationFile, required bool isNullable})
      : original = original.copyWith(isNullable: isNullable),
        super(isNullable: isNullable);

  @override
  ChromeType copyWith({required bool isNullable}) =>
      AliasedType(alias, original,
          url: url, locationFile: locationFile, isNullable: isNullable);

  @override
  code.Reference get jsType {
    var originalType = original.jsType;
    if (originalType is code.TypeReference) {
      return originalType.rebuild((b) => b.symbol = alias);
    }
    return originalType;
  }

  @override
  code.Reference get jsTypeReferencedFromDart {
    var originalType = original.jsTypeReferencedFromDart;
    if (originalType is code.TypeReference) {
      return originalType.rebuild((b) => b
        ..symbol = alias
        ..url = 'src/js/${url ?? locationFile}');
    }
    return originalType;
  }

  @override
  code.Reference get dartType => original.dartType;

  @override
  code.Expression toDart(code.Expression accessor) => original.toDart(accessor);

  @override
  code.Expression toJS(code.Expression accessor) => original.toJS(accessor);
}

class DynamicFunctionType extends ChromeType {
  DynamicFunctionType({required super.isNullable});

  static ChromeType? tryParse(String input, {required bool isNullable}) {
    if (const {
      'function',
    }.contains(input)) {
      return DynamicFunctionType(isNullable: isNullable);
    }
    return null;
  }

  static final _parameterCount = 2;
  final _allParameters =
      List.generate(_parameterCount, (i) => 'Object? p${i + 1}').join(', ');

  @override
  code.Reference get dartType => code.TypeReference((b) => b
    ..symbol = 'Function'
    ..isNullable = isNullable);

  @override
  code.Reference get jsType => code.TypeReference((b) => b
    ..symbol = 'Function'
    ..isNullable = isNullable);

  @override
  code.Expression toDart(code.Expression accessor) {
    return code.CodeExpression(code.Code.scope((allocate) {
      var emit = _createEmit(allocate);

      var jsParameters =
          List.generate(_parameterCount, (_) => 'JSAny?').join(',');
      var castedAccessor =
          '${emit(accessor)} as JSAny? Function($jsParameters)$questionMark';
      var forwardedParameters =
          List.generate(_parameterCount, (i) => 'p${i + 1}?.jsify()')
              .join(', ');
      return '''
([$_allParameters]) {
  return ($castedAccessor)${isNullable ? '?.call' : ''}($forwardedParameters)?.dartify();
}   
''';
    }));
  }

  @override
  code.Expression toJS(code.Expression accessor) {
    var allowInterop = code.refer('allowInterop', 'dart:js_util');
    if (!isNullable) {
      return allowInterop.call([accessor]);
    } else {
      return accessor.nullSafeProperty('let').call([allowInterop]);
    }
  }

  @override
  ChromeType copyWith({required bool isNullable}) =>
      DynamicFunctionType(isNullable: isNullable);
}

class FunctionType extends ChromeType {
  final ChromeType? returns;
  final List<FunctionParameter> positionalParameters;

  FunctionType(this.returns, this.positionalParameters,
      {required super.isNullable});

  @override
  ChromeType copyWith({required bool isNullable}) =>
      FunctionType(returns, positionalParameters, isNullable: isNullable);

  @override
  code.Reference get jsType => code.TypeReference((b) => b
    ..symbol = 'JSFunction'
    ..isNullable = isNullable);

  @override
  code.Reference get dartType {
    return code.FunctionType((b) => b
      ..returnType = returns?.dartType ?? code.refer('void')
      ..requiredParameters
          .addAll(positionalParameters.map((p) => p.type.dartType))
      ..isNullable = isNullable);
  }

  @override
  code.Expression toDart(code.Expression accessor) {
    return code.CodeExpression(code.Code.scope((allocate) {
      var emit = _createEmit(allocate);

      var buffer = StringBuffer();
      var dartParameters = <String>[
        for (var param in positionalParameters)
          '${emit(param.type.dartType)} ${param.dartName}',
      ];
      var forwardParameter = <String>[
        for (var param in positionalParameters)
          emit(param.type.toJS(code.refer(param.dartName))),
      ];

      var returnKeyword = returns != null ? 'return' : '';
      buffer.writeln('(${dartParameters.join(',')}) {');
      //TODO: find a proper way
      buffer.writeln('  //ignore: avoid_dynamic_calls');
      buffer.writeln(
          '$returnKeyword (${emit(accessor)} as Function)(${forwardParameter.join(',')});');
      buffer.writeln('}');

      return '$buffer';
    }));
  }

  @override
  code.Expression toJS(code.Expression accessor) {
    return code.CodeExpression(code.Code.scope((allocate) {
      var emit = _createEmit(allocate);

      var buffer = StringBuffer();
      var parameters = <String>[
        for (var param in positionalParameters)
          '${emit(param.type.jsTypeReferencedFromDart)} ${param.rawName}',
      ];
      var forwardParameter = <String>[
        for (var param in positionalParameters)
          emit(param.type.toDart(code.refer(param.rawName))),
      ];

      var returnKeyword = returns != null ? 'return' : '';
      buffer.writeln('(${parameters.join(',')}) {');
      buffer.writeln(
          '$returnKeyword ${emit(accessor)}(${forwardParameter.join(',')});');
      buffer.writeln('}');

      return '$buffer';
    }));
  }
}

class FunctionParameter {
  final String rawName;
  final ChromeType type;

  FunctionParameter(this.rawName, this.type);

  String get dartName => rawName.lowerCamel;
}

class AsyncReturnType extends ChromeType {
  final ChromeType? dart;
  final FunctionType jsCallback;
  bool supportsPromises = false;

  AsyncReturnType(this.dart, this.jsCallback)
      : super(isNullable: dart?.isNullable ?? false);

  @override
  ChromeType copyWith({required bool isNullable}) =>
      AsyncReturnType(dart, jsCallback);

  @override
  code.Reference get jsType => jsCallback.jsType;

  @override
  code.Reference get dartType => dart?.dartType ?? code.refer('void');

  @override
  code.Expression toDart(code.Expression accessor) =>
      jsCallback.toDart(accessor);

  @override
  code.Expression toJS(code.Expression accessor) =>
      dart?.toJS(accessor) ?? accessor;
}

class ChoiceType extends ChromeType {
  final List<ChromeType> choices;

  ChoiceType(this.choices, {required super.isNullable});

  @override
  code.Reference get dartType => code.TypeReference((b) => b
    ..symbol = 'Object'
    ..isNullable = isNullable);

  @override
  code.Reference get jsType {
    return code.TypeReference((b) => b
      ..symbol = 'Object'
      ..isNullable = isNullable);
  }

  @override
  code.Expression toDart(code.Expression accessor) {
    return code.CodeExpression(code.Code.scope((allocate) {
      var emit = _createEmit(allocate);

      var arguments = StringBuffer();
      for (var choice in choices) {
        var jsTypeName = emit(choice.jsType);
        if (jsTypeName.endsWith('?')) {
          jsTypeName = jsTypeName.substring(0, jsTypeName.length - 2);
        }
        var whenMethod = const {
          'int': 'isInt',
          'String': 'isString',
          'JSArray': 'isArray',
          'ImageData': 'isImageData',
          'JSAny': 'isMap',
        }[jsTypeName];
        code.Expression itemAccessor = code.refer('v');
        if (whenMethod == null) {
          whenMethod ??= 'isOther';
          itemAccessor = itemAccessor.asA(choice.jsTypeReferencedFromDart);
        }
        var conversionCode = emit(choice.toDart(itemAccessor));
        arguments.writeln('$whenMethod: (v) => $conversionCode,');
      }

      return '${emit(accessor)}$questionMark.when($arguments)';
    }));
  }

  @override
  code.Expression toJS(code.Expression accessor) {
    return code.CodeExpression(code.Code.scope((allocate) {
      var emit = _createEmit(allocate);

      var buffer = StringBuffer();
      buffer.writeln('''switch (${emit(accessor)}) {''');
      for (var choice in choices) {
        var type = emit(choice.dartType);
        if (type == 'List<String>') {
          buffer.writeln('List() => ${emit(accessor)}.toJSArrayString(),');
        } else {
          buffer.writeln('$type() => ${emit(choice.toJS(accessor))},');
        }
      }
      if (isNullable) {
        buffer.writeln('null => null,');
      }
      var supportedTypes = choices.map((c) => emit(c.dartType)).join(', ');
      buffer.writeln(
          "_ => throw UnsupportedError('Received type: \${${emit(accessor)}.runtimeType}. Supported types are: $supportedTypes')");
      buffer.writeln('}');

      return '$buffer';
    }));
  }

  @override
  ChromeType copyWith({required bool isNullable}) =>
      ChoiceType(choices, isNullable: isNullable);
}

extension on code.Expression {
  code.Expression nullSafePropertyIf(String name, bool isNullable) {
    if (isNullable) {
      return nullSafeProperty(name);
    } else {
      return property(name);
    }
  }
}

class _DelegatedAllocator implements code.Allocator {
  final String Function(code.Reference) delegate;

  _DelegatedAllocator(this.delegate);

  @override
  String allocate(code.Reference reference) => delegate(reference);

  @override
  Iterable<code.Directive> get imports => [];
}

String Function(code.Spec) _createEmit(
    String Function(code.Reference) allocate) {
  var emitter = code.DartEmitter(
      allocator: _DelegatedAllocator(allocate), useNullSafetySyntax: true);
  return (code.Spec expression) => expression.accept(emitter).toString();
}
