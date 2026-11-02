// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import
// ignore_for_file: unintended_html_in_doc_comment

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

extension type JSOmnibox._(JSObject _) {
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

  /// User has selected an action attached to a suggested result by pressing the
  /// corresponding button in the Omnibox.
  external Event get onActionExecuted;
}

/// The style type.
typedef DescriptionStyleType = JSString;

/// The window disposition for the omnibox query. This is the recommended
/// context to display results. For example, if the omnibox command is to
/// navigate to a certain URL, a disposition of 'newForegroundTab' means the
/// navigation should take place in a new selected tab.
typedef OnInputEnteredDisposition = JSString;
extension type MatchClassification._(JSObject _) implements JSObject {
  external factory MatchClassification({
    int offset,

    /// The style type
    DescriptionStyleType type,
    int? length,
  });

  external int offset;

  /// The style type
  external DescriptionStyleType type;

  external int? length;
}
extension type Action._(JSObject _) implements JSObject {
  external factory Action({
    /// The string sent to the extension in the event corresponding to the user
    /// clicking on the action.
    String name,

    /// The action button label.
    String label,

    /// The action button hover tooltip text.
    String tooltipText,

    /// The icon shown in the action button on the leading side of the  action
    /// label. The icon must be specified as an imageData object. The size should
    /// not be more than 160 px wide and tall.
    JSAny? icon,
  });

  /// The string sent to the extension in the event corresponding to the user
  /// clicking on the action.
  external String name;

  /// The action button label.
  external String label;

  /// The action button hover tooltip text.
  external String tooltipText;

  /// The icon shown in the action button on the leading side of the  action
  /// label. The icon must be specified as an imageData object. The size should
  /// not be more than 160 px wide and tall.
  external JSAny? icon;
}
extension type SuggestResult._(JSObject _) implements JSObject {
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

    /// An array of actions attached to the suggestion. Only supported for
    /// suggestions added in unscoped mode.
    JSArray? actions,

    /// An icon shown on the leading edge of the suggestion in the omnibox
    /// dropdown. Only supported for suggestions added in unscoped mode.
    String? iconUrl,
  });

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

  /// An array of actions attached to the suggestion. Only supported for
  /// suggestions added in unscoped mode.
  external JSArray? actions;

  /// An icon shown on the leading edge of the suggestion in the omnibox
  /// dropdown. Only supported for suggestions added in unscoped mode.
  external String? iconUrl;
}
extension type DefaultSuggestResult._(JSObject _) implements JSObject {
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
extension type ActionExecution._(JSObject _) implements JSObject {
  external factory ActionExecution({
    /// The name of the action the user selected, as defined by the `action` field
    /// in `Action`.
    String actionName,

    /// The text of the suggestion corresponding to the action, as shown in the
    /// Omnibox. The same as the `SuggestResult.content`.
    String content,
  });

  /// The name of the action the user selected, as defined by the `action` field
  /// in `Action`.
  external String actionName;

  /// The text of the suggestion corresponding to the action, as shown in the
  /// Omnibox. The same as the `SuggestResult.content`.
  external String content;
}
