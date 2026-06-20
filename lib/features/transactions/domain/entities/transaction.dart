import 'package:equatable/equatable.dart';

enum TransactionType {
  income,
  expense,
  transfer,
}

class Transaction extends Equatable {
  const Transaction({
    required this.id,
    required this.accountId,
    required this.type,
    required this.amount,
    required this.currencyCode,
    required this.title,
    required this.date,
    required this.isRecurring,
    required this.createdAt,
    this.categoryId,
    this.note,
    this.recurringRuleId,
    this.goalId,
    this.accountName,
    this.categoryName,
    this.categoryIconName,
    this.categoryColorHex,
  });

  final String id;
  final String accountId;
  final String? categoryId;
  final TransactionType type;
  final double amount;
  final String currencyCode;
  final String title;
  final String? note;
  final DateTime date;
  final bool isRecurring;
  final String? recurringRuleId;
  final String? goalId;
  final DateTime createdAt;
  final String? accountName;
  final String? categoryName;
  final String? categoryIconName;
  final String? categoryColorHex;

  @override
  List<Object?> get props => <Object?>[
        id,
        accountId,
        categoryId,
        type,
        amount,
        currencyCode,
        title,
        note,
        date,
        isRecurring,
        recurringRuleId,
        goalId,
        createdAt,
        accountName,
        categoryName,
        categoryIconName,
        categoryColorHex,
      ];
}
