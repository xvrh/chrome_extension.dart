import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'json_model.g.dart';

@JsonSerializable(createToJson: false)
class JsonNamespace {
  final String namespace;

  @JsonKey(defaultValue: '')
  final String description;

  @JsonKey(defaultValue: {})
  final Map<String, JsonProperty> properties;

  @JsonKey(defaultValue: [])
  final List<JsonFunction> functions;

  @JsonKey(defaultValue: [])
  final List<JsonFunction> events;

  @JsonKey(defaultValue: [])
  final List<JsonDeclaredType> types;

  JsonNamespace({
    required this.namespace,
    required this.description,
    required this.properties,
    required this.functions,
    required this.events,
    required this.types,
  });

  factory JsonNamespace.fromJson(Map<String, dynamic> json) =>
      _$JsonNamespaceFromJson(json);

  static JsonNamespace parse(String jsonText) {
    // pre-filter to remove line comments -
    //TODO: use a real JSON5 parser
    var lines = LineSplitter().convert(jsonText);
    var newLines = lines.map((String line) {
      var index = line.indexOf('//');

      // If we find // foo, we remove it from the line, unless it looks like
      // :// foo (as in, http://cheese.com).

      if (index == -1) {
        return line;
      } else if (index == 0 || line.codeUnitAt(index - 1) != 58) {
        // 58 == ':'
        return line.substring(0, index);
      } else {
        return line;
      }
    });

    return JsonNamespace.fromJson((json.decode(newLines.join('\n')) as List)
        .single as Map<String, dynamic>);
  }
}

@JsonSerializable(createToJson: false, disallowUnrecognizedKeys: true)
class JsonFunction {
  final String name;
  final String? type;

  @JsonKey(defaultValue: '')
  final String description;

  @JsonKey(defaultValue: [])
  final List<JsonProperty> parameters;

  final JsonProperty? returns;

  @JsonKey(name: 'returns_async')
  final JsonProperty? returnsAsync;

  final String? deprecated;

  final bool? nodoc, nocompile;

  final Map? options;

  final bool? optional, allowAmbiguousOptionalArguments;

  final int? maximumManifestVersion;

  @JsonKey(name: 'min_version')
  final String? minVersion;

  final List<String>? platforms;

  final List? filters;

  final List<JsonProperty>? extraParameters;

  JsonFunction(
    this.name,
    this.type,
    this.description,
    this.parameters,
    this.returns,
    this.returnsAsync,
    this.deprecated,
    this.nodoc,
    this.nocompile,
    this.options,
    this.optional,
    this.allowAmbiguousOptionalArguments,
    this.maximumManifestVersion,
    this.minVersion,
    this.platforms,
    this.filters,
    this.extraParameters,
  );

  factory JsonFunction.fromJson(Map<String, dynamic> json) =>
      _$JsonFunctionFromJson(json);
}

@JsonSerializable(createToJson: false, disallowUnrecognizedKeys: true)
class JsonDeclaredType {
  final String id;
  final String? type;

  @JsonKey(defaultValue: '')
  final String description;
  final String? decription;

  final String? name;

  @JsonKey(name: 'enum')
  @_JsonEnumConverter()
  final List<JsonEnumValue>? enums;

  final Map<String, JsonProperty>? properties;

  final List<JsonFunction>? functions;

  final List<JsonFunction>? events;

  final JsonProperty? additionalProperties;

  final bool? nodoc, nocompile;

  @JsonKey(name: 'js_module')
  final Object? jsModule;

  @JsonKey(name: 'inline_doc')
  final Object? inlineDoc;

  final Object? customBindings;

  final List<JsonProperty>? choices;

  final JsonProperty? items;

  final int? maxItems, minItems;

  final String? deprecated;
  final bool? optional;
  final List<String>? required;

  final String? isInstanceOf;

  @JsonKey(includeFromJson: false)
  bool isAnonymous = false;

  @JsonKey(includeFromJson: false)
  String? extend;

  JsonDeclaredType(
    this.id,
    this.description, {
    this.name,
    this.type,
    this.enums,
    this.properties,
    this.functions,
    this.events,
    this.nodoc,
    this.nocompile,
    this.additionalProperties,
    this.choices,
    this.jsModule,
    this.inlineDoc,
    this.customBindings,
    this.items,
    this.maxItems,
    this.minItems,
    this.deprecated,
    this.optional,
    this.required,
    this.isInstanceOf,
    this.decription,
  });

  factory JsonDeclaredType.fromJson(Map<String, dynamic> json) =>
      _$JsonDeclaredTypeFromJson(json);
}

@JsonSerializable(createToJson: false, disallowUnrecognizedKeys: true)
class JsonProperty {
  final String? name;
  final String? type;
  final num? minimum, maximum;
  final int? minLength, maxLength;
  final bool? optional;
  final Object? value;

  @JsonKey(defaultValue: '')
  final String description;
  final String? deprecated;

  final String? $ref;

  final Map<String, JsonProperty>? properties;
  final List<JsonProperty>? parameters;
  final List<JsonProperty>? choices;
  final JsonProperty? items;

  @JsonKey(name: 'enum')
  @_JsonEnumConverter()
  final List<JsonEnumValue>? enums;

  final String? isInstanceOf;

  final JsonProperty? additionalProperties;

  @JsonKey(name: 'extension_types')
  final List<String>? extensionTypes;

  final Object? nodoc;

  final int? maxItems, minItems;

  final List<String>? platforms;

  final bool? preserveNull;

  @JsonKey(name: 'serialized_type')
  final String? serializedType;

  @JsonKey(name: 'min_version')
  final String? minVersion;

  final bool? nocompile;

  JsonProperty(
    this.name,
    this.type,
    this.minimum,
    this.maximum,
    this.minLength,
    this.maxLength,
    this.optional,
    this.description,
    this.deprecated,
    this.$ref,
    this.properties,
    this.value,
    this.isInstanceOf,
    this.additionalProperties,
    this.parameters,
    this.items,
    this.extensionTypes,
    this.nodoc,
    this.choices,
    this.maxItems,
    this.minItems,
    this.enums,
    this.platforms,
    this.preserveNull,
    this.serializedType,
    this.minVersion,
    this.nocompile,
  );

  factory JsonProperty.fromJson(Map<String, dynamic> json) =>
      _$JsonPropertyFromJson(json);
}

class JsonEnumValue {
  final String name;
  final String description;

  JsonEnumValue(this.name, this.description);
}

class _JsonEnumConverter extends JsonConverter<JsonEnumValue, Object> {
  const _JsonEnumConverter();

  @override
  JsonEnumValue fromJson(Object json) {
    if (json is String) {
      return JsonEnumValue(json, '');
    } else if (json is Map<String, dynamic>) {
      return JsonEnumValue(
          json['name']! as String, json['description'] as String? ?? '');
    } else {
      throw UnsupportedError('value is ${json.runtimeType}');
    }
  }

  @override
  Object toJson(JsonEnumValue object) {
    throw UnimplementedError();
  }
}
