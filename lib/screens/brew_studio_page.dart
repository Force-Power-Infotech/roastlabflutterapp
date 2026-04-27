import 'package:flutter/material.dart';

import '../widgets/coffee_shell.dart';
import '../widgets/section_header.dart';
import 'flow_detail_page.dart';

class BrewStudioPage extends StatelessWidget {
  const BrewStudioPage({super.key, required this.onNavigateTab});

  final ValueChanged<int> onNavigateTab;

  @override
  Widget build(BuildContext context) {
    return CoffeeShell(
      title: 'Brew Studio',
      subtitle: 'Tune recipe, preview result, continue flow.',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 120),
        children: [
          _RecipeHero(onNavigateTab: onNavigateTab),
          const SizedBox(height: 18),
          const SectionHeader(
            title: 'Methods',
            subtitle: 'Clean cards with simple demo presets.',
          ),
          const SizedBox(height: 12),
          _MethodRow(
            title: 'V60',
            subtitle: '1:16 ratio, 2:40 brew time',
            icon: Icons.filter_alt_rounded,
            onTap: () => _openMethodDetail(
              context,
              title: 'V60 Minimal Preset',
              headline: 'A clean and balanced filter workflow for daily use.',
            ),
          ),
          const SizedBox(height: 10),
          _MethodRow(
            title: 'AeroPress',
            subtitle: '1:14 ratio, 1:40 brew time',
            icon: Icons.coffee_maker_rounded,
            onTap: () => _openMethodDetail(
              context,
              title: 'AeroPress Express Preset',
              headline: 'Fast body-forward cup with smooth finish.',
            ),
          ),
        ],
      ),
    );
  }

  static void _openMethodDetail(
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
            FlowDetailStat(label: 'Difficulty', value: 'Easy'),
            FlowDetailStat(label: 'Flavor', value: 'Balanced'),
            FlowDetailStat(label: 'Demo', value: 'Yes'),
          ],
        ),
      ),
    );
  }
}

class _RecipeHero extends StatelessWidget {
  const _RecipeHero({required this.onNavigateTab});

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
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(0xFFF4A261).withValues(alpha: 0.28),
                ),
                child: const Icon(Icons.tune_rounded),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Current recipe',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const _ProgressLine(label: 'Coffee', value: '18 g', progress: 0.58),
          const SizedBox(height: 10),
          const _ProgressLine(label: 'Water', value: '290 g', progress: 0.91),
          const SizedBox(height: 10),
          const _ProgressLine(label: 'Time', value: '2:25', progress: 0.72),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => onNavigateTab(2),
            icon: const Icon(Icons.arrow_forward_rounded),
            label: const Text('Send To Roast Shelf'),
          ),
        ],
      ),
    );
  }
}

class _ProgressLine extends StatelessWidget {
  const _ProgressLine({
    required this.label,
    required this.value,
    required this.progress,
  });

  final String label;
  final String value;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
            const Spacer(),
            Text(value),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            minHeight: 9,
            value: progress,
            backgroundColor: const Color(0xFFEDE7DF),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2A9D8F)),
          ),
        ),
      ],
    );
  }
}

class _MethodRow extends StatelessWidget {
  const _MethodRow({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
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
            color: Colors.white.withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
          ),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF2A9D8F)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black.withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.open_in_new_rounded, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
