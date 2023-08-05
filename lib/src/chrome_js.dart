import 'dart:js_interop';

export 'js/events.dart' show Event;

@JS()
external JSChrome get chrome;

@JS()
@staticInterop
class JSChrome {}

class ApiNotAvailableException implements Exception {
  final String name;

  ApiNotAvailableException(this.name);

  @override
  String toString() => 'ApiNotAvailableException: $name is not available. '
      'Check that the manifest contains the correct permissions.';
}
