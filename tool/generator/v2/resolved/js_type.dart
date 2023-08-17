sealed class JSType {
  final bool isNullable;

  JSType({required this.isNullable});
}

class JSDynamicFunctionType extends JSType {}

class JSFunctionType extends JSType {}

class JSPrimitiveType extends JSType {}

enum Primitive { bool, int, double, arrayBuffer, string }

class JSWebType extends JSType {}

class JSLocalType extends JSType {}

class JSDictionaryType extends JSLocalType {}

class JSEnumType extends JSLocalType {}

class JSAliasType extends JSLocalType {}

class JSListType extends JSType {}

class JSChoiceType extends JSType {}

class JSMapType extends JSType {}

class JSAnyType extends JSType {}
