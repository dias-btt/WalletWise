// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:isar_community/isar.dart' as _i214;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;
import 'package:wallet_wise/core/network/dio_client.dart' as _i484;
import 'package:wallet_wise/core/network/network_info.dart' as _i4;
import 'package:wallet_wise/core/router/app_router.dart' as _i558;
import 'package:wallet_wise/features/accounts/accounts_module.dart' as _i483;
import 'package:wallet_wise/features/accounts/data/datasources/account_local_datasource.dart'
    as _i465;
import 'package:wallet_wise/features/accounts/data/datasources/account_remote_datasource.dart'
    as _i802;
import 'package:wallet_wise/features/accounts/domain/repositories/account_repository.dart'
    as _i474;
import 'package:wallet_wise/features/accounts/presentation/bloc/account_bloc.dart'
    as _i549;
import 'package:wallet_wise/features/auth/auth_module.dart' as _i1022;
import 'package:wallet_wise/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i991;
import 'package:wallet_wise/features/auth/domain/repositories/auth_repository.dart'
    as _i666;
import 'package:wallet_wise/features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i545;
import 'package:wallet_wise/features/auth/domain/usecases/sign_in_usecase.dart'
    as _i1019;
import 'package:wallet_wise/features/auth/domain/usecases/sign_out_usecase.dart'
    as _i298;
import 'package:wallet_wise/features/auth/domain/usecases/sign_up_usecase.dart'
    as _i963;
import 'package:wallet_wise/features/auth/presentation/bloc/auth_bloc.dart'
    as _i650;
import 'package:wallet_wise/features/budgets/budgets_module.dart' as _i541;
import 'package:wallet_wise/features/budgets/data/datasources/budget_remote_datasource.dart'
    as _i831;
import 'package:wallet_wise/features/budgets/domain/repositories/budget_repository.dart'
    as _i890;
import 'package:wallet_wise/features/dashboard/dashboard_module.dart' as _i829;
import 'package:wallet_wise/features/dashboard/presentation/bloc/dashboard_bloc.dart'
    as _i768;
import 'package:wallet_wise/features/transactions/data/datasources/category_remote_datasource.dart'
    as _i484;
import 'package:wallet_wise/features/transactions/data/datasources/transaction_local_datasource.dart'
    as _i283;
import 'package:wallet_wise/features/transactions/data/datasources/transaction_remote_datasource.dart'
    as _i33;
import 'package:wallet_wise/features/transactions/domain/repositories/category_repository.dart'
    as _i688;
import 'package:wallet_wise/features/transactions/domain/repositories/transaction_repository.dart'
    as _i58;
import 'package:wallet_wise/features/transactions/domain/usecases/add_transaction_usecase.dart'
    as _i401;
import 'package:wallet_wise/features/transactions/domain/usecases/delete_transaction_usecase.dart'
    as _i128;
import 'package:wallet_wise/features/transactions/domain/usecases/get_categories_usecase.dart'
    as _i314;
import 'package:wallet_wise/features/transactions/domain/usecases/get_transactions_usecase.dart'
    as _i276;
import 'package:wallet_wise/features/transactions/domain/usecases/update_transaction_usecase.dart'
    as _i433;
import 'package:wallet_wise/features/transactions/presentation/bloc/transaction_bloc.dart'
    as _i936;
import 'package:wallet_wise/features/transactions/transactions_module.dart'
    as _i1017;
import 'package:wallet_wise/injection_container.dart' as _i244;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    final accountsModule = _$AccountsModule();
    final transactionsModule = _$TransactionsModule();
    final authModule = _$AuthModule();
    final budgetsModule = _$BudgetsModule();
    final dashboardModule = _$DashboardModule();
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => appModule.prefs(),
      preResolve: true,
    );
    gh.singleton<_i214.Isar>(() => appModule.isar());
    gh.lazySingleton<_i454.SupabaseClient>(() => appModule.supabaseClient());
    gh.lazySingleton<_i895.Connectivity>(() => appModule.connectivity());
    gh.lazySingleton<_i484.DioClient>(
      () => _i484.DioClient.create(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i465.AccountLocalDatasource>(
      () => accountsModule.accountLocalDatasource(gh<_i214.Isar>()),
    );
    gh.lazySingleton<_i484.CategoryRemoteDatasource>(
      () => transactionsModule.categoryRemoteDatasource(
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i4.NetworkInfo>(
      () => _i4.NetworkInfo(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i991.AuthRemoteDatasource>(
      () => authModule.authRemoteDatasource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i831.BudgetRemoteDatasource>(
      () => budgetsModule.budgetRemoteDatasource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i33.TransactionRemoteDatasource>(
      () => transactionsModule.transactionRemoteDatasource(
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i890.BudgetRepository>(
      () => budgetsModule.budgetRepository(
        gh<_i831.BudgetRemoteDatasource>(),
        gh<_i4.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i558.AppRouter>(
      () => _i558.AppRouter(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i802.AccountRemoteDatasource>(
      () => accountsModule.accountRemoteDatasource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i666.AuthRepository>(
      () => authModule.authRepository(gh<_i991.AuthRemoteDatasource>()),
    );
    gh.lazySingleton<_i474.AccountRepository>(
      () => accountsModule.accountRepository(
        gh<_i802.AccountRemoteDatasource>(),
        gh<_i465.AccountLocalDatasource>(),
        gh<_i4.NetworkInfo>(),
      ),
    );
    gh.factory<_i1019.SignInUseCase>(
      () => authModule.signInUseCase(gh<_i666.AuthRepository>()),
    );
    gh.factory<_i963.SignUpUseCase>(
      () => authModule.signUpUseCase(gh<_i666.AuthRepository>()),
    );
    gh.factory<_i298.SignOutUseCase>(
      () => authModule.signOutUseCase(gh<_i666.AuthRepository>()),
    );
    gh.factory<_i545.GetCurrentUserUseCase>(
      () => authModule.getCurrentUserUseCase(gh<_i666.AuthRepository>()),
    );
    gh.lazySingleton<_i283.TransactionLocalDatasource>(
      () => transactionsModule.transactionLocalDatasource(gh<_i214.Isar>()),
    );
    gh.lazySingleton<_i650.AuthBloc>(
      () => authModule.authBloc(
        gh<_i1019.SignInUseCase>(),
        gh<_i963.SignUpUseCase>(),
        gh<_i298.SignOutUseCase>(),
        gh<_i545.GetCurrentUserUseCase>(),
        gh<_i666.AuthRepository>(),
      ),
    );
    gh.lazySingleton<_i549.AccountBloc>(
      () => accountsModule.accountBloc(gh<_i474.AccountRepository>()),
    );
    gh.lazySingleton<_i688.CategoryRepository>(
      () => transactionsModule.categoryRepository(
        gh<_i484.CategoryRemoteDatasource>(),
      ),
    );
    gh.lazySingleton<_i58.TransactionRepository>(
      () => transactionsModule.transactionRepository(
        gh<_i33.TransactionRemoteDatasource>(),
        gh<_i283.TransactionLocalDatasource>(),
        gh<_i4.NetworkInfo>(),
      ),
    );
    gh.factory<_i314.GetCategoriesUseCase>(
      () => transactionsModule.getCategoriesUseCase(
        gh<_i688.CategoryRepository>(),
      ),
    );
    gh.factory<_i276.GetTransactionsUseCase>(
      () => transactionsModule.getTransactionsUseCase(
        gh<_i58.TransactionRepository>(),
      ),
    );
    gh.factory<_i401.AddTransactionUseCase>(
      () => transactionsModule.addTransactionUseCase(
        gh<_i58.TransactionRepository>(),
      ),
    );
    gh.factory<_i433.UpdateTransactionUseCase>(
      () => transactionsModule.updateTransactionUseCase(
        gh<_i58.TransactionRepository>(),
      ),
    );
    gh.factory<_i128.DeleteTransactionUseCase>(
      () => transactionsModule.deleteTransactionUseCase(
        gh<_i58.TransactionRepository>(),
      ),
    );
    gh.lazySingleton<_i768.DashboardBloc>(
      () => dashboardModule.dashboardBloc(
        gh<_i474.AccountRepository>(),
        gh<_i58.TransactionRepository>(),
        gh<_i890.BudgetRepository>(),
      ),
    );
    gh.lazySingleton<_i936.TransactionBloc>(
      () => transactionsModule.transactionBloc(
        gh<_i276.GetTransactionsUseCase>(),
        gh<_i401.AddTransactionUseCase>(),
        gh<_i433.UpdateTransactionUseCase>(),
        gh<_i128.DeleteTransactionUseCase>(),
        gh<_i314.GetCategoriesUseCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i244.AppModule {}

class _$AccountsModule extends _i483.AccountsModule {}

class _$TransactionsModule extends _i1017.TransactionsModule {}

class _$AuthModule extends _i1022.AuthModule {}

class _$BudgetsModule extends _i541.BudgetsModule {}

class _$DashboardModule extends _i829.DashboardModule {}
