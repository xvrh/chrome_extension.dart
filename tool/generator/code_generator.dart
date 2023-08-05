import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;
import 'chrome_model.dart' as model;
import 'chrome_type.dart';
import 'comment.dart';
import 'utils/string.dart';

const _dartInteropUrl = 'dart:js_interop';
const _sharedBinding = 'chrome.dart';
const _internalHelpers = 'src/internal_helpers.dart';
const _jsPrefix = r'$js';

final _formatter = DartFormatter();

class _GeneratorBase {
  final model.ChromeApi api;

  _GeneratorBase(this.api);
}

class JsBindingGenerator extends _GeneratorBase {
  JsBindingGenerator(super.api);

  String get bindingClassName => 'JS${api.classNameWithGroup}';

  String toCode() {
    final library = Library((b) => b
      ..name = ''
      ..comments.add('ignore_for_file: non_constant_identifier_names')
      ..comments.add('ignore_for_file: unnecessary_import')
      ..directives.addAll([
        Directive.export('chrome.dart'),
        if (api.group case var group?)
          Directive.export('${group.snakeCase}.dart')
      ])
      ..body.addAll([
        Extension((b) => b
          ..name = 'JSChrome${bindingClassName}Extension'
          ..on = _extensionOn
          ..methods.addAll([
            Method((b) => b
              ..external = true
              ..returns = refer('$bindingClassName?')
              ..name = '${api.nameWithoutGroup.lowerCamel}Nullable'
              ..annotations.add(_jsAnnotation(api.nameWithoutGroup.lowerCamel))
              ..type = MethodType.getter),
            Method((b) => b
              ..docs.add(documentationComment(api.documentation, indent: 2))
              ..returns = refer(bindingClassName, _sharedBinding)
              ..name = api.nameWithoutGroup.lowerCamel
              ..type = MethodType.getter
              ..body = Code('''
var ${api.nameWithoutGroup.lowerCamel}Nullable = this.${api.nameWithoutGroup.lowerCamel}Nullable;
if (${api.nameWithoutGroup.lowerCamel}Nullable == null) {
  throw ApiNotAvailableException(
      'chrome${api.group != null ? '.${api.group}' : ''}.${api.nameWithoutGroup.lowerCamel}');
}
return ${api.nameWithoutGroup.lowerCamel}Nullable;            
'''))
          ])),
        Class((b) => b
          ..annotations.addAll([_jsAnnotation(), _staticInteropAnnotation()])
          ..name = bindingClassName),
        Extension((b) => b
          ..name = '${bindingClassName}Extension'
          ..on = refer(bindingClassName)
          ..methods.addAll(api.functions.map(_function))
          ..methods.addAll(api.events.map(_event))
          ..methods.addAll(api.properties.map(_property))),
        for (var type in api.enumerations)
          TypeDef((b) => b
            ..name = type.name
            ..docs.add(documentationComment(type.documentation, indent: 0))
            ..definition = refer('String')),
        for (var type in api.typedefs)
          TypeDef((b) => b
            ..name = type.alias
            ..docs.add(documentationComment(type.documentation, indent: 0))
            ..definition = type.target.jsType),
        for (var type in api.dictionaries.where((d) => !d.isSyntheticEvent))
          ..._dictionary(type),
      ]));

    return _emitCode(library);
  }

  Reference get _extensionOn {
    var extensionOn = 'JSChrome';
    var extensionOnImport = 'chrome';
    var group = api.group;
    if (group != null) {
      extensionOn = '$extensionOn${group.upperCamel}';
      extensionOnImport = group.snakeCase;
    }
    return refer(extensionOn, '$extensionOnImport.dart');
  }

  Method _function(model.Method method) {
    var parameters = method.parameters
        .map((p) => Parameter((b) => b
          ..name = p.rawName
          ..type = p.type.jsType
          ..docs.add(documentationComment(p.documentation, indent: 4))))
        .toList();

    Reference returns;
    if (method.returns.type case model.AsyncReturnType asyncType) {
      if (asyncType.supportsPromises) {
        returns = refer('JSPromise');
      } else {
        returns = refer('void');
        parameters.add(Parameter((b) => b
          ..docs.addAll([
            if (method.returns.documentation case var returnDoc?)
              documentationComment(returnDoc, indent: 4)
          ])
          ..name = method.returns.name ?? 'callback'
          ..type = asyncType.jsType));
      }
    } else {
      returns = method.returns.type?.jsType ?? refer('void');
    }

    return Method((b) => b
      ..docs.add(documentationComment(method.documentation, indent: 2))
      ..annotations.addAll(_deprecatedAnnotation(method.deprecated))
      ..name = method.name
      ..external = true
      ..returns = returns
      ..requiredParameters.addAll(parameters));
  }

  Method _event(model.Event event) {
    return Method((b) => b
      ..name = event.name
      ..docs.add(documentationComment(event.documentation, indent: 2))
      ..external = true
      ..returns = refer('Event', _sharedBinding)
      ..type = MethodType.getter);
  }

  Method _property(model.Property prop) {
    return Method((b) => b
      ..name = prop.rawName
      ..returns = prop.type.jsType
      ..docs.add(documentationComment(prop.documentation, indent: 2))
      ..external = true
      ..type = MethodType.getter);
  }

  Iterable<Spec> _dictionary(model.Dictionary type) sync* {
    yield Class((b) {
      b
        ..annotations.addAll([
          _jsAnnotation(),
          _staticInteropAnnotation(),
          _anonymousAnnotation()
        ])
        ..name = type.name
        ..constructors.add(Constructor((b) => b
          ..external = true
          ..factory = true
          ..optionalParameters
              .addAll(type.properties.map(_typePropertyAsParameter))));

      if (type.extend case var extend?) {
        b.extend = refer(extend);
      }
    });
    yield Extension((b) => b
      ..name = '${type.name}Extension'
      ..on = refer(type.name)
      ..fields.addAll(type.properties.map(_typeProperty))
      ..methods.addAll(type.methods.map(_function))
      ..methods.addAll(type.events.map(_event)));
  }

  Field _typeProperty(model.Property property) {
    return Field((b) => b
      ..docs.add(documentationComment(property.documentation, indent: 2))
      ..name = property.rawName
      ..external = true
      ..type = property.type.jsType);
  }

  Parameter _typePropertyAsParameter(model.Property property) {
    return Parameter((b) => b
      ..docs.add(documentationComment(property.documentation, indent: 2))
      ..name = property.rawName
      ..named = true
      ..type = property.type.jsType);
  }
}

class DartApiGenerator extends _GeneratorBase {
  DartApiGenerator(super.api);

  String get mainClassName => 'Chrome${api.classNameWithGroup}';

  String get _jsFile => 'src/js/${api.fileName}';

  String toCode() {
    final library = Library((b) => b
      ..name = ''
      ..comments.add('ignore_for_file: unnecessary_parenthesis')
      ..directives.addAll([
        Directive.export('src/chrome.dart', show: ['chrome']),
        Directive.import(_internalHelpers),
        if (api.group case var group?)
          Directive.export('${group.snakeCase}.dart', show: [
            'Chrome${group.upperCamel}',
            'Chrome${group.upperCamel}Extension',
          ])
      ])
      ..body.addAll([
        Field((b) => b
          ..name = '_${api.name.lowerCamel}'
          ..modifier = FieldModifier.final$
          ..assignment = refer(mainClassName).property('_').call([]).code),
        Extension((b) => b
          ..name = '${mainClassName}Extension'
          ..on = _extensionOn
          ..methods.add(Method((b) => b
            ..docs.add(documentationComment(api.documentation, indent: 2))
            ..returns = refer(mainClassName)
            ..name = api.nameWithoutGroup.lowerCamel
            ..lambda = true
            ..body = Code('_${api.name.lowerCamel}')
            ..type = MethodType.getter))),
        Class((b) => b
          ..name = mainClassName
          ..constructors.add(Constructor((c) => c.name = '_'))
          ..methods.add(_isAvailableGetter())
          ..methods.addAll(
              api.functions.map((f) => _function(f, source: _referJsBinding())))
          ..methods.addAll(api.properties.map(_property))
          ..methods.addAll(
              api.events.map((e) => _event(e, source: _referJsBinding())))),
        for (var enumeration in api.enumerations) _enum(enumeration),
        for (var type in api.typedefs)
          TypeDef((b) => b
            ..name = type.alias
            ..docs.add(documentationComment(type.documentation, indent: 0))
            ..definition = type.target.dartType),
        for (var type in api.dictionaries) ..._dictionary(type),
      ]));

    return _emitCode(library, allocator: _PrefixedAllocator(api.fileName));
  }

  Method _isAvailableGetter() {
    Expression referTo = refer('chrome', _jsFile);

    var property = '${api.nameWithoutGroup.lowerCamel}Nullable';
    if (api.group case var group?) {
      referTo = referTo.property('${group}Nullable');
      referTo = referTo.nullSafeProperty(property);
    } else {
      referTo = referTo.property(property);
    }
    return Method((b) => b
      ..name = 'isAvailable'
      ..type = MethodType.getter
      ..lambda = true
      ..returns = refer('bool')
      ..body = referTo.notEqualTo(refer('null')).and(refer('alwaysTrue')).code);
  }

  Reference get _extensionOn {
    var extensionOn = 'Chrome';
    String? extensionOnImport;
    var group = api.group;
    if (group != null) {
      extensionOn = '$extensionOn${group.upperCamel}';
      extensionOnImport = '${group.snakeCase}.dart';
    }
    return refer(extensionOn, extensionOnImport);
  }

  Expression _referJsBinding() {
    Expression referTo = refer('chrome', _jsFile);
    if (api.group case var group?) {
      referTo = referTo.property(group);
    }
    return referTo.property(api.nameWithoutGroup.lowerCamel);
  }

  Method _function(model.Method method, {required Expression source}) {
    Reference returns;
    Code body;
    MethodModifier? methodModifier;

    var referTo = source.property(method.name);
    var callParameters = <Expression>[
      for (var p in method.parameters) p.type.toJS(refer(p.rawName))
    ];

    if (method.returns.type case model.AsyncReturnType asyncReturn) {
      var futureType = method.returns.type?.dartType ?? refer('void');
      returns = TypeReference((b) => b
        ..symbol = 'Future'
        ..types.add(futureType));

      if (asyncReturn.supportsPromises) {
        methodModifier = MethodModifier.async;
        body = _asyncReturnCodeWithPromise(asyncReturn,
            referTo: referTo,
            callParameters: callParameters,
            futureType: futureType);
      } else {
        body = _asyncReturnCodeWithCallback(asyncReturn,
            referTo: referTo,
            callParameters: callParameters,
            futureType: futureType);
      }
    } else {
      var callExpression = referTo.call(callParameters);
      if (method.returns.type case var returnType?) {
        callExpression = returnType.toDart(callExpression).returned;
      }

      body = Block.of([
        callExpression.statement,
      ]);
      returns = method.returns.type?.dartType ?? refer('void');
    }

    // Rules
    // - If >= 2 parameters, optional parameters are named
    // - If parameter with 1 complex dictionary (and potentially other primitives)
    //     inline the parameters

    var requiredParameters = method.parameters.map((p) => Parameter((b) => b
      ..name = p.dartName
      ..type = p.type.dartType));

    var optionalParameters = <Parameter>[];

    return Method((b) => b
      ..docs.add(documentationComment(method.documentation, indent: 2))
      ..docs.addAll([
        for (var param in method.parameters)
          if (param.documentation.isNotEmpty)
            parameterDocumentation(param.rawName, param.documentation,
                indent: 4),
        if (method.returns.documentation case var doc?)
          if (doc.isNotEmpty) parameterDocumentation('returns', doc, indent: 4)
      ])
      ..annotations.addAll(_deprecatedAnnotation(method.deprecated))
      ..name = method.name
      ..returns = returns
      ..modifier = methodModifier
      ..body = body
      ..requiredParameters.addAll(requiredParameters)
      ..optionalParameters.addAll(optionalParameters));
  }

  Expression _asyncCompletionParameter(AsyncReturnType asyncReturn) {
    Expression completeParameter = refer('null');
    if (asyncReturn.jsCallback.positionalParameters case [var singleParam]) {
      completeParameter = singleParam.type.toDart(refer(singleParam.rawName));
    } else if (asyncReturn.jsCallback.positionalParameters.length > 1) {
      completeParameter = asyncReturn.dartType.call([], {
        for (var jsParam in asyncReturn.jsCallback.positionalParameters)
          jsParam.dartName: jsParam.type.toDart(refer(jsParam.rawName))
      });
    }
    return completeParameter;
  }

  Block _asyncReturnCodeWithCallback(AsyncReturnType asyncReturn,
      {required Reference futureType,
      required Expression referTo,
      required List<Expression> callParameters}) {
    var completeParameter = _asyncCompletionParameter(asyncReturn);

    var completerVar = r'$completer';

    final emitter = DartEmitter(
        allocator: _PrefixedAllocator(api.fileName), useNullSafetySyntax: true);
    var completeCompleterCode = refer(completerVar)
        .property('complete')
        .call([completeParameter]).accept(emitter);

    var body = Block.of([
      declareVar(completerVar)
          .assign(refer('Completer').call([], {}, [futureType]))
          .statement,
      referTo.call([
        ...callParameters,
        Method((b) => b
          ..lambda = false
          ..requiredParameters.addAll([
            for (var jsParam in asyncReturn.jsCallback.positionalParameters)
              Parameter((b) => b
                ..name = jsParam.rawName
                ..type = jsParam.type.jsTypeReferencedFromDart)
          ])
          ..body = Code('''if (checkRuntimeLastError($completerVar)) {
              $completeCompleterCode;
            }''')).closure.property('toJS')
      ]).statement,
      refer(completerVar).property('future').returned.statement,
    ]);
    return body;
  }

  Code _asyncReturnCodeWithPromise(AsyncReturnType asyncReturn,
      {required Reference futureType,
      required Expression referTo,
      required List<Expression> callParameters}) {
    ChromeType? jsReturnType;
    if (asyncReturn.jsCallback.positionalParameters case [var singleParam]) {
      jsReturnType = singleParam.type;
    } else if (asyncReturn.jsCallback.positionalParameters.length > 1) {
      throw UnimplementedError('Multi result in JSPromise is not implemented');
    }

    var resultVariable = r'$res';
    var callJsExpression = refer('promiseToFuture', 'dart:js_util').call([
      referTo.call(callParameters)
    ], {}, [
      asyncReturn.jsCallback.positionalParameters.firstOrNull?.type
              .jsTypeReferencedFromDart ??
          refer('void')
    ]).awaited;

    if (jsReturnType != null) {
      return Block.of([
        declareVar(resultVariable).assign(callJsExpression).statement,
        jsReturnType.toDart(refer(resultVariable)).returned.statement,
      ]);
    } else {
      return callJsExpression.statement;
    }
  }

  Method _event(model.Event event, {required Expression source}) {
    var completeParameter = _asyncCompletionParameter(event.type);

    return Method((b) => b
      ..name = event.name
      ..docs.add(documentationComment(event.documentation, indent: 2))
      ..returns = TypeReference((b) => b
        ..symbol = 'EventStream'
        ..types.add(event.type.dartType))
      ..body = source.property(event.name).property('asStream').call([
        Method((b) => b
          ..lambda = true
          ..requiredParameters.add(Parameter((b) => b..name = r'$c'))
          ..body = Method((b) => b
            ..requiredParameters.addAll([
              for (var jsParam in event.type.jsCallback.positionalParameters)
                Parameter((b) => b
                  ..name = jsParam.rawName
                  ..type = jsParam.type.jsTypeReferencedFromDart)
            ])
            ..body = Block.of([
              refer(r'$c').call([completeParameter]).returned.statement
            ])).closure.code).closure
      ]).code
      ..lambda = true
      ..type = MethodType.getter);
  }

  Method _property(model.Property prop) {
    var referTo = _referJsBinding().property(prop.rawName);

    return Method((b) => b
      ..name = prop.dartName
      ..returns = prop.type.dartType
      ..docs.add(documentationComment(prop.documentation, indent: 2))
      ..type = MethodType.getter
      ..body = prop.type.toDart(referTo).code
      ..lambda = true);
  }

  Enum _enum(model.Enumeration enumeration) {
    return Enum((b) => b
      ..name = enumeration.name
      ..docs.add(documentationComment(enumeration.documentation, indent: 0))
      ..fields.add(Field((b) => b
        ..name = 'value'
        ..type = refer('String')
        ..modifier = FieldModifier.final$))
      ..constructors.add(Constructor((b) => b
        ..constant = true
        ..requiredParameters.add(Parameter((b) => b
          ..name = 'value'
          ..toThis = true))))
      ..values.addAll(enumeration.values.map((v) => EnumValue((b) => b
        ..name = _toEnumValue(v.name)
        ..arguments.add(literal(v.name))
        ..docs.addAll([
          if (v.documentation.isNotEmpty)
            documentationComment(v.documentation, indent: 2)
        ]))))
      ..methods.add(Method((b) => b
        ..name = 'toJS'
        ..type = MethodType.getter
        ..lambda = true
        ..returns = refer('String')
        ..body = Code('value')))
      ..methods.add(Method((b) => b
        ..name = 'fromJS'
        ..static = true
        ..returns = refer(enumeration.name)
        ..lambda = true
        ..requiredParameters.add(Parameter((b) => b
          ..name = 'value'
          ..type = refer('String')))
        ..body = Code('values.firstWhere((e) => e.value == value)'))));
  }

  Iterable<Spec> _dictionary(model.Dictionary dictionary) sync* {
    var type = model.DictionaryType(dictionary.name,
        locationFile: api.fileName, isNullable: false);

    const wrappedVariable = '_wrapped';

    yield Class((b) {
      b.name = dictionary.name;

      var extend = dictionary.extend;
      if (extend != null) {
        b.extend = refer(extend);
      }

      if (!dictionary.isSyntheticEvent) {
        Expression constructorSetter;
        constructorSetter = type.jsTypeReferencedFromDart.call([], {
          for (var property in dictionary.properties)
            property.rawName: property.type.toJS(refer(property.dartName)),
        });

        if (extend != null) {
          b.constructors.add(Constructor((b) => b
            ..name = 'fromJS'
            ..requiredParameters.add(Parameter((b) => b
              ..name = 'wrapped'
              ..type = refer(dictionary.name, _jsFile)))
            ..initializers.add(Code('super.fromJS(wrapped)'))));
        } else {
          b
            ..fields.add(Field((b) => b
              ..name = wrappedVariable
              ..modifier = FieldModifier.final$
              ..type = refer(dictionary.name, _jsFile)))
            ..constructors.add(Constructor((b) => b
              ..name = 'fromJS'
              ..requiredParameters.add(Parameter((b) => b
                ..name = wrappedVariable
                ..toThis = true))));
        }

        if (extend != null) {
          b.methods.add(Method((b) => b
            ..name = wrappedVariable
            ..type = MethodType.getter
            ..returns = refer(dictionary.name, _jsFile)
            ..body =
                Code('super.$wrappedVariable as $_jsPrefix.${dictionary.name}')
            ..lambda = true
            ..annotations.add(refer('override'))));
        } else {
          b.constructors.add(Constructor((b) => b
            ..optionalParameters
                .addAll(dictionary.properties.map((p) => Parameter((b) => b
                  ..docs.add(documentationComment(p.documentation, indent: 4))
                  ..name = p.dartName
                  ..type = p.type.dartType
                  ..named = true
                  ..required = !p.type.isNullable)))
            ..initializers
                .add(refer(wrappedVariable).assign(constructorSetter).code)));
          b.methods.add(Method((b) => b
            ..name = 'toJS'
            ..type = MethodType.getter
            ..returns = refer(dictionary.name, _jsFile)
            ..lambda = true
            ..body = Code(wrappedVariable)));
        }
      } else {
        b
          ..constructors.add(Constructor((b) => b
            ..optionalParameters
                .addAll(dictionary.properties.map((p) => Parameter((b) => b
                  ..name = p.dartName
                  ..named = true
                  ..required = true
                  ..toThis = true)))))
          ..fields.addAll(dictionary.properties.map(_syntheticProperty));
      }

      if (!dictionary.isSyntheticEvent) {
        b
          ..methods.addAll(
              dictionary.properties.map(_wrappingProperty).expand((e) => e))
          ..methods.addAll(dictionary.methods
              .map((f) => _function(f, source: refer(wrappedVariable))))
          ..methods.addAll(dictionary.events
              .map((e) => _event(e, source: refer(wrappedVariable))));
      }
    });
  }

  Iterable<Method> _wrappingProperty(model.Property property) sync* {
    yield Method((b) => b
      ..docs.add(documentationComment(property.documentation, indent: 2))
      ..name = property.dartName
      ..returns = property.type.dartType
      ..type = MethodType.getter
      ..lambda = true
      ..body = property.type
          .toDart(refer('_wrapped').property(property.rawName))
          .code);

    yield Method((b) => b
      ..name = property.dartName
      ..type = MethodType.setter
      ..requiredParameters.add(Parameter((b) => b
        ..name = 'v'
        ..type = property.type.dartType))
      ..body = refer('_wrapped')
          .property(property.rawName)
          .assign(property.type.toJS(refer('v')))
          .statement);
  }

  Field _syntheticProperty(model.Property property) {
    return Field((b) => b
      ..docs.add(documentationComment(property.documentation, indent: 2))
      ..name = property.dartName
      ..type = property.type.dartType
      ..modifier = FieldModifier.final$);
  }
}

class _PrefixedAllocator implements Allocator {
  final _imports = <String, String?>{};
  final String thisFile;

  _PrefixedAllocator(this.thisFile);

  @override
  String allocate(Reference reference) {
    final symbol = reference.symbol;
    final url = reference.url;

    if (url != null && url.startsWith('src/js')) {
      var baseName = p.basename(url);
      String prefix;
      if (baseName == thisFile) {
        prefix = _jsPrefix;
      } else {
        prefix = '${_jsPrefix}_${p.basenameWithoutExtension(url)}';
      }

      _imports[url] = prefix;
      return '$prefix.$symbol';
    } else if (url != null) {
      _imports[url] = null;
    }
    return symbol!;
  }

  @override
  Iterable<Directive> get imports => _imports.keys.map(
        (u) => Directive.import(u, as: _imports[u]),
      );
}

String generateJSGroupCode(String group) {
  var groupClass = 'JSChrome${group.upperCamel}';
  final library = Library((b) => b
    ..body.addAll([
      Extension((b) => b
        ..name = '${groupClass}Extension'
        ..on = refer('JSChrome', 'chrome.dart')
        ..methods.addAll([
          Method((b) => b
            ..external = true
            ..returns = refer('JSChrome${group.upperCamel}?')
            ..name = '${group}Nullable'
            ..annotations.add(_jsAnnotation(group))
            ..type = MethodType.getter),
          Method((b) => b
            ..returns = refer('JSChrome${group.upperCamel}')
            ..name = group
            ..type = MethodType.getter
            ..body = Code('''
var ${group}Nullable = this.${group}Nullable;
if (${group}Nullable == null) {
  throw ApiNotAvailableException('chrome.$group');
}
return ${group}Nullable;            
'''))
        ])),
      Class((b) => b
        ..annotations.addAll([_jsAnnotation(), _staticInteropAnnotation()])
        ..name = groupClass),
    ]));

  return _emitCode(library);
}

String generateDartGroupCode(String groupName, List<model.ChromeApi> apis) {
  var groupClass = 'Chrome${groupName.upperCamel}';
  final library = Library((b) => b
    ..body.addAll([
      Field((b) => b
        ..name = '_${groupClass.lowerCamel}'
        ..modifier = FieldModifier.final$
        ..assignment = refer(groupClass).property('_').call([]).code),
      Extension((b) => b
        ..name = '${groupClass}Extension'
        ..on = refer('Chrome', _internalHelpers)
        ..methods.add(Method((b) => b
          ..returns = refer(groupClass)
          ..name = groupName
          ..lambda = true
          ..body = Code('_${groupClass.lowerCamel}')
          ..type = MethodType.getter))),
      Class((b) => b
        ..name = groupClass
        ..constructors.add(Constructor((c) => c.name = '_'))),
    ]));

  return _emitCode(library);
}

String generateChromeCode(List<model.ChromeApi> apis, List<String> groups) {
  final library = Library((b) => b
    ..directives.addAll([
      Directive.export('src/chrome.dart', show: ['chrome', 'Chrome']),
      for (var api in apis)
        Directive.export(api.fileName, show: [
          'Chrome${api.name.upperCamel}',
          'Chrome${api.name.upperCamel}Extension',
        ]),
      for (var group in groups)
        Directive.export('${group.snakeCase}.dart', show: [
          'Chrome${group.upperCamel}',
          'Chrome${group.upperCamel}Extension',
        ]),
    ]));

  return _emitCode(library);
}

String _emitCode(Spec spec, {Allocator? allocator}) {
  final emitter = DartEmitter(
      allocator: allocator ?? Allocator(),
      useNullSafetySyntax: true,
      orderDirectives: true);
  return _formatter.format('${spec.accept(emitter)}');
}

Expression _staticInteropAnnotation() =>
    refer('staticInterop', _dartInteropUrl);

Expression _anonymousAnnotation() => refer('anonymous', _dartInteropUrl);
Expression _jsAnnotation([String? name]) =>
    refer('JS', _dartInteropUrl).call([if (name != null) literalString(name)]);

Iterable<Expression> _deprecatedAnnotation(String? deprecated) sync* {
  if (deprecated != null) {
    yield refer('Deprecated').call([literalString(deprecated, raw: true)]);
  }
}

String _toEnumValue(String input) {
  return enumValueIdentifier(input.lowerCamel);
}

const _dartKeywordsInEnum = {
  'null', 'default', 'in', 'class' //
};

String enumValueIdentifier(String input) {
  if (_dartKeywordsInEnum.contains(input)) {
    return '$input\$';
  } else {
    return input;
  }
}
