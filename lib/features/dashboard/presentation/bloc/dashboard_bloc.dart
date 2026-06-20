import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/accounts/domain/entities/account.dart';
import 'package:wallet_wise/features/accounts/domain/repositories/account_repository.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget_ring_summary.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget_with_progress.dart';
import 'package:wallet_wise/features/budgets/domain/usecases/get_budgets_with_progress_usecase.dart';
import 'package:wallet_wise/features/budgets/domain/utils/budget_ring_mapper.dart';
import 'package:wallet_wise/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:wallet_wise/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';
import 'package:wallet_wise/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:wallet_wise/features/transactions/domain/usecases/get_categories_usecase.dart';
import 'package:wallet_wise/shared/domain/usecase.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({
    required AccountRepository accountRepository,
    required TransactionRepository transactionRepository,
    required GetBudgetsWithProgressUseCase getBudgetsWithProgressUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
  })  : _accountRepository = accountRepository,
        _transactionRepository = transactionRepository,
        _getBudgetsWithProgressUseCase = getBudgetsWithProgressUseCase,
        _getCategoriesUseCase = getCategoriesUseCase,
        super(const DashboardInitial()) {
    on<DashboardStarted>(_onDashboardStarted);
    on<DashboardRefreshed>(_onDashboardRefreshed);
  }

  final AccountRepository _accountRepository;
  final TransactionRepository _transactionRepository;
  final GetBudgetsWithProgressUseCase _getBudgetsWithProgressUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;

  String _userId = '';

  Future<void> _onDashboardStarted(
    DashboardStarted event,
    Emitter<DashboardState> emit,
  ) async {
    _userId = event.userId;
    await _loadDashboard(emit, showLoading: true);
  }

  Future<void> _onDashboardRefreshed(
    DashboardRefreshed event,
    Emitter<DashboardState> emit,
  ) async {
    if (_userId.isEmpty) {
      return;
    }
    await _loadDashboard(emit, showLoading: state is! DashboardLoaded);
  }

  Future<void> _loadDashboard(
    Emitter<DashboardState> emit, {
    required bool showLoading,
  }) async {
    if (showLoading) {
      emit(const DashboardLoading());
    }

    final Either<Failure, List<Account>> accountsResult =
        await _accountRepository.getAccounts(_userId);
    final Either<Failure, double> balanceResult =
        await _accountRepository.getTotalBalance(_userId);
    final Either<Failure, List<Transaction>> transactionsResult =
        await _transactionRepository.getRecentTransactions(limit: 5);
    final Either<Failure, List<BudgetWithProgress>> budgetsResult =
        await _getBudgetsWithProgressUseCase(
      GetBudgetsWithProgressParams(userId: _userId),
    );
    final Either<Failure, List<Category>> categoriesResult =
        await _getCategoriesUseCase(const NoParams());

    if (accountsResult.isLeft() && transactionsResult.isLeft()) {
      final Failure failure = accountsResult.fold(
        (Failure f) => f,
        (_) => const UnexpectedFailure(message: 'Unknown error'),
      );
      emit(DashboardError(failure.message));
      return;
    }

    final List<Account> accounts =
        accountsResult.getOrElse((_) => <Account>[]);
    final double totalBalance = balanceResult.getOrElse((_) {
      return accounts.fold<double>(
        0,
        (double sum, Account account) => sum + account.balance,
      );
    });
    final List<Transaction> recentTransactions =
        transactionsResult.getOrElse((_) => <Transaction>[]);
    final List<BudgetWithProgress> budgetsWithProgress =
        budgetsResult.getOrElse((_) => <BudgetWithProgress>[]);
    final List<Category> categories =
        categoriesResult.getOrElse((_) => <Category>[]);

    final List<BudgetRingSummary> budgetRings = budgetsWithProgress
        .map((BudgetWithProgress budget) {
          Category? category;
          for (final Category item in categories) {
            if (item.id == budget.categoryId) {
              category = item;
              break;
            }
          }
          return budgetWithProgressToRingSummary(budget, category);
        })
        .toList();

    final String currencyCode = accounts.isNotEmpty
        ? accounts.firstWhere(
            (Account account) => account.isPrimary,
            orElse: () => accounts.first,
          ).currencyCode
        : 'USD';

    emit(
      DashboardLoaded(
        totalBalance: totalBalance,
        accounts: accounts,
        recentTransactions: recentTransactions,
        budgetRings: budgetRings,
        currencyCode: currencyCode,
      ),
    );
  }
}
