import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet_wise/core/router/app_routes.dart';
import 'package:wallet_wise/core/router/main_shell.dart';
import 'package:wallet_wise/core/router/placeholder_page.dart';
import 'package:wallet_wise/features/auth/presentation/pages/login_page.dart';
import 'package:wallet_wise/features/auth/presentation/pages/register_page.dart';
import 'package:wallet_wise/features/auth/presentation/pages/splash_page.dart';
import 'package:wallet_wise/features/budgets/presentation/bloc/budget_bloc.dart';
import 'package:wallet_wise/features/budgets/presentation/pages/budget_detail_page.dart';
import 'package:wallet_wise/features/budgets/presentation/pages/budgets_page.dart';
import 'package:wallet_wise/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:wallet_wise/features/profile/presentation/pages/profile_page.dart';
import 'package:wallet_wise/features/transactions/presentation/pages/transactions_page.dart';
import 'package:wallet_wise/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_wise/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:wallet_wise/features/transactions/presentation/bloc/transaction_bloc.dart';

@lazySingleton
class AppRouter {
  AppRouter(this._supabaseClient);

  final SupabaseClient _supabaseClient;

  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
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
      GoRoute(
        path: AppRoutes.budgets,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) =>
            BlocProvider<BudgetBloc>.value(
              value: getIt<BudgetBloc>(),
              child: const BudgetsPage(),
            ),
        routes: <RouteBase>[
          GoRoute(
            path: ':id',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              final BudgetDetailArgs args =
                  state.extra! as BudgetDetailArgs;
              return BlocProvider<BudgetBloc>.value(
                value: getIt<BudgetBloc>(),
                child: BudgetDetailPage(args: args),
              );
            },
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.dashboard,
                builder: (BuildContext context, GoRouterState state) =>
                    BlocProvider<DashboardBloc>.value(
                      value: getIt<DashboardBloc>(),
                      child: const DashboardPage(),
                    ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.transactions,
                builder: (BuildContext context, GoRouterState state) =>
                    BlocProvider<TransactionBloc>.value(
                      value: getIt<TransactionBloc>(),
                      child: const TransactionsPage(),
                    ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.analytics,
                builder: (BuildContext context, GoRouterState state) =>
                    placeholderPage('Analytics'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.goals,
                builder: (BuildContext context, GoRouterState state) =>
                    placeholderPage('Goals'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.settings,
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
      return AppRoutes.dashboard;
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
