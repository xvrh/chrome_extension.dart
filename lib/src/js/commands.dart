// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_import

library;

import 'dart:js_interop';
import 'chrome.dart';

export 'chrome.dart';

extension JSChromeJSCommandsExtension on JSChrome {
  @JS('commands')
  external JSCommands? get commandsNullable;

  /// Use the commands API to add keyboard shortcuts that trigger actions in
  /// your extension, for example, an action to open the browser action or send
  /// a command to the extension.
  JSCommands get commands {
    var commandsNullable = this.commandsNullable;
    if (commandsNullable == null) {
      throw ApiNotAvailableException('chrome.commands');
    }
    return commandsNullable;
  }
}

@JS()
@staticInterop
class JSCommands {}

extension JSCommandsExtension on JSCommands {
  /// Returns all the registered extension commands for this extension and their
  /// shortcut (if active).
  external JSPromise getAll();

  /// Fired when a registered command is activated using a keyboard shortcut.
  external Event get onCommand;
}

@JS()
@staticInterop
@anonymous
class Command {
  external factory Command({
    /// The name of the Extension Command
    String? name,

    /// The Extension Command description
    String? description,

    /// The shortcut active for this command, or blank if not active.
    String? shortcut,
  });
}

extension CommandExtension on Command {
  /// The name of the Extension Command
  external String? name;

  /// The Extension Command description
  external String? description;

  /// The shortcut active for this command, or blank if not active.
  external String? shortcut;
}
