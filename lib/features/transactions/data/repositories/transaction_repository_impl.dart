import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/exceptions.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/core/network/network_info.dart';
import 'package:wallet_wise/features/transactions/data/datasources/transaction_local_datasource.dart';
import 'package:wallet_wise/features/transactions/data/datasources/transaction_remote_datasource.dart';
import 'package:wallet_wise/features/transactions/data/models/transaction_model.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';
import 'package:wallet_wise/features/transactions/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  const TransactionRepositoryImpl(
    this._remoteDatasource,
    this._localDatasource,
    this._networkInfo,
  );

  final TransactionRemoteDatasource _remoteDatasource;
  final TransactionLocalDatasource _localDatasource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions(
    GetTransactionsParams params,
  ) async {
    final String cacheKey = TransactionLocalDatasourceImpl.buildCacheKey(params);

    try {
      final List<TransactionModel>? cached =
          await _localDatasource.getCachedTransactions(
        cacheKey: cacheKey,
        accountId: params.accountId,
        offset: params.offset,
        limit: params.limit,
      );

      if (cached != null) {
        return Right<Failure, List<Transaction>>(
          cached.map((TransactionModel model) => model.toEntity()).toList(),
        );
      }

      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        final List<TransactionModel>? stale = await _localDatasource.getStaleCache(
          accountId: params.accountId,
          offset: params.offset,
          limit: params.limit,
        );

        if (stale != null) {
          return Right<Failure, List<Transaction>>(
            stale.map((TransactionModel model) => model.toEntity()).toList(),
          );
        }

        return const Left<Failure, List<Transaction>>(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      final List<TransactionModel> remote =
          await _remoteDatasource.getTransactions(params);

      await _localDatasource.cacheTransactions(
        cacheKey: cacheKey,
        transactions: remote,
      );

      return Right<Failure, List<Transaction>>(
        remote.map((TransactionModel model) => model.toEntity()).toList(),
      );
    } on AppException catch (error) {
      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        final List<TransactionModel>? stale = await _localDatasource.getStaleCache(
          accountId: params.accountId,
          offset: params.offset,
          limit: params.limit,
        );

        if (stale != null) {
          return Right<Failure, List<Transaction>>(
            stale.map((TransactionModel model) => model.toEntity()).toList(),
          );
        }
      }

      return Left<Failure, List<Transaction>>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, List<Transaction>>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getRecentTransactions({
    required int limit,
  }) async {
    const String cacheKey = 'recent_transactions';

    try {
      final List<TransactionModel>? cached =
          await _localDatasource.getCachedTransactions(
        cacheKey: '$cacheKey|$limit',
        accountId: '',
        offset: 0,
        limit: limit,
      );

      if (cached != null) {
        return Right<Failure, List<Transaction>>(
          cached.map((TransactionModel model) => model.toEntity()).toList(),
        );
      }

      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        final List<TransactionModel>? stale = await _localDatasource.getStaleCache(
          accountId: '',
          offset: 0,
          limit: limit,
        );

        if (stale != null) {
          return Right<Failure, List<Transaction>>(
            stale.map((TransactionModel model) => model.toEntity()).toList(),
          );
        }

        return const Left<Failure, List<Transaction>>(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      final List<TransactionModel> remote =
          await _remoteDatasource.getRecentTransactions(limit: limit);

      await _localDatasource.cacheTransactions(
        cacheKey: '$cacheKey|$limit',
        transactions: remote,
      );

      return Right<Failure, List<Transaction>>(
        remote.map((TransactionModel model) => model.toEntity()).toList(),
      );
    } on AppException catch (error) {
      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        final List<TransactionModel>? stale = await _localDatasource.getStaleCache(
          accountId: '',
          offset: 0,
          limit: limit,
        );

        if (stale != null) {
          return Right<Failure, List<Transaction>>(
            stale.map((TransactionModel model) => model.toEntity()).toList(),
          );
        }
      }

      return Left<Failure, List<Transaction>>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, List<Transaction>>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Transaction>> addTransaction(
    Transaction transaction,
  ) async {
    try {
      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        return const Left<Failure, Transaction>(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      final TransactionModel model =
          await _remoteDatasource.addTransaction(transaction);
      await _localDatasource.upsertTransaction(model);
      return Right<Failure, Transaction>(model.toEntity());
    } on AppException catch (error) {
      return Left<Failure, Transaction>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, Transaction>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Transaction>> updateTransaction(
    Transaction transaction,
  ) async {
    try {
      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        return const Left<Failure, Transaction>(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      final TransactionModel model =
          await _remoteDatasource.updateTransaction(transaction);
      await _localDatasource.upsertTransaction(model);
      return Right<Failure, Transaction>(model.toEntity());
    } on AppException catch (error) {
      return Left<Failure, Transaction>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, Transaction>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String id) async {
    try {
      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        return const Left<Failure, void>(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      await _remoteDatasource.deleteTransaction(id);
      await _localDatasource.removeTransaction(id);
      return const Right<Failure, void>(null);
    } on AppException catch (error) {
      return Left<Failure, void>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, void>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<void> clearLocalCache() {
    return _localDatasource.clearCache();
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
