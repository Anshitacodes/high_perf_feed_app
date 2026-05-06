import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'feed_provider.dart';
import '../detail/detail_screen.dart';
import 'post_card.dart';
class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(feedProvider.notifier).fetchPosts();
    });

    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        ref.read(feedProvider.notifier).fetchPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(feedProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Feed")),
      body: posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                await ref
                    .read(feedProvider.notifier)
                    .fetchPosts(refresh: true);
              },
              child: ListView.builder(
                controller: controller,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(post: post),
                        ),
                      );
                    },
                    child: PostCard(
                      post: post,
                      onLike: () async {
                        try {
                          await ref
                              .read(feedProvider.notifier)
                              .toggleLike(index);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Failed to like post")),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}