import 'package:equatable/equatable.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';
import 'package:wallet_wise/features/transactions/presentation/models/transaction_filter.dart';
import 'package:wallet_wise/features/transactions/presentation/utils/transaction_date_grouper.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => <Object?>[];
}

final class TransactionInitial extends TransactionState {
  const TransactionInitial();
}

final class TransactionLoading extends TransactionState {
  const TransactionLoading();
}

final class TransactionLoaded extends TransactionState {
  const TransactionLoaded({
    required this.transactions,
    required this.groupedTransactions,
    required this.listItems,
    required this.hasMore,
    required this.isLoadingMore,
    required this.filter,
    required this.accountId,
    this.categories = const <Category>[],
  });

  final List<Transaction> transactions;
  final List<TransactionDateGroup> groupedTransactions;
  final List<TransactionListItem> listItems;
  final bool hasMore;
  final bool isLoadingMore;
  final TransactionFilter filter;
  final String accountId;
  final List<Category> categories;

  TransactionLoaded copyWith({
    List<Transaction>? transactions,
    List<TransactionDateGroup>? groupedTransactions,
    List<TransactionListItem>? listItems,
    bool? hasMore,
    bool? isLoadingMore,
    TransactionFilter? filter,
    String? accountId,
    List<Category>? categories,
  }) {
    return TransactionLoaded(
      transactions: transactions ?? this.transactions,
      groupedTransactions: groupedTransactions ?? this.groupedTransactions,
      listItems: listItems ?? this.listItems,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      filter: filter ?? this.filter,
      accountId: accountId ?? this.accountId,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        transactions,
        groupedTransactions,
        listItems,
        hasMore,
        isLoadingMore,
        filter,
        accountId,
        categories,
      ];
}

final class TransactionError extends TransactionState {
  const TransactionError(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
