import 'package:checks/checks.dart';
import 'package:chrome_apis/system_display.dart';
import 'package:test/test.dart';
import '../../runner/runner_client.dart';

void main() => setup(_tests);

void _tests(TestContext context) {
  test('getInfo', () async {
    chrome.system.display.enableUnifiedDesktop(true);
    var units = await chrome.system.display.getInfo(null);
    var unit = units.first;
    check(units).length.isGreaterOrEqual(1);
    check(unit.name).isNotNull();
    check(unit.id).isNotNull();
    check(unit.displayZoomFactor).isGreaterOrEqual(0);
    check(unit.bounds.width).isGreaterOrEqual(0);
    check(unit.bounds.height).isGreaterOrEqual(0);
    check(unit.bounds.top).isGreaterOrEqual(0);
    check(unit.bounds.left).isGreaterOrEqual(0);
    check(unit.workArea).isNotNull();
    check(unit.dpiX).isNotNull();
    check(unit.dpiY).isNotNull();
    check(unit.hasAccelerometerSupport).isNotNull();
    check(unit.hasTouchSupport).isNotNull();
    check(unit.availableDisplayZoomFactors).isNotNull();
  });
}
