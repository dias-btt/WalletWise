import 'package:equatable/equatable.dart';
import 'package:wallet_wise/features/accounts/domain/entities/account.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget_ring_summary.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => <Object?>[];
}

final class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

final class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

final class DashboardLoaded extends DashboardState {
  const DashboardLoaded({
    required this.totalBalance,
    required this.accounts,
    required this.recentTransactions,
    required this.budgetRings,
    required this.currencyCode,
  });

  final double totalBalance;
  final List<Account> accounts;
  final List<Transaction> recentTransactions;
  final List<BudgetRingSummary> budgetRings;
  final String currencyCode;

  @override
  List<Object?> get props => <Object?>[
        totalBalance,
        accounts,
        recentTransactions,
        budgetRings,
        currencyCode,
      ];
}

final class DashboardError extends DashboardState {
  const DashboardError(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
