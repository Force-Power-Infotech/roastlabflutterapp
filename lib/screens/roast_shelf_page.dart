import 'package:flutter/material.dart';

import '../widgets/coffee_shell.dart';
import '../widgets/pill_chip.dart';
import '../widgets/section_header.dart';

class RoastShelfPage extends StatelessWidget {
  const RoastShelfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CoffeeShell(
      title: 'Roast Shelf',
      subtitle: 'Clean tracking, no lab coat needed.',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 120),
        children: const [
          _ShelfHero(),
          SizedBox(height: 18),
          SectionHeader(
            title: 'Roast snapshots',
            subtitle: 'Visual summaries with a polished edge.',
          ),
          SizedBox(height: 12),
          RoastTimeline(),
          SizedBox(height: 18),
          SectionHeader(
            title: 'Consistency',
            subtitle: 'A sleek overview of how the batch behaves.',
          ),
          SizedBox(height: 12),
          ConsistencyCard(),
        ],
      ),
    );
  }
}

class _ShelfHero extends StatelessWidget {
  const _ShelfHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF241A16), Color(0xFF11100F)],
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
                  'Roast shelf',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  'A clean summary layer for roast levels, consistency, and notes.',
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
              PillChip(label: 'Batch 07', icon: Icons.layers_rounded),
              SizedBox(height: 10),
              PillChip(label: '92 score', icon: Icons.auto_graph_rounded),
            ],
          ),
        ],
      ),
    );
  }
}

class RoastTimeline extends StatelessWidget {
  const RoastTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        RoastItem(
          time: '08:14',
          title: 'Light roast',
          subtitle: 'Honey, citrus, floral notes',
          color: Color(0xFFD39B5B),
        ),
        SizedBox(height: 12),
        RoastItem(
          time: '11:02',
          title: 'Medium roast',
          subtitle: 'Caramel, cocoa, rounded body',
          color: Color(0xFFB56B4F),
        ),
        SizedBox(height: 12),
        RoastItem(
          time: '16:40',
          title: 'Dark roast',
          subtitle: 'Mellow, rich, low acidity',
          color: Color(0xFF6A4A3C),
        ),
      ],
    );
  }
}

class RoastItem extends StatelessWidget {
  const RoastItem({
    super.key,
    required this.time,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final String time;
  final String title;
  final String subtitle;
  final Color color;

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
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.18),
              border: Border.all(color: color.withValues(alpha: 0.5)),
            ),
            child: Center(
              child: Text(
                time,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
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
                    color: Colors.white.withValues(alpha: 0.65),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ConsistencyCard extends StatelessWidget {
  const ConsistencyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B1511), Color(0xFF0F0E0D)],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Batch consistency',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              const PillChip(label: 'Stable', icon: Icons.check_circle_outline),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                child: _ConsistencyDial(label: 'Texture', value: '94%'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ConsistencyDial(label: 'Finish', value: '89%'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ConsistencyDial(label: 'Aroma', value: '96%'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConsistencyDial extends StatelessWidget {
  const _ConsistencyDial({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.66),
            ),
          ),
        ],
      ),
    );
  }
}
