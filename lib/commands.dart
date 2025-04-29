// ignore_for_file: unnecessary_parenthesis, unintended_html_in_doc_comment

library;

import 'src/internal_helpers.dart';
import 'src/js/commands.dart' as $js;
import 'src/js/tabs.dart' as $js_tabs;
import 'tabs.dart';

export 'src/chrome.dart' show chrome, EventStream;

final _commands = ChromeCommands._();

extension ChromeCommandsExtension on Chrome {
  /// Use the commands API to add keyboard shortcuts that trigger actions in
  /// your extension, for example, an action to open the browser action or send
  /// a command to the extension.
  ChromeCommands get commands => _commands;
}

class ChromeCommands {
  ChromeCommands._();

  bool get isAvailable => $js.chrome.commandsNullable != null && alwaysTrue;

  /// Returns all the registered extension commands for this extension and their
  /// shortcut (if active). Before Chrome 110, this command did not return
  /// `_execute_action`.
  /// [returns] Called to return the registered commands.
  Future<List<Command>> getAll() async {
    var result = await $js.chrome.commands.getAll().toDart;
    final dartified = result.dartify() as List? ?? [];
    return dartified
        .map<Command>((e) => Command.fromJS(e as $js.Command))
        .toList();
  }

  /// Fired when a registered command is activated using a keyboard shortcut.
  EventStream<OnCommandEvent> get onCommand =>
      $js.chrome.commands.onCommand.asStream(
        ($c) =>
            (String command, $js_tabs.Tab? tab) {
              return $c(
                OnCommandEvent(command: command, tab: tab?.let(Tab.fromJS)),
              );
            }.toJS,
      );
}

class Command {
  Command.fromJS(this._wrapped);

  Command({
    /// The name of the Extension Command
    String? name,

    /// The Extension Command description
    String? description,

    /// The shortcut active for this command, or blank if not active.
    String? shortcut,
  }) : _wrapped = $js.Command(
         name: name,
         description: description,
         shortcut: shortcut,
       );

  final $js.Command _wrapped;

  $js.Command get toJS => _wrapped;

  /// The name of the Extension Command
  String? get name => _wrapped.name;

  set name(String? v) {
    _wrapped.name = v;
  }

  /// The Extension Command description
  String? get description => _wrapped.description;

  set description(String? v) {
    _wrapped.description = v;
  }

  /// The shortcut active for this command, or blank if not active.
  String? get shortcut => _wrapped.shortcut;

  set shortcut(String? v) {
    _wrapped.shortcut = v;
  }
}

class OnCommandEvent {
  OnCommandEvent({required this.command, required this.tab});

  final String command;

  final Tab? tab;
}
