import 'package:flutter/material.dart';

import '../shell/roastlab_shell.dart';
import '../theme/roastlab_theme.dart';

class RoastLabApp extends StatelessWidget {
  const RoastLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RoastLab',
      theme: roastLabTheme,
      home: const RoastLabShell(),
    );
  }
}
