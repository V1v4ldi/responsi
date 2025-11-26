import 'package:flutter/material.dart';
import 'package:responsi/models/articles_models.dart';

class BookmarkView extends ChangeNotifier {
  final List<ArticlesModels> _bookmarks = [];
  
  List<ArticlesModels> get bookmarks => _bookmarks;

  bool isBookmarked(ArticlesModels article) {
    return _bookmarks.any((item) => item.id == article.id);
  }

  void toggleBookmark(ArticlesModels article) {
    if (isBookmarked(article)) {
      _bookmarks.removeWhere((item) => item.id == article.id);
    } else {
      _bookmarks.add(article);
    }
    notifyListeners();
  }
}