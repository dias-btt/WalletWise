import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:wallet_wise/core/theme/app_colors.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget_with_progress.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';
import 'package:wallet_wise/shared/widgets/app_card.dart';
import 'package:wallet_wise/shared/widgets/category_picker.dart';

class BudgetProgressCard extends StatelessWidget {
  const BudgetProgressCard({
    required this.budget,
    required this.category,
    required this.onTap,
    super.key,
  });

  final BudgetWithProgress budget;
  final Category? category;
  final VoidCallback onTap;

  Color get _progressColor {
    final double percent = budget.progressPercentage;
    if (percent >= 100) {
      return AppColors.expenseRed;
    }
    if (percent >= 70) {
      return AppColors.warningAmber;
    }
    return AppColors.incomeGreen;
  }

  String _formatAmount(double amount) {
    return NumberFormat.currency(
      symbol: _currencySymbol(budget.currencyCode),
      decimalDigits: 0,
    ).format(amount);
  }

  String _currencySymbol(String code) {
    return switch (code) {
      'GBP' => '£',
      'USD' => '\$',
      'EUR' => '€',
      _ => '$code ',
    };
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color categoryColor = category != null
        ? categoryColorFromHex(category!.colorHex)
        : theme.colorScheme.primary;
    final double progressValue =
        (budget.progressPercentage / 100).clamp(0.0, 1.0);

    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: categoryColor.withValues(alpha: 0.2),
                child: Icon(
                  categoryIconFromName(category?.iconName ?? 'category'),
                  color: categoryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  category?.name ?? 'Budget',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: progressValue),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (BuildContext context, double value, Widget? child) {
                return LinearProgressIndicator(
                  value: value,
                  minHeight: 8,
                  backgroundColor: AppColors.borderLight,
                  valueColor: AlwaysStoppedAnimation<Color>(_progressColor),
                );
              },
            ).animate().fadeIn(duration: const Duration(milliseconds: 300)),
          ),
          const SizedBox(height: 12),
          Text(
            '${_formatAmount(budget.spentAmount)} of ${_formatAmount(budget.limitAmount)}',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${_formatAmount(budget.remainingAmount)} remaining',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
