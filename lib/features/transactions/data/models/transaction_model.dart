import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet_wise/features/transactions/data/models/category_model.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

String _transactionTypeToJson(TransactionType type) => switch (type) {
      TransactionType.income => 'income',
      TransactionType.expense => 'expense',
      TransactionType.transfer => 'transfer',
    };

TransactionType _transactionTypeFromJson(String value) => switch (value) {
      'income' => TransactionType.income,
      'expense' => TransactionType.expense,
      'transfer' => TransactionType.transfer,
      _ => TransactionType.expense,
    };

double _amountFromJson(dynamic value) {
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value) ?? 0;
  }
  return 0;
}

String _amountToJson(double value) => value.toStringAsFixed(2);

@freezed
abstract class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    @JsonKey(name: 'account_id') required String accountId,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(
      fromJson: _transactionTypeFromJson,
      toJson: _transactionTypeToJson,
    )
    required TransactionType type,
    @JsonKey(fromJson: _amountFromJson, toJson: _amountToJson)
    required double amount,
    @JsonKey(name: 'currency_code') required String currencyCode,
    required String title,
    String? note,
    required DateTime date,
    @JsonKey(name: 'is_recurring') required bool isRecurring,
    @JsonKey(name: 'recurring_rule_id') String? recurringRuleId,
    @JsonKey(name: 'goal_id') String? goalId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    Map<String, dynamic>? accounts,
    CategoryModel? categories,
  }) = _TransactionModel;

  const TransactionModel._();

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Transaction toEntity() {
    final CategoryModel? category = categories;
    final Map<String, dynamic>? account = accounts;

    return Transaction(
      id: id,
      accountId: accountId,
      categoryId: categoryId,
      type: type,
      amount: amount,
      currencyCode: currencyCode,
      title: title,
      note: note,
      date: date,
      isRecurring: isRecurring,
      recurringRuleId: recurringRuleId,
      goalId: goalId,
      createdAt: createdAt,
      accountName: account?['name'] as String?,
      categoryName: category?.name,
      categoryIconName: category?.iconName,
      categoryColorHex: category?.colorHex,
    );
  }
}

Map<String, dynamic> transactionToSupabaseJson(
  Transaction transaction, {
  required String accountId,
}) {
  final Map<String, dynamic> json = <String, dynamic>{
    'account_id': accountId,
    'type': _transactionTypeToJson(transaction.type),
    'amount': transaction.amount.toStringAsFixed(2),
    'currency_code': transaction.currencyCode,
    'title': transaction.title,
    'date': transaction.date.toIso8601String(),
    'is_recurring': transaction.isRecurring,
  };

  if (transaction.id.isNotEmpty) {
    json['id'] = transaction.id;
  }

  final String? categoryId = _uuidOrNull(transaction.categoryId);
  if (categoryId != null) {
    json['category_id'] = categoryId;
  }

  if (transaction.note != null && transaction.note!.isNotEmpty) {
    json['note'] = transaction.note;
  }

  final String? recurringRuleId = _uuidOrNull(transaction.recurringRuleId);
  if (recurringRuleId != null) {
    json['recurring_rule_id'] = recurringRuleId;
  }

  final String? goalId = _uuidOrNull(transaction.goalId);
  if (goalId != null) {
    json['goal_id'] = goalId;
  }

  return json;
}

String? _uuidOrNull(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }
  return value;
}

TransactionModel transactionEntityToModel(Transaction transaction) {
  return TransactionModel(
    id: transaction.id,
    accountId: transaction.accountId,
    categoryId: transaction.categoryId,
    type: transaction.type,
    amount: transaction.amount,
    currencyCode: transaction.currencyCode,
    title: transaction.title,
    note: transaction.note,
    date: transaction.date,
    isRecurring: transaction.isRecurring,
    recurringRuleId: transaction.recurringRuleId,
    goalId: transaction.goalId,
    createdAt: transaction.createdAt,
    accounts: transaction.accountName != null
        ? <String, dynamic>{'name': transaction.accountName}
        : null,
    categories: transaction.categoryId != null &&
            transaction.categoryName != null &&
            transaction.categoryIconName != null &&
            transaction.categoryColorHex != null
        ? CategoryModel(
            id: transaction.categoryId!,
            name: transaction.categoryName!,
            iconName: transaction.categoryIconName!,
            colorHex: transaction.categoryColorHex!,
            groupName: CategoryGroup.other,
            isSystem: false,
            sortOrder: 0,
          )
        : null,
  );
}
