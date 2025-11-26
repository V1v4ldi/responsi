import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsi/models/articles_models.dart';
import 'package:responsi/service/wrapper.dart';

class ReportsController {
  final Wrapper _wrapper;
  ReportsController(this._wrapper);

  Future<List<ArticlesModels>> getReports() async {
    final response = await _wrapper.fetchReports();

    if (response.statusCode != 200) {
      throw Exception("Gagal Fetch");
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    final articleData = data['results'] as List;

    return articleData.map((e) => ArticlesModels.fromJson(e)).toList();
  }
}

class ReportView extends ChangeNotifier {
  final ReportsController _controller;
  ReportView(this._controller);

  bool isLoading = false;
  List<ArticlesModels> reports = [];

  Future<void> getReports() async {
    isLoading = true;
    notifyListeners();

    try {
      reports = await _controller.getReports();
    } catch (e) {
      throw Exception("Gagal Load Report: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
