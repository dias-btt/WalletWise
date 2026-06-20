import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:wallet_wise/core/router/app_routes.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_event.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_state.dart';
import 'package:wallet_wise/shared/widgets/app_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const List<String> _currencyOptions = <String>[
    'USD',
    'EUR',
    'GBP',
    'KZT',
    'AED',
    'CAD',
    'AUD',
  ];

  late final FormGroup _form;

  @override
  void initState() {
    super.initState();
    _form = FormGroup(
      <String, AbstractControl<dynamic>>{
        'displayName': FormControl<String>(
          validators: <Validator<dynamic>>[
            Validators.required,
            Validators.minLength(2),
          ],
        ),
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
        'confirmPassword': FormControl<String>(
          validators: <Validator<dynamic>>[
            Validators.required,
          ],
        ),
        'currencyCode': FormControl<String>(
          value: 'USD',
          validators: <Validator<dynamic>>[
            Validators.required,
          ],
        ),
      },
      validators: <Validator<dynamic>>[
        Validators.mustMatch('password', 'confirmPassword'),
      ],
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

    final String displayName =
        _form.control('displayName').value as String;
    final String email = _form.control('email').value as String;
    final String password = _form.control('password').value as String;
    final String currencyCode =
        _form.control('currencyCode').value as String;

    context.read<AuthBloc>().add(
          SignUpRequested(
            email: email.trim(),
            password: password,
            displayName: displayName.trim(),
            currencyCode: currencyCode,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
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
            context.go(AppRoutes.dashboard);
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
                      'Join WalletWise',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Create an account to start tracking your money',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ReactiveTextField<String>(
                      formControlName: 'displayName',
                      decoration: const InputDecoration(
                        labelText: 'Display name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      textInputAction: TextInputAction.next,
                      validationMessages: <String, String Function(Object)>{
                        ValidationMessage.required: (_) =>
                            'Display name is required',
                        ValidationMessage.minLength: (_) =>
                            'Display name must be at least 2 characters',
                      },
                    ),
                    const SizedBox(height: 16),
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
                      textInputAction: TextInputAction.next,
                      validationMessages: <String, String Function(Object)>{
                        ValidationMessage.required: (_) =>
                            'Password is required',
                        ValidationMessage.minLength: (_) =>
                            'Password must be at least 6 characters',
                      },
                    ),
                    const SizedBox(height: 16),
                    ReactiveTextField<String>(
                      formControlName: 'confirmPassword',
                      decoration: const InputDecoration(
                        labelText: 'Confirm password',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      validationMessages: <String, String Function(Object)>{
                        ValidationMessage.required: (_) =>
                            'Please confirm your password',
                        ValidationMessage.mustMatch: (_) =>
                            'Passwords do not match',
                      },
                    ),
                    const SizedBox(height: 16),
                    ReactiveDropdownField<String>(
                      formControlName: 'currencyCode',
                      decoration: const InputDecoration(
                        labelText: 'Default currency',
                        prefixIcon: Icon(Icons.payments_outlined),
                      ),
                      items: _currencyOptions
                          .map(
                            (String code) => DropdownMenuItem<String>(
                              value: code,
                              child: Text(code),
                            ),
                          )
                          .toList(),
                      validationMessages: <String, String Function(Object)>{
                        ValidationMessage.required: (_) =>
                            'Currency is required',
                      },
                    ),
                    const SizedBox(height: 24),
                    AppButton(
                      label: 'Create Account',
                      isLoading: isLoading,
                      onPressed: isLoading ? null : _submit,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already have an account?',
                          style: theme.textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: isLoading
                              ? null
                              : () => context.pop(),
                          child: const Text('Sign In'),
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
