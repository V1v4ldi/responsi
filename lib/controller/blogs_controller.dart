import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsi/models/articles_models.dart';
import 'package:responsi/service/wrapper.dart';

class BlogsController {
  final Wrapper _wrapper;
  BlogsController(this._wrapper);

  Future<List<ArticlesModels>> getBlogs() async {
    final response = await _wrapper.fetchBlogs();

    if (response.statusCode != 200) {
      throw Exception("Gagal Fetch");
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    final blogData = data['results'] as List;

    return blogData.map((e) => ArticlesModels.fromJson(e)).toList();
  }
}

class BlogsView extends ChangeNotifier {
  final BlogsController _controller;
  BlogsView(this._controller);

  bool isLoading = false;
  List<ArticlesModels> blogs = [];

  Future<void> getBlogs() async {
    isLoading = true;
    notifyListeners();

    try {
      blogs = await _controller.getBlogs();
    } catch (e) {
      throw Exception("Gagal Load Blog: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
