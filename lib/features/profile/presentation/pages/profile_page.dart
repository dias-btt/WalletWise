import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_wise/core/router/app_routes.dart';
import 'package:wallet_wise/features/auth/domain/entities/user.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_event.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_state.dart';
import 'package:wallet_wise/shared/widgets/app_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _signOut(BuildContext context) {
    context.read<AuthBloc>().add(const SignOutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.message)),
              );
          }

          if (state is Unauthenticated) {
            context.go(AppRoutes.login);
          }
        },
        builder: (BuildContext context, AuthState state) {
          final bool isLoading = state is AuthLoading;
          final User? user = state is Authenticated ? state.user : null;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (user != null) ...<Widget>[
                    CircleAvatar(
                      radius: 36,
                      child: Text(
                        user.displayName.isNotEmpty
                            ? user.displayName[0].toUpperCase()
                            : '?',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.displayName,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Currency: ${user.currencyCode}',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                  ] else
                    const Spacer(),
                  AppButton(
                    label: 'Log Out',
                    variant: AppButtonVariant.destructive,
                    isLoading: isLoading,
                    icon: Icons.logout,
                    onPressed: isLoading ? null : () => _signOut(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
