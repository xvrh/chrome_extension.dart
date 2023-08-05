import 'dart:convert';

//TODO: convert html to markdown
String documentationComment(String documentation, {required int indent}) {
  documentation = convertHtmlToDartdoc(documentation);

  return _toComment(documentation, indent: indent);
}

String parameterDocumentation(String paramName, String documentation,
    {required int indent}) {
  return documentationComment('[$paramName] $documentation', indent: indent);
}

final _nonBreakingSpace = '\u00A0';
String _toComment(String? comment, {int indent = 0, int lineLength = 80}) {
  if (comment != null && comment.isNotEmpty) {
    var commentLines = <String>[];

    comment = comment
        .replaceAll('<br>', '\n')
        .replaceAll('<var>', '`')
        .replaceAll('</var>', '`')
        .replaceAll('<code>', '`')
        .replaceAll('</code>', '`')
        .replaceAll('<b>', '**')
        .replaceAll('</b>', '**');

    const docStarter = '/// ';
    var maxLineLength = lineLength - indent - docStarter.length;

    for (var hardLine in LineSplitter.split(comment)) {
      var currentLine = <String>[];
      var currentLineLength = 0;
      for (var word in hardLine.split(' ')) {
        if (currentLine.isEmpty ||
            currentLineLength + word.length < maxLineLength) {
          currentLineLength += word.length + (currentLine.isEmpty ? 0 : 1);
          currentLine.add(word);
        } else {
          commentLines.add(currentLine.join(' '));
          currentLine = [word];
          currentLineLength = word.length;
        }
      }
      if (currentLine.isNotEmpty) {
        commentLines.add(currentLine.join(' '));
      }
    }

    return commentLines
        .map((line) => line.replaceAll(_nonBreakingSpace, ' '))
        .map((line) => '${' ' * indent}$docStarter$line')
        .join('\n');
  } else {
    return '';
  }
}

String convertHtmlToDartdoc(String str) {
  str = str.replaceAll('<code>', '`');
  str = str.replaceAll('</code>', '`');

  str = str.replaceAll('<em>', '_');
  str = str.replaceAll('</em>', '_');

  str = str.replaceAll('<strong>', '*');
  str = str.replaceAll('</strong>', '*');

  str = str.replaceAll('<var>', '[');
  str = str.replaceAll('</var>', ']');

  str = str.replaceAll('&mdash;', '-');

  str = str.replaceAll('</p><p>', '\n\n');
  str = str.replaceAll('<p>', '');
  str = str.replaceAll('</p>', '');

  // $(ref:sessions) ==> [sessions]
  str = str.replaceAllMapped(
      RegExp(r"\$\(ref:([\.\w]*)\)"), (Match m) => "[${m.group(1)}]");

  // $ref:runtime.onConnect ==> [runtime.onConnect]
  str = str.replaceAllMapped(
      RegExp(r"\$ref:([\.\w]*)"), (Match m) => "[${m.group(1)}]");

  // <a href='content_scripts.html#pi'>programmatic injection</a> ==> [foo](url)
  str = str.replaceAllMapped(RegExp(r"""<a href=['"](\S*)['"]>([\w ]*)</a>"""),
      (Match m) => "[${m.group(2)}](${m.group(1)})");

  return str;
}
