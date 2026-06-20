import 'package:flutter/material.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget.dart';
import 'package:wallet_wise/features/budgets/domain/usecases/update_budget_usecase.dart';
import 'package:wallet_wise/features/budgets/presentation/bloc/budget_bloc.dart';
import 'package:wallet_wise/features/budgets/presentation/bloc/budget_event.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';
import 'package:wallet_wise/injection_container.dart';
import 'package:wallet_wise/shared/widgets/amount_field.dart';
import 'package:wallet_wise/shared/widgets/app_button.dart';
import 'package:wallet_wise/shared/widgets/category_picker.dart';

class AddBudgetSheet extends StatefulWidget {
  const AddBudgetSheet({
    required this.scrollController,
    required this.userId,
    required this.categories,
    required this.currencyCode,
    this.existingBudget,
    super.key,
  });

  final ScrollController scrollController;
  final String userId;
  final List<Category> categories;
  final String currencyCode;
  final Budget? existingBudget;

  static Future<void> show(
    BuildContext context, {
    required String userId,
    required List<Category> categories,
    required String currencyCode,
    Budget? existingBudget,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (BuildContext context, ScrollController scrollController) {
            return AddBudgetSheet(
              scrollController: scrollController,
              userId: userId,
              categories: categories,
              currencyCode: currencyCode,
              existingBudget: existingBudget,
            );
          },
        );
      },
    );
  }

  @override
  State<AddBudgetSheet> createState() => _AddBudgetSheetState();
}

class _AddBudgetSheetState extends State<AddBudgetSheet> {
  String _amountInput = '0';
  String? _selectedCategoryId;
  BudgetPeriod _period = BudgetPeriod.monthly;
  late DateTime _startDate;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final Budget? existing = widget.existingBudget;
    if (existing != null) {
      _amountInput = existing.limitAmount.toStringAsFixed(2);
      if (_amountInput.endsWith('.00')) {
        _amountInput = existing.limitAmount.toStringAsFixed(0);
      }
      _selectedCategoryId = existing.categoryId;
      _period = existing.period;
      _startDate = existing.startDate;
    } else {
      final DateTime now = DateTime.now();
      _startDate = DateTime(now.year, now.month);
    }
  }

  List<Category> get _expenseCategories {
    return widget.categories
        .where((Category c) => c.groupName != CategoryGroup.income)
        .toList();
  }

  double get _displayAmount {
    if (_amountInput.isEmpty || _amountInput == '.') {
      return 0;
    }
    return double.tryParse(_amountInput) ?? 0;
  }

  void _onDigitPressed(String digit) {
    setState(() {
      if (_amountInput == '0' && digit != '.') {
        _amountInput = digit;
        return;
      }
      if (digit == '.' && _amountInput.contains('.')) {
        return;
      }
      if (_amountInput.contains('.')) {
        final int decimals = _amountInput.split('.').last.length;
        if (decimals >= 2) {
          return;
        }
      }
      _amountInput += digit;
    });
  }

  void _onBackspace() {
    setState(() {
      if (_amountInput.length <= 1) {
        _amountInput = '0';
        return;
      }
      _amountInput = _amountInput.substring(0, _amountInput.length - 1);
    });
  }

  Future<void> _pickStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _startDate = DateTime(picked.year, picked.month, picked.day);
      });
    }
  }

  Future<void> _submit() async {
    if (_displayAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a limit greater than zero')),
      );
      return;
    }

    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select a category')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final Budget budget = Budget(
      id: widget.existingBudget?.id ?? '',
      userId: widget.userId,
      categoryId: _selectedCategoryId!,
      limitAmount: _displayAmount,
      currencyCode: widget.currencyCode,
      period: _period,
      startDate: _startDate,
      isActive: true,
    );

    if (widget.existingBudget != null) {
      final result = await getIt<UpdateBudgetUseCase>()(budget);
      result.fold(
        (failure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(failure.message)),
            );
          }
        },
        (_) {
          if (mounted) {
            getIt<BudgetBloc>().add(LoadBudgets(widget.userId));
          }
        },
      );
    } else {
      getIt<BudgetBloc>().add(CreateBudget(budget));
    }

    if (mounted) {
      setState(() => _isSubmitting = false);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isEditing = widget.existingBudget != null;

    return ListView(
      controller: widget.scrollController,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      children: <Widget>[
        Text(
          isEditing ? 'Edit budget limit' : 'Add budget',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        Text('Category', style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        CategoryPicker(
          categories: _expenseCategories,
          selectedCategoryId: _selectedCategoryId,
          onCategorySelected: (Category category) {
            setState(() => _selectedCategoryId = category.id);
          },
        ),
        const SizedBox(height: 24),
        Text('Limit', style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        AmountField(
          amountInput: _amountInput,
          currencyCode: widget.currencyCode,
          onDigitPressed: _onDigitPressed,
          onBackspace: _onBackspace,
        ),
        const SizedBox(height: 24),
        Text('Period', style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        SegmentedButton<BudgetPeriod>(
          segments: const <ButtonSegment<BudgetPeriod>>[
            ButtonSegment<BudgetPeriod>(
              value: BudgetPeriod.monthly,
              label: Text('Monthly'),
            ),
            ButtonSegment<BudgetPeriod>(
              value: BudgetPeriod.weekly,
              label: Text('Weekly'),
            ),
          ],
          selected: <BudgetPeriod>{_period},
          onSelectionChanged: (Set<BudgetPeriod> selection) {
            setState(() => _period = selection.first);
          },
        ),
        const SizedBox(height: 24),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Start date'),
          subtitle: Text(
            '${_startDate.day}/${_startDate.month}/${_startDate.year}',
          ),
          trailing: const Icon(Icons.calendar_today),
          onTap: _pickStartDate,
        ),
        const SizedBox(height: 24),
        AppButton(
          label: isEditing ? 'Save changes' : 'Create budget',
          isLoading: _isSubmitting,
          onPressed: _isSubmitting ? null : _submit,
        ),
      ],
    );
  }
}
