import 'model.dart' show Parameter, TopLevelDeclaration;

sealed class Reference {
  final bool isNullable;

  Reference({required this.isNullable});
}

class FunctionReference extends Reference {
  final String? name;
  final List<Parameter> parameters;

  FunctionReference(
    this.name, {
    required super.isNullable,
    required this.parameters,
  });
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
