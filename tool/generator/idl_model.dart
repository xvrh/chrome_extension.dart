library chrome_idl_model;

/// This class provides a model for IDL-specified namespaces.
class IDLNamespaceDeclaration {
  /// The [name] of the declared namespace.
  final String name;

  final IDLAttributeDeclaration? attribute;
  final IDLFunctionDeclaration? functionDeclaration;
  final IDLPropertiesDeclaration? propertiesDeclaration;
  final List<IDLTypeDeclaration> typeDeclarations;
  final IDLEventDeclaration? eventDeclaration;
  final List<IDLCallbackDeclaration> callbackDeclarations;
  final List<IDLEnumDeclaration> enumDeclarations;
  final String? copyrightSignature;

  /// Namespace documentation.
  final List<String> documentation;

  IDLNamespaceDeclaration(this.name,
      {this.functionDeclaration,
      this.propertiesDeclaration,
      required this.typeDeclarations,
      this.eventDeclaration,
      required this.callbackDeclarations,
      required this.enumDeclarations,
      this.attribute,
      required this.documentation,
      this.copyrightSignature});

  @override
  String toString() =>
      "IDLNamespaceDeclaration($name, $attribute, $documentation)";
}

/// This class provides a model for IDL-specified functions.
class IDLFunctionDeclaration {
  final String name = "Functions";
  final IDLAttributeDeclaration? attribute;
  final List<IDLMethod> methods;
  final List<String> documentation;

  IDLFunctionDeclaration(this.methods,
      {this.attribute, required this.documentation});

  @override
  String toString() =>
      "IDLFunctionDeclaration($name, $attribute, $methods, $documentation)";
}

class IDLPropertiesDeclaration {
  final String name = "Properties";
  final IDLAttributeDeclaration? attribute;
  final List<IDLMethod> methods;
  final List<String> documentation;

  IDLPropertiesDeclaration(this.methods,
      {this.attribute, required this.documentation});

  @override
  String toString() =>
      "IDLPropertiesDeclaration($name, $attribute, $methods, $documentation)";
}

/// This class provides a model for IDL-specified type definitions.
class IDLTypeDeclaration {
  final String name;
  final IDLAttributeDeclaration? attribute;
  final List<IDLField> members;
  final List<IDLMethod> methods;
  final List<String> documentation;

  IDLTypeDeclaration(this.name, this.members,
      {required this.methods, this.attribute, required this.documentation});

  @override
  String toString() =>
      "IDLTypeDeclaration($name, $members, $methods, $attribute, $documentation)";
}

/// This class provides a model for IDL-specified events.
class IDLEventDeclaration {
  final String name = "Events";
  final IDLAttributeDeclaration? attribute;
  final List<IDLMethod> methods;
  final List<String> documentation;
  IDLEventDeclaration(this.methods,
      {this.attribute, required this.documentation});
  @override
  String toString() =>
      "IDLEventDeclaration($name, $attribute, $methods, $documentation)";
}

/// This class provides a model for IDL-specified callbacks.
class IDLCallbackDeclaration {
  final String name;
  final List<IDLParameter> parameters;
  final List<String> documentation;

  IDLCallbackDeclaration(this.name, this.parameters,
      {required this.documentation});

  @override
  String toString() =>
      "IDLCallbackDeclaration($name, $parameters, $documentation)";
}

/// This class provides a model for IDL-specified enums.
class IDLEnumDeclaration {
  final String name;
  final IDLAttributeDeclaration? attribute;
  final List<IDLEnumValue> enums; // TODO: rename enumValue
  final List<String> documentation;

  IDLEnumDeclaration(this.name, this.enums,
      {this.attribute, required this.documentation});

  @override
  String toString() =>
      "IDLEnumDeclaration($name, $enums, $attribute, $documentation)";
}

/// This class provides a model for IDL-specified attributes.
class IDLAttributeDeclaration {
  final List<IDLAttribute> attributes;
  IDLAttributeDeclaration(this.attributes);
  @override
  String toString() => "IDLAttributeDeclaration($attributes)";
}

/// This class provides a model for IDL-specified methods.
class IDLMethod {
  final String name;
  final List<IDLParameter> parameters;
  final IDLType returnType;
  final List<String> documentation;
  final IDLAttributeDeclaration? attribute;

  IDLMethod(this.name, this.returnType, this.parameters,
      {this.attribute, required this.documentation});

  @override
  String toString() =>
      "IDLMethod($name, $returnType, $parameters, $attribute, $documentation})";
}

/// This class provides a model for IDL-specified fields.
class IDLField {
  final String name;
  final IDLTypeOrUnion types;
  final bool isOptional;
  final IDLAttributeDeclaration? attribute;
  final List<String> documentation;

  IDLField(this.name, this.types,
      {this.attribute, this.isOptional = false, required this.documentation});

  @override
  String toString() =>
      "IDLField($name, $types, $attribute, $isOptional, $documentation)";
}

/// This class provides a model for IDL-specified parameters.
class IDLParameter {
  final String name;
  final IDLTypeOrUnion types;
  final bool isOptional;
  // TODO: rename all variable names of IDLAttributeDeclaration attribute
  // to IDLAttributeDeclaration attributeDeclaration.
  final IDLAttributeDeclaration? attribute;

  // This is known by the convention used in chrome idl
  //   static void create(DOMString url, optional CreateWindowOptions options,
  //     optional CreateWindowCallback callback);
  final bool isCallback;

  IDLParameter(this.name, this.types,
      {this.attribute, this.isOptional = false, this.isCallback = false});

  bool get supportsPromises =>
      attribute?.attributes.any(
          (e) => e.attributeType == IDLAttributeTypeEnum.supportsPromises) ??
      false;

  @override
  String toString() =>
      "IDLParameter($name, $types, $attribute, $isOptional, $isCallback)";
}

/// This class provides an enumeration of the different types of attributes
/// used in the chrome apps idls.
enum IDLAttributeTypeEnum {
  /// Example:
  ///
  ///    [deprecated="Use innerBounds or outerBounds."]
  deprecated("deprecated"),

  /// Example:
  ///
  ///  [instanceOf=Window]
  instanceOf("instanceOf"),

  /// Example:
  ///
  ///  [nodefine]
  nodefine("nodefine"),

  /// Example:
  ///
  ///  [implemented_in="path/to/implementation.h"]
  implementedIn("implemented_in"),

  /// Example:
  ///
  /// [supportsFilters=true]
  supportsFilter("supportsFilters"),

  /// Example:
  ///
  /// [inline_doc]
  inlineDoc("inline_doc"),

  /// Example:
  ///
  /// [noinline_doc]
  noinlineDoc("noinline_doc"),

  /// Example:
  ///
  /// [nodoc]
  nodoc("nodoc"),

  /// Example:
  ///
  /// [nocompile]
  ///
  /// also sometimes paired with [nocompile, nodoc]
  nocompile("nocompile"),

  /// Example:
  ///
  /// [legalValues=(16,32)]
  legalValues("legalValues"),

  /// Example:
  ///
  /// [permissions=downloads]
  permissions("permissions"),

  /// Example:
  ///
  /// [maxListeners=1]
  maxListeners("maxListeners"),

  /// Example:
  ///
  /// [platforms = ("chromeos")]
  platforms("platforms"),

  /// Example:
  ///
  /// [supportsPromises]
  supportsPromises("supportsPromises"),

  /// Example:
  ///
  /// [modernised_enums]
  modernisedEnums("modernised_enums"),

  /// Example:
  ///
  /// [generate_error_messages]
  generateErrorMessages("generate_error_messages"),

  /// Example:
  ///
  /// [value]
  val("value"),

  /// Example:
  ///
  /// [serializableFunction]
  serializableFunction("serializableFunction"),

  documentationTitle("documentation_title"),
  documentationNamespace("documentation_namespace"),
  documentedIn("documented_in"),
  ;

  final String type;

  const IDLAttributeTypeEnum(this.type);
}

extension IDLAttributeDeclarationExtension on IDLAttributeDeclaration? {
  bool get supportsPromises =>
      this?.attributes.any(
          (e) => e.attributeType == IDLAttributeTypeEnum.supportsPromises) ??
      false;
}

class IDLAttribute {
  ///The type of attribute.
  final IDLAttributeTypeEnum attributeType;

  ///The possible value used on assignment to the attribute.
  final String? attributeValue;

  ///The possible [List] of values used on assignment to the attribute.
  final List? attributeValues;

  IDLAttribute(this.attributeType, {this.attributeValue, this.attributeValues});

  @override
  String toString() =>
      "IDLAttribute($attributeType, $attributeValue, $attributeValues)";
}

class IDLEnumValue {
  final String name;
  final List<String> documentation;

  IDLEnumValue(this.name, {required this.documentation});

  @override
  String toString() => "IDLEnumValue($name, $documentation)";
}

class IDLType {
  final String name;

  final bool isArray;

  IDLType(this.name, {this.isArray = false});

  @override
  String toString() => "IDLType($name, $isArray)";
}

class IDLTypeOrUnion {
  final List<IDLType> types;

  IDLTypeOrUnion(this.types) : assert(types.isNotEmpty);

  IDLType operator [](int index) => types[index];

  int get length => types.length;

  void apply(IDLType Function(IDLType) callback) {
    for (var i = 0; i < types.length; i++) {
      types[i] = callback(types[i]);
    }
  }

  String get name {
    assert(types.length == 1);
    return types.first.name;
  }

  bool get isArray {
    assert(types.length == 1);
    return types.first.isArray;
  }
}
