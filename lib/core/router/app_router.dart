import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet_wise/core/router/app_routes.dart';
import 'package:wallet_wise/core/router/app_shell_scaffold.dart'
    show AppShellScaffold;
import 'package:wallet_wise/core/router/placeholder_page.dart';
import 'package:wallet_wise/features/auth/presentation/pages/login_page.dart';
import 'package:wallet_wise/features/auth/presentation/pages/register_page.dart';
import 'package:wallet_wise/features/auth/presentation/pages/splash_page.dart';
import 'package:wallet_wise/features/profile/presentation/pages/profile_page.dart';

@lazySingleton
class AppRouter {
  AppRouter(this._supabaseClient);

  final SupabaseClient _supabaseClient;

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: _redirect,
    refreshListenable: _AuthRefreshListenable(_supabaseClient.auth),
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (BuildContext context, GoRouterState state) =>
            const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (BuildContext context, GoRouterState state) =>
            placeholderPage('Forgot Password'),
      ),
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return AppShellScaffold(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.home,
                builder: (BuildContext context, GoRouterState state) =>
                    placeholderPage('Home'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.transactions,
                builder: (BuildContext context, GoRouterState state) =>
                    placeholderPage('Transactions'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.budgets,
                builder: (BuildContext context, GoRouterState state) =>
                    placeholderPage('Budgets'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.profile,
                builder: (BuildContext context, GoRouterState state) =>
                    const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  String? _redirect(BuildContext context, GoRouterState state) {
    final bool isAuthenticated =
        _supabaseClient.auth.currentSession != null;
    final String location = state.matchedLocation;

    if (location == AppRoutes.splash) {
      return null;
    }

    final bool isOnAuthRoute = AppRoutes.isAuthRoute(location);

    if (!isAuthenticated && !isOnAuthRoute) {
      return AppRoutes.login;
    }

    if (isAuthenticated && isOnAuthRoute) {
      return AppRoutes.home;
    }

    return null;
  }
}

class _AuthRefreshListenable extends ChangeNotifier {
  _AuthRefreshListenable(GoTrueClient auth) {
    _subscription = auth.onAuthStateChange.listen((_) => notifyListeners());
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
