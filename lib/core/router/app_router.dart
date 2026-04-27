import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/auth_screens.dart';
import '../../features/brew/presentation/screens/brew_tools_screen.dart';
import '../../features/coach/presentation/screens/coach_screen.dart';
import '../../features/dashboard/presentation/screens/home_dashboard_screen.dart';
import '../../features/feed/presentation/screens/feed_screens.dart';
import '../../features/journal/presentation/screens/journal_screen.dart';
import '../../features/learn/presentation/screens/learn_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/premium/presentation/screens/premium_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/recipes/presentation/screens/recipe_saver_screen.dart';
import '../../features/scan/presentation/screens/scan_screens.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/shell/presentation/app_shell.dart';
import '../../shared/models/app_models.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) => const OtpVerificationScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/scan',
                builder: (context, state) => const ScanSelectionScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/feed',
                builder: (context, state) => const FeedScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/learn',
                builder: (context, state) => const LearnVideosScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/scan/roast',
        builder: (context, state) => const CameraScanScreen(type: ScanType.roast),
      ),
      GoRoute(
        path: '/scan/grind',
        builder: (context, state) => const CameraScanScreen(type: ScanType.grind),
      ),
      GoRoute(
        path: '/scan/result',
        builder: (context, state) {
          final result = state.extra! as ScanResult;
          return ScanResultScreen(result: result);
        },
      ),
      GoRoute(
        path: '/brew',
        builder: (context, state) => const BrewCalculatorScreen(),
      ),
      GoRoute(
        path: '/recipes',
        builder: (context, state) => const RecipeSaverScreen(),
      ),
      GoRoute(
        path: '/journal',
        builder: (context, state) => const RoastJournalScreen(),
      ),
      GoRoute(
        path: '/feed/create',
        builder: (context, state) => const CreatePostScreen(),
      ),
      GoRoute(
        path: '/feed/post/:id',
        builder: (context, state) => PostDetailScreen(postId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/coach',
        builder: (context, state) => const AICoachChatScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/premium',
        builder: (context, state) => const PremiumSubscriptionScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});
