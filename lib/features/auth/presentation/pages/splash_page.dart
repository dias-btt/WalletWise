import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_wise/core/router/app_routes.dart';
import 'package:wallet_wise/core/theme/app_colors.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_event.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _navigationHandled = false;
  Timer? _maxSplashTimer;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthStarted());
    _maxSplashTimer = Timer(const Duration(seconds: 2), _navigateFromSplash);
  }

  @override
  void dispose() {
    _maxSplashTimer?.cancel();
    super.dispose();
  }

  void _navigateFromSplash() {
    if (_navigationHandled || !mounted) {
      return;
    }

    final AuthState authState = context.read<AuthBloc>().state;

    if (authState is AuthLoading || authState is AuthInitial) {
      return;
    }

    _navigationHandled = true;

    if (authState is Authenticated) {
      context.go(AppRoutes.dashboard);
      return;
    }

    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is Authenticated || state is Unauthenticated) {
          _navigateFromSplash();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.account_balance_wallet_rounded,
                size: 80,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              const SizedBox(height: 24),
              Text(
                'WalletWise',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
