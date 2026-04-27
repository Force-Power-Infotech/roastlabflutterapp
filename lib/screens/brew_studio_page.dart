import 'package:flutter/material.dart';

import '../widgets/coffee_shell.dart';
import '../widgets/section_header.dart';

class BrewStudioPage extends StatelessWidget {
  const BrewStudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CoffeeShell(
      title: 'Brew Studio',
      subtitle: 'Dial the recipe, keep the vibe.',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 120),
        children: const [
          _BrewHero(),
          SizedBox(height: 18),
          SectionHeader(
            title: 'Brewing tools',
            subtitle: 'Quick picks for different mornings.',
          ),
          SizedBox(height: 12),
          BrewMethodGrid(),
          SizedBox(height: 18),
          SectionHeader(
            title: 'Ratio board',
            subtitle: 'Built for fast decisions.',
          ),
          SizedBox(height: 12),
          RatioPanel(),
        ],
      ),
    );
  }
}

class _BrewHero extends StatelessWidget {
  const _BrewHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF231915), Color(0xFF15110F)],
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
                  'Brew like it is styled.',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  'Tap a method, adjust a ratio, and keep the whole flow clean and minimal.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: [Color(0xFFE7B15E), Color(0xFFB56B4F)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE7B15E).withValues(alpha: 0.24),
                  blurRadius: 24,
                ),
              ],
            ),
            child: const Icon(Icons.coffee, size: 32, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class BrewMethodGrid extends StatelessWidget {
  const BrewMethodGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MethodCard(
                title: 'V60',
                subtitle: 'Clean and bright',
                icon: Icons.filter_alt_rounded,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: MethodCard(
                title: 'AeroPress',
                subtitle: 'Fast and flexible',
                icon: Icons.timer_rounded,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: MethodCard(
                title: 'French Press',
                subtitle: 'Full and cozy',
                icon: Icons.blender_rounded,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: MethodCard(
                title: 'Espresso',
                subtitle: 'Short and punchy',
                icon: Icons.local_cafe_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MethodCard extends StatelessWidget {
  const MethodCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFE7B15E)),
          const SizedBox(height: 16),
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
    );
  }
}

class RatioPanel extends StatelessWidget {
  const RatioPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          _ratioLine('Coffee', '18 g', 0.58),
          const SizedBox(height: 14),
          _ratioLine('Water', '300 g', 0.92),
          const SizedBox(height: 14),
          _ratioLine('Finish', '2:30 min', 0.74),
        ],
      ),
    );
  }

  Widget _ratioLine(String label, String value, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
            const Spacer(),
            Text(value, style: const TextStyle(color: Colors.white70)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            minHeight: 10,
            value: progress,
            backgroundColor: Colors.white.withValues(alpha: 0.08),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFE7B15E)),
          ),
        ),
      ],
    );
  }
}
