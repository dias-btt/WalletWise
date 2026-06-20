import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:wallet_wise/shared/domain/usecase.dart';

class DeleteTransactionParams extends Equatable {
  const DeleteTransactionParams({required this.id});

  final String id;

  @override
  List<Object?> get props => <Object?>[id];
}

class DeleteTransactionUseCase extends UseCase<void, DeleteTransactionParams> {
  DeleteTransactionUseCase(this._repository);

  final TransactionRepository _repository;

  @override
  Future<Either<Failure, void>> call(DeleteTransactionParams params) {
    return _repository.deleteTransaction(params.id);
  }
}
