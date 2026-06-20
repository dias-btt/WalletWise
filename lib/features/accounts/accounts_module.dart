import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet_wise/core/network/network_info.dart';
import 'package:wallet_wise/features/accounts/data/datasources/account_local_datasource.dart';
import 'package:wallet_wise/features/accounts/data/datasources/account_remote_datasource.dart';
import 'package:wallet_wise/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:wallet_wise/features/accounts/domain/repositories/account_repository.dart';
import 'package:wallet_wise/features/accounts/presentation/bloc/account_bloc.dart';

@module
abstract class AccountsModule {
  @LazySingleton(as: AccountRemoteDatasource)
  AccountRemoteDatasourceImpl accountRemoteDatasource(SupabaseClient client) =>
      AccountRemoteDatasourceImpl(client);

  @LazySingleton(as: AccountLocalDatasource)
  AccountLocalDatasourceImpl accountLocalDatasource(Isar isar) =>
      AccountLocalDatasourceImpl(isar);

  @LazySingleton(as: AccountRepository)
  AccountRepositoryImpl accountRepository(
    AccountRemoteDatasource remoteDatasource,
    AccountLocalDatasource localDatasource,
    NetworkInfo networkInfo,
  ) =>
      AccountRepositoryImpl(
        remoteDatasource,
        localDatasource,
        networkInfo,
      );

  @lazySingleton
  AccountBloc accountBloc(AccountRepository accountRepository) =>
      AccountBloc(accountRepository: accountRepository);
}
