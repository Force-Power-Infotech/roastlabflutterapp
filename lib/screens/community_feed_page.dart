import 'package:flutter/material.dart';

import '../widgets/coffee_shell.dart';
import '../widgets/pill_chip.dart';

class CommunityFeedPage extends StatelessWidget {
  const CommunityFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CoffeeShell(
      title: 'Community',
      subtitle: 'A feed that feels more gallery than dashboard.',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 120),
        children: const [
          _FeedHeader(),
          SizedBox(height: 18),
          FeedCard(
            name: 'Mila',
            location: 'Brooklyn',
            caption: 'Black sesame latte, slow pour, warm lights.',
            hearts: '1.2k',
            comments: '84',
            colorA: Color(0xFF5F3425),
            colorB: Color(0xFFF2C07A),
          ),
          SizedBox(height: 14),
          FeedCard(
            name: 'Noah',
            location: 'Osaka',
            caption: 'Weekend filter brew with a citrus snap.',
            hearts: '960',
            comments: '41',
            colorA: Color(0xFF1F2937),
            colorB: Color(0xFF9CA3AF),
          ),
          SizedBox(height: 14),
          FeedCard(
            name: 'Aya',
            location: 'Melbourne',
            caption: 'Creamy flat white, glossy art, low glare.',
            hearts: '1.6k',
            comments: '112',
            colorA: Color(0xFF5B3B2E),
            colorB: Color(0xFFD39B5B),
          ),
        ],
      ),
    );
  }
}

class _FeedHeader extends StatelessWidget {
  const _FeedHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFF221814), Color(0xFF141110)],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fresh feed',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'A bold social layer for coffee shots, notes, and reactions.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            children: [
              PillChip(label: 'Like', icon: Icons.favorite_border_rounded),
              SizedBox(height: 8),
              PillChip(
                label: 'Comment',
                icon: Icons.chat_bubble_outline_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FeedCard extends StatelessWidget {
  const FeedCard({
    super.key,
    required this.name,
    required this.location,
    required this.caption,
    required this.hearts,
    required this.comments,
    required this.colorA,
    required this.colorB,
  });

  final String name;
  final String location;
  final String caption;
  final String hearts;
  final String comments;
  final Color colorA;
  final Color colorB;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF5B3B2E),
                ),
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      location,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz, color: Colors.white54),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 210,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [colorA, colorB],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  top: -10,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.12),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Text(
                    'coffee mood',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(caption, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 12),
          Row(
            children: [
              PillChip(label: '$hearts likes', icon: Icons.favorite_rounded),
              const SizedBox(width: 10),
              PillChip(
                label: '$comments replies',
                icon: Icons.chat_bubble_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
