import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsi/controller/articles_controller.dart';
import 'package:responsi/models/articles_models.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(
        () => Provider.of<ArticlesView>(
          context,
          listen: false,
        ).getArticles(),
      );
    return _HomeContent();
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final view = context.watch<ArticlesView>();
    return Scaffold(
      appBar: AppBar(title: Text("Selamat Datang User")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Builder(
          builder: (_) {
            if (view.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.red),
              );
            }
            return ListView(children: [
              _ArticleSection(title: "News", result: view.articles)
            ],);
          },
        ),
      ),
    );
  }
}

class _ArticleSection extends StatelessWidget {
  final String title;
  final List<ArticlesModels> result;

  const _ArticleSection({required this.title, required this.result});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}