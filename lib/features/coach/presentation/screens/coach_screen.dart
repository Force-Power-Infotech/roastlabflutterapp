import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/app_providers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/ui_widgets.dart';

class AICoachChatScreen extends ConsumerStatefulWidget {
  const AICoachChatScreen({super.key});

  @override
  ConsumerState<AICoachChatScreen> createState() => _AICoachChatScreenState();
}

class _AICoachChatScreenState extends ConsumerState<AICoachChatScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(coachProvider);
    final suggestions = ref.watch(coachSuggestionsProvider);

    return ScreenScaffold(
      title: 'AI Coach',
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: suggestions.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final prompt = suggestions[index].label;
                return ActionChip(
                  label: Text(prompt),
                  onPressed: () => ref.read(coachProvider.notifier).send(prompt),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          ...messages.map(
            (message) => Align(
              alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.8),
                decoration: BoxDecoration(
                  color: message.isUser
                      ? AppTheme.coffee.withValues(alpha: 0.22)
                      : Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(message.message),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Ask the coach',
              suffixIcon: IconButton(
                onPressed: () {
                  final prompt = _controller.text.trim();
                  if (prompt.isEmpty) return;
                  ref.read(coachProvider.notifier).send(prompt);
                  _controller.clear();
                },
                icon: const Icon(Icons.send_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
