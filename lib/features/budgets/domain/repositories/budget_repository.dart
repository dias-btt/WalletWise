import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget.dart';
import 'package:wallet_wise/features/budgets/domain/entities/spending_by_category.dart';

abstract class BudgetRepository {
  Future<Either<Failure, List<Budget>>> getActiveBudgets(String userId);

  Future<Either<Failure, Budget>> createBudget(Budget budget);

  Future<Either<Failure, Budget>> updateBudget(Budget budget);

  Future<Either<Failure, void>> deactivateBudget(String budgetId);

  Future<Either<Failure, double>> getBudgetProgress({
    required String budgetId,
    required DateTime periodStart,
    required DateTime periodEnd,
  });

  Future<Either<Failure, List<SpendingByCategory>>> getSpendingByCategory({
    required String userId,
    required DateTime periodStart,
    required DateTime periodEnd,
  });
}
