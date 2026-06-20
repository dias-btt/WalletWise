import 'package:injectable/injectable.dart';
import 'package:wallet_wise/features/accounts/domain/repositories/account_repository.dart';
import 'package:wallet_wise/features/budgets/domain/usecases/get_budgets_with_progress_usecase.dart';
import 'package:wallet_wise/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:wallet_wise/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:wallet_wise/features/transactions/domain/usecases/get_categories_usecase.dart';

@module
abstract class DashboardModule {
  @lazySingleton
  DashboardBloc dashboardBloc(
    AccountRepository accountRepository,
    TransactionRepository transactionRepository,
    GetBudgetsWithProgressUseCase getBudgetsWithProgressUseCase,
    GetCategoriesUseCase getCategoriesUseCase,
  ) =>
      DashboardBloc(
        accountRepository: accountRepository,
        transactionRepository: transactionRepository,
        getBudgetsWithProgressUseCase: getBudgetsWithProgressUseCase,
        getCategoriesUseCase: getCategoriesUseCase,
      );
}
