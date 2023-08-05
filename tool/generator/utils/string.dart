import 'string/case_format.dart' as f;
import 'string/split_words.dart';

extension StringExtensions on String {
  String get lowerCamel => f.lowerCamel(splitWords(this));
  String get upperCamel => f.upperCamel(splitWords(this));
  String get snakeCase => f.snakeCase(splitWords(this));
}
