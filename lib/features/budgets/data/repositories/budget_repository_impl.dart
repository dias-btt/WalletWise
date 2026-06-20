import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/exceptions.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/core/network/network_info.dart';
import 'package:wallet_wise/features/budgets/data/datasources/budget_remote_datasource.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget_ring_summary.dart';
import 'package:wallet_wise/features/budgets/domain/repositories/budget_repository.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  const BudgetRepositoryImpl(
    this._remoteDatasource,
    this._networkInfo,
  );

  final BudgetRemoteDatasource _remoteDatasource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, List<BudgetRingSummary>>> getActiveBudgetsSummary(
    String userId,
  ) async {
    try {
      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        return const Right<Failure, List<BudgetRingSummary>>(<BudgetRingSummary>[]);
      }

      final List<BudgetRingSummary> summaries =
          await _remoteDatasource.getActiveBudgetsSummary(userId);

      return Right<Failure, List<BudgetRingSummary>>(summaries);
    } on AppException catch (error) {
      return Left<Failure, List<BudgetRingSummary>>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, List<BudgetRingSummary>>(
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
