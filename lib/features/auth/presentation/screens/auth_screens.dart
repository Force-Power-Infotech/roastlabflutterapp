import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/providers/app_providers.dart';
import '../../../../core/theme/app_theme.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1400), _routeNext);
  }

  void _routeNext() {
    final boot = ref.read(appBootstrapProvider);
    final user = ref.read(authProvider);
    if (!boot.ready) return;
    if (!boot.hasSeenOnboarding) {
      context.go('/onboarding');
    } else if (user == null) {
      context.go('/login');
    } else {
      context.go('/home');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(appBootstrapProvider, (_, next) {
      if (next.ready) {
        _routeNext();
      }
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF130D0B), Color(0xFF2D1D16), Color(0xFF6E4A31)],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _RoastLabLogo(size: 96),
              SizedBox(height: 24),
              Text(
                'RoastLab',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8),
              Text(
                'Coffee intelligence for every brew',
                style: TextStyle(color: AppTheme.crema),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  static const _slides = [
    (
      title: 'Scan your roast in seconds',
      description:
          'Estimate roast level, score, and consistency from a quick bean photo using RoastLab image analysis.',
    ),
    (
      title: 'Decode grind quality',
      description:
          'Measure fines, uneven particle spread, and the best brew method before you ever start pouring.',
    ),
    (
      title: 'Brew, learn, and improve',
      description:
          'Save recipes, get AI coaching, learn from videos, and share your coffee experiments with the community.',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = PageController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () async {
                    await ref.read(appBootstrapProvider.notifier).markOnboardingSeen();
                    if (context.mounted) context.go('/login');
                  },
                  child: const Text('Skip'),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const _RoastLabLogo(size: 120),
                        const SizedBox(height: 40),
                        Text(
                          slide.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(height: 18),
                        Text(
                          slide.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.white.withValues(alpha: 0.72),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: controller,
                count: _slides.length,
                effect: WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: AppTheme.coffee,
                  dotColor: Colors.white.withValues(alpha: 0.2),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  await ref.read(appBootstrapProvider.notifier).markOnboardingSeen();
                  if (context.mounted) context.go('/login');
                },
                child: const Text('Start Brewing'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController(text: 'rohit@roastlab.app');
  final _password = TextEditingController(text: 'Roast1234');
  bool _busy = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _busy = true);
    await ref.read(authProvider.notifier).signIn(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );
    if (mounted) {
      setState(() => _busy = false);
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _AuthLayout(
      title: 'Welcome back',
      subtitle: 'Keep your brew data, scans, and saved recipes in one place.',
      child: Column(
        children: [
          TextField(
            controller: _email,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => context.push('/forgot-password'),
              child: const Text('Forgot password?'),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _busy ? null : _login,
            child: Text(_busy ? 'Signing in...' : 'Login'),
          ),
          const SizedBox(height: 14),
          OutlinedButton(
            onPressed: () async {
              await ref.read(authProvider.notifier).signInWithGoogle();
              if (context.mounted) context.go('/home');
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              side: BorderSide(color: Colors.white.withValues(alpha: 0.14)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('Continue with Google'),
          ),
          const SizedBox(height: 18),
          TextButton(
            onPressed: () => context.push('/signup'),
            child: const Text('Create a new RoastLab account'),
          ),
        ],
      ),
    );
  }
}

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _AuthLayout(
      title: 'Build your coffee lab',
      subtitle: 'Create an account for scans, learning history, and social sharing.',
      child: Column(
        children: [
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Full name'),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _email,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () async {
              await ref.read(authProvider.notifier).signUp(
                    name: _name.text.trim(),
                    email: _email.text.trim(),
                    password: _password.text.trim(),
                  );
              if (context.mounted) context.push('/otp');
            },
            child: const Text('Create account'),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('I already have an account'),
          ),
        ],
      ),
    );
  }
}

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AuthLayout(
      title: 'Verify your account',
      subtitle: 'Enter the six-digit code sent to your inbox.',
      child: Column(
        children: [
          Row(
            children: List.generate(
              6,
              (index) => Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () => context.go('/home'),
            child: const Text('Verify and continue'),
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AuthLayout(
      title: 'Reset password',
      subtitle: 'We will send a recovery link to your email.',
      child: Column(
        children: [
          const TextField(decoration: InputDecoration(labelText: 'Email')),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () => context.pop(),
            child: const Text('Send reset link'),
          ),
        ],
      ),
    );
  }
}

class _AuthLayout extends StatelessWidget {
  const _AuthLayout({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A110E), Color(0xFF0C0908), Color(0xFF090706)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      context.pop();
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                const SizedBox(height: 18),
                const _RoastLabLogo(size: 72),
                const SizedBox(height: 26),
                Text(title, style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.68),
                    fontSize: 16,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 28),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoastLabLogo extends StatelessWidget {
  const _RoastLabLogo({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.32),
        gradient: const LinearGradient(
          colors: [Color(0xFFE5BC8C), Color(0xFF8E5E3C), Color(0xFF2C1911)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Icon(Icons.coffee_rounded, size: size * 0.44, color: AppTheme.background),
    );
  }
}
