// ignore_for_file: unnecessary_parenthesis

library;

import 'dart:js_util';
import 'input.dart';
import 'src/internal_helpers.dart';
import 'src/js/input_ime.dart' as $js;

export 'input.dart' show ChromeInput, ChromeInputExtension;
export 'src/chrome.dart' show chrome;

final _inputIme = ChromeInputIme._();

extension ChromeInputImeExtension on ChromeInput {
  /// Use the `chrome.input.ime` API to implement a custom IME for Chrome OS.
  /// This allows your extension to handle keystrokes, set the composition, and
  /// manage the candidate window.
  ChromeInputIme get ime => _inputIme;
}

class ChromeInputIme {
  ChromeInputIme._();

  bool get isAvailable =>
      $js.chrome.inputNullable?.imeNullable != null && alwaysTrue;

  /// Set the current composition. If this extension does not own the active
  /// IME, this fails.
  /// [returns] Called when the operation completes with a boolean indicating
  /// if the text was accepted or not. On failure, [runtime.lastError] is set.
  Future<bool> setComposition(SetCompositionParameters parameters) async {
    var $res = await promiseToFuture<bool>(
        $js.chrome.input.ime.setComposition(parameters.toJS));
    return $res;
  }

  /// Clear the current composition. If this extension does not own the active
  /// IME, this fails.
  /// [returns] Called when the operation completes with a boolean indicating
  /// if the text was accepted or not. On failure, [runtime.lastError] is set.
  Future<bool> clearComposition(ClearCompositionParameters parameters) async {
    var $res = await promiseToFuture<bool>(
        $js.chrome.input.ime.clearComposition(parameters.toJS));
    return $res;
  }

  /// Commits the provided text to the current input.
  /// [returns] Called when the operation completes with a boolean indicating
  /// if the text was accepted or not. On failure, [runtime.lastError] is set.
  Future<bool> commitText(CommitTextParameters parameters) async {
    var $res = await promiseToFuture<bool>(
        $js.chrome.input.ime.commitText(parameters.toJS));
    return $res;
  }

  /// Sends the key events.  This function is expected to be used by virtual
  /// keyboards.  When key(s) on a virtual keyboard is pressed by a user, this
  /// function is used to propagate that event to the system.
  /// [returns] Called when the operation completes.
  Future<void> sendKeyEvents(SendKeyEventsParameters parameters) async {
    await promiseToFuture<void>(
        $js.chrome.input.ime.sendKeyEvents(parameters.toJS));
  }

  /// Hides the input view window, which is popped up automatically by system.
  /// If the input view window is already hidden, this function will do nothing.
  void hideInputView() {
    $js.chrome.input.ime.hideInputView();
  }

  /// Sets the properties of the candidate window. This fails if the extension
  /// doesn't own the active IME
  /// [returns] Called when the operation completes.
  Future<bool> setCandidateWindowProperties(
      SetCandidateWindowPropertiesParameters parameters) async {
    var $res = await promiseToFuture<bool>(
        $js.chrome.input.ime.setCandidateWindowProperties(parameters.toJS));
    return $res;
  }

  /// Sets the current candidate list. This fails if this extension doesn't own
  /// the active IME
  /// [returns] Called when the operation completes.
  Future<bool> setCandidates(SetCandidatesParameters parameters) async {
    var $res = await promiseToFuture<bool>(
        $js.chrome.input.ime.setCandidates(parameters.toJS));
    return $res;
  }

  /// Set the position of the cursor in the candidate window. This is a no-op if
  /// this extension does not own the active IME.
  /// [returns] Called when the operation completes
  Future<bool> setCursorPosition(SetCursorPositionParameters parameters) async {
    var $res = await promiseToFuture<bool>(
        $js.chrome.input.ime.setCursorPosition(parameters.toJS));
    return $res;
  }

  /// Shows/Hides an assistive window with the given properties.
  /// [returns] Called when the operation completes.
  Future<bool> setAssistiveWindowProperties(
      SetAssistiveWindowPropertiesParameters parameters) async {
    var $res = await promiseToFuture<bool>(
        $js.chrome.input.ime.setAssistiveWindowProperties(parameters.toJS));
    return $res;
  }

  /// Highlights/Unhighlights a button in an assistive window.
  /// [returns] Called when the operation completes. On failure,
  /// [runtime.lastError] is set.
  Future<void> setAssistiveWindowButtonHighlighted(
      SetAssistiveWindowButtonHighlightedParameters parameters) async {
    await promiseToFuture<void>($js.chrome.input.ime
        .setAssistiveWindowButtonHighlighted(parameters.toJS));
  }

  /// Adds the provided menu items to the language menu when this IME is active.
  Future<void> setMenuItems(MenuParameters parameters) async {
    await promiseToFuture<void>(
        $js.chrome.input.ime.setMenuItems(parameters.toJS));
  }

  /// Updates the state of the MenuItems specified
  /// [returns] Called when the operation completes
  Future<void> updateMenuItems(MenuParameters parameters) async {
    await promiseToFuture<void>(
        $js.chrome.input.ime.updateMenuItems(parameters.toJS));
  }

  /// Deletes the text around the caret.
  /// [returns] Called when the operation completes.
  Future<void> deleteSurroundingText(
      DeleteSurroundingTextParameters parameters) async {
    await promiseToFuture<void>(
        $js.chrome.input.ime.deleteSurroundingText(parameters.toJS));
  }

  /// Indicates that the key event received by onKeyEvent is handled.  This
  /// should only be called if the onKeyEvent listener is asynchronous.
  /// [requestId] Request id of the event that was handled.  This should come
  /// from keyEvent.requestId
  /// [response] True if the keystroke was handled, false if not
  void keyEventHandled(
    String requestId,
    bool response,
  ) {
    $js.chrome.input.ime.keyEventHandled(
      requestId,
      response,
    );
  }

  /// This event is sent when an IME is activated. It signals that the IME will
  /// be receiving onKeyPress events.
  EventStream<OnActivateEvent> get onActivate =>
      $js.chrome.input.ime.onActivate.asStream(($c) => (
            String engineID,
            $js.ScreenType screen,
          ) {
            return $c(OnActivateEvent(
              engineId: engineID,
              screen: ScreenType.fromJS(screen),
            ));
          });

  /// This event is sent when an IME is deactivated. It signals that the IME
  /// will no longer be receiving onKeyPress events.
  EventStream<String> get onDeactivated =>
      $js.chrome.input.ime.onDeactivated.asStream(($c) => (String engineId) {
            return $c(engineId);
          });

  /// This event is sent when focus enters a text box. It is sent to all
  /// extensions that are listening to this event, and enabled by the user.
  EventStream<InputContext> get onFocus =>
      $js.chrome.input.ime.onFocus.asStream(($c) => ($js.InputContext context) {
            return $c(InputContext.fromJS(context));
          });

  /// This event is sent when focus leaves a text box. It is sent to all
  /// extensions that are listening to this event, and enabled by the user.
  EventStream<int> get onBlur =>
      $js.chrome.input.ime.onBlur.asStream(($c) => (int contextId) {
            return $c(contextId);
          });

  /// This event is sent when the properties of the current InputContext change,
  /// such as the the type. It is sent to all extensions that are listening to
  /// this event, and enabled by the user.
  EventStream<InputContext> get onInputContextUpdate =>
      $js.chrome.input.ime.onInputContextUpdate
          .asStream(($c) => ($js.InputContext context) {
                return $c(InputContext.fromJS(context));
              });

  /// Fired when a key event is sent from the operating system. The event will
  /// be sent to the extension if this extension owns the active IME. The
  /// listener function should return true if the event was handled false if it
  /// was not.  If the event will be evaluated asynchronously, this function
  /// must return undefined and the IME must later call keyEventHandled() with
  /// the result.
  EventStream<OnKeyEventEvent> get onKeyEvent =>
      $js.chrome.input.ime.onKeyEvent.asStream(($c) => (
            String engineID,
            $js.KeyboardEvent keyData,
            String requestId,
          ) {
            return $c(OnKeyEventEvent(
              engineId: engineID,
              keyData: KeyboardEvent.fromJS(keyData),
              requestId: requestId,
            ));
          });

  /// This event is sent if this extension owns the active IME.
  EventStream<OnCandidateClickedEvent> get onCandidateClicked =>
      $js.chrome.input.ime.onCandidateClicked.asStream(($c) => (
            String engineID,
            int candidateID,
            $js.MouseButton button,
          ) {
            return $c(OnCandidateClickedEvent(
              engineId: engineID,
              candidateId: candidateID,
              button: MouseButton.fromJS(button),
            ));
          });

  /// Called when the user selects a menu item
  EventStream<OnMenuItemActivatedEvent> get onMenuItemActivated =>
      $js.chrome.input.ime.onMenuItemActivated.asStream(($c) => (
            String engineID,
            String name,
          ) {
            return $c(OnMenuItemActivatedEvent(
              engineId: engineID,
              name: name,
            ));
          });

  /// Called when the editable string around caret is changed or when the caret
  /// position is moved. The text length is limited to 100 characters for each
  /// back and forth direction.
  EventStream<OnSurroundingTextChangedEvent> get onSurroundingTextChanged =>
      $js.chrome.input.ime.onSurroundingTextChanged.asStream(($c) => (
            String engineID,
            $js.OnSurroundingTextChangedSurroundingInfo surroundingInfo,
          ) {
            return $c(OnSurroundingTextChangedEvent(
              engineId: engineID,
              surroundingInfo: OnSurroundingTextChangedSurroundingInfo.fromJS(
                  surroundingInfo),
            ));
          });

  /// This event is sent when chrome terminates ongoing text input session.
  EventStream<String> get onReset =>
      $js.chrome.input.ime.onReset.asStream(($c) => (String engineId) {
            return $c(engineId);
          });

  /// This event is sent when a button in an assistive window is clicked.
  EventStream<OnAssistiveWindowButtonClickedDetails>
      get onAssistiveWindowButtonClicked =>
          $js.chrome.input.ime.onAssistiveWindowButtonClicked.asStream(
              ($c) => ($js.OnAssistiveWindowButtonClickedDetails details) {
                    return $c(
                        OnAssistiveWindowButtonClickedDetails.fromJS(details));
                  });
}

enum KeyboardEventType {
  keyup('keyup'),
  keydown('keydown');

  const KeyboardEventType(this.value);

  final String value;

  String get toJS => value;
  static KeyboardEventType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Type of value this text field edits, (Text, Number, URL, etc)
enum InputContextType {
  text('text'),
  search('search'),
  tel('tel'),
  url('url'),
  email('email'),
  number('number'),
  password('password'),
  null$('null');

  const InputContextType(this.value);

  final String value;

  String get toJS => value;
  static InputContextType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The auto-capitalize type of the text field.
enum AutoCapitalizeType {
  characters('characters'),
  words('words'),
  sentences('sentences');

  const AutoCapitalizeType(this.value);

  final String value;

  String get toJS => value;
  static AutoCapitalizeType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The type of menu item. Radio buttons between separators are considered
/// grouped.
enum MenuItemStyle {
  check('check'),
  radio('radio'),
  separator('separator');

  const MenuItemStyle(this.value);

  final String value;

  String get toJS => value;
  static MenuItemStyle fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The type of the underline to modify this segment.
enum UnderlineStyle {
  underline('underline'),
  doubleUnderline('doubleUnderline'),
  noUnderline('noUnderline');

  const UnderlineStyle(this.value);

  final String value;

  String get toJS => value;
  static UnderlineStyle fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Where to display the candidate window. If set to 'cursor', the window
/// follows the cursor. If set to 'composition', the window is locked to the
/// beginning of the composition.
enum WindowPosition {
  cursor('cursor'),
  composition('composition');

  const WindowPosition(this.value);

  final String value;

  String get toJS => value;
  static WindowPosition fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// The screen type under which the IME is activated.
enum ScreenType {
  normal('normal'),
  login('login'),
  lock('lock'),
  secondaryLogin('secondary-login');

  const ScreenType(this.value);

  final String value;

  String get toJS => value;
  static ScreenType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Which mouse buttons was clicked.
enum MouseButton {
  left('left'),
  middle('middle'),
  right('right');

  const MouseButton(this.value);

  final String value;

  String get toJS => value;
  static MouseButton fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// Type of assistive window.
enum AssistiveWindowType {
  undo('undo');

  const AssistiveWindowType(this.value);

  final String value;

  String get toJS => value;
  static AssistiveWindowType fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

/// ID of buttons in assistive window.
enum AssistiveWindowButton {
  undo('undo'),
  addToDictionary('addToDictionary');

  const AssistiveWindowButton(this.value);

  final String value;

  String get toJS => value;
  static AssistiveWindowButton fromJS(String value) =>
      values.firstWhere((e) => e.value == value);
}

class KeyboardEvent {
  KeyboardEvent.fromJS(this._wrapped);

  KeyboardEvent({
    /// One of keyup or keydown.
    required KeyboardEventType type,

    /// (Deprecated) The ID of the request. Use the `requestId` param from the
    /// `onKeyEvent` event instead.
    String? requestId,

    /// The extension ID of the sender of this keyevent.
    String? extensionId,

    /// Value of the key being pressed
    required String key,

    /// Value of the physical key being pressed. The value is not affected by
    /// current keyboard layout or modifier state.
    required String code,

    /// The deprecated HTML keyCode, which is system- and
    /// implementation-dependent numerical code signifying the unmodified
    /// identifier associated with the key pressed.
    int? keyCode,

    /// Whether or not the ALT key is pressed.
    bool? altKey,

    /// Whether or not the ALTGR key is pressed.
    bool? altgrKey,

    /// Whether or not the CTRL key is pressed.
    bool? ctrlKey,

    /// Whether or not the SHIFT key is pressed.
    bool? shiftKey,

    /// Whether or not the CAPS_LOCK is enabled.
    bool? capsLock,
  }) : _wrapped = $js.KeyboardEvent(
          type: type.toJS,
          requestId: requestId,
          extensionId: extensionId,
          key: key,
          code: code,
          keyCode: keyCode,
          altKey: altKey,
          altgrKey: altgrKey,
          ctrlKey: ctrlKey,
          shiftKey: shiftKey,
          capsLock: capsLock,
        );

  final $js.KeyboardEvent _wrapped;

  $js.KeyboardEvent get toJS => _wrapped;

  /// One of keyup or keydown.
  KeyboardEventType get type => KeyboardEventType.fromJS(_wrapped.type);
  set type(KeyboardEventType v) {
    _wrapped.type = v.toJS;
  }

  /// (Deprecated) The ID of the request. Use the `requestId` param from the
  /// `onKeyEvent` event instead.
  String? get requestId => _wrapped.requestId;
  set requestId(String? v) {
    _wrapped.requestId = v;
  }

  /// The extension ID of the sender of this keyevent.
  String? get extensionId => _wrapped.extensionId;
  set extensionId(String? v) {
    _wrapped.extensionId = v;
  }

  /// Value of the key being pressed
  String get key => _wrapped.key;
  set key(String v) {
    _wrapped.key = v;
  }

  /// Value of the physical key being pressed. The value is not affected by
  /// current keyboard layout or modifier state.
  String get code => _wrapped.code;
  set code(String v) {
    _wrapped.code = v;
  }

  /// The deprecated HTML keyCode, which is system- and implementation-dependent
  /// numerical code signifying the unmodified identifier associated with the
  /// key pressed.
  int? get keyCode => _wrapped.keyCode;
  set keyCode(int? v) {
    _wrapped.keyCode = v;
  }

  /// Whether or not the ALT key is pressed.
  bool? get altKey => _wrapped.altKey;
  set altKey(bool? v) {
    _wrapped.altKey = v;
  }

  /// Whether or not the ALTGR key is pressed.
  bool? get altgrKey => _wrapped.altgrKey;
  set altgrKey(bool? v) {
    _wrapped.altgrKey = v;
  }

  /// Whether or not the CTRL key is pressed.
  bool? get ctrlKey => _wrapped.ctrlKey;
  set ctrlKey(bool? v) {
    _wrapped.ctrlKey = v;
  }

  /// Whether or not the SHIFT key is pressed.
  bool? get shiftKey => _wrapped.shiftKey;
  set shiftKey(bool? v) {
    _wrapped.shiftKey = v;
  }

  /// Whether or not the CAPS_LOCK is enabled.
  bool? get capsLock => _wrapped.capsLock;
  set capsLock(bool? v) {
    _wrapped.capsLock = v;
  }
}

class InputContext {
  InputContext.fromJS(this._wrapped);

  InputContext({
    /// This is used to specify targets of text field operations.  This ID
    /// becomes invalid as soon as onBlur is called.
    required int contextId,

    /// Type of value this text field edits, (Text, Number, URL, etc)
    required InputContextType type,

    /// Whether the text field wants auto-correct.
    required bool autoCorrect,

    /// Whether the text field wants auto-complete.
    required bool autoComplete,

    /// The auto-capitalize type of the text field.
    required AutoCapitalizeType autoCapitalize,

    /// Whether the text field wants spell-check.
    required bool spellCheck,

    /// Whether text entered into the text field should be used to improve
    /// typing suggestions for the user.
    required bool shouldDoLearning,
  }) : _wrapped = $js.InputContext(
          contextID: contextId,
          type: type.toJS,
          autoCorrect: autoCorrect,
          autoComplete: autoComplete,
          autoCapitalize: autoCapitalize.toJS,
          spellCheck: spellCheck,
          shouldDoLearning: shouldDoLearning,
        );

  final $js.InputContext _wrapped;

  $js.InputContext get toJS => _wrapped;

  /// This is used to specify targets of text field operations.  This ID becomes
  /// invalid as soon as onBlur is called.
  int get contextId => _wrapped.contextID;
  set contextId(int v) {
    _wrapped.contextID = v;
  }

  /// Type of value this text field edits, (Text, Number, URL, etc)
  InputContextType get type => InputContextType.fromJS(_wrapped.type);
  set type(InputContextType v) {
    _wrapped.type = v.toJS;
  }

  /// Whether the text field wants auto-correct.
  bool get autoCorrect => _wrapped.autoCorrect;
  set autoCorrect(bool v) {
    _wrapped.autoCorrect = v;
  }

  /// Whether the text field wants auto-complete.
  bool get autoComplete => _wrapped.autoComplete;
  set autoComplete(bool v) {
    _wrapped.autoComplete = v;
  }

  /// The auto-capitalize type of the text field.
  AutoCapitalizeType get autoCapitalize =>
      AutoCapitalizeType.fromJS(_wrapped.autoCapitalize);
  set autoCapitalize(AutoCapitalizeType v) {
    _wrapped.autoCapitalize = v.toJS;
  }

  /// Whether the text field wants spell-check.
  bool get spellCheck => _wrapped.spellCheck;
  set spellCheck(bool v) {
    _wrapped.spellCheck = v;
  }

  /// Whether text entered into the text field should be used to improve typing
  /// suggestions for the user.
  bool get shouldDoLearning => _wrapped.shouldDoLearning;
  set shouldDoLearning(bool v) {
    _wrapped.shouldDoLearning = v;
  }
}

class MenuItem {
  MenuItem.fromJS(this._wrapped);

  MenuItem({
    /// String that will be passed to callbacks referencing this MenuItem.
    required String id,

    /// Text displayed in the menu for this item.
    String? label,

    /// The type of menu item.
    MenuItemStyle? style,

    /// Indicates this item is visible.
    bool? visible,

    /// Indicates this item should be drawn with a check.
    bool? checked,

    /// Indicates this item is enabled.
    bool? enabled,
  }) : _wrapped = $js.MenuItem(
          id: id,
          label: label,
          style: style?.toJS,
          visible: visible,
          checked: checked,
          enabled: enabled,
        );

  final $js.MenuItem _wrapped;

  $js.MenuItem get toJS => _wrapped;

  /// String that will be passed to callbacks referencing this MenuItem.
  String get id => _wrapped.id;
  set id(String v) {
    _wrapped.id = v;
  }

  /// Text displayed in the menu for this item.
  String? get label => _wrapped.label;
  set label(String? v) {
    _wrapped.label = v;
  }

  /// The type of menu item.
  MenuItemStyle? get style => _wrapped.style?.let(MenuItemStyle.fromJS);
  set style(MenuItemStyle? v) {
    _wrapped.style = v?.toJS;
  }

  /// Indicates this item is visible.
  bool? get visible => _wrapped.visible;
  set visible(bool? v) {
    _wrapped.visible = v;
  }

  /// Indicates this item should be drawn with a check.
  bool? get checked => _wrapped.checked;
  set checked(bool? v) {
    _wrapped.checked = v;
  }

  /// Indicates this item is enabled.
  bool? get enabled => _wrapped.enabled;
  set enabled(bool? v) {
    _wrapped.enabled = v;
  }
}

class AssistiveWindowProperties {
  AssistiveWindowProperties.fromJS(this._wrapped);

  AssistiveWindowProperties({
    required AssistiveWindowType type,

    /// Sets true to show AssistiveWindow, sets false to hide.
    required bool visible,

    /// Strings for ChromeVox to announce.
    String? announceString,
  }) : _wrapped = $js.AssistiveWindowProperties(
          type: type.toJS,
          visible: visible,
          announceString: announceString,
        );

  final $js.AssistiveWindowProperties _wrapped;

  $js.AssistiveWindowProperties get toJS => _wrapped;

  AssistiveWindowType get type => AssistiveWindowType.fromJS(_wrapped.type);
  set type(AssistiveWindowType v) {
    _wrapped.type = v.toJS;
  }

  /// Sets true to show AssistiveWindow, sets false to hide.
  bool get visible => _wrapped.visible;
  set visible(bool v) {
    _wrapped.visible = v;
  }

  /// Strings for ChromeVox to announce.
  String? get announceString => _wrapped.announceString;
  set announceString(String? v) {
    _wrapped.announceString = v;
  }
}

class MenuParameters {
  MenuParameters.fromJS(this._wrapped);

  MenuParameters({
    /// ID of the engine to use.
    required String engineId,

    /// MenuItems to add or update. They will be added in the order they exist
    /// in the array.
    required List<MenuItem> items,
  }) : _wrapped = $js.MenuParameters(
          engineID: engineId,
          items: items.toJSArray((e) => e.toJS),
        );

  final $js.MenuParameters _wrapped;

  $js.MenuParameters get toJS => _wrapped;

  /// ID of the engine to use.
  String get engineId => _wrapped.engineID;
  set engineId(String v) {
    _wrapped.engineID = v;
  }

  /// MenuItems to add or update. They will be added in the order they exist in
  /// the array.
  List<MenuItem> get items => _wrapped.items.toDart
      .cast<$js.MenuItem>()
      .map((e) => MenuItem.fromJS(e))
      .toList();
  set items(List<MenuItem> v) {
    _wrapped.items = v.toJSArray((e) => e.toJS);
  }
}

class OnSurroundingTextChangedSurroundingInfo {
  OnSurroundingTextChangedSurroundingInfo.fromJS(this._wrapped);

  OnSurroundingTextChangedSurroundingInfo({
    /// The text around the cursor. This is only a subset of all text in the
    /// input field.
    required String text,

    /// The ending position of the selection. This value indicates caret
    /// position if there is no selection.
    required int focus,

    /// The beginning position of the selection. This value indicates caret
    /// position if there is no selection.
    required int anchor,

    /// The offset position of `text`. Since `text` only includes a subset of
    /// text around the cursor, offset indicates the absolute position of the
    /// first character of `text`.
    required int offset,
  }) : _wrapped = $js.OnSurroundingTextChangedSurroundingInfo(
          text: text,
          focus: focus,
          anchor: anchor,
          offset: offset,
        );

  final $js.OnSurroundingTextChangedSurroundingInfo _wrapped;

  $js.OnSurroundingTextChangedSurroundingInfo get toJS => _wrapped;

  /// The text around the cursor. This is only a subset of all text in the input
  /// field.
  String get text => _wrapped.text;
  set text(String v) {
    _wrapped.text = v;
  }

  /// The ending position of the selection. This value indicates caret position
  /// if there is no selection.
  int get focus => _wrapped.focus;
  set focus(int v) {
    _wrapped.focus = v;
  }

  /// The beginning position of the selection. This value indicates caret
  /// position if there is no selection.
  int get anchor => _wrapped.anchor;
  set anchor(int v) {
    _wrapped.anchor = v;
  }

  /// The offset position of `text`. Since `text` only includes a subset of text
  /// around the cursor, offset indicates the absolute position of the first
  /// character of `text`.
  int get offset => _wrapped.offset;
  set offset(int v) {
    _wrapped.offset = v;
  }
}

class OnAssistiveWindowButtonClickedDetails {
  OnAssistiveWindowButtonClickedDetails.fromJS(this._wrapped);

  OnAssistiveWindowButtonClickedDetails({
    /// The ID of the button clicked.
    required AssistiveWindowButton buttonId,

    /// The type of the assistive window.
    required AssistiveWindowType windowType,
  }) : _wrapped = $js.OnAssistiveWindowButtonClickedDetails(
          buttonID: buttonId.toJS,
          windowType: windowType.toJS,
        );

  final $js.OnAssistiveWindowButtonClickedDetails _wrapped;

  $js.OnAssistiveWindowButtonClickedDetails get toJS => _wrapped;

  /// The ID of the button clicked.
  AssistiveWindowButton get buttonId =>
      AssistiveWindowButton.fromJS(_wrapped.buttonID);
  set buttonId(AssistiveWindowButton v) {
    _wrapped.buttonID = v.toJS;
  }

  /// The type of the assistive window.
  AssistiveWindowType get windowType =>
      AssistiveWindowType.fromJS(_wrapped.windowType);
  set windowType(AssistiveWindowType v) {
    _wrapped.windowType = v.toJS;
  }
}

class SetCompositionParameters {
  SetCompositionParameters.fromJS(this._wrapped);

  SetCompositionParameters({
    /// ID of the context where the composition text will be set
    required int contextId,

    /// Text to set
    required String text,

    /// Position in the text that the selection starts at.
    int? selectionStart,

    /// Position in the text that the selection ends at.
    int? selectionEnd,

    /// Position in the text of the cursor.
    required int cursor,

    /// List of segments and their associated types.
    List<SetCompositionParametersSegments>? segments,
  }) : _wrapped = $js.SetCompositionParameters(
          contextID: contextId,
          text: text,
          selectionStart: selectionStart,
          selectionEnd: selectionEnd,
          cursor: cursor,
          segments: segments?.toJSArray((e) => e.toJS),
        );

  final $js.SetCompositionParameters _wrapped;

  $js.SetCompositionParameters get toJS => _wrapped;

  /// ID of the context where the composition text will be set
  int get contextId => _wrapped.contextID;
  set contextId(int v) {
    _wrapped.contextID = v;
  }

  /// Text to set
  String get text => _wrapped.text;
  set text(String v) {
    _wrapped.text = v;
  }

  /// Position in the text that the selection starts at.
  int? get selectionStart => _wrapped.selectionStart;
  set selectionStart(int? v) {
    _wrapped.selectionStart = v;
  }

  /// Position in the text that the selection ends at.
  int? get selectionEnd => _wrapped.selectionEnd;
  set selectionEnd(int? v) {
    _wrapped.selectionEnd = v;
  }

  /// Position in the text of the cursor.
  int get cursor => _wrapped.cursor;
  set cursor(int v) {
    _wrapped.cursor = v;
  }

  /// List of segments and their associated types.
  List<SetCompositionParametersSegments>? get segments =>
      _wrapped.segments?.toDart
          .cast<$js.SetCompositionParametersSegments>()
          .map((e) => SetCompositionParametersSegments.fromJS(e))
          .toList();
  set segments(List<SetCompositionParametersSegments>? v) {
    _wrapped.segments = v?.toJSArray((e) => e.toJS);
  }
}

class ClearCompositionParameters {
  ClearCompositionParameters.fromJS(this._wrapped);

  ClearCompositionParameters(
      {
      /// ID of the context where the composition will be cleared
      required int contextId})
      : _wrapped = $js.ClearCompositionParameters(contextID: contextId);

  final $js.ClearCompositionParameters _wrapped;

  $js.ClearCompositionParameters get toJS => _wrapped;

  /// ID of the context where the composition will be cleared
  int get contextId => _wrapped.contextID;
  set contextId(int v) {
    _wrapped.contextID = v;
  }
}

class CommitTextParameters {
  CommitTextParameters.fromJS(this._wrapped);

  CommitTextParameters({
    /// ID of the context where the text will be committed
    required int contextId,

    /// The text to commit
    required String text,
  }) : _wrapped = $js.CommitTextParameters(
          contextID: contextId,
          text: text,
        );

  final $js.CommitTextParameters _wrapped;

  $js.CommitTextParameters get toJS => _wrapped;

  /// ID of the context where the text will be committed
  int get contextId => _wrapped.contextID;
  set contextId(int v) {
    _wrapped.contextID = v;
  }

  /// The text to commit
  String get text => _wrapped.text;
  set text(String v) {
    _wrapped.text = v;
  }
}

class SendKeyEventsParameters {
  SendKeyEventsParameters.fromJS(this._wrapped);

  SendKeyEventsParameters({
    /// ID of the context where the key events will be sent, or zero to send key
    /// events to non-input field.
    required int contextId,

    /// Data on the key event.
    required List<KeyboardEvent> keyData,
  }) : _wrapped = $js.SendKeyEventsParameters(
          contextID: contextId,
          keyData: keyData.toJSArray((e) => e.toJS),
        );

  final $js.SendKeyEventsParameters _wrapped;

  $js.SendKeyEventsParameters get toJS => _wrapped;

  /// ID of the context where the key events will be sent, or zero to send key
  /// events to non-input field.
  int get contextId => _wrapped.contextID;
  set contextId(int v) {
    _wrapped.contextID = v;
  }

  /// Data on the key event.
  List<KeyboardEvent> get keyData => _wrapped.keyData.toDart
      .cast<$js.KeyboardEvent>()
      .map((e) => KeyboardEvent.fromJS(e))
      .toList();
  set keyData(List<KeyboardEvent> v) {
    _wrapped.keyData = v.toJSArray((e) => e.toJS);
  }
}

class SetCandidateWindowPropertiesParameters {
  SetCandidateWindowPropertiesParameters.fromJS(this._wrapped);

  SetCandidateWindowPropertiesParameters({
    /// ID of the engine to set properties on.
    required String engineId,
    required SetCandidateWindowPropertiesParametersProperties properties,
  }) : _wrapped = $js.SetCandidateWindowPropertiesParameters(
          engineID: engineId,
          properties: properties.toJS,
        );

  final $js.SetCandidateWindowPropertiesParameters _wrapped;

  $js.SetCandidateWindowPropertiesParameters get toJS => _wrapped;

  /// ID of the engine to set properties on.
  String get engineId => _wrapped.engineID;
  set engineId(String v) {
    _wrapped.engineID = v;
  }

  SetCandidateWindowPropertiesParametersProperties get properties =>
      SetCandidateWindowPropertiesParametersProperties.fromJS(
          _wrapped.properties);
  set properties(SetCandidateWindowPropertiesParametersProperties v) {
    _wrapped.properties = v.toJS;
  }
}

class SetCandidatesParameters {
  SetCandidatesParameters.fromJS(this._wrapped);

  SetCandidatesParameters({
    /// ID of the context that owns the candidate window.
    required int contextId,

    /// List of candidates to show in the candidate window
    required List<SetCandidatesParametersCandidates> candidates,
  }) : _wrapped = $js.SetCandidatesParameters(
          contextID: contextId,
          candidates: candidates.toJSArray((e) => e.toJS),
        );

  final $js.SetCandidatesParameters _wrapped;

  $js.SetCandidatesParameters get toJS => _wrapped;

  /// ID of the context that owns the candidate window.
  int get contextId => _wrapped.contextID;
  set contextId(int v) {
    _wrapped.contextID = v;
  }

  /// List of candidates to show in the candidate window
  List<SetCandidatesParametersCandidates> get candidates =>
      _wrapped.candidates.toDart
          .cast<$js.SetCandidatesParametersCandidates>()
          .map((e) => SetCandidatesParametersCandidates.fromJS(e))
          .toList();
  set candidates(List<SetCandidatesParametersCandidates> v) {
    _wrapped.candidates = v.toJSArray((e) => e.toJS);
  }
}

class SetCursorPositionParameters {
  SetCursorPositionParameters.fromJS(this._wrapped);

  SetCursorPositionParameters({
    /// ID of the context that owns the candidate window.
    required int contextId,

    /// ID of the candidate to select.
    required int candidateId,
  }) : _wrapped = $js.SetCursorPositionParameters(
          contextID: contextId,
          candidateID: candidateId,
        );

  final $js.SetCursorPositionParameters _wrapped;

  $js.SetCursorPositionParameters get toJS => _wrapped;

  /// ID of the context that owns the candidate window.
  int get contextId => _wrapped.contextID;
  set contextId(int v) {
    _wrapped.contextID = v;
  }

  /// ID of the candidate to select.
  int get candidateId => _wrapped.candidateID;
  set candidateId(int v) {
    _wrapped.candidateID = v;
  }
}

class SetAssistiveWindowPropertiesParameters {
  SetAssistiveWindowPropertiesParameters.fromJS(this._wrapped);

  SetAssistiveWindowPropertiesParameters({
    /// ID of the context owning the assistive window.
    required int contextId,

    /// Properties of the assistive window.
    required AssistiveWindowProperties properties,
  }) : _wrapped = $js.SetAssistiveWindowPropertiesParameters(
          contextID: contextId,
          properties: properties.toJS,
        );

  final $js.SetAssistiveWindowPropertiesParameters _wrapped;

  $js.SetAssistiveWindowPropertiesParameters get toJS => _wrapped;

  /// ID of the context owning the assistive window.
  int get contextId => _wrapped.contextID;
  set contextId(int v) {
    _wrapped.contextID = v;
  }

  /// Properties of the assistive window.
  AssistiveWindowProperties get properties =>
      AssistiveWindowProperties.fromJS(_wrapped.properties);
  set properties(AssistiveWindowProperties v) {
    _wrapped.properties = v.toJS;
  }
}

class SetAssistiveWindowButtonHighlightedParameters {
  SetAssistiveWindowButtonHighlightedParameters.fromJS(this._wrapped);

  SetAssistiveWindowButtonHighlightedParameters({
    /// ID of the context owning the assistive window.
    required int contextId,

    /// The ID of the button
    required AssistiveWindowButton buttonId,

    /// The window type the button belongs to.
    required AssistiveWindowType windowType,

    /// The text for the screenreader to announce.
    String? announceString,

    /// Whether the button should be highlighted.
    required bool highlighted,
  }) : _wrapped = $js.SetAssistiveWindowButtonHighlightedParameters(
          contextID: contextId,
          buttonID: buttonId.toJS,
          windowType: windowType.toJS,
          announceString: announceString,
          highlighted: highlighted,
        );

  final $js.SetAssistiveWindowButtonHighlightedParameters _wrapped;

  $js.SetAssistiveWindowButtonHighlightedParameters get toJS => _wrapped;

  /// ID of the context owning the assistive window.
  int get contextId => _wrapped.contextID;
  set contextId(int v) {
    _wrapped.contextID = v;
  }

  /// The ID of the button
  AssistiveWindowButton get buttonId =>
      AssistiveWindowButton.fromJS(_wrapped.buttonID);
  set buttonId(AssistiveWindowButton v) {
    _wrapped.buttonID = v.toJS;
  }

  /// The window type the button belongs to.
  AssistiveWindowType get windowType =>
      AssistiveWindowType.fromJS(_wrapped.windowType);
  set windowType(AssistiveWindowType v) {
    _wrapped.windowType = v.toJS;
  }

  /// The text for the screenreader to announce.
  String? get announceString => _wrapped.announceString;
  set announceString(String? v) {
    _wrapped.announceString = v;
  }

  /// Whether the button should be highlighted.
  bool get highlighted => _wrapped.highlighted;
  set highlighted(bool v) {
    _wrapped.highlighted = v;
  }
}

class DeleteSurroundingTextParameters {
  DeleteSurroundingTextParameters.fromJS(this._wrapped);

  DeleteSurroundingTextParameters({
    /// ID of the engine receiving the event.
    required String engineId,

    /// ID of the context where the surrounding text will be deleted.
    required int contextId,

    /// The offset from the caret position where deletion will start. This value
    /// can be negative.
    required int offset,

    /// The number of characters to be deleted
    required int length,
  }) : _wrapped = $js.DeleteSurroundingTextParameters(
          engineID: engineId,
          contextID: contextId,
          offset: offset,
          length: length,
        );

  final $js.DeleteSurroundingTextParameters _wrapped;

  $js.DeleteSurroundingTextParameters get toJS => _wrapped;

  /// ID of the engine receiving the event.
  String get engineId => _wrapped.engineID;
  set engineId(String v) {
    _wrapped.engineID = v;
  }

  /// ID of the context where the surrounding text will be deleted.
  int get contextId => _wrapped.contextID;
  set contextId(int v) {
    _wrapped.contextID = v;
  }

  /// The offset from the caret position where deletion will start. This value
  /// can be negative.
  int get offset => _wrapped.offset;
  set offset(int v) {
    _wrapped.offset = v;
  }

  /// The number of characters to be deleted
  int get length => _wrapped.length;
  set length(int v) {
    _wrapped.length = v;
  }
}

class SetCompositionParametersSegments {
  SetCompositionParametersSegments.fromJS(this._wrapped);

  SetCompositionParametersSegments({
    /// Index of the character to start this segment at
    required int start,

    /// Index of the character to end this segment after.
    required int end,

    /// The type of the underline to modify this segment.
    required UnderlineStyle style,
  }) : _wrapped = $js.SetCompositionParametersSegments(
          start: start,
          end: end,
          style: style.toJS,
        );

  final $js.SetCompositionParametersSegments _wrapped;

  $js.SetCompositionParametersSegments get toJS => _wrapped;

  /// Index of the character to start this segment at
  int get start => _wrapped.start;
  set start(int v) {
    _wrapped.start = v;
  }

  /// Index of the character to end this segment after.
  int get end => _wrapped.end;
  set end(int v) {
    _wrapped.end = v;
  }

  /// The type of the underline to modify this segment.
  UnderlineStyle get style => UnderlineStyle.fromJS(_wrapped.style);
  set style(UnderlineStyle v) {
    _wrapped.style = v.toJS;
  }
}

class SetCandidateWindowPropertiesParametersProperties {
  SetCandidateWindowPropertiesParametersProperties.fromJS(this._wrapped);

  SetCandidateWindowPropertiesParametersProperties({
    /// True to show the Candidate window, false to hide it.
    bool? visible,

    /// True to show the cursor, false to hide it.
    bool? cursorVisible,

    /// True if the candidate window should be rendered vertical, false to make
    /// it horizontal.
    bool? vertical,

    /// The number of candidates to display per page.
    int? pageSize,

    /// Text that is shown at the bottom of the candidate window.
    String? auxiliaryText,

    /// True to display the auxiliary text, false to hide it.
    bool? auxiliaryTextVisible,

    /// The total number of candidates for the candidate window.
    int? totalCandidates,

    /// The index of the current chosen candidate out of total candidates.
    int? currentCandidateIndex,

    /// Where to display the candidate window.
    WindowPosition? windowPosition,
  }) : _wrapped = $js.SetCandidateWindowPropertiesParametersProperties(
          visible: visible,
          cursorVisible: cursorVisible,
          vertical: vertical,
          pageSize: pageSize,
          auxiliaryText: auxiliaryText,
          auxiliaryTextVisible: auxiliaryTextVisible,
          totalCandidates: totalCandidates,
          currentCandidateIndex: currentCandidateIndex,
          windowPosition: windowPosition?.toJS,
        );

  final $js.SetCandidateWindowPropertiesParametersProperties _wrapped;

  $js.SetCandidateWindowPropertiesParametersProperties get toJS => _wrapped;

  /// True to show the Candidate window, false to hide it.
  bool? get visible => _wrapped.visible;
  set visible(bool? v) {
    _wrapped.visible = v;
  }

  /// True to show the cursor, false to hide it.
  bool? get cursorVisible => _wrapped.cursorVisible;
  set cursorVisible(bool? v) {
    _wrapped.cursorVisible = v;
  }

  /// True if the candidate window should be rendered vertical, false to make it
  /// horizontal.
  bool? get vertical => _wrapped.vertical;
  set vertical(bool? v) {
    _wrapped.vertical = v;
  }

  /// The number of candidates to display per page.
  int? get pageSize => _wrapped.pageSize;
  set pageSize(int? v) {
    _wrapped.pageSize = v;
  }

  /// Text that is shown at the bottom of the candidate window.
  String? get auxiliaryText => _wrapped.auxiliaryText;
  set auxiliaryText(String? v) {
    _wrapped.auxiliaryText = v;
  }

  /// True to display the auxiliary text, false to hide it.
  bool? get auxiliaryTextVisible => _wrapped.auxiliaryTextVisible;
  set auxiliaryTextVisible(bool? v) {
    _wrapped.auxiliaryTextVisible = v;
  }

  /// The total number of candidates for the candidate window.
  int? get totalCandidates => _wrapped.totalCandidates;
  set totalCandidates(int? v) {
    _wrapped.totalCandidates = v;
  }

  /// The index of the current chosen candidate out of total candidates.
  int? get currentCandidateIndex => _wrapped.currentCandidateIndex;
  set currentCandidateIndex(int? v) {
    _wrapped.currentCandidateIndex = v;
  }

  /// Where to display the candidate window.
  WindowPosition? get windowPosition =>
      _wrapped.windowPosition?.let(WindowPosition.fromJS);
  set windowPosition(WindowPosition? v) {
    _wrapped.windowPosition = v?.toJS;
  }
}

class SetCandidatesParametersCandidates {
  SetCandidatesParametersCandidates.fromJS(this._wrapped);

  SetCandidatesParametersCandidates({
    /// The candidate
    required String candidate,

    /// The candidate's id
    required int id,

    /// The id to add these candidates under
    int? parentId,

    /// Short string displayed to next to the candidate, often the shortcut key
    /// or index
    String? label,

    /// Additional text describing the candidate
    String? annotation,

    /// The usage or detail description of word.
    SetCandidatesParametersCandidatesUsage? usage,
  }) : _wrapped = $js.SetCandidatesParametersCandidates(
          candidate: candidate,
          id: id,
          parentId: parentId,
          label: label,
          annotation: annotation,
          usage: usage?.toJS,
        );

  final $js.SetCandidatesParametersCandidates _wrapped;

  $js.SetCandidatesParametersCandidates get toJS => _wrapped;

  /// The candidate
  String get candidate => _wrapped.candidate;
  set candidate(String v) {
    _wrapped.candidate = v;
  }

  /// The candidate's id
  int get id => _wrapped.id;
  set id(int v) {
    _wrapped.id = v;
  }

  /// The id to add these candidates under
  int? get parentId => _wrapped.parentId;
  set parentId(int? v) {
    _wrapped.parentId = v;
  }

  /// Short string displayed to next to the candidate, often the shortcut key or
  /// index
  String? get label => _wrapped.label;
  set label(String? v) {
    _wrapped.label = v;
  }

  /// Additional text describing the candidate
  String? get annotation => _wrapped.annotation;
  set annotation(String? v) {
    _wrapped.annotation = v;
  }

  /// The usage or detail description of word.
  SetCandidatesParametersCandidatesUsage? get usage =>
      _wrapped.usage?.let(SetCandidatesParametersCandidatesUsage.fromJS);
  set usage(SetCandidatesParametersCandidatesUsage? v) {
    _wrapped.usage = v?.toJS;
  }
}

class SetCandidatesParametersCandidatesUsage {
  SetCandidatesParametersCandidatesUsage.fromJS(this._wrapped);

  SetCandidatesParametersCandidatesUsage({
    /// The title string of details description.
    required String title,

    /// The body string of detail description.
    required String body,
  }) : _wrapped = $js.SetCandidatesParametersCandidatesUsage(
          title: title,
          body: body,
        );

  final $js.SetCandidatesParametersCandidatesUsage _wrapped;

  $js.SetCandidatesParametersCandidatesUsage get toJS => _wrapped;

  /// The title string of details description.
  String get title => _wrapped.title;
  set title(String v) {
    _wrapped.title = v;
  }

  /// The body string of detail description.
  String get body => _wrapped.body;
  set body(String v) {
    _wrapped.body = v;
  }
}

class OnActivateEvent {
  OnActivateEvent({
    required this.engineId,
    required this.screen,
  });

  /// ID of the engine receiving the event
  final String engineId;

  /// The screen type under which the IME is activated.
  final ScreenType screen;
}

class OnKeyEventEvent {
  OnKeyEventEvent({
    required this.engineId,
    required this.keyData,
    required this.requestId,
  });

  /// ID of the engine receiving the event
  final String engineId;

  /// Data on the key event
  final KeyboardEvent keyData;

  /// ID of the request. If the event listener returns undefined, then
  /// `keyEventHandled` must be called later with this `requestId`.
  final String requestId;
}

class OnCandidateClickedEvent {
  OnCandidateClickedEvent({
    required this.engineId,
    required this.candidateId,
    required this.button,
  });

  /// ID of the engine receiving the event
  final String engineId;

  /// ID of the candidate that was clicked.
  final int candidateId;

  /// Which mouse buttons was clicked.
  final MouseButton button;
}

class OnMenuItemActivatedEvent {
  OnMenuItemActivatedEvent({
    required this.engineId,
    required this.name,
  });

  /// ID of the engine receiving the event
  final String engineId;

  /// Name of the MenuItem which was activated
  final String name;
}

class OnSurroundingTextChangedEvent {
  OnSurroundingTextChangedEvent({
    required this.engineId,
    required this.surroundingInfo,
  });

  /// ID of the engine receiving the event
  final String engineId;

  /// The surrounding information.
  final OnSurroundingTextChangedSurroundingInfo surroundingInfo;
}
