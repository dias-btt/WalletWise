import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet_wise/core/network/network_info.dart';
import 'package:wallet_wise/features/transactions/data/datasources/category_remote_datasource.dart';
import 'package:wallet_wise/features/transactions/data/datasources/transaction_local_datasource.dart';
import 'package:wallet_wise/features/transactions/data/datasources/transaction_remote_datasource.dart';
import 'package:wallet_wise/features/transactions/data/repositories/category_repository_impl.dart';
import 'package:wallet_wise/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:wallet_wise/features/transactions/domain/repositories/category_repository.dart';
import 'package:wallet_wise/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:wallet_wise/features/transactions/domain/usecases/add_transaction_usecase.dart';
import 'package:wallet_wise/features/transactions/domain/usecases/delete_transaction_usecase.dart';
import 'package:wallet_wise/features/transactions/domain/usecases/get_categories_usecase.dart';
import 'package:wallet_wise/features/transactions/domain/usecases/get_transactions_usecase.dart';
import 'package:wallet_wise/features/transactions/domain/usecases/update_transaction_usecase.dart';
import 'package:wallet_wise/features/transactions/presentation/bloc/transaction_bloc.dart';

@module
abstract class TransactionsModule {
  @LazySingleton(as: TransactionRemoteDatasource)
  TransactionRemoteDatasourceImpl transactionRemoteDatasource(
    SupabaseClient client,
  ) =>
      TransactionRemoteDatasourceImpl(client);

  @LazySingleton(as: TransactionLocalDatasource)
  TransactionLocalDatasourceImpl transactionLocalDatasource(Isar isar) =>
      TransactionLocalDatasourceImpl(isar);

  @LazySingleton(as: CategoryRemoteDatasource)
  CategoryRemoteDatasourceImpl categoryRemoteDatasource(
    SupabaseClient client,
  ) =>
      CategoryRemoteDatasourceImpl(client);

  @LazySingleton(as: TransactionRepository)
  TransactionRepositoryImpl transactionRepository(
    TransactionRemoteDatasource remoteDatasource,
    TransactionLocalDatasource localDatasource,
    NetworkInfo networkInfo,
  ) =>
      TransactionRepositoryImpl(
        remoteDatasource,
        localDatasource,
        networkInfo,
      );

  @LazySingleton(as: CategoryRepository)
  CategoryRepositoryImpl categoryRepository(
    CategoryRemoteDatasource remoteDatasource,
  ) =>
      CategoryRepositoryImpl(remoteDatasource);

  @injectable
  GetTransactionsUseCase getTransactionsUseCase(
    TransactionRepository repository,
  ) =>
      GetTransactionsUseCase(repository);

  @injectable
  AddTransactionUseCase addTransactionUseCase(
    TransactionRepository repository,
  ) =>
      AddTransactionUseCase(repository);

  @injectable
  UpdateTransactionUseCase updateTransactionUseCase(
    TransactionRepository repository,
  ) =>
      UpdateTransactionUseCase(repository);

  @injectable
  DeleteTransactionUseCase deleteTransactionUseCase(
    TransactionRepository repository,
  ) =>
      DeleteTransactionUseCase(repository);

  @injectable
  GetCategoriesUseCase getCategoriesUseCase(CategoryRepository repository) =>
      GetCategoriesUseCase(repository);

  @lazySingleton
  TransactionBloc transactionBloc(
    GetTransactionsUseCase getTransactionsUseCase,
    AddTransactionUseCase addTransactionUseCase,
    UpdateTransactionUseCase updateTransactionUseCase,
    DeleteTransactionUseCase deleteTransactionUseCase,
    GetCategoriesUseCase getCategoriesUseCase,
  ) =>
      TransactionBloc(
        getTransactionsUseCase: getTransactionsUseCase,
        addTransactionUseCase: addTransactionUseCase,
        updateTransactionUseCase: updateTransactionUseCase,
        deleteTransactionUseCase: deleteTransactionUseCase,
        getCategoriesUseCase: getCategoriesUseCase,
      );
}
