import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsi/models/blogs_models.dart';
import 'package:responsi/service/wrapper.dart';

class BlogsController {
  final Wrapper _wrapper;
  BlogsController(this._wrapper);

  Future<List<BlogsModels>> getBlogs() async {
    final response = await _wrapper.fetchBlogs();

    if (response.statusCode != 200) {
      throw Exception("Gagal Fetch");
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic> articleData = data['results'];

    return articleData.map((e) => BlogsModels.fromJson(e)).toList();
  }
}

class BlogsView extends ChangeNotifier {
  final BlogsController _controller;
  BlogsView(this._controller);

  bool isLoading = false;
  List<BlogsModels> blogs = [];

  Future<void> getBlogs() async {
    isLoading = true;
    notifyListeners();

    try {
      blogs = await _controller.getBlogs();
    } catch (e) {
      throw Exception("Gagal Load Artikel: $e");
    }
  }
}
