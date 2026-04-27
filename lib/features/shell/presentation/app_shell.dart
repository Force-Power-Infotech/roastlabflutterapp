import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) {
              navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
            },
            height: 78,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.document_scanner_outlined),
                selectedIcon: Icon(Icons.document_scanner_rounded),
                label: 'Scan',
              ),
              NavigationDestination(
                icon: Icon(Icons.dynamic_feed_outlined),
                selectedIcon: Icon(Icons.dynamic_feed_rounded),
                label: 'Feed',
              ),
              NavigationDestination(
                icon: Icon(Icons.play_circle_outline_rounded),
                selectedIcon: Icon(Icons.play_circle_fill_rounded),
                label: 'Learn',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 66,
        height: 66,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [AppTheme.crema, AppTheme.coffee],
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.coffee.withValues(alpha: 0.34),
              blurRadius: 28,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          onPressed: () => context.push('/scan/roast'),
          child: const Icon(Icons.camera_alt_rounded, color: AppTheme.background),
        ),
      ),
    );
  }
}
