import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';

class TransactionDateGroup extends Equatable {
  const TransactionDateGroup({
    required this.label,
    required this.date,
    required this.transactions,
  });

  final String label;
  final DateTime date;
  final List<Transaction> transactions;

  @override
  List<Object?> get props => <Object?>[label, date, transactions];
}

enum TransactionListItemType { header, transaction }

class TransactionListItem extends Equatable {
  const TransactionListItem._({
    required this.type,
    this.headerLabel,
    this.transaction,
  });

  const TransactionListItem.header(String label)
      : this._(
          type: TransactionListItemType.header,
          headerLabel: label,
        );

  const TransactionListItem.transaction(Transaction transaction)
      : this._(
          type: TransactionListItemType.transaction,
          transaction: transaction,
        );

  final TransactionListItemType type;
  final String? headerLabel;
  final Transaction? transaction;

  bool get isHeader => type == TransactionListItemType.header;

  @override
  List<Object?> get props => <Object?>[type, headerLabel, transaction];
}

class TransactionDateGrouper {
  static List<TransactionDateGroup> groupByDate(
    List<Transaction> transactions,
  ) {
    if (transactions.isEmpty) {
      return const <TransactionDateGroup>[];
    }

    final Map<DateTime, List<Transaction>> grouped =
        <DateTime, List<Transaction>>{};

    for (final Transaction transaction in transactions) {
      final DateTime day = DateTime(
        transaction.date.year,
        transaction.date.month,
        transaction.date.day,
      );
      grouped.putIfAbsent(day, () => <Transaction>[]).add(transaction);
    }

    final List<DateTime> sortedDays = grouped.keys.toList()
      ..sort((DateTime a, DateTime b) => b.compareTo(a));

    return sortedDays
        .map(
          (DateTime day) => TransactionDateGroup(
            label: _formatDayLabel(day),
            date: day,
            transactions: grouped[day]!,
          ),
        )
        .toList();
  }

  static List<TransactionListItem> flattenGroups(
    List<TransactionDateGroup> groups,
  ) {
    final List<TransactionListItem> items = <TransactionListItem>[];

    for (final TransactionDateGroup group in groups) {
      items.add(TransactionListItem.header(group.label));
      for (final Transaction transaction in group.transactions) {
        items.add(TransactionListItem.transaction(transaction));
      }
    }

    return items;
  }

  static String _formatDayLabel(DateTime day) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime yesterday = today.subtract(const Duration(days: 1));

    if (day == today) {
      return 'Today';
    }
    if (day == yesterday) {
      return 'Yesterday';
    }

    if (day.year == now.year) {
      return DateFormat('MMM d').format(day);
    }

    return DateFormat('MMM d, yyyy').format(day);
  }
}
