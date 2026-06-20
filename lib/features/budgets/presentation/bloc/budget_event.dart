import 'package:equatable/equatable.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget.dart';

sealed class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object?> get props => <Object?>[];
}

final class LoadBudgets extends BudgetEvent {
  const LoadBudgets(this.userId);

  final String userId;

  @override
  List<Object?> get props => <Object?>[userId];
}

final class CreateBudget extends BudgetEvent {
  const CreateBudget(this.budget);

  final Budget budget;

  @override
  List<Object?> get props => <Object?>[budget];
}

final class DeactivateBudget extends BudgetEvent {
  const DeactivateBudget(this.budgetId);

  final String budgetId;

  @override
  List<Object?> get props => <Object?>[budgetId];
}

final class BudgetCategoriesRequested extends BudgetEvent {
  const BudgetCategoriesRequested();
}
