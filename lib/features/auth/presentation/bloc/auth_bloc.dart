import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_wise/features/auth/domain/entities/user.dart';
import 'package:wallet_wise/features/auth/domain/repositories/auth_repository.dart';
import 'package:wallet_wise/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:wallet_wise/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:wallet_wise/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:wallet_wise/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_event.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_state.dart';
import 'package:wallet_wise/shared/domain/usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required SignOutUseCase signOutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required AuthRepository authRepository,
  })  : _signInUseCase = signInUseCase,
        _signUpUseCase = signUpUseCase,
        _signOutUseCase = signOutUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        super(const AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<AuthUserChanged>(_onAuthUserChanged);

    _authSubscription = authRepository.authStateChanges().listen(
      (User? user) => add(AuthUserChanged(user)),
    );
  }

  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  late final StreamSubscription<User?> _authSubscription;

  Future<void> _onAuthStarted(
    AuthStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _getCurrentUserUseCase(const NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (User? user) {
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(const Unauthenticated());
        }
      },
    );
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _signInUseCase(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (User user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _signUpUseCase(
      SignUpParams(
        email: event.email,
        password: event.password,
        displayName: event.displayName,
        currencyCode: event.currencyCode,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (User user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _signOutUseCase(const NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const Unauthenticated()),
    );
  }

  void _onAuthUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) {
    final User? user = event.user;
    if (user != null) {
      emit(Authenticated(user));
      return;
    }

    if (state is! AuthLoading) {
      emit(const Unauthenticated());
    }
  }

  @override
  Future<void> close() {
    unawaited(_authSubscription.cancel());
    return super.close();
  }
}
