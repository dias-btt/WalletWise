import 'package:equatable/equatable.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget_with_progress.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';

sealed class BudgetState extends Equatable {
  const BudgetState();

  @override
  List<Object?> get props => <Object?>[];
}

final class BudgetInitial extends BudgetState {
  const BudgetInitial();
}

final class BudgetLoading extends BudgetState {
  const BudgetLoading();
}

final class BudgetLoaded extends BudgetState {
  const BudgetLoaded({
    required this.budgetsWithProgress,
    this.categories = const <Category>[],
  });

  final List<BudgetWithProgress> budgetsWithProgress;
  final List<Category> categories;

  BudgetLoaded copyWith({
    List<BudgetWithProgress>? budgetsWithProgress,
    List<Category>? categories,
  }) {
    return BudgetLoaded(
      budgetsWithProgress: budgetsWithProgress ?? this.budgetsWithProgress,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        budgetsWithProgress,
        categories,
      ];
}

final class BudgetError extends BudgetState {
  const BudgetError(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
