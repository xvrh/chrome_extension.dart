

/*
From the base model:

 - Generate a JS & Dart model
 - From this JS & Dart model, code emitter should be trivial (and potentially directly in the class?)



 */

// e.g. JS Model

import 'type.dart';

class JSMethod {
  String name;
  ResolvedType returns;
  List<JSParameter> parameters;
}

class JSParameter {
  String name;
  ResolvedType type;
}