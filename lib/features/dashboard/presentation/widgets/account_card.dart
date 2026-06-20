import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_wise/core/theme/app_colors.dart';
import 'package:wallet_wise/features/accounts/domain/entities/account.dart';
import 'package:wallet_wise/shared/widgets/category_picker.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({
    required this.account,
    super.key,
  });

  final Account account;

  @override
  Widget build(BuildContext context) {
    final Color cardColor = categoryColorFromHex(account.colorHex);
    final String formattedBalance = NumberFormat.currency(
      symbol: '',
      decimalDigits: 2,
    ).format(account.balance);

    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: cardColor.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                _accountIconFromName(account.iconName),
                color: AppColors.textPrimaryDark,
                size: 20,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.textPrimaryDark.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  account.type.label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textPrimaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            account.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimaryDark,
                  fontWeight: FontWeight.w600,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '$formattedBalance ${account.currencyCode}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.textPrimaryDark.withValues(alpha: 0.9),
                ),
          ),
        ],
      ),
    );
  }
}

class AddAccountCard extends StatelessWidget {
  const AddAccountCard({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: const Icon(
          Icons.add,
          size: 32,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

IconData _accountIconFromName(String iconName) {
  return switch (iconName) {
    'account_balance' => Icons.account_balance,
    'savings' => Icons.savings,
    'payments' => Icons.payments,
    'wallet' => Icons.wallet,
    'trending_up' => Icons.trending_up,
    _ => Icons.account_balance_wallet,
  };
}
