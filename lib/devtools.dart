import 'src/internal_helpers.dart';

final _chromeDevtools = ChromeDevtools._();

extension ChromeDevtoolsExtension on Chrome {
  ChromeDevtools get devtools => _chromeDevtools;
}

class ChromeDevtools {
  ChromeDevtools._();
}
