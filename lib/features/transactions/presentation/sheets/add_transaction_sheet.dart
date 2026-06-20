import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';
import 'package:wallet_wise/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:wallet_wise/features/transactions/presentation/bloc/transaction_event.dart';
import 'package:wallet_wise/shared/widgets/app_button.dart';
import 'package:wallet_wise/shared/widgets/app_text_field.dart';
import 'package:wallet_wise/shared/widgets/category_picker.dart';

class AddTransactionSheet extends StatefulWidget {
  const AddTransactionSheet({
    required this.scrollController,
    required this.accountId,
    required this.categories,
    required this.currencyCode,
    super.key,
  });

  final ScrollController scrollController;
  final String accountId;
  final List<Category> categories;
  final String currencyCode;

  @override
  State<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  TransactionType _type = TransactionType.expense;
  String _amountInput = '0';
  String? _selectedCategoryId;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _showNote = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  double get _displayAmount {
    if (_amountInput.isEmpty || _amountInput == '.') {
      return 0;
    }
    return double.tryParse(_amountInput) ?? 0;
  }

  List<Category> get _filteredCategories {
    if (widget.categories.isEmpty) {
      return const <Category>[];
    }

    return widget.categories.where((Category category) {
      if (_type == TransactionType.income) {
        return category.groupName == CategoryGroup.income;
      }
      return category.groupName != CategoryGroup.income;
    }).toList();
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

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _selectedDate.hour,
          _selectedDate.minute,
        );
      });
    }
  }

  Future<void> _submit() async {
    if (_displayAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter an amount greater than zero')),
      );
      return;
    }

    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a title')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    Category? selectedCategory;
    for (final Category category in widget.categories) {
      if (category.id == _selectedCategoryId) {
        selectedCategory = category;
        break;
      }
    }

    final Transaction transaction = Transaction(
      id: '',
      accountId: widget.accountId,
      categoryId: _selectedCategoryId,
      type: _type,
      amount: _displayAmount,
      currencyCode: widget.currencyCode,
      title: _titleController.text.trim(),
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
      date: _selectedDate,
      isRecurring: false,
      createdAt: DateTime.now().toUtc(),
      categoryName: selectedCategory?.name,
      categoryIconName: selectedCategory?.iconName,
      categoryColorHex: selectedCategory?.colorHex,
    );

    context.read<TransactionBloc>().add(AddTransactionEvent(transaction));

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final NumberFormat currencyFormat = NumberFormat.currency(
      symbol: widget.currencyCode,
    );

    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: ListView(
        controller: widget.scrollController,
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
            'New transaction',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              currencyFormat.format(_displayAmount),
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _AmountKeypad(
            onDigitPressed: _onDigitPressed,
            onBackspace: _onBackspace,
          ),
          const SizedBox(height: 16),
          SegmentedButton<TransactionType>(
            segments: const <ButtonSegment<TransactionType>>[
              ButtonSegment<TransactionType>(
                value: TransactionType.expense,
                label: Text('Expense'),
                icon: Icon(Icons.remove),
              ),
              ButtonSegment<TransactionType>(
                value: TransactionType.income,
                label: Text('Income'),
                icon: Icon(Icons.add),
              ),
            ],
            selected: <TransactionType>{_type},
            onSelectionChanged: (Set<TransactionType> value) {
              setState(() {
                _type = value.first;
                _selectedCategoryId = null;
              });
            },
          ),
          const SizedBox(height: 20),
          Text('Category', style: theme.textTheme.titleSmall),
          const SizedBox(height: 12),
          if (_filteredCategories.isEmpty)
            Text(
              'No categories available',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            )
          else
            CategoryPicker(
              categories: _filteredCategories,
              selectedCategoryId: _selectedCategoryId,
              onCategorySelected: (Category category) {
                setState(() => _selectedCategoryId = category.id);
              },
            ),
          const SizedBox(height: 20),
          AppTextField(
            controller: _titleController,
            label: 'Title',
            hint: 'Coffee, salary, rent...',
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Date'),
            subtitle: Text(DateFormat.yMMMd().format(_selectedDate)),
            trailing: const Icon(Icons.calendar_today),
            onTap: _pickDate,
          ),
          const SizedBox(height: 8),
          ExpansionTile(
            title: const Text('Note'),
            initiallyExpanded: _showNote,
            onExpansionChanged: (bool expanded) {
              setState(() => _showNote = expanded);
            },
            children: <Widget>[
              AppTextField(
                controller: _noteController,
                label: 'Note',
                hint: 'Optional details',
                maxLines: 3,
              ),
            ],
          ),
          const SizedBox(height: 20),
          AppButton(
            label: 'Add transaction',
            isLoading: _isSubmitting,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}

class _AmountKeypad extends StatelessWidget {
  const _AmountKeypad({
    required this.onDigitPressed,
    required this.onBackspace,
  });

  final ValueChanged<String> onDigitPressed;
  final VoidCallback onBackspace;

  @override
  Widget build(BuildContext context) {
    const List<String> keys = <String>[
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '.',
      '0',
      '⌫',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.2,
      ),
      itemCount: keys.length,
      itemBuilder: (BuildContext context, int index) {
        final String key = keys[index];
        return OutlinedButton(
          onPressed: () {
            if (key == '⌫') {
              onBackspace();
            } else {
              onDigitPressed(key);
            }
          },
          child: Text(
            key,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      },
    );
  }
}
