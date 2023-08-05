import 'chrome_type.dart';
import 'utils/string.dart';

export 'chrome_type.dart';

class ChromeApi {
  final String name;
  final String documentation;
  final List<Event> events;
  final List<Method> functions;
  final List<Property> properties;
  final List<Dictionary> dictionaries;
  final List<Enumeration> enumerations;
  final List<Typedef> typedefs;

  ChromeApi({
    required this.documentation,
    required this.properties,
    required this.name,
    required this.events,
    required this.functions,
    required this.dictionaries,
    required this.enumerations,
    required this.typedefs,
  });

  String? get group {
    var split = name.split('.');
    if (split.length > 1) {
      return split.first;
    }
    return null;
  }

  String get nameWithoutGroup => name.split('.').last;

  String get classNameWithGroup => name.upperCamel;
  String get classNameWithoutGroup => nameWithoutGroup.upperCamel;

  String get fileName => '${name.snakeCase}.dart';
}

class Event {
  final String name;
  final String documentation;
  final AsyncReturnType type;

  Event(this.name, {required this.type, required this.documentation});
}

class Method {
  final String name;
  final String documentation;
  final List<Property> parameters;
  final MethodReturn returns;
  final String? deprecated;

  Method(
    this.name, {
    required this.parameters,
    required this.documentation,
    required this.returns,
    required this.deprecated,
  });
}

class MethodReturn {
  final ChromeType? type;
  final String? name;
  final String? documentation;

  MethodReturn({
    required this.type,
    this.name,
    required this.documentation,
  });

  bool get isAsync => type is AsyncReturnType;
}

class Enumeration {
  final String name;
  final String documentation;
  final List<EnumerationValue> values;

  Enumeration(this.name, {required this.documentation, required this.values});
}

class EnumerationValue {
  final String name;
  final String documentation;

  EnumerationValue({required this.name, required this.documentation});
}

class Dictionary {
  final String name;
  final List<Property> properties;
  final List<Method> methods;
  final List<Event> events;
  final String documentation;
  final bool isAnonymous;
  final bool isSyntheticEvent;
  final String? extend;

  Dictionary(
    this.name, {
    required this.properties,
    required this.methods,
    required this.events,
    required this.documentation,
    required this.isAnonymous,
    this.isSyntheticEvent = false,
    this.extend,
  });
}

class Property {
  final String rawName;
  final ChromeType type;
  final String documentation;

  Property(
    this.rawName, {
    required this.type,
    required this.documentation,
  });

  String get dartName => rawName.lowerCamel;
}

class Typedef {
  final String alias;
  final ChromeType target;
  final String documentation;

  Typedef(this.alias, {required this.target, required this.documentation});
}
