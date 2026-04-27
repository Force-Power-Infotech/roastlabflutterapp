enum ScanType { roast, grind }

enum RoastLevel { light, medium, dark }

enum GrindSize { fine, medium, coarse }

enum SubscriptionTier { free, pro }

class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.tier,
    required this.following,
    required this.followers,
    required this.savedPosts,
  });

  final String id;
  final String name;
  final String email;
  final String avatar;
  final SubscriptionTier tier;
  final int following;
  final int followers;
  final int savedPosts;

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    SubscriptionTier? tier,
    int? following,
    int? followers,
    int? savedPosts,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      tier: tier ?? this.tier,
      following: following ?? this.following,
      followers: followers ?? this.followers,
      savedPosts: savedPosts ?? this.savedPosts,
    );
  }
}

class DashboardMetric {
  const DashboardMetric({
    required this.label,
    required this.value,
    required this.caption,
  });

  final String label;
  final String value;
  final String caption;
}

class ScanResult {
  const ScanResult({
    required this.id,
    required this.type,
    required this.label,
    required this.score,
    required this.consistency,
    required this.finesPercent,
    required this.unevenWarning,
    required this.suggestedBrewMethod,
    required this.imagePath,
    required this.createdAt,
    required this.notes,
  });

  final String id;
  final ScanType type;
  final String label;
  final double score;
  final double consistency;
  final double finesPercent;
  final bool unevenWarning;
  final String suggestedBrewMethod;
  final String imagePath;
  final DateTime createdAt;
  final List<String> notes;
}

class BrewMethodRecipe {
  const BrewMethodRecipe({
    required this.name,
    required this.ratio,
    required this.grind,
    required this.time,
    required this.temperature,
    required this.defaultDose,
  });

  final String name;
  final String ratio;
  final String grind;
  final String time;
  final String temperature;
  final double defaultDose;
}

class SavedRecipe {
  const SavedRecipe({
    required this.id,
    required this.name,
    required this.method,
    required this.dose,
    required this.water,
    required this.notes,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String method;
  final double dose;
  final double water;
  final String notes;
  final DateTime createdAt;
}

class CommentModel {
  const CommentModel({
    required this.id,
    required this.author,
    required this.message,
    required this.createdAt,
  });

  final String id;
  final String author;
  final String message;
  final DateTime createdAt;
}

class FeedPost {
  const FeedPost({
    required this.id,
    required this.author,
    required this.handle,
    required this.caption,
    required this.brewMethod,
    required this.roastTag,
    required this.likes,
    required this.commentsCount,
    required this.saved,
    required this.liked,
    required this.imageHint,
    required this.createdAt,
    required this.comments,
  });

  final String id;
  final String author;
  final String handle;
  final String caption;
  final String brewMethod;
  final String roastTag;
  final int likes;
  final int commentsCount;
  final bool saved;
  final bool liked;
  final String imageHint;
  final DateTime createdAt;
  final List<CommentModel> comments;

  FeedPost copyWith({
    String? id,
    String? author,
    String? handle,
    String? caption,
    String? brewMethod,
    String? roastTag,
    int? likes,
    int? commentsCount,
    bool? saved,
    bool? liked,
    String? imageHint,
    DateTime? createdAt,
    List<CommentModel>? comments,
  }) {
    return FeedPost(
      id: id ?? this.id,
      author: author ?? this.author,
      handle: handle ?? this.handle,
      caption: caption ?? this.caption,
      brewMethod: brewMethod ?? this.brewMethod,
      roastTag: roastTag ?? this.roastTag,
      likes: likes ?? this.likes,
      commentsCount: commentsCount ?? this.commentsCount,
      saved: saved ?? this.saved,
      liked: liked ?? this.liked,
      imageHint: imageHint ?? this.imageHint,
      createdAt: createdAt ?? this.createdAt,
      comments: comments ?? this.comments,
    );
  }
}

class VideoLesson {
  const VideoLesson({
    required this.id,
    required this.title,
    required this.category,
    required this.youtubeId,
    required this.duration,
    required this.description,
  });

  final String id;
  final String title;
  final String category;
  final String youtubeId;
  final String duration;
  final String description;
}

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.message,
    required this.isUser,
    required this.createdAt,
  });

  final String id;
  final String message;
  final bool isUser;
  final DateTime createdAt;
}

class AppNotificationItem {
  const AppNotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timeLabel,
    required this.isUnread,
  });

  final String id;
  final String title;
  final String message;
  final String timeLabel;
  final bool isUnread;

  AppNotificationItem copyWith({
    String? id,
    String? title,
    String? message,
    String? timeLabel,
    bool? isUnread,
  }) {
    return AppNotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timeLabel: timeLabel ?? this.timeLabel,
      isUnread: isUnread ?? this.isUnread,
    );
  }
}

class SubscriptionPlan {
  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.billingLabel,
    required this.features,
    required this.recommended,
  });

  final String id;
  final String name;
  final String price;
  final String billingLabel;
  final List<String> features;
  final bool recommended;
}

class CoachSuggestion {
  const CoachSuggestion(this.label);

  final String label;
}
