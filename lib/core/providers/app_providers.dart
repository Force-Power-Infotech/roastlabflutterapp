import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../shared/data/mock_data.dart';
import '../../shared/models/app_models.dart';

final uuidProvider = Provider((ref) => const Uuid());

class AppBootstrapState {
  const AppBootstrapState({
    this.ready = false,
    this.hasSeenOnboarding = false,
  });

  final bool ready;
  final bool hasSeenOnboarding;

  AppBootstrapState copyWith({
    bool? ready,
    bool? hasSeenOnboarding,
  }) {
    return AppBootstrapState(
      ready: ready ?? this.ready,
      hasSeenOnboarding: hasSeenOnboarding ?? this.hasSeenOnboarding,
    );
  }
}

class AppBootstrapController extends StateNotifier<AppBootstrapState> {
  AppBootstrapController() : super(const AppBootstrapState()) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('seen_onboarding') ?? false;
    state = state.copyWith(ready: true, hasSeenOnboarding: seen);
  }

  Future<void> markOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_onboarding', true);
    state = state.copyWith(hasSeenOnboarding: true);
  }
}

final appBootstrapProvider =
    StateNotifierProvider<AppBootstrapController, AppBootstrapState>(
  (ref) => AppBootstrapController(),
);

class AuthController extends StateNotifier<UserProfile?> {
  AuthController() : super(null);

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    state = MockData.user.copyWith(email: email);
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    state = MockData.user.copyWith(name: name, email: email);
  }

  Future<void> signInWithGoogle() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    state = MockData.user;
  }

  void signOut() => state = null;
}

final authProvider = StateNotifierProvider<AuthController, UserProfile?>(
  (ref) => AuthController(),
);

final dashboardMetricsProvider = Provider((ref) => MockData.metrics);
final brewMethodsProvider = Provider((ref) => MockData.brewMethods);
final subscriptionPlansProvider = Provider((ref) => MockData.plans);
final coachSuggestionsProvider = Provider((ref) => MockData.coachSuggestions);

class FeedController extends StateNotifier<List<FeedPost>> {
  FeedController() : super(MockData.posts);

  void toggleLike(String id) {
    state = [
      for (final post in state)
        if (post.id == id)
          post.copyWith(
            liked: !post.liked,
            likes: post.liked ? post.likes - 1 : post.likes + 1,
          )
        else
          post,
    ];
  }

  void toggleSave(String id) {
    state = [
      for (final post in state)
        if (post.id == id) post.copyWith(saved: !post.saved) else post,
    ];
  }

  void addPost(FeedPost post) {
    state = [post, ...state];
  }

  void addComment(String postId, CommentModel comment) {
    state = [
      for (final post in state)
        if (post.id == postId)
          post.copyWith(
            comments: [...post.comments, comment],
            commentsCount: post.commentsCount + 1,
          )
        else
          post,
    ];
  }

  FeedPost? getById(String id) {
    for (final post in state) {
      if (post.id == id) return post;
    }
    return null;
  }
}

final feedProvider = StateNotifierProvider<FeedController, List<FeedPost>>(
  (ref) => FeedController(),
);

class RecipeController extends StateNotifier<List<SavedRecipe>> {
  RecipeController() : super(MockData.recipes);

  void addRecipe(SavedRecipe recipe) {
    state = [recipe, ...state];
  }
}

final recipeProvider = StateNotifierProvider<RecipeController, List<SavedRecipe>>(
  (ref) => RecipeController(),
);

class NotificationController extends StateNotifier<List<AppNotificationItem>> {
  NotificationController() : super(MockData.notifications);

  void markAllRead() {
    state = [for (final item in state) item.copyWith(isUnread: false)];
  }
}

final notificationsProvider =
    StateNotifierProvider<NotificationController, List<AppNotificationItem>>(
  (ref) => NotificationController(),
);

class ScanEngineService {
  Future<ScanResult> analyze({
    required String imagePath,
    required ScanType type,
    required String id,
  }) async {
    final bytes = await File(imagePath).readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      throw Exception('Could not decode selected image');
    }

    final sample = img.copyResize(decoded, width: 120);
    final pixels = <double>[];
    var luminanceTotal = 0.0;
    var redTotal = 0.0;
    var greenTotal = 0.0;
    var blueTotal = 0.0;

    for (var y = 0; y < sample.height; y++) {
      for (var x = 0; x < sample.width; x++) {
        final pixel = sample.getPixel(x, y);
        final r = pixel.r.toDouble();
        final g = pixel.g.toDouble();
        final b = pixel.b.toDouble();
        final luma = (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255;
        luminanceTotal += luma;
        redTotal += r;
        greenTotal += g;
        blueTotal += b;
        pixels.add(luma);
      }
    }

    final count = pixels.length;
    final avgLuma = luminanceTotal / count;
    final avgRed = redTotal / count;
    final avgGreen = greenTotal / count;
    final avgBlue = blueTotal / count;
    final variance = pixels
            .map((value) => pow(value - avgLuma, 2).toDouble())
            .reduce((a, b) => a + b) /
        count;
    final deviation = sqrt(variance);

    if (type == ScanType.roast) {
      final roastScore = ((1 - avgLuma) * 100).clamp(0, 100).toDouble();
      final label = roastScore < 38
          ? 'Light Roast'
          : roastScore < 68
              ? 'Medium Roast'
              : 'Dark Roast';
      final consistency = ((1 - deviation * 2.4) * 100).clamp(42, 99).toDouble();
      final warmth = avgRed - avgBlue;

      return ScanResult(
        id: id,
        type: type,
        label: label,
        score: roastScore,
        consistency: consistency,
        finesPercent: 0,
        unevenWarning: deviation > 0.2,
        suggestedBrewMethod: roastScore < 40
            ? 'Pour Over'
            : roastScore < 68
                ? 'Espresso'
                : 'French Press',
        imagePath: imagePath,
        createdAt: DateTime.now(),
        notes: [
          'Average luminance suggests a ${label.toLowerCase()} profile.',
          'Warmth index ${warmth.toStringAsFixed(1)} indicates bean surface oils are ${roastScore > 70 ? 'starting to show' : 'still restrained'}.',
          if (deviation > 0.18)
            'Color spread is wide, so a few beans may have developed faster than the rest.',
        ],
      );
    }

    var edgeEnergy = 0.0;
    for (var y = 1; y < sample.height; y++) {
      for (var x = 1; x < sample.width; x++) {
        final current = pixels[y * sample.width + x];
        final left = pixels[y * sample.width + (x - 1)];
        final top = pixels[(y - 1) * sample.width + x];
        edgeEnergy += (current - left).abs() + (current - top).abs();
      }
    }
    final normalizedEdges = edgeEnergy / count;
    final finesPercent = (normalizedEdges * 115).clamp(6, 48).toDouble();
    final grindScore = (avgLuma * 100).clamp(0, 100).toDouble();
    final size = finesPercent > 28
        ? 'Fine'
        : finesPercent > 16
            ? 'Medium'
            : 'Coarse';

    return ScanResult(
      id: id,
      type: type,
      label: '$size Grind',
      score: grindScore,
      consistency: ((1 - deviation * 2.1) * 100).clamp(35, 98).toDouble(),
      finesPercent: finesPercent,
      unevenWarning: deviation > 0.19 || finesPercent > 32,
      suggestedBrewMethod: size == 'Fine'
          ? 'Espresso'
          : size == 'Medium'
              ? 'Pour Over'
              : 'French Press',
      imagePath: imagePath,
      createdAt: DateTime.now(),
      notes: [
        'Particle edge density maps closest to a $size grind band.',
        if (finesPercent > 30)
          'High fines percentage can increase bitterness and choking risk.'
        else
          'Fines remain controlled enough for balanced extraction.',
        if (deviation > 0.18)
          'Distribution looks uneven, so burr alignment or dosing may need attention.',
      ],
    );
  }
}

final scanEngineProvider = Provider((ref) => ScanEngineService());

class ScanHistoryController extends StateNotifier<List<ScanResult>> {
  ScanHistoryController() : super(const []);

  void addResult(ScanResult result) {
    state = [result, ...state];
  }
}

final scanHistoryProvider =
    StateNotifierProvider<ScanHistoryController, List<ScanResult>>(
  (ref) => ScanHistoryController(),
);

class CoachController extends StateNotifier<List<ChatMessage>> {
  CoachController(this._ref)
      : super([
          ChatMessage(
            id: 'coach_welcome',
            message:
                'I am your RoastLab coach. Ask about bitterness, sour espresso, roast levels, or grind size and I will help you troubleshoot.',
            isUser: false,
            createdAt: DateTime.now(),
          ),
        ]);

  final Ref _ref;

  Future<void> send(String prompt) async {
    final uuid = _ref.read(uuidProvider);
    state = [
      ...state,
      ChatMessage(
        id: uuid.v4(),
        message: prompt,
        isUser: true,
        createdAt: DateTime.now(),
      ),
    ];
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final history = _ref.read(scanHistoryProvider);
    final reply = _buildReply(prompt, history.isEmpty ? null : history.first);
    state = [
      ...state,
      ChatMessage(
        id: uuid.v4(),
        message: reply,
        isUser: false,
        createdAt: DateTime.now(),
      ),
    ];
  }

  String _buildReply(String prompt, ScanResult? recentScan) {
    final lower = prompt.toLowerCase();
    if (lower.contains('bitter')) {
      return 'Bitterness usually means over-extraction. Try a slightly coarser grind, lower brew time, or drop water temperature by 1 to 2 degrees. If your recent scan showed many fines, that is likely amplifying harshness.';
    }
    if (lower.contains('sour')) {
      return 'Sour espresso is usually under-extracted. Go a notch finer, extend contact time, or increase ratio toward 1:2.2. If the roast itself is very light, add a touch more temperature for sweetness.';
    }
    if (lower.contains('grind')) {
      final context = recentScan?.type == ScanType.grind
          ? ' Your latest grind scan looked like ${recentScan!.label.toLowerCase()} with ${recentScan.finesPercent.toStringAsFixed(0)}% fines.'
          : '';
      return 'For clarity and balanced flow, match grind to the brewer: fine for espresso, medium for pour over and Aeropress, coarse for French press and cold brew.$context';
    }
    if (lower.contains('roast')) {
      final context = recentScan?.type == ScanType.roast
          ? ' Your latest roast scan leaned ${recentScan!.label.toLowerCase()} at ${recentScan.score.toStringAsFixed(0)}.'
          : '';
      return 'For milk drinks, medium to medium-dark roasts give sweetness and body. For filter coffee, stay light to medium when you want florals and acidity.$context';
    }
    return 'Start with one variable at a time: dose, grind, yield, time, or temperature. Tell me what brewer you are using and what the cup tastes like, and I will narrow it down.';
  }
}

final coachProvider = StateNotifierProvider<CoachController, List<ChatMessage>>(
  (ref) => CoachController(ref),
);

final videosProvider = Provider((ref) => MockData.videos);
final selectedVideoProvider = StateProvider<VideoLesson?>(
  (ref) => MockData.videos.first,
);
