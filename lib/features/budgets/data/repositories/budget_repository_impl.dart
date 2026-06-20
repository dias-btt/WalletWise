import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/exceptions.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/core/network/network_info.dart';
import 'package:wallet_wise/features/budgets/data/datasources/budget_local_datasource.dart';
import 'package:wallet_wise/features/budgets/data/datasources/budget_remote_datasource.dart';
import 'package:wallet_wise/features/budgets/data/models/budget_model.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget.dart';
import 'package:wallet_wise/features/budgets/domain/entities/spending_by_category.dart';
import 'package:wallet_wise/features/budgets/domain/repositories/budget_repository.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  const BudgetRepositoryImpl(
    this._remoteDatasource,
    this._localDatasource,
    this._networkInfo,
  );

  final BudgetRemoteDatasource _remoteDatasource;
  final BudgetLocalDatasource _localDatasource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, List<Budget>>> getActiveBudgets(String userId) async {
    try {
      final List<BudgetModel>? cached =
          await _localDatasource.getCachedBudgets(userId);

      if (cached != null) {
        return Right<Failure, List<Budget>>(
          cached.map((BudgetModel model) => model.toEntity()).toList(),
        );
      }

      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        final List<BudgetModel>? stale =
            await _localDatasource.getStaleBudgets(userId);

        if (stale != null) {
          return Right<Failure, List<Budget>>(
            stale.map((BudgetModel model) => model.toEntity()).toList(),
          );
        }

        return const Left<Failure, List<Budget>>(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      final List<BudgetModel> remote =
          await _remoteDatasource.getActiveBudgets(userId);

      await _localDatasource.cacheBudgets(
        userId: userId,
        budgets: remote,
      );

      return Right<Failure, List<Budget>>(
        remote.map((BudgetModel model) => model.toEntity()).toList(),
      );
    } on AppException catch (error) {
      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        final List<BudgetModel>? stale =
            await _localDatasource.getStaleBudgets(userId);

        if (stale != null) {
          return Right<Failure, List<Budget>>(
            stale.map((BudgetModel model) => model.toEntity()).toList(),
          );
        }
      }

      return Left<Failure, List<Budget>>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, List<Budget>>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Budget>> createBudget(Budget budget) async {
    try {
      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        return const Left<Failure, Budget>(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      final BudgetModel model = await _remoteDatasource.createBudget(budget);
      final List<BudgetModel> refreshed =
          await _remoteDatasource.getActiveBudgets(budget.userId);
      await _localDatasource.cacheBudgets(
        userId: budget.userId,
        budgets: refreshed,
      );
      return Right<Failure, Budget>(model.toEntity());
    } on AppException catch (error) {
      return Left<Failure, Budget>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, Budget>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Budget>> updateBudget(Budget budget) async {
    try {
      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        return const Left<Failure, Budget>(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      final BudgetModel model = await _remoteDatasource.updateBudget(budget);
      final List<BudgetModel> refreshed =
          await _remoteDatasource.getActiveBudgets(budget.userId);
      await _localDatasource.cacheBudgets(
        userId: budget.userId,
        budgets: refreshed,
      );
      return Right<Failure, Budget>(model.toEntity());
    } on AppException catch (error) {
      return Left<Failure, Budget>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, Budget>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deactivateBudget(String budgetId) async {
    try {
      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        return const Left<Failure, void>(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      final BudgetModel? cached =
          await _localDatasource.getBudgetById(budgetId);
      await _remoteDatasource.deactivateBudget(budgetId);
      await _localDatasource.removeBudget(budgetId);
      if (cached != null) {
        final List<BudgetModel> refreshed =
            await _remoteDatasource.getActiveBudgets(cached.userId);
        await _localDatasource.cacheBudgets(
          userId: cached.userId,
          budgets: refreshed,
        );
      }
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
  Future<Either<Failure, double>> getBudgetProgress({
    required String budgetId,
    required DateTime periodStart,
    required DateTime periodEnd,
  }) async {
    try {
      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        return const Left<Failure, double>(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      final BudgetModel? budget =
          await _localDatasource.getBudgetById(budgetId);
      if (budget == null) {
        return const Left<Failure, double>(
          UnexpectedFailure(message: 'Budget not found'),
        );
      }

      final List<SpendingByCategory> spending =
          (await _remoteDatasource.getSpendingByCategory(
        userId: budget.userId,
        periodStart: periodStart,
        periodEnd: periodEnd,
      ))
              .map((model) => model.toEntity())
              .toList();

      for (final SpendingByCategory item in spending) {
        if (item.categoryId == budget.categoryId) {
          return Right<Failure, double>(item.total);
        }
      }

      return const Right<Failure, double>(0);
    } on AppException catch (error) {
      return Left<Failure, double>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, double>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, List<SpendingByCategory>>> getSpendingByCategory({
    required String userId,
    required DateTime periodStart,
    required DateTime periodEnd,
  }) async {
    try {
      final bool connected = await _networkInfo.isConnected;
      if (!connected) {
        return const Left<Failure, List<SpendingByCategory>>(
          NetworkFailure(message: 'No internet connection'),
        );
      }

      final List<SpendingByCategory> spending =
          (await _remoteDatasource.getSpendingByCategory(
        userId: userId,
        periodStart: periodStart,
        periodEnd: periodEnd,
      ))
              .map((model) => model.toEntity())
              .toList();

      return Right<Failure, List<SpendingByCategory>>(spending);
    } on AppException catch (error) {
      return Left<Failure, List<SpendingByCategory>>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, List<SpendingByCategory>>(
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
