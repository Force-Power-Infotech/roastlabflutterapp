import 'package:flutter/material.dart';

import '../widgets/coffee_shell.dart';
import '../widgets/pill_chip.dart';
import '../widgets/section_header.dart';
import 'flow_detail_page.dart';

class CommunityFeedPage extends StatelessWidget {
  const CommunityFeedPage({super.key, required this.onNavigateTab});

  final ValueChanged<int> onNavigateTab;

  @override
  Widget build(BuildContext context) {
    return CoffeeShell(
      title: 'Community',
      subtitle: 'Simple feed cards with fast interactions.',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 120),
        children: [
          _FeedHero(onNavigateTab: onNavigateTab),
          const SizedBox(height: 18),
          const SectionHeader(
            title: 'Latest posts',
            subtitle: 'Tap a post to open a full detail page.',
          ),
          const SizedBox(height: 12),
          _FeedPost(
            name: 'Ari',
            location: 'Seoul',
            caption: 'Cold brew with orange peel and tonic.',
            onTap: () => _openPostDetail(
              context,
              title: 'Ari\'s Cold Brew',
              headline: 'Bright sparkling profile with a clean aftertaste.',
            ),
          ),
          const SizedBox(height: 10),
          _FeedPost(
            name: 'Luna',
            location: 'Berlin',
            caption: 'Oat flat white, clean heart latte art.',
            onTap: () => _openPostDetail(
              context,
              title: 'Luna\'s Oat Flat White',
              headline: 'Creamy and minimal cafe-style cup.',
            ),
          ),
        ],
      ),
    );
  }

  static void _openPostDetail(
    BuildContext context, {
    required String title,
    required String headline,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => FlowDetailPage(
          title: title,
          headline: headline,
          stats: const [
            FlowDetailStat(label: 'Likes', value: '1.2k'),
            FlowDetailStat(label: 'Replies', value: '84'),
            FlowDetailStat(label: 'Saved', value: '420'),
          ],
        ),
      ),
    );
  }
}

class _FeedHero extends StatelessWidget {
  const _FeedHero({required this.onNavigateTab});

  final ValueChanged<int> onNavigateTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white.withValues(alpha: 0.88),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              PillChip(label: 'Live feed', icon: Icons.wifi_rounded),
              SizedBox(width: 10),
              PillChip(label: 'Demo users', icon: Icons.groups_rounded),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Share your brew and jump to profile.',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'All cards are demo data, built for showing interaction flow.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black.withValues(alpha: 0.57),
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: () => onNavigateTab(4),
            icon: const Icon(Icons.person_rounded),
            label: const Text('Go To Your Profile'),
          ),
        ],
      ),
    );
  }
}

class _FeedPost extends StatelessWidget {
  const _FeedPost({
    required this.name,
    required this.location,
    required this.caption,
    required this.onTap,
  });

  final String name;
  final String location;
  final String caption;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.white.withValues(alpha: 0.88),
            border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A9D8F).withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person_rounded),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: Theme.of(context).textTheme.titleLarge),
                      Text(
                        location,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.more_horiz_rounded),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2A9D8F), Color(0xFFF4A261)],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(caption, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
