import 'package:flutter/material.dart';

import '../widgets/coffee_shell.dart';
import '../widgets/pill_chip.dart';
import '../widgets/section_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CoffeeShell(
      title: 'Your Space',
      subtitle: 'A profile with polish, not clutter.',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 120),
        children: const [
          _ProfileHero(),
          SizedBox(height: 18),
          _ProfileStats(),
          SizedBox(height: 18),
          SectionHeader(
            title: 'Saved vibes',
            subtitle: 'A curated shelf of your favorites.',
          ),
          SizedBox(height: 12),
          SavedVibesList(),
        ],
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFF241A16), Color(0xFF12100F)],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFD39B5B), Color(0xFFB56B4F)],
              ),
            ),
            child: const Icon(Icons.person, size: 36, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jordan',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 6),
                Text(
                  'Home brewer • espresso runner • filter coffee on weekends',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 12),
                const PillChip(
                  label: 'Premium vibe',
                  icon: Icons.workspace_premium_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileStats extends StatelessWidget {
  const _ProfileStats();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _ProfileStat(label: 'Brews', value: '48'),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _ProfileStat(label: 'Saved', value: '22'),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _ProfileStat(label: 'Followers', value: '1.8k'),
        ),
      ],
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.64),
            ),
          ),
        ],
      ),
    );
  }
}

class SavedVibesList extends StatelessWidget {
  const SavedVibesList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _SavedVibeRow(
          title: 'Morning matcha latte',
          subtitle: 'Soft green, smooth foam, calm start',
          accent: Color(0xFF8BC48A),
        ),
        SizedBox(height: 12),
        _SavedVibeRow(
          title: 'Citrus filter cup',
          subtitle: 'Bright notes, clean finish',
          accent: Color(0xFFD39B5B),
        ),
        SizedBox(height: 12),
        _SavedVibeRow(
          title: 'Late-night mocha',
          subtitle: 'Rich, cozy, glossy texture',
          accent: Color(0xFFB56B4F),
        ),
      ],
    );
  }
}

class _SavedVibeRow extends StatelessWidget {
  const _SavedVibeRow({
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: accent,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.64),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.bookmark_border_rounded, color: Colors.white54),
        ],
      ),
    );
  }
}
