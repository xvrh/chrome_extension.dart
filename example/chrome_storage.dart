import 'package:chrome_extension/storage.dart';

void main() async {
  await chrome.storage.local.set({'mykey': 'value'});
  var values = await chrome.storage.local.get(null /* all */);
  print(values['mykey']);
}
