import 'src/internal_helpers.dart';

final _chromeInput = ChromeInput._();

extension ChromeInputExtension on Chrome {
  ChromeInput get input => _chromeInput;
}

class ChromeInput {
  ChromeInput._();
}
