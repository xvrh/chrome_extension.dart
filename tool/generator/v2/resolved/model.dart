import 'type.dart';
import '../common_model/model.dart' as common;

class JSApi {
  final List<JSMethod> methods;
}

class JSMethod {
  common.Method method;
  String name;
  JSReturns? returns;
  List<JSParameter> parameters;
}

class JSParameter {
  String name;
  JSType type;
}

sealed class JSReturns {
  final String? documentation;

  JSReturns({required this.documentation});
}

class SyncJSReturns extends JSReturns {
  final JSType type;

  SyncJSReturns(this.type, {required super.documentation});
}

class AsyncJSReturns extends JSReturns {
  final JSFunctionType type;
  final bool supportsPromises;

  AsyncJSReturns({
    required this.type,
    required this.supportsPromises,
    required super.documentation,
  });
}

class DartApi {}

class DartMethod {
  JSMethod binding;
  String name;
  DartReturns returns;
  List<DartParameter> parameters;
}

class DartReturns {
  final bool isFuture;
  DartType type;
  ReturnConversion conversion;
}

sealed class ReturnConversion {}

class PromiseConversion extends ReturnConversion {}

class SyncConversion extends ReturnConversion {}

class CallbackConversion extends ReturnConversion {}

class DartParameter {
  String name;
  DartType type;
  ParameterConversion conversion;
}

sealed class ParameterConversion {}

class NormalDartParameterConversion extends ParameterConversion {
  JSParameter target;
  DartType type;
}

class InlineDartParameterConversion extends ParameterConversion {
  JSDictionary dictionary;
  JSProperty property;
}
