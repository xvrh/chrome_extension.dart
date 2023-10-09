import 'package:chrome_extension/power.dart';

void main() {
  chrome.power.requestKeepAwake(Level.display);
}
