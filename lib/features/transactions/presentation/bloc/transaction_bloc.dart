import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';
import 'package:wallet_wise/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:wallet_wise/features/transactions/domain/usecases/add_transaction_usecase.dart';
import 'package:wallet_wise/features/transactions/domain/usecases/delete_transaction_usecase.dart';
import 'package:wallet_wise/features/transactions/domain/usecases/get_categories_usecase.dart';
import 'package:wallet_wise/features/transactions/domain/usecases/get_transactions_usecase.dart';
import 'package:wallet_wise/features/transactions/domain/usecases/update_transaction_usecase.dart';
import 'package:wallet_wise/features/transactions/presentation/bloc/transaction_event.dart';
import 'package:wallet_wise/features/transactions/presentation/bloc/transaction_state.dart';
import 'package:wallet_wise/features/transactions/presentation/models/transaction_filter.dart';
import 'package:wallet_wise/features/transactions/presentation/utils/transaction_date_grouper.dart';
import 'package:wallet_wise/shared/domain/usecase.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({
    required GetTransactionsUseCase getTransactionsUseCase,
    required AddTransactionUseCase addTransactionUseCase,
    required UpdateTransactionUseCase updateTransactionUseCase,
    required DeleteTransactionUseCase deleteTransactionUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
  })  : _getTransactionsUseCase = getTransactionsUseCase,
        _addTransactionUseCase = addTransactionUseCase,
        _updateTransactionUseCase = updateTransactionUseCase,
        _deleteTransactionUseCase = deleteTransactionUseCase,
        _getCategoriesUseCase = getCategoriesUseCase,
        super(const TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<LoadMoreTransactions>(_onLoadMoreTransactions);
    on<AddTransactionEvent>(_onAddTransaction);
    on<UpdateTransactionEvent>(_onUpdateTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
    on<RestoreTransactionEvent>(_onRestoreTransaction);
    on<FilterChanged>(_onFilterChanged);
    on<CategoriesRequested>(_onCategoriesRequested);
  }

  static const int _pageSize = 20;

  final GetTransactionsUseCase _getTransactionsUseCase;
  final AddTransactionUseCase _addTransactionUseCase;
  final UpdateTransactionUseCase _updateTransactionUseCase;
  final DeleteTransactionUseCase _deleteTransactionUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;

  int _offset = 0;
  String _accountId = '';
  TransactionFilter _filter = const TransactionFilter();
  List<Category> _categories = <Category>[];

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    _accountId = event.accountId;
    _offset = 0;
    emit(const TransactionLoading());

    add(const CategoriesRequested());

    final result = await _getTransactionsUseCase(
      _buildParams(offset: 0),
    );

    result.fold(
      (failure) => emit(TransactionError(failure.message)),
      (List<Transaction> transactions) {
        final List<TransactionDateGroup> groups =
            TransactionDateGrouper.groupByDate(transactions);

        emit(
          TransactionLoaded(
            transactions: transactions,
            groupedTransactions: groups,
            listItems: TransactionDateGrouper.flattenGroups(groups),
            hasMore: transactions.length >= _pageSize,
            isLoadingMore: false,
            filter: _filter,
            accountId: _accountId,
            categories: _categories,
          ),
        );
        _offset = transactions.length;
      },
    );
  }

  Future<void> _onLoadMoreTransactions(
    LoadMoreTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    final TransactionState current = state;
    if (current is! TransactionLoaded ||
        current.isLoadingMore ||
        !current.hasMore) {
      return;
    }

    emit(current.copyWith(isLoadingMore: true));

    final result = await _getTransactionsUseCase(
      _buildParams(offset: _offset),
    );

    result.fold(
      (failure) => emit(current.copyWith(isLoadingMore: false)),
      (List<Transaction> newItems) {
        final List<Transaction> merged = <Transaction>[
          ...current.transactions,
          ...newItems,
        ];
        final List<TransactionDateGroup> groups =
            TransactionDateGrouper.groupByDate(merged);

        emit(
          current.copyWith(
            transactions: merged,
            groupedTransactions: groups,
            listItems: TransactionDateGrouper.flattenGroups(groups),
            hasMore: newItems.length >= _pageSize,
            isLoadingMore: false,
          ),
        );
        _offset = merged.length;
      },
    );
  }

  Future<void> _onAddTransaction(
    AddTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final TransactionState current = state;

    final result = await _addTransactionUseCase(event.transaction);

    result.fold(
      (failure) => emit(TransactionError(failure.message)),
      (Transaction transaction) {
        if (current is TransactionLoaded) {
          final List<Transaction> updated = <Transaction>[
            transaction,
            ...current.transactions,
          ];
          final List<TransactionDateGroup> groups =
              TransactionDateGrouper.groupByDate(updated);

          emit(
            current.copyWith(
              transactions: updated,
              groupedTransactions: groups,
              listItems: TransactionDateGrouper.flattenGroups(groups),
            ),
          );
          _offset = updated.length;
        } else {
          add(LoadTransactions(_accountId));
        }
      },
    );
  }

  Future<void> _onUpdateTransaction(
    UpdateTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final TransactionState current = state;

    final result = await _updateTransactionUseCase(event.transaction);

    result.fold(
      (failure) => emit(TransactionError(failure.message)),
      (Transaction transaction) {
        if (current is TransactionLoaded) {
          final List<Transaction> updated = current.transactions
              .map(
                (Transaction item) =>
                    item.id == transaction.id ? transaction : item,
              )
              .toList();
          final List<TransactionDateGroup> groups =
              TransactionDateGrouper.groupByDate(updated);

          emit(
            current.copyWith(
              transactions: updated,
              groupedTransactions: groups,
              listItems: TransactionDateGrouper.flattenGroups(groups),
            ),
          );
        }
      },
    );
  }

  Future<void> _onDeleteTransaction(
    DeleteTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final TransactionState current = state;
    if (current is! TransactionLoaded) {
      return;
    }

    Transaction? deleted;
    for (final Transaction item in current.transactions) {
      if (item.id == event.id) {
        deleted = item;
        break;
      }
    }

    if (deleted == null) {
      return;
    }

    final Transaction removed = deleted;

    final List<Transaction> updated = current.transactions
        .where((Transaction item) => item.id != event.id)
        .toList();
    final List<TransactionDateGroup> groups =
        TransactionDateGrouper.groupByDate(updated);

    emit(
      current.copyWith(
        transactions: updated,
        groupedTransactions: groups,
        listItems: TransactionDateGrouper.flattenGroups(groups),
      ),
    );
    _offset = updated.length;

    final result = await _deleteTransactionUseCase(
      DeleteTransactionParams(id: event.id),
    );

    result.fold(
      (failure) {
        add(RestoreTransactionEvent(removed));
        emit(TransactionError(failure.message));
      },
      (_) {},
    );
  }

  Future<void> _onRestoreTransaction(
    RestoreTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    final TransactionState current = state;
    if (current is! TransactionLoaded) {
      return;
    }

    final List<Transaction> updated = <Transaction>[
      event.transaction,
      ...current.transactions,
    ]..sort((Transaction a, Transaction b) => b.date.compareTo(a.date));

    final List<TransactionDateGroup> groups =
        TransactionDateGrouper.groupByDate(updated);

    emit(
      current.copyWith(
        transactions: updated,
        groupedTransactions: groups,
        listItems: TransactionDateGrouper.flattenGroups(groups),
      ),
    );
    _offset = updated.length;
  }

  Future<void> _onFilterChanged(
    FilterChanged event,
    Emitter<TransactionState> emit,
  ) async {
    _filter = event.filter;
    add(LoadTransactions(_accountId));
  }

  Future<void> _onCategoriesRequested(
    CategoriesRequested event,
    Emitter<TransactionState> emit,
  ) async {
    final result = await _getCategoriesUseCase(const NoParams());

    result.fold(
      (_) {},
      (List<Category> categories) {
        _categories = categories;
        final TransactionState current = state;
        if (current is TransactionLoaded) {
          emit(current.copyWith(categories: categories));
        }
      },
    );
  }

  GetTransactionsParams _buildParams({required int offset}) {
    return GetTransactionsParams(
      accountId: _accountId,
      offset: offset,
      limit: _pageSize,
      type: _filter.type,
      searchQuery:
          _filter.searchQuery.isEmpty ? null : _filter.searchQuery,
      categoryId: _filter.categoryId,
      startDate: _filter.startDate,
      endDate: _filter.endDate,
    );
  }
}
