import 'package:chrome_extension/tabs.dart';

void main() async {
  var tabs = await chrome.tabs.query(QueryInfo(
    active: true,
    currentWindow: true,
  ));
  print(tabs.first.title);
}
