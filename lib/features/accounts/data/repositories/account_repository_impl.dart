import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/exceptions.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/core/network/network_info.dart';
import 'package:wallet_wise/features/accounts/data/datasources/account_local_datasource.dart';
import 'package:wallet_wise/features/accounts/data/datasources/account_remote_datasource.dart';
import 'package:wallet_wise/features/accounts/data/models/account_model.dart';
import 'package:wallet_wise/features/accounts/domain/entities/account.dart';
import 'package:wallet_wise/features/accounts/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  const AccountRepositoryImpl(
    this._remoteDatasource,
    this._localDatasource,
    this._networkInfo,
  );

  final AccountRemoteDatasource _remoteDatasource;
  final AccountLocalDatasource _localDatasource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, List<Account>>> getAccounts(String userId) async {
    try {
      final List<AccountModel>? cached =
          await _localDatasource.getCachedAccounts(userId);

      if (cached != null) {
        return Right<Failure, List<Account>>(
          cached.map((AccountModel model) => model.toEntity()).toList(),
        );
      }

      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        final List<AccountModel>? stale =
            await _localDatasource.getStaleAccounts(userId);

        if (stale != null) {
          return Right<Failure, List<Account>>(
            stale.map((AccountModel model) => model.toEntity()).toList(),
          );
        }

        return const Left<Failure, List<Account>>(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      final List<AccountModel> remote =
          await _remoteDatasource.getAccounts(userId);

      await _localDatasource.cacheAccounts(
        userId: userId,
        accounts: remote,
      );

      return Right<Failure, List<Account>>(
        remote.map((AccountModel model) => model.toEntity()).toList(),
      );
    } on AppException catch (error) {
      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        final List<AccountModel>? stale =
            await _localDatasource.getStaleAccounts(userId);

        if (stale != null) {
          return Right<Failure, List<Account>>(
            stale.map((AccountModel model) => model.toEntity()).toList(),
          );
        }
      }

      return Left<Failure, List<Account>>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, List<Account>>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, double>> getTotalBalance(String userId) async {
    final Either<Failure, List<Account>> result = await getAccounts(userId);

    return result.map(
      (List<Account> accounts) => accounts.fold<double>(
        0,
        (double sum, Account account) => sum + account.balance,
      ),
    );
  }

  @override
  Future<Either<Failure, Account>> createAccount(Account account) async {
    try {
      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        return const Left<Failure, Account>(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      final AccountModel model =
          await _remoteDatasource.createAccount(account);
      await _localDatasource.upsertAccount(model);
      return Right<Failure, Account>(model.toEntity());
    } on AppException catch (error) {
      return Left<Failure, Account>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, Account>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Account>> updateAccount(Account account) async {
    try {
      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        return const Left<Failure, Account>(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      final AccountModel model =
          await _remoteDatasource.updateAccount(account);
      await _localDatasource.upsertAccount(model);
      return Right<Failure, Account>(model.toEntity());
    } on AppException catch (error) {
      return Left<Failure, Account>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, Account>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(String id) async {
    try {
      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        return const Left<Failure, void>(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      await _remoteDatasource.deleteAccount(id);
      await _localDatasource.removeAccount(id);
      return const Right<Failure, void>(null);
    } on AppException catch (error) {
      return Left<Failure, void>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, void>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  Failure _mapAppException(AppException exception) {
    return switch (exception) {
      NetworkException() => NetworkFailure(message: exception.message),
      CacheException() => CacheFailure(message: exception.message),
      UnexpectedException() => UnexpectedFailure(message: exception.message),
      _ => UnexpectedFailure(message: exception.message),
    };
  }
}
