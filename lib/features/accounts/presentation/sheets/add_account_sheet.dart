import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_wise/core/theme/app_colors.dart';
import 'package:wallet_wise/features/accounts/domain/entities/account.dart';
import 'package:wallet_wise/features/accounts/presentation/bloc/account_bloc.dart';
import 'package:wallet_wise/features/accounts/presentation/bloc/account_event.dart';
import 'package:wallet_wise/shared/widgets/app_button.dart';
import 'package:wallet_wise/shared/widgets/category_picker.dart';

class AddAccountSheet extends StatefulWidget {
  const AddAccountSheet({
    required this.userId,
    required this.defaultCurrencyCode,
    super.key,
  });

  final String userId;
  final String defaultCurrencyCode;

  static Future<void> show(
    BuildContext context, {
    required String userId,
    required String defaultCurrencyCode,
  }) {
    final AccountBloc accountBloc = context.read<AccountBloc>();

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext sheetContext) {
        return BlocProvider<AccountBloc>.value(
          value: accountBloc,
          child: AddAccountSheet(
            userId: userId,
            defaultCurrencyCode: defaultCurrencyCode,
          ),
        );
      },
    );
  }

  @override
  State<AddAccountSheet> createState() => _AddAccountSheetState();
}

class _AddAccountSheetState extends State<AddAccountSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _balanceController =
      TextEditingController(text: '0');

  AccountType _selectedType = AccountType.checking;
  String _selectedColorHex = '14213D';
  String _selectedIconName = 'account_balance';

  static const List<String> _colorOptions = <String>[
    '14213D',
    '2ECC71',
    'E74C3C',
    'F39C12',
    '3498DB',
    '9B59B6',
  ];

  static const List<String> _iconOptions = <String>[
    'account_balance',
    'savings',
    'payments',
    'wallet',
    'trending_up',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final Account account = Account(
      id: '',
      userId: widget.userId,
      name: _nameController.text.trim(),
      type: _selectedType,
      balance: double.tryParse(_balanceController.text.trim()) ?? 0,
      currencyCode: widget.defaultCurrencyCode,
      colorHex: _selectedColorHex,
      iconName: _selectedIconName,
      isPrimary: false,
      createdAt: DateTime.now(),
    );

    context.read<AccountBloc>().add(CreateAccount(account));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final EdgeInsets viewInsets = MediaQuery.viewInsetsOf(context);

    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Add Account',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Account name'),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter account name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<AccountType>(
                initialValue: _selectedType,
                decoration: const InputDecoration(labelText: 'Account type'),
                items: AccountType.values
                    .map(
                      (AccountType type) => DropdownMenuItem<AccountType>(
                        value: type,
                        child: Text(type.label),
                      ),
                    )
                    .toList(),
                onChanged: (AccountType? value) {
                  if (value != null) {
                    setState(() => _selectedType = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _balanceController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Balance (${widget.defaultCurrencyCode})',
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter balance';
                  }
                  if (double.tryParse(value.trim()) == null) {
                    return 'Invalid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Color',
                style: theme.textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _colorOptions.map((String hex) {
                  final Color color = categoryColorFromHex(hex);
                  final bool selected = _selectedColorHex == hex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColorHex = hex),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected
                              ? AppColors.primary
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Text(
                'Icon',
                style: theme.textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _iconOptions.map((String iconName) {
                  final bool selected = _selectedIconName == iconName;
                  return ChoiceChip(
                    selected: selected,
                    label: Icon(_accountIconFromName(iconName)),
                    onSelected: (_) =>
                        setState(() => _selectedIconName = iconName),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'Create Account',
                onPressed: _submit,
              ),
            ],
          ),
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
