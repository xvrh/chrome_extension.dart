import 'package:chrome_extension/bookmarks.dart';

// ---- example

// lib/main.dart
void main() {
  var service = ChromeBookmarkService();
  runApp(MyExtensionPopup(service));
}

class ChromeBookmarkService implements BookmarkService {
  @override
  Future<List<Bookmark>> getBookmarks() async {
    // Real implementation using chrome.bookmarks
    return (await chrome.bookmarks.getTree()).map(Bookmark.new).toList();
  }
}

// ----

abstract class BookmarkService {
  Future<List<Bookmark>> getBookmarks();
}

void runApp(widget) {}

class MyExtensionPopup {
  MyExtensionPopup(service);
}

class FakeServiceForDesktop {}

class Bookmark {
  Bookmark(tree);
}
