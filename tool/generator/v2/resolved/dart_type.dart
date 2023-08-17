sealed class DartType {
  final bool isNullable;

  DartType({required this.isNullable});
}

class DartDynamicFunctionType extends DartType {}

class DartFunctionType extends DartType {}

class DartPrimitiveType extends DartType {}

enum Primitive { bool, int, double, arrayBuffer, string }

class DartWebType extends DartType {}

class DartLocalType extends DartType {}

class DartListType extends DartType {}

class DartChoiceType extends DartType {}

class DartMapType extends DartType {}

class DartAnyType extends DartType {}
