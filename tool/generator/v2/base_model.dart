class Api {
  final String name;
  final List<Method> methods;
}

class Method {
  final String name;
  final List<Parameter> parameters;
  final Reference? returns;
  final

  Method(this.name, this.parameters);
}

class Parameter {
  final String name;
  final Reference reference;

  Parameter(this.name, this.reference);
}

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
