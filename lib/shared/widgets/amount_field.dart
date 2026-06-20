import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AmountField extends StatelessWidget {
  const AmountField({
    required this.amountInput,
    required this.currencyCode,
    required this.onDigitPressed,
    required this.onBackspace,
    super.key,
  });

  final String amountInput;
  final String currencyCode;
  final ValueChanged<String> onDigitPressed;
  final VoidCallback onBackspace;

  double get _displayAmount {
    if (amountInput.isEmpty || amountInput == '.') {
      return 0;
    }
    return double.tryParse(amountInput) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String formatted =
        NumberFormat.currency(symbol: currencyCode).format(_displayAmount);

    return Column(
      children: <Widget>[
        Text(
          formatted,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _AmountKeypad(
          onDigitPressed: onDigitPressed,
          onBackspace: onBackspace,
        ),
      ],
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

  static const List<String> _keys = <String>[
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

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.8,
      ),
      itemCount: _keys.length,
      itemBuilder: (BuildContext context, int index) {
        final String key = _keys[index];
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
