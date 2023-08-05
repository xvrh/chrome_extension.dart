String capitalize(String word) {
  if (word.isEmpty) return word;

  return replaceAt(word, 0, transformer: (s) => s.toUpperCase());
}

String replaceAt(String input, int startIndex,
    {int? endIndex, required String Function(String) transformer}) {
  endIndex ??= startIndex + 1;

  if (startIndex < 0) throw RangeError.value(startIndex);
  if (startIndex > endIndex) throw RangeError.value(startIndex);
  if (endIndex > input.length) throw RangeError.value(endIndex);

  var before = input.substring(0, startIndex);
  var toReplace = input.substring(startIndex, endIndex);
  var after = input.substring(endIndex);

  var replace = transformer(toReplace);
  return '$before$replace$after';
}

// Following recommendation from Dart style guide
// https://dart.dev/effective-dart/style#do-capitalize-acronyms-and-abbreviations-longer-than-two-letters-like-words
const wordsToKeepInUppercase = ['UI', 'IO'];

String lowerCamel(Iterable<String> input) {
  return _mapWithIndex<String, String>(input, (word, index) {
    if (index > 0) {
      if (!wordsToKeepInUppercase.contains(word)) {
        word = word.toLowerCase();
      }
      return capitalize(word);
    } else {
      return word.toLowerCase();
    }
  }).join('');
}

String upperCamel(Iterable<String> input) {
  return input.map((word) {
    if (!wordsToKeepInUppercase.contains(word)) {
      word = word.toLowerCase();
    }
    return capitalize(word);
  }).join('');
}

String lowerHyphen(Iterable<String> input) {
  return input.map((s) => s.toLowerCase()).join('-');
}

String snakeCase(Iterable<String> input) {
  return input.map((s) => s.toLowerCase()).join('_');
}

Iterable<T> _mapWithIndex<E, T>(
    Iterable<E> collection, T Function(E, int) f) sync* {
  var index = 0;
  for (var element in collection) {
    yield f(element, index);
    ++index;
  }
}
