import 'package:flutter/material.dart';

import '../widgets/coffee_shell.dart';
import '../widgets/pill_chip.dart';
import '../widgets/section_header.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return CoffeeShell(
      title: 'RoastLab',
      subtitle: 'Coffee with a sharper aesthetic.',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 120),
        children: const [
          _HeroBanner(),
          SizedBox(height: 18),
          _MetricRow(),
          SizedBox(height: 18),
          SectionHeader(
            title: 'Today\'s mood',
            subtitle: 'Cold brew energy, warm crema finish.',
          ),
          SizedBox(height: 12),
          MoodStrip(),
          SizedBox(height: 18),
          SectionHeader(
            title: 'Featured pours',
            subtitle: 'Minimal cards, maximum appetite.',
          ),
          SizedBox(height: 12),
          DrinkCarousel(),
          SizedBox(height: 18),
          FeedbackPanel(),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.94, end: 1),
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeOutCubic,
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2A1A14), Color(0xFF15100D), Color(0xFF332218)],
          ),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withValues(alpha: 0.35),
              blurRadius: 30,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                _AvatarStack(),
                Spacer(),
                PillChip(label: 'Live now', icon: Icons.wifi_tethering_rounded),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Design-forward coffee\nfor the daily scroll.',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 12),
            Text(
              'A sleek mobile experience with bold cards, warm gradients, and smooth micro-interactions.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.78),
              ),
            ),
            const SizedBox(height: 18),
            const Row(
              children: [
                _MiniStat(value: '92', label: 'roast'),
                SizedBox(width: 12),
                _MiniStat(value: '4.8', label: 'taste'),
                SizedBox(width: 12),
                _MiniStat(value: '18', label: 'sips'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  const _AvatarStack();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      height: 36,
      child: Stack(
        children: const [
          Positioned(
            left: 0,
            child: _Avatar(color: Color(0xFF6A4A3C), label: 'R'),
          ),
          Positioned(
            left: 24,
            child: _Avatar(color: Color(0xFFB56B4F), label: 'C'),
          ),
          Positioned(
            left: 48,
            child: _Avatar(color: Color(0xFFD39B5B), label: 'S'),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: const Color(0xFF15110F), width: 2),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.62),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: MetricCard(
            label: 'Brews tracked',
            value: '128',
            icon: Icons.query_stats_rounded,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: MetricCard(
            label: 'Favorite roast',
            value: 'Medium',
            icon: Icons.brightness_5_rounded,
          ),
        ),
      ],
    );
  }
}

class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color(0xFFE7B15E).withValues(alpha: 0.15),
            ),
            child: Icon(icon, color: const Color(0xFFE7B15E)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.66),
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

class MoodStrip extends StatelessWidget {
  const MoodStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: MoodCard(
            title: 'Soft roast',
            subtitle: 'Bright, clean, airy',
            accent: Color(0xFFD39B5B),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: MoodCard(
            title: 'Deep roast',
            subtitle: 'Bold, cocoa, silky',
            accent: Color(0xFFB56B4F),
          ),
        ),
      ],
    );
  }
}

class MoodCard extends StatelessWidget {
  const MoodCard({
    super.key,
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
      height: 132,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent.withValues(alpha: 0.24),
            Colors.white.withValues(alpha: 0.05),
          ],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
          const Spacer(),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.68),
            ),
          ),
        ],
      ),
    );
  }
}

class DrinkCarousel extends StatelessWidget {
  const DrinkCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: const [
          SizedBox(width: 4),
          DrinkCard(
            name: 'Velvet Flat White',
            tag: 'Creamy / balanced',
            rating: '4.9',
            note: 'Smooth texture with a caramel finish.',
            colors: [Color(0xFF5B3B2E), Color(0xFFD39B5B)],
          ),
          SizedBox(width: 14),
          DrinkCard(
            name: 'Sunset Cold Brew',
            tag: 'Bold / crisp',
            rating: '4.7',
            note: 'Bright acidity with a clean, modern profile.',
            colors: [Color(0xFF17324D), Color(0xFF7FB7E6)],
          ),
          SizedBox(width: 14),
          DrinkCard(
            name: 'Molten Mocha',
            tag: 'Rich / sweet',
            rating: '4.8',
            note: 'Deep cocoa tones with a glossy finish.',
            colors: [Color(0xFF2C1D1A), Color(0xFFB56B4F)],
          ),
          SizedBox(width: 6),
        ],
      ),
    );
  }
}

class DrinkCard extends StatelessWidget {
  const DrinkCard({
    super.key,
    required this.name,
    required this.tag,
    required this.rating,
    required this.note,
    required this.colors,
  });

  final String name;
  final String tag;
  final String rating;
  final String note;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.last.withValues(alpha: 0.22),
            blurRadius: 30,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PillChip(label: tag, icon: Icons.auto_awesome_rounded),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  rating,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            name,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 8),
          Text(
            note,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class FeedbackPanel extends StatelessWidget {
  const FeedbackPanel({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(0xFFE7B15E).withValues(alpha: 0.14),
                ),
                child: const Icon(
                  Icons.reviews_rounded,
                  color: Color(0xFFE7B15E),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Feedback loop',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Quick reactions, smooth ratings, and a polished review feel.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.66),
                      ),
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
                child: _ReactionPill(
                  icon: Icons.favorite_rounded,
                  label: 'Love it',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _ReactionPill(
                  icon: Icons.thumb_up_alt_rounded,
                  label: 'On point',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _ReactionPill(icon: Icons.star_rounded, label: 'Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReactionPill extends StatelessWidget {
  const _ReactionPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 18, color: const Color(0xFFE7B15E)),
          const SizedBox(height: 6),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
