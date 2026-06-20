import 'package:injectable/injectable.dart';
import 'package:wallet_wise/features/accounts/domain/repositories/account_repository.dart';
import 'package:wallet_wise/features/budgets/domain/repositories/budget_repository.dart';
import 'package:wallet_wise/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:wallet_wise/features/transactions/domain/repositories/transaction_repository.dart';

@module
abstract class DashboardModule {
  @lazySingleton
  DashboardBloc dashboardBloc(
    AccountRepository accountRepository,
    TransactionRepository transactionRepository,
    BudgetRepository budgetRepository,
  ) =>
      DashboardBloc(
        accountRepository: accountRepository,
        transactionRepository: transactionRepository,
        budgetRepository: budgetRepository,
      );
}
