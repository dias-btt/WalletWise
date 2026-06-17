import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:wallet_wise/core/router/app_routes.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_event.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_state.dart';
import 'package:wallet_wise/shared/widgets/app_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final FormGroup _form;

  @override
  void initState() {
    super.initState();
    _form = FormGroup(
      <String, AbstractControl<dynamic>>{
        'email': FormControl<String>(
          validators: <Validator<dynamic>>[
            Validators.required,
            Validators.email,
          ],
        ),
        'password': FormControl<String>(
          validators: <Validator<dynamic>>[
            Validators.required,
            Validators.minLength(6),
          ],
        ),
      },
    );
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _submit() {
    _form.markAllAsTouched();
    if (!_form.valid) {
      return;
    }

    final String email = _form.control('email').value as String;
    final String password = _form.control('password').value as String;

    context.read<AuthBloc>().add(
          SignInRequested(
            email: email.trim(),
            password: password,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
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

          if (state is Authenticated) {
            context.go(AppRoutes.home);
          }
        },
        builder: (BuildContext context, AuthState state) {
          final bool isLoading = state is AuthLoading;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ReactiveForm(
                formGroup: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Welcome back',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to manage your finances',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ReactiveTextField<String>(
                      formControlName: 'email',
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validationMessages: <String, String Function(Object)>{
                        ValidationMessage.required: (_) => 'Email is required',
                        ValidationMessage.email: (_) => 'Enter a valid email',
                      },
                    ),
                    const SizedBox(height: 16),
                    ReactiveTextField<String>(
                      formControlName: 'password',
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _submit(),
                      validationMessages: <String, String Function(Object)>{
                        ValidationMessage.required: (_) =>
                            'Password is required',
                        ValidationMessage.minLength: (_) =>
                            'Password must be at least 6 characters',
                      },
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: isLoading
                            ? null
                            : () => context.push(AppRoutes.forgotPassword),
                        child: const Text('Forgot password?'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      label: 'Sign In',
                      isLoading: isLoading,
                      onPressed: isLoading ? null : _submit,
                    ),
                    const SizedBox(height: 16),
                    const Tooltip(
                      message: 'Coming soon',
                      child: AppButton(
                        label: 'Continue with Google',
                        variant: AppButtonVariant.secondary,
                        icon: Icons.g_mobiledata,
                        onPressed: null,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account?",
                          style: theme.textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: isLoading
                              ? null
                              : () => context.push(AppRoutes.register),
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
