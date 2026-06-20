import 'package:equatable/equatable.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';
import 'package:wallet_wise/features/transactions/presentation/models/transaction_filter.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => <Object?>[];
}

final class LoadTransactions extends TransactionEvent {
  const LoadTransactions(this.accountId);

  final String accountId;

  @override
  List<Object?> get props => <Object?>[accountId];
}

final class LoadMoreTransactions extends TransactionEvent {
  const LoadMoreTransactions();
}

final class AddTransactionEvent extends TransactionEvent {
  const AddTransactionEvent(this.transaction);

  final Transaction transaction;

  @override
  List<Object?> get props => <Object?>[transaction];
}

final class UpdateTransactionEvent extends TransactionEvent {
  const UpdateTransactionEvent(this.transaction);

  final Transaction transaction;

  @override
  List<Object?> get props => <Object?>[transaction];
}

final class DeleteTransactionEvent extends TransactionEvent {
  const DeleteTransactionEvent(this.id);

  final String id;

  @override
  List<Object?> get props => <Object?>[id];
}

final class RestoreTransactionEvent extends TransactionEvent {
  const RestoreTransactionEvent(this.transaction);

  final Transaction transaction;

  @override
  List<Object?> get props => <Object?>[transaction];
}

final class FilterChanged extends TransactionEvent {
  const FilterChanged(this.filter);

  final TransactionFilter filter;

  @override
  List<Object?> get props => <Object?>[filter];
}

final class CategoriesRequested extends TransactionEvent {
  const CategoriesRequested();
}
