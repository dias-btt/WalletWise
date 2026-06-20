// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    _TransactionModel(
      id: json['id'] as String,
      accountId: json['account_id'] as String,
      categoryId: json['category_id'] as String?,
      type: _transactionTypeFromJson(json['type'] as String),
      amount: _amountFromJson(json['amount']),
      currencyCode: json['currency_code'] as String,
      title: json['title'] as String,
      note: json['note'] as String?,
      date: DateTime.parse(json['date'] as String),
      isRecurring: json['is_recurring'] as bool,
      recurringRuleId: json['recurring_rule_id'] as String?,
      goalId: json['goal_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      accounts: json['accounts'] as Map<String, dynamic>?,
      categories: json['categories'] == null
          ? null
          : CategoryModel.fromJson(json['categories'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionModelToJson(_TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_id': instance.accountId,
      'category_id': instance.categoryId,
      'type': _transactionTypeToJson(instance.type),
      'amount': _amountToJson(instance.amount),
      'currency_code': instance.currencyCode,
      'title': instance.title,
      'note': instance.note,
      'date': instance.date.toIso8601String(),
      'is_recurring': instance.isRecurring,
      'recurring_rule_id': instance.recurringRuleId,
      'goal_id': instance.goalId,
      'created_at': instance.createdAt.toIso8601String(),
      'accounts': instance.accounts,
      'categories': instance.categories,
    };
