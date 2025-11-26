import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsi/controller/articles_controller.dart';
import 'package:responsi/controller/blogs_controller.dart';
import 'package:responsi/controller/reports_controller.dart';
import 'package:responsi/models/articles_models.dart';
import 'package:responsi/view/article_item.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final articlesInfo = Provider.of<ArticlesView>(context, listen: false);
      final blogsInfo = Provider.of<BlogsView>(context, listen: false);
      final reportsInfo = Provider.of<ReportView>(context, listen: false);
      
      articlesInfo.getArticles();
      blogsInfo.getBlogs();
      reportsInfo.getReports();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Space Flight News")),
      body: Column(
        children: [
          const SizedBox(height: 16),
          _buildCategoryButtons(),
          const SizedBox(height: 16),
          Expanded(child: _buildSelectedContent()),
        ],
      ),
    );
  }

  Widget _buildCategoryButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _menuButton("News", 0),
        const SizedBox(width: 10),
        _menuButton("Blogs", 1),
        const SizedBox(width: 10),
        _menuButton("Reports", 2),
      ],
    );
  }

  Widget _menuButton(String text, int index) {
    bool isActive = _selectedIndex == index;
    return ElevatedButton(
      onPressed: () => setState(() => _selectedIndex = index),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.blue : Colors.grey[300],
        foregroundColor: isActive ? Colors.white : Colors.black,
      ),
      child: Text(text),
    );
  }

  Widget _buildSelectedContent() {
    final articleView = context.watch<ArticlesView>();
    final blogsView = context.watch<BlogsView>();
    final reportsView = context.watch<ReportView>();

    switch (_selectedIndex) {
      case 0:
        return _ContentList(
          isLoading: articleView.isLoading,
          data: articleView.articles,
          emptyMessage: "Belum ada berita news.",
        );
      case 1:
        return _ContentList(
          isLoading: blogsView.isLoading,
          data: blogsView.blogs, 
          emptyMessage: "Belum ada blog.",
        );
      case 2: // Tampilkan Reports
        return _ContentList(
          isLoading: reportsView.isLoading,
          data: reportsView.reports, 
          emptyMessage: "Belum ada report.",
        );
      default:
        return const SizedBox();
    }
  }
}

class _ContentList extends StatelessWidget {
  final bool isLoading;
  final List<ArticlesModels> data;
  final String emptyMessage;

  const _ContentList({
    required this.isLoading,
    required this.data,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (data.isEmpty) {
      return Center(child: Text(emptyMessage));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return ArticleItem(article: item);
      },
    );
  }
}