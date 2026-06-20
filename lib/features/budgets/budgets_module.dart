import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet_wise/core/network/network_info.dart';
import 'package:wallet_wise/features/budgets/data/datasources/budget_remote_datasource.dart';
import 'package:wallet_wise/features/budgets/data/repositories/budget_repository_impl.dart';
import 'package:wallet_wise/features/budgets/domain/repositories/budget_repository.dart';

@module
abstract class BudgetsModule {
  @LazySingleton(as: BudgetRemoteDatasource)
  BudgetRemoteDatasourceImpl budgetRemoteDatasource(SupabaseClient client) =>
      BudgetRemoteDatasourceImpl(client);

  @LazySingleton(as: BudgetRepository)
  BudgetRepositoryImpl budgetRepository(
    BudgetRemoteDatasource remoteDatasource,
    NetworkInfo networkInfo,
  ) =>
      BudgetRepositoryImpl(remoteDatasource, networkInfo);
}
