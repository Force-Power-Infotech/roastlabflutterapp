import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/app_providers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/ui_widgets.dart';
import '../../../../shared/models/app_models.dart';

class BrewCalculatorScreen extends ConsumerStatefulWidget {
  const BrewCalculatorScreen({super.key});

  @override
  ConsumerState<BrewCalculatorScreen> createState() => _BrewCalculatorScreenState();
}

class _BrewCalculatorScreenState extends ConsumerState<BrewCalculatorScreen> {
  int _methodIndex = 0;
  double _dose = 20;

  @override
  Widget build(BuildContext context) {
    final methods = ref.watch(brewMethodsProvider);
    final method = methods[_methodIndex];
    final ratioParts = method.ratio.split(':');
    final water = _dose * double.parse(ratioParts[1]);

    return ScreenScaffold(
      title: 'Brew Calculator',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: methods.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final selected = index == _methodIndex;
                return ChoiceChip(
                  label: Text(methods[index].name),
                  selected: selected,
                  onSelected: (_) => setState(() {
                    _methodIndex = index;
                    _dose = methods[index].defaultDose;
                  }),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(method.name, style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 20),
                Text('Coffee dose: ${_dose.toStringAsFixed(0)} g'),
                Slider(
                  value: _dose,
                  min: 12,
                  max: 90,
                  activeColor: AppTheme.crema,
                  onChanged: (value) => setState(() => _dose = value),
                ),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    MetricPill(label: 'Water', value: '${water.toStringAsFixed(0)} g'),
                    MetricPill(label: 'Ratio', value: method.ratio),
                    MetricPill(label: 'Grind', value: method.grind),
                    MetricPill(label: 'Time', value: method.time),
                    MetricPill(label: 'Temp', value: method.temperature),
                  ],
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () => context.push('/recipes'),
                  child: const Text('Save to recipe shelf'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
