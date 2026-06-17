import 'package:equatable/equatable.dart';
import 'package:wallet_wise/features/auth/domain/entities/user.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => <Object?>[];
}

final class AuthStarted extends AuthEvent {
  const AuthStarted();
}

final class SignInRequested extends AuthEvent {
  const SignInRequested({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => <Object?>[email, password];
}

final class SignUpRequested extends AuthEvent {
  const SignUpRequested({
    required this.email,
    required this.password,
    required this.displayName,
    required this.currencyCode,
  });

  final String email;
  final String password;
  final String displayName;
  final String currencyCode;

  @override
  List<Object?> get props => <Object?>[
        email,
        password,
        displayName,
        currencyCode,
      ];
}

final class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}

final class AuthUserChanged extends AuthEvent {
  const AuthUserChanged(this.user);

  final User? user;

  @override
  List<Object?> get props => <Object?>[user];
}
