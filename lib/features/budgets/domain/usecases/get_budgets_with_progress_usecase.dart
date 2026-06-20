import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget_with_progress.dart';
import 'package:wallet_wise/features/budgets/domain/entities/spending_by_category.dart';
import 'package:wallet_wise/features/budgets/domain/repositories/budget_repository.dart';
import 'package:wallet_wise/features/budgets/domain/utils/budget_period_utils.dart';
import 'package:wallet_wise/shared/domain/usecase.dart';

class GetBudgetsWithProgressParams extends Equatable {
  const GetBudgetsWithProgressParams({required this.userId});

  final String userId;

  @override
  List<Object?> get props => <Object?>[userId];
}

class GetBudgetsWithProgressUseCase
    extends UseCase<List<BudgetWithProgress>, GetBudgetsWithProgressParams> {
  GetBudgetsWithProgressUseCase(this._repository);

  final BudgetRepository _repository;

  @override
  Future<Either<Failure, List<BudgetWithProgress>>> call(
    GetBudgetsWithProgressParams params,
  ) async {
    final Either<Failure, List<Budget>> budgetsResult =
        await _repository.getActiveBudgets(params.userId);

    return budgetsResult.fold(
      Left.new,
      (List<Budget> budgets) => _buildWithProgress(params.userId, budgets),
    );
  }

  Future<Either<Failure, List<BudgetWithProgress>>> _buildWithProgress(
    String userId,
    List<Budget> budgets,
  ) async {
    if (budgets.isEmpty) {
      return const Right<Failure, List<BudgetWithProgress>>(<BudgetWithProgress>[]);
    }

    final Map<String, BudgetPeriodRange> periodByBudgetId =
        <String, BudgetPeriodRange>{};
    final Map<String, List<Budget>> budgetsByPeriodKey =
        <String, List<Budget>>{};

    for (final Budget budget in budgets) {
      final BudgetPeriodRange period =
          BudgetPeriodUtils.getCurrentPeriod(budget);
      periodByBudgetId[budget.id] = period;
      final String periodKey =
          '${period.start.toIso8601String()}|${period.end.toIso8601String()}';
      budgetsByPeriodKey.putIfAbsent(periodKey, () => <Budget>[]).add(budget);
    }

    final Map<String, double> spentByBudgetId = <String, double>{};

    for (final MapEntry<String, List<Budget>> entry
        in budgetsByPeriodKey.entries) {
      final BudgetPeriodRange period =
          BudgetPeriodUtils.getCurrentPeriod(entry.value.first);
      final Either<Failure, List<SpendingByCategory>> spendingResult =
          await _repository.getSpendingByCategory(
        userId: userId,
        periodStart: period.start,
        periodEnd: period.end,
      );

      if (spendingResult.isLeft()) {
        return Left<Failure, List<BudgetWithProgress>>(
          spendingResult.fold((Failure f) => f, (_) => throw StateError('')),
        );
      }

      final List<SpendingByCategory> spending =
          spendingResult.getOrElse((_) => <SpendingByCategory>[]);

      for (final Budget budget in entry.value) {
        SpendingByCategory? match;
        for (final SpendingByCategory item in spending) {
          if (item.categoryId == budget.categoryId) {
            match = item;
            break;
          }
        }
        spentByBudgetId[budget.id] = match?.total ?? 0;
      }
    }

    final List<BudgetWithProgress> result = budgets.map((Budget budget) {
      final double spent = spentByBudgetId[budget.id] ?? 0;
      final double progress =
          budget.limitAmount > 0 ? (spent / budget.limitAmount) * 100 : 0;
      final double remaining =
          (budget.limitAmount - spent).clamp(0, double.infinity).toDouble();

      return BudgetWithProgress(
        id: budget.id,
        userId: budget.userId,
        categoryId: budget.categoryId,
        limitAmount: budget.limitAmount,
        currencyCode: budget.currencyCode,
        period: budget.period,
        startDate: budget.startDate,
        isActive: budget.isActive,
        spentAmount: spent,
        progressPercentage: progress,
        remainingAmount: remaining,
      );
    }).toList();

    return Right<Failure, List<BudgetWithProgress>>(result);
  }
}
