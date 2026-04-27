import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/providers/app_providers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/ui_widgets.dart';
import '../../../../shared/models/app_models.dart';

class RoastJournalScreen extends ConsumerWidget {
  const RoastJournalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(scanHistoryProvider);

    return ScreenScaffold(
      title: 'Roast Journal',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'History',
            subtitle: 'Every roast and grind scan, in one timeline.',
          ),
          const SizedBox(height: 16),
          if (history.isEmpty)
            const GlassCard(child: Text('Your journal is empty. Capture a roast or grind scan to begin.'))
          else
            ...history.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlassCard(
                  child: Row(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: AppTheme.coffee.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          entry.type == ScanType.roast ? Icons.coffee_outlined : Icons.grain_outlined,
                          color: AppTheme.crema,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(entry.label, style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 4),
                            Text(
                              '${entry.score.toStringAsFixed(0)} score · ${entry.consistency.toStringAsFixed(0)}% consistency',
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        DateFormat('MMM d, h:mm a').format(entry.createdAt),
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
