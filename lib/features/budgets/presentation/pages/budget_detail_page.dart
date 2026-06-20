import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wallet_wise/core/theme/app_colors.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_state.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget_with_progress.dart';
import 'package:wallet_wise/features/budgets/domain/utils/budget_period_utils.dart';
import 'package:wallet_wise/features/budgets/presentation/bloc/budget_bloc.dart';
import 'package:wallet_wise/features/budgets/presentation/bloc/budget_event.dart';
import 'package:wallet_wise/features/budgets/presentation/sheets/add_budget_sheet.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';
import 'package:wallet_wise/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:wallet_wise/features/transactions/domain/usecases/get_transactions_usecase.dart';
import 'package:wallet_wise/features/transactions/presentation/widgets/transaction_list_tile.dart';
import 'package:wallet_wise/injection_container.dart';
import 'package:wallet_wise/shared/widgets/app_button.dart';
import 'package:wallet_wise/shared/widgets/category_picker.dart';

class BudgetDetailArgs {
  const BudgetDetailArgs({
    required this.budget,
    required this.categories,
    this.category,
  });

  final BudgetWithProgress budget;
  final Category? category;
  final List<Category> categories;
}

class BudgetDetailPage extends StatefulWidget {
  const BudgetDetailPage({
    required this.args,
    super.key,
  });

  final BudgetDetailArgs args;

  @override
  State<BudgetDetailPage> createState() => _BudgetDetailPageState();
}

class _BudgetDetailPageState extends State<BudgetDetailPage> {
  List<Transaction> _transactions = <Transaction>[];
  bool _isLoadingTransactions = true;

  BudgetWithProgress get _budget => widget.args.budget;
  Category? get _category => widget.args.category;

  BudgetPeriodRange get _periodRange =>
      BudgetPeriodUtils.getCurrentPeriod(_budget);

  Color get _progressColor {
    final double percent = _budget.progressPercentage;
    if (percent >= 100) {
      return AppColors.expenseRed;
    }
    if (percent >= 70) {
      return AppColors.warningAmber;
    }
    return AppColors.incomeGreen;
  }

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    setState(() => _isLoadingTransactions = true);

    final result = await getIt<GetTransactionsUseCase>()(
      GetTransactionsParams(
        accountId: '',
        categoryId: _budget.categoryId,
        type: TransactionType.expense,
        startDate: _periodRange.start,
        endDate: _periodRange.end.subtract(const Duration(milliseconds: 1)),
        limit: 100,
      ),
    );

    if (mounted) {
      setState(() {
        _isLoadingTransactions = false;
        _transactions = result.fold(
          (_) => <Transaction>[],
          (List<Transaction> txs) => txs,
        );
      });
    }
  }

  String _formatAmount(double amount) {
    return NumberFormat.currency(
      symbol: _currencySymbol(_budget.currencyCode),
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

  String _formatPeriodDates() {
    final DateFormat formatter = DateFormat('d MMM');
    final DateTime endInclusive =
        _periodRange.end.subtract(const Duration(days: 1));
    return '${formatter.format(_periodRange.start)} – ${formatter.format(endInclusive)}';
  }

  Future<void> _editLimit() async {
    final AuthState authState = context.read<AuthBloc>().state;
    if (authState is! Authenticated) {
      return;
    }

    await AddBudgetSheet.show(
      context,
      userId: authState.user.id,
      categories: widget.args.categories,
      currencyCode: _budget.currencyCode,
      existingBudget: Budget(
        id: _budget.id,
        userId: _budget.userId,
        categoryId: _budget.categoryId,
        limitAmount: _budget.limitAmount,
        currencyCode: _budget.currencyCode,
        period: _budget.period,
        startDate: _budget.startDate,
        isActive: _budget.isActive,
      ),
    );

    if (mounted) {
      context.read<BudgetBloc>().add(LoadBudgets(authState.user.id));
      Navigator.of(context).pop();
    }
  }

  Future<void> _deleteBudget() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete budget'),
          content: const Text(
            'This budget will be deactivated. You can create a new one later.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) {
      return;
    }

    context.read<BudgetBloc>().add(DeactivateBudget(_budget.id));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color categoryColor = _category != null
        ? categoryColorFromHex(_category!.colorHex)
        : theme.colorScheme.primary;
    final double progressValue =
        (_budget.progressPercentage / 100).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(_category?.name ?? 'Budget'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(
            _formatPeriodDates(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_formatAmount(_budget.spentAmount)} spent of ${_formatAmount(_budget.limitAmount)}',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 260,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                PieChart(
                  PieChartData(
                    startDegreeOffset: -90,
                    sectionsSpace: 0,
                    centerSpaceRadius: 88,
                    sections: <PieChartSectionData>[
                      PieChartSectionData(
                        value: progressValue * 100,
                        color: _progressColor,
                        radius: 32,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: (1 - progressValue) * 100,
                        color: AppColors.borderLight,
                        radius: 32,
                        showTitle: false,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: categoryColor.withValues(alpha: 0.2),
                      child: Icon(
                        categoryIconFromName(
                          _category?.iconName ?? 'category',
                        ),
                        color: categoryColor,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_budget.progressPercentage.round()}%',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _progressColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Transactions',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          if (_isLoadingTransactions)
            const Center(child: CircularProgressIndicator())
          else if (_transactions.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                'No transactions this period',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
              ),
            )
          else
            ..._transactions.map(
              (Transaction transaction) => TransactionListTile(
                transaction: transaction,
                onTap: () {},
              ),
            ),
          const SizedBox(height: 24),
          AppButton(
            label: 'Edit limit',
            onPressed: _editLimit,
          ),
          const SizedBox(height: 12),
          AppButton(
            label: 'Delete budget',
            variant: AppButtonVariant.destructive,
            onPressed: _deleteBudget,
          ),
        ],
      ),
    );
  }
}
