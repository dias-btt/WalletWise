import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/accounts/domain/entities/account.dart';

abstract class AccountRepository {
  Future<Either<Failure, List<Account>>> getAccounts(String userId);

  Future<Either<Failure, double>> getTotalBalance(String userId);

  Future<Either<Failure, Account>> createAccount(Account account);

  Future<Either<Failure, Account>> updateAccount(Account account);

  Future<Either<Failure, void>> deleteAccount(String id);
}
