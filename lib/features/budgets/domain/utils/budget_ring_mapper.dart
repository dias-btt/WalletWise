import 'package:wallet_wise/features/budgets/domain/entities/budget_ring_summary.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget_with_progress.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';

BudgetRingSummary budgetWithProgressToRingSummary(
  BudgetWithProgress budget,
  Category? category,
) {
  return BudgetRingSummary(
    categoryName: category?.name ?? 'Budget',
    spent: budget.spentAmount,
    limit: budget.limitAmount,
    colorHex: category?.colorHex ?? '14213D',
    categoryIconName: category?.iconName,
  );
}
