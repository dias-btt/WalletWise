import 'package:flutter/material.dart';
import 'package:wallet_wise/core/router/placeholder_page.dart';

class BudgetsPage extends StatelessWidget {
  const BudgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budgets')),
      body: placeholderPage('Budgets'),
    );
  }
}
