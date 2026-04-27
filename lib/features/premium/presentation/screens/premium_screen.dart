import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/app_providers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/ui_widgets.dart';

class PremiumSubscriptionScreen extends ConsumerWidget {
  const PremiumSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(subscriptionPlansProvider);

    return ScreenScaffold(
      title: 'Premium',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Unlock Pro Lab', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 8),
          Text(
            'Unlimited scans, AI Pro Coach, cloud backup, detailed trends, and no ads.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.72)),
          ),
          const SizedBox(height: 20),
          ...plans.map(
            (plan) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                decoration: AppTheme.glassCard(tint: plan.recommended ? AppTheme.coffee : Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (plan.recommended)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.crema,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('Recommended', style: TextStyle(color: AppTheme.background)),
                        ),
                      const SizedBox(height: 12),
                      Text(plan.name, style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 6),
                      Text('${plan.price} ${plan.billingLabel}', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 12),
                      ...plan.features.map((feature) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text('• $feature'),
                          )),
                      const SizedBox(height: 14),
                      ElevatedButton(
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${plan.name} checkout would begin here.')),
                        ),
                        child: Text('Choose ${plan.name}'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
