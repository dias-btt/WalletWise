abstract final class AppRoutes {
  // Auth
  static const String splash = '/';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot';

  // Shell tabs
  static const String home = '/home';
  static const String transactions = '/transactions';
  static const String budgets = '/budgets';
  static const String profile = '/profile';

  static const List<String> shellRoutes = <String>[
    home,
    transactions,
    budgets,
    profile,
  ];

  static bool isAuthRoute(String location) => location.startsWith('/auth');
}
