import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/providers/app_providers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/ui_widgets.dart';
import '../../../../shared/models/app_models.dart';

class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metrics = ref.watch(dashboardMetricsProvider);
    final history = ref.watch(scanHistoryProvider);
    final user = ref.watch(authProvider);
    final latest = history.isEmpty ? null : history.first;

    return ScreenScaffold(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good brew, ${user?.name.split(' ').first ?? 'Maker'}',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Track roasts, catch grind issues, and keep your coffee routine sharp.',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.72), height: 1.4),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => context.push('/notifications'),
                icon: const Icon(Icons.notifications_none_rounded),
              ),
            ],
          ),
          const SizedBox(height: 24),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Today\'s Lab'),
                const SizedBox(height: 8),
                Text(
                  latest == null
                      ? 'No scans yet today'
                      : '${latest.label} at ${latest.score.toStringAsFixed(0)} score',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 160,
                  child: LineChart(
                    LineChartData(
                      minY: 0,
                      maxY: 100,
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          spots: [
                            const FlSpot(0, 46),
                            const FlSpot(1, 57),
                            const FlSpot(2, 61),
                            const FlSpot(3, 68),
                            const FlSpot(4, 72),
                            FlSpot(5, latest?.score ?? 78),
                          ],
                          color: AppTheme.crema,
                          barWidth: 4,
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.coffee.withValues(alpha: 0.38),
                                Colors.transparent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          dotData: const FlDotData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.25,
            ),
            itemCount: metrics.length,
            itemBuilder: (context, index) => _MetricCard(metric: metrics[index]),
          ),
          const SizedBox(height: 28),
          const SectionTitle(
            title: 'Quick actions',
            subtitle: 'Jump into the tools you use most.',
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _ActionCard(
                title: 'Roast Meter',
                subtitle: 'Analyze bean color',
                icon: Icons.camera_outlined,
                onTap: () => context.push('/scan/roast'),
              ),
              _ActionCard(
                title: 'Grind Scan',
                subtitle: 'Spot fines and boulders',
                icon: Icons.grain_outlined,
                onTap: () => context.push('/scan/grind'),
              ),
              _ActionCard(
                title: 'Brew Calculator',
                subtitle: 'Dial in ratios',
                icon: Icons.calculate_outlined,
                onTap: () => context.push('/brew'),
              ),
              _ActionCard(
                title: 'AI Coach',
                subtitle: 'Troubleshoot cups',
                icon: Icons.auto_awesome_outlined,
                onTap: () => context.push('/coach'),
              ),
            ],
          ),
          const SizedBox(height: 28),
          const SectionTitle(
            title: 'Latest activity',
            subtitle: 'Recent lab entries and saved brew context.',
          ),
          const SizedBox(height: 14),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (latest == null)
                  Text(
                    'Run your first scan to start building roast and grind history.',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                  )
                else
                  _HistoryRow(result: latest),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () => context.push('/journal'),
                  child: const Text('Open Roast Journal'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.metric});

  final DashboardMetric metric;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(metric.label, style: TextStyle(color: Colors.white.withValues(alpha: 0.62))),
          Text(metric.value, style: Theme.of(context).textTheme.displayMedium),
          Text(metric.caption, style: TextStyle(color: Colors.white.withValues(alpha: 0.75))),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (MediaQuery.sizeOf(context).width - 52) / 2,
        padding: const EdgeInsets.all(18),
        decoration: AppTheme.glassCard(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppTheme.coffee.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppTheme.crema),
            ),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.7))),
          ],
        ),
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.result});

  final ScanResult result;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: AppTheme.coffee.withValues(alpha: 0.16),
          ),
          child: Icon(
            result.type == ScanType.roast ? Icons.coffee_outlined : Icons.grain_outlined,
            color: AppTheme.crema,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(result.label, style: Theme.of(context).textTheme.titleLarge),
              Text(
                '${result.score.toStringAsFixed(0)} score · ${result.consistency.toStringAsFixed(0)}% consistency',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.68)),
              ),
            ],
          ),
        ),
        Text(
          DateFormat('MMM d').format(result.createdAt),
          style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
        ),
      ],
    );
  }
}
