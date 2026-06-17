import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/auth/domain/entities/user.dart';
import 'package:wallet_wise/features/auth/domain/repositories/auth_repository.dart';
import 'package:wallet_wise/shared/domain/usecase.dart';

class SignUpParams extends Equatable {
  const SignUpParams({
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

class SignUpUseCase extends UseCase<User, SignUpParams> {
  SignUpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, User>> call(SignUpParams params) {
    return _repository.signUp(
      email: params.email,
      password: params.password,
      displayName: params.displayName,
      currencyCode: params.currencyCode,
    );
  }
}
