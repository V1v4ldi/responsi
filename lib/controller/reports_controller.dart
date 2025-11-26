import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsi/models/reports_models.dart';
import 'package:responsi/service/wrapper.dart';

class ReportsController {
  final Wrapper _wrapper;
  ReportsController(this._wrapper);

  Future<List<ReportsModels>> getReports() async {
    final response = await _wrapper.fetchReports();

    if (response.statusCode != 200) {
      throw Exception("Gagal Fetch");
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic> articleData = data['results'];

    return articleData.map((e) => ReportsModels.fromJson(e)).toList();
  }
}

class ReportView extends ChangeNotifier {
  final ReportsController _controller;
  ReportView(this._controller);

  bool isLoading = false;
  List<ReportsModels> reports = [];

  Future<void> getReports() async {
    isLoading = true;
    notifyListeners();

    try {
      reports = await _controller.getReports();
    } catch (e) {
      throw Exception("Gagal Load Artikel: $e");
    }
  }
}
