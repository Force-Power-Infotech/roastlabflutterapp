import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/app_providers.dart';
import '../../../../core/widgets/ui_widgets.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final scans = ref.watch(scanHistoryProvider);
    final recipes = ref.watch(recipeProvider);

    return ScreenScaffold(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassCard(
            child: Column(
              children: [
                CircleAvatar(radius: 34, child: Text(user?.avatar ?? 'RL')),
                const SizedBox(height: 12),
                Text(user?.name ?? 'RoastLab User', style: Theme.of(context).textTheme.headlineSmall),
                Text(user?.email ?? 'guest@roastlab.app'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MetricPill(label: 'Scans', value: '${scans.length}'),
                    MetricPill(label: 'Recipes', value: '${recipes.length}'),
                    MetricPill(label: 'Saved', value: '${user?.savedPosts ?? 0}'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _ProfileLink(
            title: 'Premium',
            subtitle: 'Manage your RoastLab Pro access',
            onTap: () => context.push('/premium'),
          ),
          _ProfileLink(
            title: 'Settings',
            subtitle: 'Notifications, backups, and preferences',
            onTap: () => context.push('/settings'),
          ),
          _ProfileLink(
            title: 'Journal',
            subtitle: 'Review your scans and results',
            onTap: () => context.push('/journal'),
          ),
        ],
      ),
    );
  }
}

class _ProfileLink extends StatelessWidget {
  const _ProfileLink({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: onTap,
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
        ),
      ),
    );
  }
}
