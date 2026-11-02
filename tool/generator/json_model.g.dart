// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonNamespace _$JsonNamespaceFromJson(Map<String, dynamic> json) =>
    JsonNamespace(
      namespace: json['namespace'] as String,
      description: json['description'] as String? ?? '',
      properties: (json['properties'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, JsonProperty.fromJson(e as Map<String, dynamic>)),
          ) ??
          {},
      functions: (json['functions'] as List<dynamic>?)
              ?.map((e) => JsonFunction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      events: (json['events'] as List<dynamic>?)
              ?.map((e) => JsonFunction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      types: (json['types'] as List<dynamic>?)
              ?.map((e) => JsonDeclaredType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

JsonFunction _$JsonFunctionFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const [
      'name',
      'type',
      'description',
      'parameters',
      'returns',
      'returns_async',
      'deprecated',
      'nodoc',
      'nocompile',
      'options',
      'optional',
      'allowAmbiguousOptionalArguments',
      'maximumManifestVersion',
      'min_version',
      'platforms',
      'filters',
      'extraParameters'
    ],
  );
  return JsonFunction(
    json['name'] as String,
    json['type'] as String?,
    json['description'] as String? ?? '',
    (json['parameters'] as List<dynamic>?)
            ?.map((e) => JsonProperty.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    json['returns'] == null
        ? null
        : JsonProperty.fromJson(json['returns'] as Map<String, dynamic>),
    json['returns_async'] == null
        ? null
        : JsonProperty.fromJson(json['returns_async'] as Map<String, dynamic>),
    json['deprecated'] as String?,
    json['nodoc'] as bool?,
    json['nocompile'] as bool?,
    json['options'] as Map<String, dynamic>?,
    json['optional'] as bool?,
    json['allowAmbiguousOptionalArguments'] as bool?,
    (json['maximumManifestVersion'] as num?)?.toInt(),
    json['min_version'] as String?,
    (json['platforms'] as List<dynamic>?)?.map((e) => e as String).toList(),
    json['filters'] as List<dynamic>?,
    (json['extraParameters'] as List<dynamic>?)
        ?.map((e) => JsonProperty.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

JsonDeclaredType _$JsonDeclaredTypeFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const [
      'id',
      'type',
      'description',
      'decription',
      'name',
      'enum',
      'properties',
      'functions',
      'events',
      'additionalProperties',
      'nodoc',
      'nocompile',
      'js_module',
      'inline_doc',
      'customBindings',
      'choices',
      'items',
      'maxItems',
      'minItems',
      'deprecated',
      'optional',
      'required',
      'isInstanceOf'
    ],
  );
  return JsonDeclaredType(
    json['id'] as String,
    json['description'] as String? ?? '',
    name: json['name'] as String?,
    type: json['type'] as String?,
    enums: (json['enum'] as List<dynamic>?)
        ?.map((e) => const _JsonEnumConverter().fromJson(e as Object))
        .toList(),
    properties: (json['properties'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, JsonProperty.fromJson(e as Map<String, dynamic>)),
    ),
    functions: (json['functions'] as List<dynamic>?)
        ?.map((e) => JsonFunction.fromJson(e as Map<String, dynamic>))
        .toList(),
    events: (json['events'] as List<dynamic>?)
        ?.map((e) => JsonFunction.fromJson(e as Map<String, dynamic>))
        .toList(),
    nodoc: json['nodoc'] as bool?,
    nocompile: json['nocompile'] as bool?,
    additionalProperties: json['additionalProperties'] == null
        ? null
        : JsonProperty.fromJson(
            json['additionalProperties'] as Map<String, dynamic>),
    choices: (json['choices'] as List<dynamic>?)
        ?.map((e) => JsonProperty.fromJson(e as Map<String, dynamic>))
        .toList(),
    jsModule: json['js_module'],
    inlineDoc: json['inline_doc'],
    customBindings: json['customBindings'],
    items: json['items'] == null
        ? null
        : JsonProperty.fromJson(json['items'] as Map<String, dynamic>),
    maxItems: (json['maxItems'] as num?)?.toInt(),
    minItems: (json['minItems'] as num?)?.toInt(),
    deprecated: json['deprecated'] as String?,
    optional: json['optional'] as bool?,
    required:
        (json['required'] as List<dynamic>?)?.map((e) => e as String).toList(),
    isInstanceOf: json['isInstanceOf'] as String?,
    decription: json['decription'] as String?,
  );
}

JsonProperty _$JsonPropertyFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const [
      'name',
      'type',
      'minimum',
      'maximum',
      'minLength',
      'maxLength',
      'optional',
      'value',
      'description',
      'deprecated',
      r'$ref',
      'properties',
      'parameters',
      'choices',
      'items',
      'enum',
      'isInstanceOf',
      'additionalProperties',
      'extension_types',
      'nodoc',
      'maxItems',
      'minItems',
      'platforms',
      'preserveNull',
      'serialized_type',
      'min_version',
      'nocompile',
      'does_not_support_promises'
    ],
  );
  return JsonProperty(
    json['name'] as String?,
    json['type'] as String?,
    json['minimum'] as num?,
    json['maximum'] as num?,
    (json['minLength'] as num?)?.toInt(),
    (json['maxLength'] as num?)?.toInt(),
    json['optional'] as bool?,
    json['description'] as String? ?? '',
    json['deprecated'] as String?,
    json[r'$ref'] as String?,
    (json['properties'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, JsonProperty.fromJson(e as Map<String, dynamic>)),
    ),
    json['value'],
    json['isInstanceOf'] as String?,
    json['additionalProperties'] == null
        ? null
        : JsonProperty.fromJson(
            json['additionalProperties'] as Map<String, dynamic>),
    (json['parameters'] as List<dynamic>?)
        ?.map((e) => JsonProperty.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['items'] == null
        ? null
        : JsonProperty.fromJson(json['items'] as Map<String, dynamic>),
    (json['extension_types'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    json['nodoc'],
    (json['choices'] as List<dynamic>?)
        ?.map((e) => JsonProperty.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['maxItems'] as num?)?.toInt(),
    (json['minItems'] as num?)?.toInt(),
    (json['enum'] as List<dynamic>?)
        ?.map((e) => const _JsonEnumConverter().fromJson(e as Object))
        .toList(),
    (json['platforms'] as List<dynamic>?)?.map((e) => e as String).toList(),
    json['preserveNull'] as bool?,
    json['serialized_type'] as String?,
    json['min_version'] as String?,
    json['nocompile'] as bool?,
    json['does_not_support_promises'] as String?,
  );
}
