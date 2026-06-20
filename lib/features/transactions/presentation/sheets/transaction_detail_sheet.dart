import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wallet_wise/core/theme/app_theme.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';
import 'package:wallet_wise/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:wallet_wise/features/transactions/presentation/bloc/transaction_event.dart';
import 'package:wallet_wise/shared/widgets/app_button.dart';
import 'package:wallet_wise/shared/widgets/category_picker.dart';

class TransactionDetailSheet extends StatelessWidget {
  const TransactionDetailSheet({
    required this.transaction,
    required this.scrollController,
    super.key,
  });

  final Transaction transaction;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isIncome = transaction.type == TransactionType.income;
    final Color amountColor = isIncome
        ? context.appTheme.income
        : transaction.type == TransactionType.expense
            ? context.appTheme.expense
            : theme.colorScheme.onSurface;

    final String amountPrefix = isIncome ? '+' : '-';
    final String formattedAmount =
        '$amountPrefix${NumberFormat.currency(symbol: '').format(transaction.amount)} ${transaction.currencyCode}';

    final Color categoryColor = transaction.categoryColorHex != null
        ? categoryColorFromHex(transaction.categoryColorHex!)
        : theme.colorScheme.primary;

    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: <Widget>[
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            transaction.title,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            formattedAmount,
            style: theme.textTheme.displaySmall?.copyWith(
              color: amountColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          if (transaction.categoryName != null)
            Chip(
              avatar: CircleAvatar(
                backgroundColor: categoryColor,
                child: Icon(
                  categoryIconFromName(
                    transaction.categoryIconName ?? 'category',
                  ),
                  color: Colors.white,
                  size: 16,
                ),
              ),
              label: Text(transaction.categoryName!),
            ),
          const SizedBox(height: 16),
          _DetailRow(
            label: 'Account',
            value: transaction.accountName ?? 'Unknown account',
          ),
          _DetailRow(
            label: 'Type',
            value: _typeLabel(transaction.type),
          ),
          _DetailRow(
            label: 'Date',
            value: DateFormat.yMMMEd().add_jm().format(transaction.date),
          ),
          if (transaction.note != null && transaction.note!.isNotEmpty)
            _DetailRow(label: 'Note', value: transaction.note!),
          _DetailRow(
            label: 'Recurring',
            value: transaction.isRecurring ? 'Yes' : 'No',
          ),
          const SizedBox(height: 24),
          AppButton(
            label: 'Edit',
            variant: AppButtonVariant.secondary,
            icon: Icons.edit,
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Edit flow can reuse AddTransactionSheet'),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          AppButton(
            label: 'Delete',
            variant: AppButtonVariant.destructive,
            icon: Icons.delete_outline,
            onPressed: () {
              context.read<TransactionBloc>().add(
                    DeleteTransactionEvent(transaction.id),
                  );
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  String _typeLabel(TransactionType type) => switch (type) {
        TransactionType.income => 'Income',
        TransactionType.expense => 'Expense',
        TransactionType.transfer => 'Transfer',
      };
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
