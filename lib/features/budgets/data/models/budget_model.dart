import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget.dart';

part 'budget_model.freezed.dart';
part 'budget_model.g.dart';

BudgetPeriod _periodFromJson(String value) => BudgetPeriodX.fromDbValue(value);

String _periodToJson(BudgetPeriod period) => period.dbValue;

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

DateTime _startDateFromJson(String value) => DateTime.parse(value);

String _startDateToJson(DateTime value) =>
    DateTime(value.year, value.month, value.day).toIso8601String();

@freezed
abstract class BudgetModel with _$BudgetModel {
  const factory BudgetModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'category_id') required String categoryId,
    @JsonKey(name: 'limit_amount', fromJson: _amountFromJson, toJson: _amountToJson)
    required double limitAmount,
    @JsonKey(name: 'currency_code') required String currencyCode,
    @JsonKey(fromJson: _periodFromJson, toJson: _periodToJson)
    required BudgetPeriod period,
    @JsonKey(name: 'start_date', fromJson: _startDateFromJson, toJson: _startDateToJson)
    required DateTime startDate,
    @JsonKey(name: 'is_active') required bool isActive,
  }) = _BudgetModel;

  const BudgetModel._();

  factory BudgetModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetModelFromJson(json);

  Budget toEntity() => Budget(
        id: id,
        userId: userId,
        categoryId: categoryId,
        limitAmount: limitAmount,
        currencyCode: currencyCode,
        period: period,
        startDate: startDate,
        isActive: isActive,
      );
}

Map<String, dynamic> budgetToSupabaseJson(Budget budget) {
  final Map<String, dynamic> json = <String, dynamic>{
    'user_id': budget.userId,
    'category_id': budget.categoryId,
    'limit_amount': budget.limitAmount.toStringAsFixed(2),
    'currency_code': budget.currencyCode,
    'period': budget.period.dbValue,
    'start_date': DateTime(
      budget.startDate.year,
      budget.startDate.month,
      budget.startDate.day,
    ).toIso8601String(),
    'is_active': budget.isActive,
  };

  if (budget.id.isNotEmpty) {
    json['id'] = budget.id;
  }

  return json;
}

BudgetModel budgetEntityToModel(Budget budget) => BudgetModel(
      id: budget.id,
      userId: budget.userId,
      categoryId: budget.categoryId,
      limitAmount: budget.limitAmount,
      currencyCode: budget.currencyCode,
      period: budget.period,
      startDate: budget.startDate,
      isActive: budget.isActive,
    );
