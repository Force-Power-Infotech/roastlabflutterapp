import '../models/app_models.dart';

class MockData {
  static const user = UserProfile(
    id: 'user_1',
    name: 'Rohit Menon',
    email: 'rohit@roastlab.app',
    avatar: 'RM',
    tier: SubscriptionTier.pro,
    following: 218,
    followers: 1240,
    savedPosts: 38,
  );

  static final metrics = <DashboardMetric>[
    const DashboardMetric(
      label: 'Weekly scans',
      value: '26',
      caption: '+18% roast consistency this week',
    ),
    const DashboardMetric(
      label: 'Dial-ins saved',
      value: '14',
      caption: 'Three recipes are trending in your lab',
    ),
    const DashboardMetric(
      label: 'Community score',
      value: '91',
      caption: 'Top 8% among local roasters',
    ),
  ];

  static final brewMethods = <BrewMethodRecipe>[
    const BrewMethodRecipe(
      name: 'Espresso',
      ratio: '1:2',
      grind: 'Fine',
      time: '28-32 sec',
      temperature: '93 C',
      defaultDose: 18,
    ),
    const BrewMethodRecipe(
      name: 'French Press',
      ratio: '1:15',
      grind: 'Coarse',
      time: '4:00 min',
      temperature: '94 C',
      defaultDose: 24,
    ),
    const BrewMethodRecipe(
      name: 'Pour Over',
      ratio: '1:16',
      grind: 'Medium',
      time: '2:45 min',
      temperature: '92 C',
      defaultDose: 20,
    ),
    const BrewMethodRecipe(
      name: 'Aeropress',
      ratio: '1:14',
      grind: 'Medium-fine',
      time: '1:45 min',
      temperature: '90 C',
      defaultDose: 17,
    ),
    const BrewMethodRecipe(
      name: 'Cold Brew',
      ratio: '1:8',
      grind: 'Coarse',
      time: '14 hr',
      temperature: 'Room temp',
      defaultDose: 80,
    ),
  ];

  static final recipes = <SavedRecipe>[
    SavedRecipe(
      id: 'recipe_1',
      name: 'Morning Gesha',
      method: 'Pour Over',
      dose: 20,
      water: 320,
      notes: 'Bloom 45s, slower final pour for florals.',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    SavedRecipe(
      id: 'recipe_2',
      name: 'House Flat White',
      method: 'Espresso',
      dose: 18,
      water: 36,
      notes: 'Slightly finer after humid weather.',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  static final posts = <FeedPost>[
    FeedPost(
      id: 'post_1',
      author: 'Aisha Bean',
      handle: '@aisharoasts',
      caption: 'Washed Ethiopian on a flat-bottom brewer. Lime zest, jasmine, and a really sweet finish.',
      brewMethod: 'Pour Over',
      roastTag: 'Light roast',
      likes: 324,
      commentsCount: 18,
      saved: true,
      liked: true,
      imageHint: 'Citrus floral cup profile',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      comments: [
        CommentModel(
          id: 'comment_1',
          author: 'Marco',
          message: 'That bloom looks spot on.',
          createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        ),
      ],
    ),
    FeedPost(
      id: 'post_2',
      author: 'Brew Cartel',
      handle: '@brewcartel',
      caption: 'Testing a medium roast espresso profile for chocolate-heavy milk drinks.',
      brewMethod: 'Espresso',
      roastTag: 'Medium roast',
      likes: 198,
      commentsCount: 9,
      saved: false,
      liked: false,
      imageHint: 'Chocolate syrup extraction',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      comments: [
        CommentModel(
          id: 'comment_2',
          author: 'Rina',
          message: 'What was the final ratio?',
          createdAt: DateTime.now().subtract(const Duration(hours: 4)),
        ),
      ],
    ),
  ];

  static final videos = <VideoLesson>[
    const VideoLesson(
      id: 'video_1',
      title: 'Brew Better V60 Cups',
      category: 'Brewing',
      youtubeId: 'AI4ynXzkSQo',
      duration: '11 min',
      description: 'Flow control, bed management, and dialing in for sweetness.',
    ),
    const VideoLesson(
      id: 'video_2',
      title: 'Roast Curves for Small Batch Roasters',
      category: 'Roasting',
      youtubeId: 'Jw2gUQd8J1U',
      duration: '14 min',
      description: 'Development time, turning point decisions, and flavor impact.',
    ),
    const VideoLesson(
      id: 'video_3',
      title: 'Latte Art Foundations',
      category: 'Latte Art',
      youtubeId: 'nV4P4VY2Cq0',
      duration: '9 min',
      description: 'Pitcher control, milk texture, and contrast tips.',
    ),
    const VideoLesson(
      id: 'video_4',
      title: 'Choosing Grinder Burrs',
      category: 'Grinder Guides',
      youtubeId: 'QLEBfom0mhM',
      duration: '13 min',
      description: 'How burr geometry shapes particle distribution.',
    ),
    const VideoLesson(
      id: 'video_5',
      title: 'Coffee Basics for New Brewers',
      category: 'Beginner Coffee',
      youtubeId: 'B2V8x0a9L2Q',
      duration: '8 min',
      description: 'A fast guide to extraction, ratio, and water temperature.',
    ),
  ];

  static final notifications = <AppNotificationItem>[
    const AppNotificationItem(
      id: 'notif_1',
      title: 'Roast scan ready',
      message: 'Your latest roast image shows a 78 consistency score.',
      timeLabel: 'Just now',
      isUnread: true,
    ),
    const AppNotificationItem(
      id: 'notif_2',
      title: 'New comment',
      message: 'Marco replied to your espresso profile post.',
      timeLabel: '18 min ago',
      isUnread: true,
    ),
    const AppNotificationItem(
      id: 'notif_3',
      title: 'Lesson unlocked',
      message: 'A new grinder calibration guide is available in Learn.',
      timeLabel: 'Yesterday',
      isUnread: false,
    ),
  ];

  static final plans = <SubscriptionPlan>[
    const SubscriptionPlan(
      id: 'plan_monthly',
      name: 'Pro Monthly',
      price: '\$12',
      billingLabel: 'per month',
      features: [
        'Unlimited roast and grind scans',
        'Advanced charts and consistency trends',
        'AI Pro Coach with deeper troubleshooting',
        'Cloud backup and zero ads',
      ],
      recommended: true,
    ),
    const SubscriptionPlan(
      id: 'plan_yearly',
      name: 'Pro Annual',
      price: '\$99',
      billingLabel: 'per year',
      features: [
        'Everything in Pro Monthly',
        'Two months free',
        'Priority feature access',
        'Team sharing for micro-cafes',
      ],
      recommended: false,
    ),
  ];

  static final coachSuggestions = <CoachSuggestion>[
    const CoachSuggestion('Why is my espresso bitter?'),
    const CoachSuggestion('What grind suits V60?'),
    const CoachSuggestion('How dark should I roast for milk drinks?'),
    const CoachSuggestion('Why does my cup taste hollow?'),
  ];
}
