import 'dart:io';
import 'dart:async';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String roastLabWebsiteUrl =
    'https://remix-roastlab-466628391045.asia-southeast1.run.app/';

class RoastLabBootstrap extends StatelessWidget {
  const RoastLabBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RoastLab',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB87333),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0E0A08),
      ),
      home: const _PermissionGate(),
    );
  }
}

class _PermissionGate extends StatefulWidget {
  const _PermissionGate();

  @override
  State<_PermissionGate> createState() => _PermissionGateState();
}

class _PermissionGateState extends State<_PermissionGate> {
  bool _isRequesting = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPermissions();
    });
  }

  Future<void> _checkPermissions() async {
    if (!mounted) {
      return;
    }

    setState(() {
      _isRequesting = true;
      _errorMessage = null;
    });

    if (!Platform.isAndroid && !Platform.isIOS) {
      _continueToApp();
      return;
    }

    final Map<Permission, PermissionStatus> statuses = await <Permission>[
      Permission.camera,
      Permission.microphone,
    ].request();

    final bool hasCameraAccess = statuses[Permission.camera]?.isGranted == true;
    final bool hasMicrophoneAccess =
        statuses[Permission.microphone]?.isGranted == true;

    if (hasCameraAccess && hasMicrophoneAccess) {
      _continueToApp();
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _isRequesting = false;
      _errorMessage =
          'Camera and microphone access are required for the in-app site to use video and audio features.';
    });
  }

  void _continueToApp() {
    if (!mounted) {
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const _LaunchGate()),
    );
  }

  Future<void> _openAppSettings() async {
    await openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    if (_isRequesting) {
      return const Scaffold(body: _SplashScreen());
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF140F0C), Color(0xFF0E0A08)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/roastlab_splash.png',
                  width: 140,
                  height: 140,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Camera access is required',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Text(
                  _errorMessage ??
                      'Enable camera and microphone permissions to continue into RoastLab.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFFCFB8A3)),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _checkPermissions,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Try again'),
                ),
                TextButton(
                  onPressed: _openAppSettings,
                  child: const Text('Open app settings'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LaunchGate extends StatefulWidget {
  const _LaunchGate();

  @override
  State<_LaunchGate> createState() => _LaunchGateState();
}

class _LaunchGateState extends State<_LaunchGate> {
  static const Duration _splashDuration = Duration(milliseconds: 1200);

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(_splashDuration, _showWebWrapper);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showWebWrapper() {
    if (!mounted) {
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const RoastLabWebWrapper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _SplashScreen());
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF140F0C), Color(0xFF0E0A08)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/icons/roastlab_splash.png',
              width: 180,
              height: 180,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            const Text(
              'RoastLab',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Coffee intelligence for every brew',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Color(0xFFCFB8A3)),
            ),
          ],
        ),
      ),
    );
  }
}

class RoastLabWebWrapper extends StatefulWidget {
  const RoastLabWebWrapper({super.key});

  @override
  State<RoastLabWebWrapper> createState() => _RoastLabWebWrapperState();
}

class _RoastLabWebWrapperState extends State<RoastLabWebWrapper> {
  late final WebViewController _controller;
  double _progress = 0;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController(
            onPermissionRequest: (WebViewPermissionRequest request) {
              request.grant();
            },
          )
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0xFF0E0A08))
          ..setNavigationDelegate(
            NavigationDelegate(
              onNavigationRequest: (NavigationRequest request) {
                return NavigationDecision.navigate;
              },
              onProgress: (int progress) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  _progress = progress / 100;
                });
              },
              onPageStarted: (_) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  _errorMessage = null;
                  _progress = 0;
                });
              },
              onPageFinished: (_) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  _progress = 1;
                });
              },
              onWebResourceError: (WebResourceError error) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  _errorMessage = error.description;
                });
              },
            ),
          )
          ..loadRequest(Uri.parse(roastLabWebsiteUrl));
  }

  Future<bool> _handleBackNavigation() async {
    if (await _controller.canGoBack()) {
      await _controller.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBackNavigation,
      child: Scaffold(
        backgroundColor: const Color(0xFF0E0A08),
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              WebViewWidget(controller: _controller),
              if (_progress < 1) const LinearProgressIndicator(minHeight: 2),
              if (_errorMessage != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.wifi_off_rounded, size: 48),
                        const SizedBox(height: 12),
                        const Text(
                          'Unable to load the site.',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Color(0xFFCFB8A3)),
                        ),
                        const SizedBox(height: 20),
                        FilledButton.icon(
                          onPressed: () {
                            setState(() {
                              _errorMessage = null;
                              _progress = 0;
                            });
                            _controller.loadRequest(
                              Uri.parse(roastLabWebsiteUrl),
                            );
                          },
                          icon: const Icon(Icons.refresh_rounded),
                          label: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
