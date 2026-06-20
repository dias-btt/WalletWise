import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget_with_progress.dart';
import 'package:wallet_wise/features/budgets/domain/usecases/create_budget_usecase.dart';
import 'package:wallet_wise/features/budgets/domain/usecases/deactivate_budget_usecase.dart';
import 'package:wallet_wise/features/budgets/domain/usecases/get_budgets_with_progress_usecase.dart';
import 'package:wallet_wise/features/budgets/presentation/bloc/budget_event.dart';
import 'package:wallet_wise/features/budgets/presentation/bloc/budget_state.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';
import 'package:wallet_wise/features/transactions/domain/usecases/get_categories_usecase.dart';
import 'package:wallet_wise/shared/domain/usecase.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  BudgetBloc({
    required GetBudgetsWithProgressUseCase getBudgetsWithProgressUseCase,
    required CreateBudgetUseCase createBudgetUseCase,
    required DeactivateBudgetUseCase deactivateBudgetUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
  })  : _getBudgetsWithProgressUseCase = getBudgetsWithProgressUseCase,
        _createBudgetUseCase = createBudgetUseCase,
        _deactivateBudgetUseCase = deactivateBudgetUseCase,
        _getCategoriesUseCase = getCategoriesUseCase,
        super(const BudgetInitial()) {
    on<LoadBudgets>(_onLoadBudgets);
    on<CreateBudget>(_onCreateBudget);
    on<DeactivateBudget>(_onDeactivateBudget);
    on<BudgetCategoriesRequested>(_onCategoriesRequested);
  }

  final GetBudgetsWithProgressUseCase _getBudgetsWithProgressUseCase;
  final CreateBudgetUseCase _createBudgetUseCase;
  final DeactivateBudgetUseCase _deactivateBudgetUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;

  String _userId = '';
  List<Category> _categories = <Category>[];

  Future<void> _onLoadBudgets(
    LoadBudgets event,
    Emitter<BudgetState> emit,
  ) async {
    _userId = event.userId;
    emit(const BudgetLoading());
    add(const BudgetCategoriesRequested());

    final Either<Failure, List<BudgetWithProgress>> result =
        await _getBudgetsWithProgressUseCase(
      GetBudgetsWithProgressParams(userId: event.userId),
    );

    result.fold(
      (Failure failure) => emit(BudgetError(failure.message)),
      (List<BudgetWithProgress> budgets) => emit(
        BudgetLoaded(
          budgetsWithProgress: budgets,
          categories: _categories,
        ),
      ),
    );
  }

  Future<void> _onCreateBudget(
    CreateBudget event,
    Emitter<BudgetState> emit,
  ) async {
    final Either<Failure, Budget> result =
        await _createBudgetUseCase(event.budget);

    await result.fold(
      (Failure failure) async => emit(BudgetError(failure.message)),
      (_) async {
        if (_userId.isNotEmpty) {
          add(LoadBudgets(_userId));
        }
      },
    );
  }

  Future<void> _onDeactivateBudget(
    DeactivateBudget event,
    Emitter<BudgetState> emit,
  ) async {
    final Either<Failure, void> result = await _deactivateBudgetUseCase(
      DeactivateBudgetParams(budgetId: event.budgetId),
    );

    await result.fold(
      (Failure failure) async => emit(BudgetError(failure.message)),
      (_) async {
        if (_userId.isNotEmpty) {
          add(LoadBudgets(_userId));
        }
      },
    );
  }

  Future<void> _onCategoriesRequested(
    BudgetCategoriesRequested event,
    Emitter<BudgetState> emit,
  ) async {
    final Either<Failure, List<Category>> result =
        await _getCategoriesUseCase(const NoParams());

    result.fold(
      (_) {},
      (List<Category> categories) {
        _categories = categories;
        if (state is BudgetLoaded) {
          emit((state as BudgetLoaded).copyWith(categories: categories));
        }
      },
    );
  }
}
