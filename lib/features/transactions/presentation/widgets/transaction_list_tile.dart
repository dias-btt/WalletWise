import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_wise/core/theme/app_theme.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';
import 'package:wallet_wise/shared/widgets/category_picker.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({
    required this.transaction,
    required this.onTap,
    super.key,
  });

  final Transaction transaction;
  final VoidCallback onTap;

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
    final String timeLabel = DateFormat('HH:mm').format(transaction.date);

    final Color categoryColor = transaction.categoryColorHex != null
        ? categoryColorFromHex(transaction.categoryColorHex!)
        : theme.colorScheme.primary;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: categoryColor.withValues(alpha: 0.2),
        child: Icon(
          categoryIconFromName(transaction.categoryIconName ?? 'category'),
          color: categoryColor,
          size: 20,
        ),
      ),
      title: Text(
        transaction.title,
        style: theme.textTheme.titleSmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        transaction.accountName ?? 'Account',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            formattedAmount,
            style: theme.textTheme.titleSmall?.copyWith(
              color: amountColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            timeLabel,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
