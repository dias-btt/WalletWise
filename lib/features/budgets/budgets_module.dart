import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet_wise/core/network/network_info.dart';
import 'package:wallet_wise/features/budgets/data/datasources/budget_local_datasource.dart';
import 'package:wallet_wise/features/budgets/data/datasources/budget_remote_datasource.dart';
import 'package:wallet_wise/features/budgets/data/repositories/budget_repository_impl.dart';
import 'package:wallet_wise/features/budgets/domain/repositories/budget_repository.dart';
import 'package:wallet_wise/features/budgets/domain/usecases/create_budget_usecase.dart';
import 'package:wallet_wise/features/budgets/domain/usecases/deactivate_budget_usecase.dart';
import 'package:wallet_wise/features/budgets/domain/usecases/get_budgets_with_progress_usecase.dart';
import 'package:wallet_wise/features/budgets/domain/usecases/update_budget_usecase.dart';
import 'package:wallet_wise/features/budgets/presentation/bloc/budget_bloc.dart';
import 'package:wallet_wise/features/transactions/domain/usecases/get_categories_usecase.dart';

@module
abstract class BudgetsModule {
  @LazySingleton(as: BudgetRemoteDatasource)
  BudgetRemoteDatasourceImpl budgetRemoteDatasource(SupabaseClient client) =>
      BudgetRemoteDatasourceImpl(client);

  @LazySingleton(as: BudgetLocalDatasource)
  BudgetLocalDatasourceImpl budgetLocalDatasource(Isar isar) =>
      BudgetLocalDatasourceImpl(isar);

  @LazySingleton(as: BudgetRepository)
  BudgetRepositoryImpl budgetRepository(
    BudgetRemoteDatasource remoteDatasource,
    BudgetLocalDatasource localDatasource,
    NetworkInfo networkInfo,
  ) =>
      BudgetRepositoryImpl(
        remoteDatasource,
        localDatasource,
        networkInfo,
      );

  @injectable
  GetBudgetsWithProgressUseCase getBudgetsWithProgressUseCase(
    BudgetRepository repository,
  ) =>
      GetBudgetsWithProgressUseCase(repository);

  @injectable
  CreateBudgetUseCase createBudgetUseCase(BudgetRepository repository) =>
      CreateBudgetUseCase(repository);

  @injectable
  UpdateBudgetUseCase updateBudgetUseCase(BudgetRepository repository) =>
      UpdateBudgetUseCase(repository);

  @injectable
  DeactivateBudgetUseCase deactivateBudgetUseCase(
    BudgetRepository repository,
  ) =>
      DeactivateBudgetUseCase(repository);

  @lazySingleton
  BudgetBloc budgetBloc(
    GetBudgetsWithProgressUseCase getBudgetsWithProgressUseCase,
    CreateBudgetUseCase createBudgetUseCase,
    DeactivateBudgetUseCase deactivateBudgetUseCase,
    GetCategoriesUseCase getCategoriesUseCase,
  ) =>
      BudgetBloc(
        getBudgetsWithProgressUseCase: getBudgetsWithProgressUseCase,
        createBudgetUseCase: createBudgetUseCase,
        deactivateBudgetUseCase: deactivateBudgetUseCase,
        getCategoriesUseCase: getCategoriesUseCase,
      );
}
