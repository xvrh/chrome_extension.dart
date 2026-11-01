import 'dart:js_interop';

export 'js/events.dart' show Event;

@JS()
external JSChrome get chrome;

extension type JSChrome._(JSObject _) implements JSObject {}

class ApiNotAvailableException implements Exception {
  final String name;

  ApiNotAvailableException(this.name);

  @override
  String toString() => 'ApiNotAvailableException: $name is not available. '
      'Check that the manifest contains the correct permissions.';
}
