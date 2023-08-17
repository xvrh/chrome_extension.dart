import 'package:code_builder/code_builder.dart' as code;

sealed class ResolvedType {
  final bool isNullable;

  ResolvedType({required this.isNullable});

  code.Reference get jsType;
  code.Reference get dartType;
  code.Expression toDart(code.Expression accessor);
  code.Expression toJS(code.Expression accessor);
}

class DynamicFunctionType extends ResolvedType {}

class FunctionType extends ResolvedType {}

class PrimitiveType extends ResolvedType {}

enum Primitive { bool, int, double, arrayBuffer, string }

class WebType extends ResolvedType {}

class LocalType extends ResolvedType {}

class DictionaryType extends LocalType {}

class EnumType extends LocalType {}

class AliasType extends LocalType {}

class ListType extends ResolvedType {}

class ChoiceType extends ResolvedType {}

class MapType extends ResolvedType {}

class AnyType extends ResolvedType {}
