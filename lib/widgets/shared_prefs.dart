import 'package:shared_preferences/shared_preferences.dart';

class BookmarkStorage {
  static const _bookmarkKey = 'bookmarkedImages';

  static Future<void> saveBookmarks(Set<String> bookmarks) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_bookmarkKey, bookmarks.toList());
  }

  static Future<Set<String>> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList(_bookmarkKey);
    return bookmarks?.toSet() ?? {};
  }
}
