import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/auth/domain/entities/user.dart';
import 'package:wallet_wise/features/auth/domain/repositories/auth_repository.dart';
import 'package:wallet_wise/shared/domain/usecase.dart';

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => <Object?>[email, password];
}

class SignInUseCase extends UseCase<User, SignInParams> {
  SignInUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, User>> call(SignInParams params) {
    return _repository.signIn(
      email: params.email,
      password: params.password,
    );
  }
}
