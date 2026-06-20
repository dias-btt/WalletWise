import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';
import 'package:wallet_wise/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:wallet_wise/shared/domain/usecase.dart';

class AddTransactionUseCase extends UseCase<Transaction, Transaction> {
  AddTransactionUseCase(this._repository);

  final TransactionRepository _repository;

  @override
  Future<Either<Failure, Transaction>> call(Transaction params) {
    return _repository.addTransaction(params);
  }
}

class AddTransactionParams extends Equatable {
  const AddTransactionParams({required this.transaction});

  final Transaction transaction;

  @override
  List<Object?> get props => <Object?>[transaction];
}
