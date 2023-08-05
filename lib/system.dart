import 'src/internal_helpers.dart';

final _chromeSystem = ChromeSystem._();

extension ChromeSystemExtension on Chrome {
  ChromeSystem get system => _chromeSystem;
}

class ChromeSystem {
  ChromeSystem._();
}
