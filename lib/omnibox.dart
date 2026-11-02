// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'src/internal_helpers.dart';
import 'src/js/omnibox.dart' as $js;

export 'src/chrome.dart' show chrome, EventStream;

final _omnibox = ChromeOmnibox._();

extension ChromeOmniboxExtension on Chrome {
  /// The omnibox API allows you to register a keyword with Google Chrome's
  /// address bar, which is also known as the omnibox.
  ChromeOmnibox get omnibox => _omnibox;
}

class ChromeOmnibox {
  ChromeOmnibox._();

  bool get isAvailable => $js.chrome.omniboxNullable != null && alwaysTrue;

  /// A callback passed to the onInputChanged event used for sending suggestions
  /// back to the browser.
  /// [suggestResults] An array of suggest results
  void sendSuggestions(
    int requestId,
    List<SuggestResult> suggestResults,
  ) {
    $js.chrome.omnibox.sendSuggestions(
      requestId,
      suggestResults.toJSArray((e) => e.toJS),
    );
  }

  /// Sets the description and styling for the default suggestion. The default
  /// suggestion is the text that is displayed in the first suggestion row
  /// underneath the URL bar.
  /// [suggestion] A partial SuggestResult object, without the 'content'
  /// parameter.
  Future<void> setDefaultSuggestion(DefaultSuggestResult suggestion) async {
    await $js.chrome.omnibox.setDefaultSuggestion(suggestion.toJS).toDart;
  }

  /// User has started a keyword input session by typing the extension's
  /// keyword. This is guaranteed to be sent exactly once per input session, and
  /// before any onInputChanged events.
  EventStream<void> get onInputStarted =>
      $js.chrome.omnibox.onInputStarted.asStream(($c) => () {
            return $c(null);
          }.toJS);

  /// User has changed what is typed into the omnibox.
  EventStream<OnInputChangedEvent> get onInputChanged =>
      $js.chrome.omnibox.onInputChanged.asStream(($c) => (
            String text,
            JSFunction suggest,
          ) {
            return $c(OnInputChangedEvent(
              text: text,
              suggest: suggest,
            ));
          }.toJS);

  /// User has accepted what is typed into the omnibox.
  EventStream<OnInputEnteredEvent> get onInputEntered =>
      $js.chrome.omnibox.onInputEntered.asStream(($c) => (
            String text,
            $js.OnInputEnteredDisposition disposition,
          ) {
            return $c(OnInputEnteredEvent(
              text: text,
              disposition: OnInputEnteredDisposition.fromJS(disposition),
            ));
          }.toJS);

  /// User has ended the keyword input session without accepting the input.
  EventStream<void> get onInputCancelled =>
      $js.chrome.omnibox.onInputCancelled.asStream(($c) => () {
            return $c(null);
          }.toJS);

  /// User has deleted a suggested result.
  EventStream<String> get onDeleteSuggestion =>
      $js.chrome.omnibox.onDeleteSuggestion.asStream(($c) => (String text) {
            return $c(text);
          }.toJS);

  /// User has selected an action attached to a suggested result by pressing the
  /// corresponding button in the Omnibox.
  EventStream<ActionExecution> get onActionExecuted =>
      $js.chrome.omnibox.onActionExecuted
          .asStream(($c) => ($js.ActionExecution actionExecution) {
                return $c(ActionExecution.fromJS(actionExecution));
              }.toJS);
}

/// The style type.
enum DescriptionStyleType {
  url('url'),
  match('match'),
  dim('dim');

  const DescriptionStyleType(this.value);

  final String value;

  JSString get toJS => value.toJS;

  static DescriptionStyleType fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

/// The window disposition for the omnibox query. This is the recommended
/// context to display results. For example, if the omnibox command is to
/// navigate to a certain URL, a disposition of 'newForegroundTab' means the
/// navigation should take place in a new selected tab.
enum OnInputEnteredDisposition {
  currentTab('currentTab'),
  newForegroundTab('newForegroundTab'),
  newBackgroundTab('newBackgroundTab');

  const OnInputEnteredDisposition(this.value);

  final String value;

  JSString get toJS => value.toJS;

  static OnInputEnteredDisposition fromJS(JSString value) {
    var dartValue = value.toDart;
    return values.firstWhere((e) => e.value == dartValue);
  }
}

class MatchClassification {
  MatchClassification.fromJS(this._wrapped);

  MatchClassification({
    required int offset,

    /// The style type
    required DescriptionStyleType type,
    int? length,
  }) : _wrapped = $js.MatchClassification(
          offset: offset,
          type: type.toJS,
          length: length,
        );

  final $js.MatchClassification _wrapped;

  $js.MatchClassification get toJS => _wrapped;

  int get offset => _wrapped.offset;

  set offset(int v) {
    _wrapped.offset = v;
  }

  /// The style type
  DescriptionStyleType get type => DescriptionStyleType.fromJS(_wrapped.type);

  set type(DescriptionStyleType v) {
    _wrapped.type = v.toJS;
  }

  int? get length => _wrapped.length;

  set length(int? v) {
    _wrapped.length = v;
  }
}

class Action {
  Action.fromJS(this._wrapped);

  Action({
    /// The string sent to the extension in the event corresponding to the user
    /// clicking on the action.
    required String name,

    /// The action button label.
    required String label,

    /// The action button hover tooltip text.
    required String tooltipText,

    /// The icon shown in the action button on the leading side of the  action
    /// label. The icon must be specified as an imageData object. The size
    /// should not be more than 160 px wide and tall.
    Map? icon,
  }) : _wrapped = $js.Action(
          name: name,
          label: label,
          tooltipText: tooltipText,
          icon: icon?.jsify(),
        );

  final $js.Action _wrapped;

  $js.Action get toJS => _wrapped;

  /// The string sent to the extension in the event corresponding to the user
  /// clicking on the action.
  String get name => _wrapped.name;

  set name(String v) {
    _wrapped.name = v;
  }

  /// The action button label.
  String get label => _wrapped.label;

  set label(String v) {
    _wrapped.label = v;
  }

  /// The action button hover tooltip text.
  String get tooltipText => _wrapped.tooltipText;

  set tooltipText(String v) {
    _wrapped.tooltipText = v;
  }

  /// The icon shown in the action button on the leading side of the  action
  /// label. The icon must be specified as an imageData object. The size should
  /// not be more than 160 px wide and tall.
  Map? get icon => _wrapped.icon?.toDartMap();

  set icon(Map? v) {
    _wrapped.icon = v?.jsify();
  }
}

class SuggestResult {
  SuggestResult.fromJS(this._wrapped);

  SuggestResult({
    /// The text that is put into the URL bar, and that is sent to the extension
    /// when the user chooses this entry.
    required String content,

    /// The text that is displayed in the URL dropdown. Can contain XML-style
    /// markup for styling. The supported tags are 'url' (for a literal URL),
    /// 'match' (for highlighting text that matched what the user's query), and
    /// 'dim' (for dim helper text). The styles can be nested, eg.
    /// <dim><match>dimmed match</match></dim>. You must escape the five
    /// predefined entities to display them as text:
    /// stackoverflow.com/a/1091953/89484
    required String description,

    /// Whether the suggest result can be deleted by the user.
    bool? deletable,

    /// An array of style ranges for the description, as provided by the
    /// extension.
    List<MatchClassification>? descriptionStyles,

    /// An array of actions attached to the suggestion. Only supported for
    /// suggestions added in unscoped mode.
    List<Action>? actions,

    /// An icon shown on the leading edge of the suggestion in the omnibox
    /// dropdown. Only supported for suggestions added in unscoped mode.
    String? iconUrl,
  }) : _wrapped = $js.SuggestResult(
          content: content,
          description: description,
          deletable: deletable,
          descriptionStyles: descriptionStyles?.toJSArray((e) => e.toJS),
          actions: actions?.toJSArray((e) => e.toJS),
          iconUrl: iconUrl,
        );

  final $js.SuggestResult _wrapped;

  $js.SuggestResult get toJS => _wrapped;

  /// The text that is put into the URL bar, and that is sent to the extension
  /// when the user chooses this entry.
  String get content => _wrapped.content;

  set content(String v) {
    _wrapped.content = v;
  }

  /// The text that is displayed in the URL dropdown. Can contain XML-style
  /// markup for styling. The supported tags are 'url' (for a literal URL),
  /// 'match' (for highlighting text that matched what the user's query), and
  /// 'dim' (for dim helper text). The styles can be nested, eg.
  /// <dim><match>dimmed match</match></dim>. You must escape the five
  /// predefined entities to display them as text:
  /// stackoverflow.com/a/1091953/89484
  String get description => _wrapped.description;

  set description(String v) {
    _wrapped.description = v;
  }

  /// Whether the suggest result can be deleted by the user.
  bool? get deletable => _wrapped.deletable;

  set deletable(bool? v) {
    _wrapped.deletable = v;
  }

  /// An array of style ranges for the description, as provided by the
  /// extension.
  List<MatchClassification>? get descriptionStyles =>
      _wrapped.descriptionStyles?.toDart
          .cast<$js.MatchClassification>()
          .map((e) => MatchClassification.fromJS(e))
          .toList();

  set descriptionStyles(List<MatchClassification>? v) {
    _wrapped.descriptionStyles = v?.toJSArray((e) => e.toJS);
  }

  /// An array of actions attached to the suggestion. Only supported for
  /// suggestions added in unscoped mode.
  List<Action>? get actions => _wrapped.actions?.toDart
      .cast<$js.Action>()
      .map((e) => Action.fromJS(e))
      .toList();

  set actions(List<Action>? v) {
    _wrapped.actions = v?.toJSArray((e) => e.toJS);
  }

  /// An icon shown on the leading edge of the suggestion in the omnibox
  /// dropdown. Only supported for suggestions added in unscoped mode.
  String? get iconUrl => _wrapped.iconUrl;

  set iconUrl(String? v) {
    _wrapped.iconUrl = v;
  }
}

class DefaultSuggestResult {
  DefaultSuggestResult.fromJS(this._wrapped);

  DefaultSuggestResult({
    /// The text that is displayed in the URL dropdown. Can contain XML-style
    /// markup for styling. The supported tags are 'url' (for a literal URL),
    /// 'match' (for highlighting text that matched what the user's query), and
    /// 'dim' (for dim helper text). The styles can be nested, eg.
    /// <dim><match>dimmed match</match></dim>.
    required String description,

    /// An array of style ranges for the description, as provided by the
    /// extension.
    List<MatchClassification>? descriptionStyles,
  }) : _wrapped = $js.DefaultSuggestResult(
          description: description,
          descriptionStyles: descriptionStyles?.toJSArray((e) => e.toJS),
        );

  final $js.DefaultSuggestResult _wrapped;

  $js.DefaultSuggestResult get toJS => _wrapped;

  /// The text that is displayed in the URL dropdown. Can contain XML-style
  /// markup for styling. The supported tags are 'url' (for a literal URL),
  /// 'match' (for highlighting text that matched what the user's query), and
  /// 'dim' (for dim helper text). The styles can be nested, eg.
  /// <dim><match>dimmed match</match></dim>.
  String get description => _wrapped.description;

  set description(String v) {
    _wrapped.description = v;
  }

  /// An array of style ranges for the description, as provided by the
  /// extension.
  List<MatchClassification>? get descriptionStyles =>
      _wrapped.descriptionStyles?.toDart
          .cast<$js.MatchClassification>()
          .map((e) => MatchClassification.fromJS(e))
          .toList();

  set descriptionStyles(List<MatchClassification>? v) {
    _wrapped.descriptionStyles = v?.toJSArray((e) => e.toJS);
  }
}

class ActionExecution {
  ActionExecution.fromJS(this._wrapped);

  ActionExecution({
    /// The name of the action the user selected, as defined by the `action`
    /// field in `Action`.
    required String actionName,

    /// The text of the suggestion corresponding to the action, as shown in the
    /// Omnibox. The same as the `SuggestResult.content`.
    required String content,
  }) : _wrapped = $js.ActionExecution(
          actionName: actionName,
          content: content,
        );

  final $js.ActionExecution _wrapped;

  $js.ActionExecution get toJS => _wrapped;

  /// The name of the action the user selected, as defined by the `action` field
  /// in `Action`.
  String get actionName => _wrapped.actionName;

  set actionName(String v) {
    _wrapped.actionName = v;
  }

  /// The text of the suggestion corresponding to the action, as shown in the
  /// Omnibox. The same as the `SuggestResult.content`.
  String get content => _wrapped.content;

  set content(String v) {
    _wrapped.content = v;
  }
}

class OnInputChangedEvent {
  OnInputChangedEvent({
    required this.text,
    required this.suggest,
  });

  final String text;

  /// A callback passed to the onInputChanged event used for sending suggestions
  /// back to the browser.
  final JSFunction suggest;
}

class OnInputEnteredEvent {
  OnInputEnteredEvent({
    required this.text,
    required this.disposition,
  });

  final String text;

  final OnInputEnteredDisposition disposition;
}
