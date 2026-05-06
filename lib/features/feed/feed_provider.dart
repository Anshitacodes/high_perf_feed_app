import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/supabase_client.dart';
final feedProvider =
    StateNotifierProvider<FeedNotifier, List<Map<String, dynamic>>>(
  (ref) => FeedNotifier(),
);

class FeedNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  FeedNotifier() : super([]);

  int page = 0;
  final int limit = 10;
  bool isLoading = false;

  Set<String> likingPosts = {};

  Future<void> fetchPosts({bool refresh = false}) async {
    if (isLoading) return;
    isLoading = true;

    if (refresh) {
      page = 0;
      state = [];
    }

    final data = await supabase
        .from('posts')
        .select()
        .order('created_at', ascending: false)
        .range(page * limit, (page + 1) * limit - 1);

    state = [...state, ...List<Map<String, dynamic>>.from(data)];
    page++;

    isLoading = false;
  }

  Future<void> toggleLike(int index) async {
    final post = state[index];
    final postId = post['id'];

    final isLiked = post['liked'] == true;
    final currentLikes = post['like_count'] ?? 0;

    final updatedPost = {
      ...post,
      'liked': !isLiked,
      'like_count': isLiked ? currentLikes - 1 : currentLikes + 1,
    };

    // Optimistic UI
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) updatedPost else state[i]
    ];

    // Prevent API spam
    if (likingPosts.contains(postId)) return;
    likingPosts.add(postId);

    try {
      await supabase.rpc('toggle_like', params: {
        'post_id': postId,
        'user_id': 'user_123',
      });
    } catch (e) {
      // revert UI if failed
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index) post else state[i]
      ];
      rethrow; // for snackbar
    }

    await Future.delayed(const Duration(milliseconds: 300));
    likingPosts.remove(postId);
  }
}