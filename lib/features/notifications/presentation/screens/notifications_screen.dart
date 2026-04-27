import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/app_providers.dart';
import '../../../../core/widgets/ui_widgets.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(notificationsProvider);

    return ScreenScaffold(
      title: 'Notifications',
      actions: [
        TextButton(
          onPressed: () => ref.read(notificationsProvider.notifier).markAllRead(),
          child: const Text('Mark all read'),
        ),
      ],
      child: Column(
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlassCard(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: item.isUnread ? const Color(0x30BE8F62) : const Color(0x14FFFFFF),
                      child: Text(item.title.substring(0, 1)),
                    ),
                    title: Text(item.title),
                    subtitle: Text(item.message),
                    trailing: Text(item.timeLabel),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
