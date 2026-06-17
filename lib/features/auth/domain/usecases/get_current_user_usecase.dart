import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/auth/domain/entities/user.dart';
import 'package:wallet_wise/features/auth/domain/repositories/auth_repository.dart';
import 'package:wallet_wise/shared/domain/usecase.dart';

class GetCurrentUserUseCase extends UseCase<User?, NoParams> {
  GetCurrentUserUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, User?>> call(NoParams params) {
    return _repository.getCurrentUser();
  }
}
