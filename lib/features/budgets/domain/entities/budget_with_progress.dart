import 'package:wallet_wise/features/budgets/domain/entities/budget.dart';

class BudgetWithProgress extends Budget {
  const BudgetWithProgress({
    required super.id,
    required super.userId,
    required super.categoryId,
    required super.limitAmount,
    required super.currencyCode,
    required super.period,
    required super.startDate,
    required super.isActive,
    required this.spentAmount,
    required this.progressPercentage,
    required this.remainingAmount,
  });

  final double spentAmount;
  final double progressPercentage;
  final double remainingAmount;

  @override
  List<Object?> get props => <Object?>[
        ...super.props,
        spentAmount,
        progressPercentage,
        remainingAmount,
      ];
}
