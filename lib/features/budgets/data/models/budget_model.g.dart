// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BudgetModel _$BudgetModelFromJson(Map<String, dynamic> json) => _BudgetModel(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  categoryId: json['category_id'] as String,
  limitAmount: _amountFromJson(json['limit_amount']),
  currencyCode: json['currency_code'] as String,
  period: _periodFromJson(json['period'] as String),
  startDate: _startDateFromJson(json['start_date'] as String),
  isActive: json['is_active'] as bool,
);

Map<String, dynamic> _$BudgetModelToJson(_BudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'category_id': instance.categoryId,
      'limit_amount': _amountToJson(instance.limitAmount),
      'currency_code': instance.currencyCode,
      'period': _periodToJson(instance.period),
      'start_date': _startDateToJson(instance.startDate),
      'is_active': instance.isActive,
    };
