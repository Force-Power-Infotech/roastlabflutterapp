import 'package:flutter/material.dart';

import '../widgets/coffee_shell.dart';
import '../widgets/pill_chip.dart';
import '../widgets/section_header.dart';
import 'flow_detail_page.dart';

class RoastShelfPage extends StatelessWidget {
  const RoastShelfPage({super.key, required this.onNavigateTab});

  final ValueChanged<int> onNavigateTab;

  @override
  Widget build(BuildContext context) {
    return CoffeeShell(
      title: 'Roast Shelf',
      subtitle: 'Track roast profile in a clean visual flow.',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 120),
        children: [
          _BatchCard(onNavigateTab: onNavigateTab),
          const SizedBox(height: 18),
          const SectionHeader(
            title: 'Roast moments',
            subtitle: 'Tap any roast point to open the detail screen.',
          ),
          const SizedBox(height: 12),
          _RoastPoint(
            color: const Color(0xFFFFCC80),
            title: 'Light Roast',
            subtitle: 'Honey, citrus, tea-like finish',
            onTap: () =>
                _openDetail(context, 'Light Roast', 'High clarity cup profile'),
          ),
          const SizedBox(height: 10),
          _RoastPoint(
            color: const Color(0xFFFFB74D),
            title: 'Medium Roast',
            subtitle: 'Caramel, balanced body, soft sweetness',
            onTap: () => _openDetail(
              context,
              'Medium Roast',
              'Balanced and daily-friendly profile',
            ),
          ),
          const SizedBox(height: 10),
          _RoastPoint(
            color: const Color(0xFF8D6E63),
            title: 'Dark Roast',
            subtitle: 'Cocoa, bold body, low acidity',
            onTap: () => _openDetail(
              context,
              'Dark Roast',
              'Deep and heavy finish profile',
            ),
          ),
        ],
      ),
    );
  }

  static void _openDetail(BuildContext context, String title, String headline) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => FlowDetailPage(
          title: title,
          headline: headline,
          stats: const [
            FlowDetailStat(label: 'Batch', value: '07'),
            FlowDetailStat(label: 'Consistency', value: '91%'),
            FlowDetailStat(label: 'Demo', value: 'Ready'),
          ],
        ),
      ),
    );
  }
}

class _BatchCard extends StatelessWidget {
  const _BatchCard({required this.onNavigateTab});

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
              PillChip(label: 'Batch 07', icon: Icons.layers_rounded),
              SizedBox(width: 10),
              PillChip(label: 'Score 91', icon: Icons.auto_graph_rounded),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Today batch summary',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'Roast curve is stable and ready to be shared to community feed.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black.withValues(alpha: 0.58),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => onNavigateTab(3),
            icon: const Icon(Icons.send_rounded),
            label: const Text('Share To Community'),
          ),
        ],
      ),
    );
  }
}

class _RoastPoint extends StatelessWidget {
  const _RoastPoint({
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final Color color;
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
                width: 14,
                height: 52,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(999),
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
              const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
