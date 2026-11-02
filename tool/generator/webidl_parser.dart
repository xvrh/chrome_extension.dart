library;

/// Parser for the WebIDL subset used by the Chromium extension API schemas
/// (`.webidl` files).
///
/// Like Chromium's `web_idl_schema.py`, the documentation of a definition is
/// the block of `//` comments on the lines directly above it.
List<WebIdlDefinition> parseWebIdl(String source) =>
    _WebIdlParser(_tokenize(source)).parseDefinitions();

class WebIdlExtendedAttribute {
  final String name;

  /// `null`, a [String] or a [List<String>] (for `name=("a", "b")`).
  final Object? value;

  WebIdlExtendedAttribute(this.name, this.value);

  @override
  String toString() => 'WebIdlExtendedAttribute($name, $value)';
}

extension WebIdlExtendedAttributesExtension on List<WebIdlExtendedAttribute> {
  bool has(String name) => any((e) => e.name == name);

  Object? valueOf(String name) {
    for (var attribute in this) {
      if (attribute.name == name) return attribute.value;
    }
    return null;
  }
}

class WebIdlType {
  /// The identifier of the type, or `union` for `(A or B)`.
  final String name;

  /// The type arguments (`sequence<T>`, `Promise<T>`) or the members of a
  /// union.
  final List<WebIdlType> arguments;
  final bool isNullable;
  final List<WebIdlExtendedAttribute> extendedAttributes;

  WebIdlType(this.name,
      {this.arguments = const [],
      this.isNullable = false,
      this.extendedAttributes = const []});

  bool get isUnion => name == 'union';

  @override
  String toString() => [
        name,
        if (arguments.isNotEmpty) '<${arguments.join(', ')}>',
        if (isNullable) '?',
      ].join();
}

sealed class WebIdlDefinition {
  final String name;
  final List<String> documentation;
  final List<WebIdlExtendedAttribute> extendedAttributes;

  WebIdlDefinition(this.name,
      {required this.documentation, required this.extendedAttributes});
}

class WebIdlInterface extends WebIdlDefinition {
  final bool isPartial;
  final String? inherits;
  final List<WebIdlMember> members;

  WebIdlInterface(super.name,
      {required this.isPartial,
      required this.inherits,
      required this.members,
      required super.documentation,
      required super.extendedAttributes});
}

class WebIdlDictionary extends WebIdlDefinition {
  final bool isPartial;
  final List<WebIdlDictionaryMember> members;

  WebIdlDictionary(super.name,
      {required this.isPartial,
      required this.members,
      required super.documentation,
      required super.extendedAttributes});
}

class WebIdlEnum extends WebIdlDefinition {
  final List<WebIdlEnumValue> values;

  WebIdlEnum(super.name,
      {required this.values,
      required super.documentation,
      required super.extendedAttributes});
}

class WebIdlCallback extends WebIdlDefinition {
  final WebIdlType returnType;
  final List<WebIdlArgument> arguments;

  WebIdlCallback(super.name,
      {required this.returnType,
      required this.arguments,
      required super.documentation,
      required super.extendedAttributes});
}

class WebIdlTypedef extends WebIdlDefinition {
  final WebIdlType type;

  WebIdlTypedef(super.name,
      {required this.type,
      required super.documentation,
      required super.extendedAttributes});
}

sealed class WebIdlMember {
  final String name;
  final List<String> documentation;
  final List<WebIdlExtendedAttribute> extendedAttributes;

  WebIdlMember(this.name,
      {required this.documentation, required this.extendedAttributes});
}

class WebIdlOperation extends WebIdlMember {
  final WebIdlType returnType;
  final List<WebIdlArgument> arguments;

  WebIdlOperation(super.name,
      {required this.returnType,
      required this.arguments,
      required super.documentation,
      required super.extendedAttributes});
}

class WebIdlAttribute extends WebIdlMember {
  final WebIdlType type;

  WebIdlAttribute(super.name,
      {required this.type,
      required super.documentation,
      required super.extendedAttributes});
}

class WebIdlConst extends WebIdlMember {
  final WebIdlType type;
  final String value;

  WebIdlConst(super.name,
      {required this.type,
      required this.value,
      required super.documentation,
      required super.extendedAttributes});
}

class WebIdlDictionaryMember {
  final String name;
  final WebIdlType type;
  final bool isRequired;
  final List<String> documentation;
  final List<WebIdlExtendedAttribute> extendedAttributes;

  WebIdlDictionaryMember(this.name,
      {required this.type,
      required this.isRequired,
      required this.documentation,
      required this.extendedAttributes});
}

class WebIdlArgument {
  final String name;
  final WebIdlType type;
  final bool isOptional;
  final List<WebIdlExtendedAttribute> extendedAttributes;

  WebIdlArgument(this.name,
      {required this.type,
      required this.isOptional,
      required this.extendedAttributes});
}

class WebIdlEnumValue {
  final String name;
  final List<String> documentation;

  WebIdlEnumValue(this.name, {required this.documentation});
}

enum _TokenType { identifier, string, number, symbol, end }

class _Token {
  final _TokenType type;
  final String value;
  final int line;

  /// The `//` comments on the lines directly above this token (only for the
  /// first token of a line).
  final List<String> documentation;

  _Token(this.type, this.value,
      {required this.line, required this.documentation});

  @override
  String toString() => '"$value" (line $line)';
}

final _identifierStart = RegExp(r'[A-Za-z_]');
final _identifierPart = RegExp(r'[A-Za-z0-9_]');
final _numberPart = RegExp(r'[0-9A-Fa-fxX.]');
final _digit = RegExp(r'[0-9]');

List<_Token> _tokenize(String source) {
  var tokens = <_Token>[];
  var pendingDocumentation = <String>[];
  var line = 1;
  // Whether the current line already has a token or a comment, a line with
  // neither ends the block of documentation comments.
  var lineHasToken = false;
  var lineHasComment = false;
  var i = 0;

  void addToken(_TokenType type, String value) {
    tokens.add(_Token(type, value,
        line: line,
        documentation: lineHasToken ? const [] : [...pendingDocumentation]));
    pendingDocumentation.clear();
    lineHasToken = true;
  }

  while (i < source.length) {
    var char = source[i];
    if (char == '\n') {
      if (!lineHasToken && !lineHasComment) {
        pendingDocumentation.clear();
      }
      line++;
      lineHasToken = false;
      lineHasComment = false;
      i++;
    } else if (char.trim().isEmpty) {
      i++;
    } else if (source.startsWith('//', i)) {
      var end = source.indexOf('\n', i);
      if (end < 0) end = source.length;
      var comment = source.substring(i + 2, end);
      if (lineHasToken) {
        // A comment at the end of a line isn't documentation, and the line
        // isn't a comment line either.
        pendingDocumentation.clear();
      } else {
        if (comment.startsWith(' ')) comment = comment.substring(1);
        pendingDocumentation.add(comment.trimRight());
        lineHasComment = true;
      }
      i = end;
    } else if (source.startsWith('/*', i)) {
      var end = source.indexOf('*/', i + 2);
      if (end < 0) throw FormatException('Unterminated comment', source, i);
      line += '\n'.allMatches(source.substring(i, end)).length;
      pendingDocumentation.clear();
      lineHasToken = true;
      i = end + 2;
    } else if (char == '"') {
      var end = source.indexOf('"', i + 1);
      if (end < 0) throw FormatException('Unterminated string', source, i);
      addToken(_TokenType.string, source.substring(i + 1, end));
      i = end + 1;
    } else if (_identifierStart.hasMatch(char)) {
      var start = i;
      while (i < source.length && _identifierPart.hasMatch(source[i])) {
        i++;
      }
      addToken(_TokenType.identifier, source.substring(start, i));
    } else if (_digit.hasMatch(char) ||
        (char == '-' &&
            i + 1 < source.length &&
            _digit.hasMatch(source[i + 1]))) {
      var start = i;
      i++;
      while (i < source.length && _numberPart.hasMatch(source[i])) {
        i++;
      }
      addToken(_TokenType.number, source.substring(start, i));
    } else if ('{}()[]<>;:,=?.'.contains(char)) {
      addToken(_TokenType.symbol, char);
      i++;
    } else {
      throw FormatException('Unexpected character "$char"', source, i);
    }
  }
  tokens.add(_Token(_TokenType.end, '<end>', line: line, documentation: []));
  return tokens;
}

class _WebIdlParser {
  final List<_Token> _tokens;
  var _position = 0;

  _WebIdlParser(this._tokens);

  _Token get _current => _tokens[_position];

  bool _isSymbol(String symbol) =>
      _current.type == _TokenType.symbol && _current.value == symbol;

  bool _isKeyword(String keyword) =>
      _current.type == _TokenType.identifier && _current.value == keyword;

  _Token _next() => _tokens[_position++];

  Never _error(String expected) =>
      throw FormatException('Expected $expected, found $_current');

  void _expectSymbol(String symbol) {
    if (!_isSymbol(symbol)) _error('"$symbol"');
    _next();
  }

  bool _acceptSymbol(String symbol) {
    if (_isSymbol(symbol)) {
      _next();
      return true;
    }
    return false;
  }

  bool _acceptKeyword(String keyword) {
    if (_isKeyword(keyword)) {
      _next();
      return true;
    }
    return false;
  }

  String _identifier() {
    if (_current.type != _TokenType.identifier) _error('an identifier');
    return _next().value;
  }

  List<WebIdlDefinition> parseDefinitions() {
    var definitions = <WebIdlDefinition>[];
    while (_current.type != _TokenType.end) {
      definitions.add(_definition());
    }
    return definitions;
  }

  WebIdlDefinition _definition() {
    var documentation = _current.documentation;
    var extendedAttributes = _extendedAttributes();
    var isPartial = _acceptKeyword('partial');
    if (_acceptKeyword('interface')) {
      var name = _identifier();
      String? inherits;
      if (_acceptSymbol(':')) {
        inherits = _identifier();
      }
      _expectSymbol('{');
      var members = <WebIdlMember>[];
      while (!_acceptSymbol('}')) {
        members.add(_interfaceMember());
      }
      _expectSymbol(';');
      return WebIdlInterface(name,
          isPartial: isPartial,
          inherits: inherits,
          members: members,
          documentation: documentation,
          extendedAttributes: extendedAttributes);
    } else if (_acceptKeyword('dictionary')) {
      var name = _identifier();
      _expectSymbol('{');
      var members = <WebIdlDictionaryMember>[];
      while (!_acceptSymbol('}')) {
        members.add(_dictionaryMember());
      }
      _expectSymbol(';');
      return WebIdlDictionary(name,
          isPartial: isPartial,
          members: members,
          documentation: documentation,
          extendedAttributes: extendedAttributes);
    } else if (_acceptKeyword('enum')) {
      var name = _identifier();
      _expectSymbol('{');
      var values = <WebIdlEnumValue>[];
      while (!_acceptSymbol('}')) {
        var valueDocumentation = _current.documentation;
        if (_current.type != _TokenType.string) _error('an enum value');
        values.add(
            WebIdlEnumValue(_next().value, documentation: valueDocumentation));
        if (!_acceptSymbol(',')) {
          _expectSymbol('}');
          break;
        }
      }
      _expectSymbol(';');
      return WebIdlEnum(name,
          values: values,
          documentation: documentation,
          extendedAttributes: extendedAttributes);
    } else if (_acceptKeyword('callback')) {
      var name = _identifier();
      _expectSymbol('=');
      var returnType = _type();
      var arguments = _arguments();
      _expectSymbol(';');
      return WebIdlCallback(name,
          returnType: returnType,
          arguments: arguments,
          documentation: documentation,
          extendedAttributes: extendedAttributes);
    } else if (_acceptKeyword('typedef')) {
      var type = _type();
      var name = _identifier();
      _expectSymbol(';');
      return WebIdlTypedef(name,
          type: type,
          documentation: documentation,
          extendedAttributes: extendedAttributes);
    }
    _error('a definition');
  }

  WebIdlMember _interfaceMember() {
    var documentation = _current.documentation;
    var extendedAttributes = _extendedAttributes();
    if (_acceptKeyword('const')) {
      var type = _type();
      var name = _identifier();
      _expectSymbol('=');
      var value = _next().value;
      _expectSymbol(';');
      return WebIdlConst(name,
          type: type,
          value: value,
          documentation: documentation,
          extendedAttributes: extendedAttributes);
    }
    _acceptKeyword('static');
    _acceptKeyword('readonly');
    if (_acceptKeyword('attribute')) {
      var type = _type();
      var name = _identifier();
      _expectSymbol(';');
      return WebIdlAttribute(name,
          type: type,
          documentation: documentation,
          extendedAttributes: extendedAttributes);
    }
    var returnType = _type();
    var name = _identifier();
    var arguments = _arguments();
    _expectSymbol(';');
    return WebIdlOperation(name,
        returnType: returnType,
        arguments: arguments,
        documentation: documentation,
        extendedAttributes: extendedAttributes);
  }

  WebIdlDictionaryMember _dictionaryMember() {
    var documentation = _current.documentation;
    var extendedAttributes = _extendedAttributes();
    var isRequired = _acceptKeyword('required');
    var type = _type();
    var name = _identifier();
    if (_acceptSymbol('=')) {
      _next();
    }
    _expectSymbol(';');
    return WebIdlDictionaryMember(name,
        type: type,
        isRequired: isRequired,
        documentation: documentation,
        extendedAttributes: extendedAttributes);
  }

  List<WebIdlArgument> _arguments() {
    _expectSymbol('(');
    var arguments = <WebIdlArgument>[];
    if (_acceptSymbol(')')) return arguments;
    do {
      var extendedAttributes = _extendedAttributes();
      var isOptional = _acceptKeyword('optional');
      var type = _type();
      var name = _identifier();
      if (_acceptSymbol('=')) {
        _next();
      }
      arguments.add(WebIdlArgument(name,
          type: type,
          isOptional: isOptional,
          extendedAttributes: extendedAttributes));
    } while (_acceptSymbol(','));
    _expectSymbol(')');
    return arguments;
  }

  WebIdlType _type() {
    var extendedAttributes = _extendedAttributes();
    String name;
    var arguments = <WebIdlType>[];
    if (_acceptSymbol('(')) {
      name = 'union';
      do {
        arguments.add(_type());
      } while (_acceptKeyword('or'));
      _expectSymbol(')');
    } else {
      name = _identifier();
      if (name == 'unsigned' || name == 'unrestricted') {
        name = _identifier();
      }
      if (name == 'long' && _isKeyword('long')) {
        _next();
      }
      if (_acceptSymbol('<')) {
        do {
          arguments.add(_type());
        } while (_acceptSymbol(','));
        _expectSymbol('>');
      }
    }
    var isNullable = _acceptSymbol('?');
    return WebIdlType(name,
        arguments: arguments,
        isNullable: isNullable,
        extendedAttributes: extendedAttributes);
  }

  List<WebIdlExtendedAttribute> _extendedAttributes() {
    if (!_acceptSymbol('[')) return const [];
    var attributes = <WebIdlExtendedAttribute>[];
    do {
      var name = _identifier();
      Object? value;
      if (_acceptSymbol('=')) {
        if (_acceptSymbol('(')) {
          var values = <String>[];
          do {
            values.add(_next().value);
          } while (_acceptSymbol(','));
          _expectSymbol(')');
          value = values;
        } else {
          value = _next().value;
        }
      }
      attributes.add(WebIdlExtendedAttribute(name, value));
    } while (_acceptSymbol(','));
    _expectSymbol(']');
    return attributes;
  }
}
