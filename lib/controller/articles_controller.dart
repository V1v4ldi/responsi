import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsi/models/articles_models.dart';
import 'package:responsi/service/wrapper.dart';

class ArticlesController {
  final Wrapper _wrapper;
  ArticlesController(this._wrapper);

  Future<List<ArticlesModels>> getArticles() async {
    final response = await _wrapper.fetchArticles();

    if (response.statusCode != 200) {
      throw Exception("Gagal Fetch");
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    final articleData = data['results'] as List;

    return articleData.map((e) => ArticlesModels.fromJson(e)).toList();
  }
}

class ArticlesView extends ChangeNotifier {
  final ArticlesController _controller;
  ArticlesView(this._controller);

  bool isLoading = false;
  List<ArticlesModels> articles = [];

  Future<void> getArticles() async {
    isLoading = true;
    notifyListeners();

    try {
      articles = await _controller.getArticles();
    } catch (e) {
      throw Exception("Gagal Load Artikel: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
