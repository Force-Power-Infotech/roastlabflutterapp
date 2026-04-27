import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../../core/providers/app_providers.dart';
import '../../../../core/widgets/ui_widgets.dart';
import '../../../../shared/models/app_models.dart';

class LearnVideosScreen extends ConsumerStatefulWidget {
  const LearnVideosScreen({super.key});

  @override
  ConsumerState<LearnVideosScreen> createState() => _LearnVideosScreenState();
}

class _LearnVideosScreenState extends ConsumerState<LearnVideosScreen> {
  late YoutubePlayerController _controller;
  String _category = 'Brewing';

  @override
  void initState() {
    super.initState();
    final video = MockVideoState.initialVideo(ref);
    _controller = YoutubePlayerController.fromVideoId(
      videoId: video.youtubeId,
      autoPlay: false,
      params: const YoutubePlayerParams(showControls: true, showFullscreenButton: true),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videos = ref.watch(videosProvider);
    final selected = ref.watch(selectedVideoProvider) ?? videos.first;
    final categories = videos.map((video) => video.category).toSet().toList();
    final filtered = videos.where((video) => video.category == _category).toList();

    return ScreenScaffold(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Learn Videos', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 8),
          Text(
            'Curated brewing, roasting, latte art, grinder, and beginner lessons.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.72)),
          ),
          const SizedBox(height: 20),
          GlassCard(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: YoutubePlayer(controller: _controller, aspectRatio: 16 / 9),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(selected.title, style: Theme.of(context).textTheme.titleLarge),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(selected.description),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = categories[index];
                return ChoiceChip(
                  label: Text(category),
                  selected: category == _category,
                  onSelected: (_) => setState(() => _category = category),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          ...filtered.map(
            (video) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GlassCard(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    ref.read(selectedVideoProvider.notifier).state = video;
                    _controller.loadVideoById(videoId: video.youtubeId);
                  },
                  title: Text(video.title),
                  subtitle: Text('${video.duration} · ${video.description}'),
                  trailing: const Icon(Icons.play_circle_outline_rounded),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MockVideoState {
  static VideoLesson initialVideo(WidgetRef ref) {
    return ref.read(selectedVideoProvider) ?? ref.read(videosProvider).first;
  }
}
