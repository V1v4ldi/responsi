import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsi/controller/bookmark_controller.dart';
import 'package:responsi/view/article_item.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarkView = context.watch<BookmarkView>();
    final bookmarks = bookmarkView.bookmarks;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmark Saya"),
      ),
      body: bookmarks.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text("Belum ada artikel yang disimpan", style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final article = bookmarks[index];
                // Kita pakai widget yang sama dengan Home!
                return ArticleItem(article: article);
              },
            ),
    );
  }
}