import 'model.dart' show TopLevelDeclaration;

sealed class Reference {
  final bool isNullable;

  Reference({required this.isNullable});
}

class FunctionReference extends Reference {
  final Reference returns;
  final List<(String?, Reference)> parameters;

  FunctionReference({
    required super.isNullable,
    required this.returns,
    required this.parameters,
  });
}

class DynamicFunctionReference extends Reference {
  DynamicFunctionReference({required super.isNullable});
}

class ArrayReference extends Reference {
  final Reference item;

  ArrayReference(this.item, {required super.isNullable});
}

class NamedReference extends Reference {
  final String name;

  NamedReference(this.name, {required super.isNullable});
}

class LocaleReference extends Reference {
  final TopLevelDeclaration declaration;

  LocaleReference(this.declaration, {required super.isNullable});
}

class ChoiceReference extends Reference {
  final List<Reference> choices;

  ChoiceReference({required super.isNullable, required this.choices});
}

class MapReference extends Reference {
  final Reference? item;

  MapReference({required super.isNullable, required this.item});
}