abstract final class AppRoutes {
  // Auth
  static const String splash = '/';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot';

  // Shell tabs
  static const String dashboard = '/dashboard';
  static const String transactions = '/transactions';
  static const String analytics = '/analytics';
  static const String goals = '/goals';
  static const String settings = '/settings';

  // Standalone routes
  static const String budgets = '/budgets';

  static const List<String> shellRoutes = <String>[
    dashboard,
    transactions,
    analytics,
    goals,
    settings,
  ];

  static bool isAuthRoute(String location) => location.startsWith('/auth');
}
