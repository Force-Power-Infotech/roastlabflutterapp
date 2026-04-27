import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/app_providers.dart';
import '../../../../core/widgets/ui_widgets.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool pushNotifications = true;
  bool cloudBackup = true;
  bool analytics = true;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: 'Settings',
      child: Column(
        children: [
          GlassCard(
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: pushNotifications,
                  onChanged: (value) => setState(() => pushNotifications = value),
                  title: const Text('Push notifications'),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: cloudBackup,
                  onChanged: (value) => setState(() => cloudBackup = value),
                  title: const Text('Cloud backup'),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: analytics,
                  onChanged: (value) => setState(() => analytics = value),
                  title: const Text('Anonymous analytics'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GlassCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () {
                ref.read(authProvider.notifier).signOut();
                context.go('/login');
              },
              title: const Text('Sign out'),
              subtitle: const Text('End the current session on this device'),
              trailing: const Icon(Icons.logout_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
