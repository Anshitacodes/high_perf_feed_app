import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Map post;
  final VoidCallback onLike;

  const PostCard({super.key, required this.post, required this.onLike});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width.toInt();

    return RepaintBoundary(
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 25,
              color: Colors.black26,
              offset: Offset(0, 10),
            )
          ],
        ),
        child: Column(
          children: [
            Hero(
              tag: post['id'],
              child: Image.network(
                post['media_thumb_url'],
                cacheWidth: width, // ✅ RAM safe
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Likes: ${post['like_count'] ?? 0}"),
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: post['liked'] == true
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: onLike,
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