import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/providers/app_providers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/ui_widgets.dart';
import '../../../../shared/models/app_models.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(feedProvider);

    return ScreenScaffold(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Community Feed', style: Theme.of(context).textTheme.displayMedium),
              ),
              IconButton(
                onPressed: () => context.push('/feed/create'),
                icon: const Icon(Icons.add_box_outlined),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Share brews, compare roast styles, and learn from other coffee people.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.72)),
          ),
          const SizedBox(height: 20),
          ...posts.map(
            (post) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppTheme.coffee.withValues(alpha: 0.2),
                          child: Text(post.author.substring(0, 1)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post.author, style: Theme.of(context).textTheme.titleMedium),
                              Text(post.handle, style: TextStyle(color: Colors.white.withValues(alpha: 0.6))),
                            ],
                          ),
                        ),
                        Text(
                          DateFormat('MMM d').format(post.createdAt),
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.imageHint, style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 8),
                          Text(post.caption, style: TextStyle(color: Colors.white.withValues(alpha: 0.76), height: 1.45)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: [
                        Chip(label: Text(post.brewMethod)),
                        Chip(label: Text(post.roastTag)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => ref.read(feedProvider.notifier).toggleLike(post.id),
                          icon: Icon(post.liked ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: post.liked ? AppTheme.danger : null),
                        ),
                        Text('${post.likes}'),
                        IconButton(
                          onPressed: () => context.push('/feed/post/${post.id}'),
                          icon: const Icon(Icons.mode_comment_outlined),
                        ),
                        Text('${post.commentsCount}'),
                        IconButton(
                          onPressed: () => ref.read(feedProvider.notifier).toggleSave(post.id),
                          icon: Icon(post.saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Share sheet would open here.')),
                          ),
                          icon: const Icon(Icons.share_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final _caption = TextEditingController();
  final _brewMethod = TextEditingController(text: 'Pour Over');
  final _roastTag = TextEditingController(text: 'Light roast');

  @override
  void dispose() {
    _caption.dispose();
    _brewMethod.dispose();
    _roastTag.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);

    return ScreenScaffold(
      title: 'Create Post',
      child: GlassCard(
        child: Column(
          children: [
            TextField(
              controller: _caption,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Caption'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _brewMethod,
              decoration: const InputDecoration(labelText: 'Brew method'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _roastTag,
              decoration: const InputDecoration(labelText: 'Roast tag'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(feedProvider.notifier).addPost(
                      FeedPost(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        author: user?.name ?? 'RoastLab User',
                        handle: '@${(user?.name ?? 'roastlab').toLowerCase().replaceAll(' ', '')}',
                        caption: _caption.text.trim(),
                        brewMethod: _brewMethod.text.trim(),
                        roastTag: _roastTag.text.trim(),
                        likes: 0,
                        commentsCount: 0,
                        saved: false,
                        liked: false,
                        imageHint: 'Fresh brew notes',
                        createdAt: DateTime.now(),
                        comments: const [],
                      ),
                    );
                context.go('/feed');
              },
              child: const Text('Publish post'),
            ),
          ],
        ),
      ),
    );
  }
}

class PostDetailScreen extends ConsumerStatefulWidget {
  const PostDetailScreen({super.key, required this.postId});

  final String postId;

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  final _comment = TextEditingController();

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(feedProvider.notifier);
    final post = controller.getById(widget.postId);
    if (post == null) {
      return const ScreenScaffold(title: 'Post Detail', child: Text('Post not found'));
    }

    return ScreenScaffold(
      title: 'Post Detail',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.author, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(post.caption, style: TextStyle(color: Colors.white.withValues(alpha: 0.76), height: 1.45)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const SectionTitle(
            title: 'Comments',
            subtitle: 'Brew notes, questions, and suggestions.',
          ),
          const SizedBox(height: 12),
          ...post.comments.map(
            (comment) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment.author, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 6),
                    Text(comment.message),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _comment,
            decoration: InputDecoration(
              labelText: 'Write a comment',
              suffixIcon: IconButton(
                onPressed: () {
                  if (_comment.text.trim().isEmpty) return;
                  ref.read(feedProvider.notifier).addComment(
                        widget.postId,
                        CommentModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          author: ref.read(authProvider)?.name ?? 'You',
                          message: _comment.text.trim(),
                          createdAt: DateTime.now(),
                        ),
                      );
                  setState(() => _comment.clear());
                },
                icon: const Icon(Icons.send_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
