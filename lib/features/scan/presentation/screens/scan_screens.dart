import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../core/providers/app_providers.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/ui_widgets.dart';
import '../../../../shared/models/app_models.dart';

class ScanSelectionScreen extends StatelessWidget {
  const ScanSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Scan Lab', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 8),
          Text(
            'Choose whether you are inspecting whole beans or brewed grounds.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.72)),
          ),
          const SizedBox(height: 24),
          _ScanOptionCard(
            title: 'Roast Color Meter',
            subtitle: 'Agtron-style roast estimate, roast band, and consistency spread.',
            icon: Icons.coffee_maker_outlined,
            onTap: () => context.push('/scan/roast'),
          ),
          const SizedBox(height: 16),
          _ScanOptionCard(
            title: 'Grind Size Detector',
            subtitle: 'Particle distribution, fines percentage, and brew fit guidance.',
            icon: Icons.grain_outlined,
            onTap: () => context.push('/scan/grind'),
          ),
        ],
      ),
    );
  }
}

class CameraScanScreen extends ConsumerStatefulWidget {
  const CameraScanScreen({super.key, required this.type});

  final ScanType type;

  @override
  ConsumerState<CameraScanScreen> createState() => _CameraScanScreenState();
}

class _CameraScanScreenState extends ConsumerState<CameraScanScreen> {
  XFile? _capture;
  bool _analyzing = false;

  Future<void> _captureAndAnalyze() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (image == null) return;

    setState(() {
      _capture = image;
      _analyzing = true;
    });

    final uuid = ref.read(uuidProvider);
    final result = await ref.read(scanEngineProvider).analyze(
          imagePath: image.path,
          type: widget.type,
          id: uuid.v4(),
        );
    ref.read(scanHistoryProvider.notifier).addResult(result);

    if (mounted) {
      setState(() => _analyzing = false);
      context.push('/scan/result', extra: result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.type == ScanType.roast ? 'Roast Camera' : 'Grind Camera';
    final subtitle = widget.type == ScanType.roast
        ? 'Frame the beans under even light with minimal shadows.'
        : 'Spread grounds in a thin, even layer for better particle detection.';

    return ScreenScaffold(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassCard(
            padding: EdgeInsets.zero,
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: _capture == null
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(color: Colors.white.withValues(alpha: 0.03)),
                        const Center(
                          child: Icon(Icons.camera_alt_rounded, size: 72, color: AppTheme.crema),
                        ),
                        Positioned(
                          left: 24,
                          right: 24,
                          top: 46,
                          bottom: 46,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(color: AppTheme.crema, width: 1.4),
                            ),
                          ),
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.file(File(_capture!.path), fit: BoxFit.cover),
                    ),
            ),
          ),
          const SizedBox(height: 18),
          Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.72))),
          const SizedBox(height: 18),
          if (_analyzing)
            const LinearProgressIndicator(
              minHeight: 8,
              borderRadius: BorderRadius.all(Radius.circular(100)),
              color: AppTheme.crema,
              backgroundColor: Colors.white24,
            ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _analyzing ? null : _captureAndAnalyze,
            child: Text(_analyzing ? 'Analyzing...' : 'Capture and analyze'),
          ),
        ],
      ),
    );
  }
}

class ScanResultScreen extends StatelessWidget {
  const ScanResultScreen({super.key, required this.result});

  final ScanResult result;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: 'Scan Result',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(result.label, style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    MetricPill(label: 'Score', value: result.score.toStringAsFixed(0)),
                    MetricPill(label: 'Consistency', value: '${result.consistency.toStringAsFixed(0)}%'),
                    if (result.type == ScanType.grind)
                      MetricPill(label: 'Fines', value: '${result.finesPercent.toStringAsFixed(0)}%'),
                  ],
                ),
                const SizedBox(height: 18),
                if (result.unevenWarning)
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.warning.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Text('Uneven distribution detected. Adjust lighting, grinder alignment, or sample spread before the next brew.'),
                  ),
                const SizedBox(height: 18),
                Text(
                  'Suggested brew: ${result.suggestedBrewMethod}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                ...result.notes.map(
                  (note) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Icon(Icons.circle, size: 8, color: AppTheme.crema),
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text(note, style: TextStyle(color: Colors.white.withValues(alpha: 0.74), height: 1.4))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () => context.push('/journal'),
            child: const Text('Open Journal'),
          ),
        ],
      ),
    );
  }
}

class _ScanOptionCard extends StatelessWidget {
  const _ScanOptionCard({
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
      child: GlassCard(
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: AppTheme.coffee.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, color: AppTheme.crema),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 6),
                  Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.72))),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 18),
          ],
        ),
      ),
    );
  }
}
