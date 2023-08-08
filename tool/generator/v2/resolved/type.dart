

sealed class ResolvedType {
  final bool isNullable;

  ResolvedType({required this.isNullable});
}

class DynamicFunctionType extends ResolvedType {}

class FunctionType extends ResolvedType {}

class PrimitiveType extends ResolvedType {}

enum Primitive {bool, int, double, arrayBuffer, string}

class WebType extends ResolvedType {}

class LocalType extends ResolvedType {}

class DictionaryType extends LocalType {}

class EnumType extends LocalType {}

class AliasType extends LocalType {}

class ListType extends ResolvedType {}

class ChoiceType extends ResolvedType {}

class MapType extends ResolvedType {}

class AnyType extends ResolvedType {}
