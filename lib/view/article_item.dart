import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsi/controller/bookmark_controller.dart';
import 'package:responsi/models/articles_models.dart';
import 'package:responsi/view/detail.dart';

class ArticleItem extends StatelessWidget {
  final ArticlesModels article;

  const ArticleItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = context.watch<BookmarkView>();
    final isBookmarked = bookmarkProvider.isBookmarked(article);

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
           Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Detail(article: article),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                 article.imgUrl,
                 width: double.infinity,
                 fit: BoxFit.fitWidth,
                 errorBuilder: (_,__,___) => const SizedBox(height: 150),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.newsSite,
                    style: TextStyle(
                      color: Colors.red[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          article.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          isBookmarked ? Icons.favorite : Icons.favorite_border,
                          color: isBookmarked ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          final controller = Provider.of<BookmarkView>(context, listen: false);
                          controller.toggleBookmark(article);

                          String text = isBookmarked 
                              ? "Dihapus dari Bookmark" 
                              : "Ditambahkan ke Bookmark";
                              
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(text),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  Text(
                    article.summary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}