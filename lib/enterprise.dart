import 'src/internal_helpers.dart';

final _chromeEnterprise = ChromeEnterprise._();

extension ChromeEnterpriseExtension on Chrome {
  ChromeEnterprise get enterprise => _chromeEnterprise;
}

class ChromeEnterprise {
  ChromeEnterprise._();
}
