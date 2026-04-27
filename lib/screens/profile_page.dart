import 'package:flutter/material.dart';

import '../widgets/coffee_shell.dart';
import '../widgets/pill_chip.dart';
import '../widgets/section_header.dart';
import 'flow_detail_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.onNavigateTab});

  final ValueChanged<int> onNavigateTab;

  @override
  Widget build(BuildContext context) {
    return CoffeeShell(
      title: 'Your Profile',
      subtitle: 'Minimal profile page with complete loop back to home.',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 120),
        children: [
          _ProfileHero(onNavigateTab: onNavigateTab),
          const SizedBox(height: 18),
          const SectionHeader(
            title: 'Saved demos',
            subtitle: 'Tap to open a detail screen with static sample info.',
          ),
          const SizedBox(height: 12),
          _SavedItem(
            title: 'Minimal iced latte setup',
            subtitle: 'Soft milk texture and caramel notes.',
            onTap: () => _openSavedDetail(
              context,
              title: 'Minimal Iced Latte Setup',
              headline: 'A calm recipe tuned for everyday consistency.',
            ),
          ),
          const SizedBox(height: 10),
          _SavedItem(
            title: 'Weekend filter routine',
            subtitle: 'Clean workflow with bright cup profile.',
            onTap: () => _openSavedDetail(
              context,
              title: 'Weekend Filter Routine',
              headline: 'Simple and repeatable V60 plan for home brewing.',
            ),
          ),
        ],
      ),
    );
  }

  static void _openSavedDetail(
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
            FlowDetailStat(label: 'Saved', value: 'Yes'),
            FlowDetailStat(label: 'Replays', value: '26'),
            FlowDetailStat(label: 'Sharing', value: 'Private'),
          ],
        ),
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({required this.onNavigateTab});

  final ValueChanged<int> onNavigateTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF2A9D8F), Color(0xFFF4A261)],
                  ),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jordan',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Home brewer, visual thinker, clean workflow fan.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const PillChip(
                      label: 'Demo account',
                      icon: Icons.verified_rounded,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                child: _MiniStat(label: 'Brews', value: '48'),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _MiniStat(label: 'Saved', value: '22'),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _MiniStat(label: 'Followers', value: '1.8k'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: () => onNavigateTab(0),
            icon: const Icon(Icons.home_rounded),
            label: const Text('Back To Home'),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFF7F3EC),
      ),
      child: Column(
        children: [
          Text(value, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 2),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _SavedItem extends StatelessWidget {
  const _SavedItem({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
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
          child: Row(
            children: [
              Container(
                width: 12,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: const Color(0xFF2A9D8F),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black.withValues(alpha: 0.56),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
