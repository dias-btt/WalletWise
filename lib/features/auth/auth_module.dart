import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet_wise/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:wallet_wise/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:wallet_wise/features/auth/domain/repositories/auth_repository.dart';
import 'package:wallet_wise/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:wallet_wise/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:wallet_wise/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:wallet_wise/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_bloc.dart';

@module
abstract class AuthModule {
  @LazySingleton(as: AuthRemoteDatasource)
  AuthRemoteDatasourceImpl authRemoteDatasource(SupabaseClient client) =>
      AuthRemoteDatasourceImpl(client);

  @LazySingleton(as: AuthRepository)
  AuthRepositoryImpl authRepository(AuthRemoteDatasource datasource) =>
      AuthRepositoryImpl(datasource);

  @injectable
  SignInUseCase signInUseCase(AuthRepository repository) =>
      SignInUseCase(repository);

  @injectable
  SignUpUseCase signUpUseCase(AuthRepository repository) =>
      SignUpUseCase(repository);

  @injectable
  SignOutUseCase signOutUseCase(AuthRepository repository) =>
      SignOutUseCase(repository);

  @injectable
  GetCurrentUserUseCase getCurrentUserUseCase(AuthRepository repository) =>
      GetCurrentUserUseCase(repository);

  @lazySingleton
  AuthBloc authBloc(
    SignInUseCase signInUseCase,
    SignUpUseCase signUpUseCase,
    SignOutUseCase signOutUseCase,
    GetCurrentUserUseCase getCurrentUserUseCase,
    AuthRepository authRepository,
  ) =>
      AuthBloc(
        signInUseCase: signInUseCase,
        signUpUseCase: signUpUseCase,
        signOutUseCase: signOutUseCase,
        getCurrentUserUseCase: getCurrentUserUseCase,
        authRepository: authRepository,
      );
}
