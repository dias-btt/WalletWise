import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';

class GetTransactionsParams {
  const GetTransactionsParams({
    required this.accountId,
    this.offset = 0,
    this.limit = 20,
    this.type,
    this.searchQuery,
    this.categoryId,
    this.startDate,
    this.endDate,
  });

  final String accountId;
  final int offset;
  final int limit;
  final TransactionType? type;
  final String? searchQuery;
  final String? categoryId;
  final DateTime? startDate;
  final DateTime? endDate;
}

abstract class TransactionRepository {
  Future<Either<Failure, List<Transaction>>> getTransactions(
    GetTransactionsParams params,
  );

  Future<Either<Failure, Transaction>> addTransaction(Transaction transaction);

  Future<Either<Failure, Transaction>> updateTransaction(
    Transaction transaction,
  );

  Future<Either<Failure, void>> deleteTransaction(String id);

  Future<void> clearLocalCache();
}
