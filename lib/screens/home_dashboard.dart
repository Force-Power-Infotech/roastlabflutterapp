import 'package:flutter/material.dart';

import '../widgets/coffee_shell.dart';
import '../widgets/pill_chip.dart';
import '../widgets/section_header.dart';
import 'flow_detail_page.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key, required this.onNavigateTab});

  final ValueChanged<int> onNavigateTab;

  @override
  Widget build(BuildContext context) {
    return CoffeeShell(
      title: 'RoastLab',
      subtitle: 'Minimal coffee app flow with demo data.',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 120),
        children: [
          _HeroCard(onNavigateTab: onNavigateTab),
          const SizedBox(height: 18),
          const SectionHeader(
            title: 'Quick shortcuts',
            subtitle: 'Jump instantly to any part of the app flow.',
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ActionChip(
                label: const Text('Open Brew Studio'),
                avatar: const Icon(Icons.tune_rounded, size: 18),
                onPressed: () => onNavigateTab(1),
              ),
              ActionChip(
                label: const Text('Open Roast Shelf'),
                avatar: const Icon(Icons.wine_bar_rounded, size: 18),
                onPressed: () => onNavigateTab(2),
              ),
              ActionChip(
                label: const Text('Open Community'),
                avatar: const Icon(Icons.forum_rounded, size: 18),
                onPressed: () => onNavigateTab(3),
              ),
              ActionChip(
                label: const Text('Open Profile'),
                avatar: const Icon(Icons.person_rounded, size: 18),
                onPressed: () => onNavigateTab(4),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const SectionHeader(
            title: 'Trending drinks',
            subtitle: 'Tap any card to view detail screen with demo info.',
          ),
          const SizedBox(height: 12),
          _DrinkTile(
            title: 'Matcha Cloud Latte',
            subtitle: 'Soft sweetness, clean finish',
            color: const Color(0xFFC8E6C9),
            onTap: () => _openDetail(
              context,
              title: 'Matcha Cloud Latte',
              headline: 'A smooth, pastel-profile cup for the morning routine.',
              stats: const [
                _FlowStat('Rating', '4.9'),
                _FlowStat('Sweetness', 'Low'),
                _FlowStat('Type', 'Iced'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _DrinkTile(
            title: 'Citrus V60 Pour',
            subtitle: 'Bright acidity, light body',
            color: const Color(0xFFFFE0B2),
            onTap: () => _openDetail(
              context,
              title: 'Citrus V60 Pour',
              headline: 'A minimal filter profile with crisp fruit notes.',
              stats: const [
                _FlowStat('Rating', '4.7'),
                _FlowStat('Roast', 'Light'),
                _FlowStat('Brew', 'V60'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void _openDetail(
    BuildContext context, {
    required String title,
    required String headline,
    required List<_FlowStat> stats,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => FlowDetailPage(
          title: title,
          headline: headline,
          stats: stats
              .map(
                (item) => FlowDetailStat(label: item.label, value: item.value),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.onNavigateTab});

  final ValueChanged<int> onNavigateTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A9D8F), Color(0xFF74C6BC)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              PillChip(label: 'Demo mode', icon: Icons.auto_awesome_rounded),
              Spacer(),
              PillChip(label: 'v1 flow', icon: Icons.route_rounded),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'Clean UI,\nfull app flow.',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start from Home and move through Brew, Roast, Feed, and Profile with one-tap redirection.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => onNavigateTab(1),
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Start Brew Flow'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF2A9D8F),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrinkTile extends StatelessWidget {
  const _DrinkTile({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.white.withValues(alpha: 0.86),
            border: Border.all(color: Colors.black.withValues(alpha: 0.07)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withValues(alpha: 0.58),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FlowStat {
  const _FlowStat(this.label, this.value);

  final String label;
  final String value;
}
