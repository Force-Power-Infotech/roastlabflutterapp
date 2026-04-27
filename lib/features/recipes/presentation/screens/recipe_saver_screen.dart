import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/app_providers.dart';
import '../../../../core/widgets/ui_widgets.dart';
import '../../../../shared/models/app_models.dart';

class RecipeSaverScreen extends ConsumerStatefulWidget {
  const RecipeSaverScreen({super.key});

  @override
  ConsumerState<RecipeSaverScreen> createState() => _RecipeSaverScreenState();
}

class _RecipeSaverScreenState extends ConsumerState<RecipeSaverScreen> {
  final _name = TextEditingController();
  final _notes = TextEditingController();
  String _method = 'Pour Over';
  double _dose = 20;
  double _water = 320;

  @override
  void dispose() {
    _name.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipes = ref.watch(recipeProvider);
    final methods = ref.watch(brewMethodsProvider);

    return ScreenScaffold(
      title: 'Recipe Saver',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassCard(
            child: Column(
              children: [
                TextField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Recipe name'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _method,
                  items: methods
                      .map((item) => DropdownMenuItem(value: item.name, child: Text(item.name)))
                      .toList(),
                  onChanged: (value) => setState(() => _method = value!),
                  decoration: const InputDecoration(labelText: 'Method'),
                ),
                const SizedBox(height: 12),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Dose (g)'),
                  onChanged: (value) => _dose = double.tryParse(value) ?? _dose,
                ),
                const SizedBox(height: 12),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Water (g)'),
                  onChanged: (value) => _water = double.tryParse(value) ?? _water,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _notes,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Notes'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.read(recipeProvider.notifier).addRecipe(
                          SavedRecipe(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            name: _name.text.isEmpty ? 'Untitled Recipe' : _name.text.trim(),
                            method: _method,
                            dose: _dose,
                            water: _water,
                            notes: _notes.text.trim(),
                            createdAt: DateTime.now(),
                          ),
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Recipe saved to your shelf')),
                    );
                  },
                  child: const Text('Save recipe'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const SectionTitle(
            title: 'Saved Recipes',
            subtitle: 'Reusable dial-ins for repeatable cups.',
          ),
          const SizedBox(height: 14),
          ...recipes.map(
            (recipe) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recipe.name, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 6),
                    Text('${recipe.method} · ${recipe.dose.toStringAsFixed(0)}g / ${recipe.water.toStringAsFixed(0)}g'),
                    if (recipe.notes.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(recipe.notes, style: TextStyle(color: Colors.white.withValues(alpha: 0.7))),
                    ],
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
