// ---- example

// lib/main_desktop.dart
void main() {
  // Inject a fake service that doesn't use the real chrome_extension package.
  var service = FakeBookmarkService();
  runApp(MyExtensionPopup(service));
}

abstract class BookmarkService {
  Future<List<Bookmark>> getBookmarks();
}

class FakeBookmarkService implements BookmarkService {
  @override
  Future<List<Bookmark>> getBookmarks() async => [Bookmark()];
}

// ----

void runApp(widget) {}

class MyExtensionPopup {
  MyExtensionPopup(service);
}

class FakeServiceForDesktop {}

class Bookmark {}
