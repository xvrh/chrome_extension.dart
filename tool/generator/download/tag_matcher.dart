/// A [RegExp]-based matcher that can find attributes and contents of given tags
/// in html or other markup.
class TagMatcher implements Pattern {
  static const _tagString = 'TAG';
  static const _tagTemplate = '<$_tagString([^>]*)?>(.*?)</$_tagString>';
  final _attributeMatcher = RegExp('([^ ]*?)="(.*?)"');
  final RegExp _regExp;

  static final anyTag = TagMatcher('.*?');
  static final olMatcher = TagMatcher('ol');
  static final liMatcher = TagMatcher('li');
  static final aMatcher = TagMatcher('a');
  static final spanMatcher = TagMatcher('span');

  TagMatcher(String tagName)
      : _regExp =
            RegExp(_tagTemplate.replaceAll(_tagString, tagName), dotAll: true);

  @override
  Match matchAsPrefix(String string, [int start = 0]) =>
      _regExp.matchAsPrefix(string, start)!;

  @override
  Iterable<Match> allMatches(String string, [int start = 0]) =>
      _regExp.allMatches(string, start);

  /// Given a string of html or xml, find all attributes for each tag matched by
  /// this [TagMatcher]. Each tag's attributes are given as a [Map].
  Iterable<Map<String, String>> allAttributes(String string, [int start = 0]) {
    var attributesList = <Map<String, String>>[];
    _regExp.allMatches(string, start).forEach((match) {
      var allAttributes = match.group(1)!;
      attributesList.add(_makeAttributesMap(allAttributes));
    });
    return attributesList;
  }

  /// Given a string of html or other markup, find all of the contents of the
  /// matching tags. For example, given the html '<div>foo</div><div>bar</div>',
  /// calling this on a [TagMatcher] matching the div tag should return
  /// ['foo','bar'].
  Iterable<String> allContents(String string, [int start = 0]) =>
      _regExp.allMatches(string, start).map((match) => match.group(2)!);

  Map<String, String> _makeAttributesMap(String allAttributes) => {
        for (var match in _attributeMatcher.allMatches(allAttributes))
          match.group(1)!: match.group(2)!
      };
}
