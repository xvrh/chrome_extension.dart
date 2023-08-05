// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSOmniboxExtension on JSChrome {
  @JS('omnibox')
  external JSOmnibox? get omniboxNullable;

  /// The omnibox API allows you to register a keyword with Google Chrome's
  /// address bar, which is also known as the omnibox.
  JSOmnibox get omnibox {
    var omniboxNullable = this.omniboxNullable;
    if (omniboxNullable == null) {
      throw ApiNotAvailableException('chrome.omnibox');
    }
    return omniboxNullable;
  }
}

@JS()
@staticInterop
class JSOmnibox {}

extension JSOmniboxExtension on JSOmnibox {
  /// A callback passed to the onInputChanged event used for sending suggestions
  /// back to the browser.
  external void sendSuggestions(
    int requestId,

    /// An array of suggest results
    JSArray suggestResults,
  );

  /// Sets the description and styling for the default suggestion. The default
  /// suggestion is the text that is displayed in the first suggestion row
  /// underneath the URL bar.
  external JSPromise setDefaultSuggestion(

      /// A partial SuggestResult object, without the 'content' parameter.
      DefaultSuggestResult suggestion);

  /// User has started a keyword input session by typing the extension's
  /// keyword. This is guaranteed to be sent exactly once per input session, and
  /// before any onInputChanged events.
  external Event get onInputStarted;

  /// User has changed what is typed into the omnibox.
  external Event get onInputChanged;

  /// User has accepted what is typed into the omnibox.
  external Event get onInputEntered;

  /// User has ended the keyword input session without accepting the input.
  external Event get onInputCancelled;

  /// User has deleted a suggested result.
  external Event get onDeleteSuggestion;
}

/// The style type.
typedef DescriptionStyleType = String;

/// The window disposition for the omnibox query. This is the recommended
/// context to display results. For example, if the omnibox command is to
/// navigate to a certain URL, a disposition of 'newForegroundTab' means the
/// navigation should take place in a new selected tab.
typedef OnInputEnteredDisposition = String;

@JS()
@staticInterop
@anonymous
class MatchClassification {
  external factory MatchClassification({
    int offset,

    /// The style type
    DescriptionStyleType type,
    int? length,
  });
}

extension MatchClassificationExtension on MatchClassification {
  external int offset;

  /// The style type
  external DescriptionStyleType type;

  external int? length;
}

@JS()
@staticInterop
@anonymous
class SuggestResult {
  external factory SuggestResult({
    /// The text that is put into the URL bar, and that is sent to the extension
    /// when the user chooses this entry.
    String content,

    /// The text that is displayed in the URL dropdown. Can contain XML-style
    /// markup for styling. The supported tags are 'url' (for a literal URL),
    /// 'match' (for highlighting text that matched what the user's query), and
    /// 'dim' (for dim helper text). The styles can be nested, eg.
    /// <dim><match>dimmed match</match></dim>. You must escape the five
    /// predefined entities to display them as text:
    /// stackoverflow.com/a/1091953/89484
    String description,

    /// Whether the suggest result can be deleted by the user.
    bool? deletable,

    /// An array of style ranges for the description, as provided by the
    /// extension.
    JSArray? descriptionStyles,
  });
}

extension SuggestResultExtension on SuggestResult {
  /// The text that is put into the URL bar, and that is sent to the extension
  /// when the user chooses this entry.
  external String content;

  /// The text that is displayed in the URL dropdown. Can contain XML-style
  /// markup for styling. The supported tags are 'url' (for a literal URL),
  /// 'match' (for highlighting text that matched what the user's query), and
  /// 'dim' (for dim helper text). The styles can be nested, eg.
  /// <dim><match>dimmed match</match></dim>. You must escape the five
  /// predefined entities to display them as text:
  /// stackoverflow.com/a/1091953/89484
  external String description;

  /// Whether the suggest result can be deleted by the user.
  external bool? deletable;

  /// An array of style ranges for the description, as provided by the
  /// extension.
  external JSArray? descriptionStyles;
}

@JS()
@staticInterop
@anonymous
class DefaultSuggestResult {
  external factory DefaultSuggestResult({
    /// The text that is displayed in the URL dropdown. Can contain XML-style
    /// markup for styling. The supported tags are 'url' (for a literal URL),
    /// 'match' (for highlighting text that matched what the user's query), and
    /// 'dim' (for dim helper text). The styles can be nested, eg.
    /// <dim><match>dimmed match</match></dim>.
    String description,

    /// An array of style ranges for the description, as provided by the
    /// extension.
    JSArray? descriptionStyles,
  });
}

extension DefaultSuggestResultExtension on DefaultSuggestResult {
  /// The text that is displayed in the URL dropdown. Can contain XML-style
  /// markup for styling. The supported tags are 'url' (for a literal URL),
  /// 'match' (for highlighting text that matched what the user's query), and
  /// 'dim' (for dim helper text). The styles can be nested, eg.
  /// <dim><match>dimmed match</match></dim>.
  external String description;

  /// An array of style ranges for the description, as provided by the
  /// extension.
  external JSArray? descriptionStyles;
}
