import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet_wise/features/budgets/domain/entities/spending_by_category.dart';

part 'spending_by_category_model.freezed.dart';
part 'spending_by_category_model.g.dart';

double _totalFromJson(dynamic value) {
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value) ?? 0;
  }
  return 0;
}

int _countFromJson(dynamic value) {
  if (value is num) {
    return value.toInt();
  }
  if (value is String) {
    return int.tryParse(value) ?? 0;
  }
  return 0;
}

@freezed
abstract class SpendingByCategoryModel with _$SpendingByCategoryModel {
  const factory SpendingByCategoryModel({
    @JsonKey(name: 'category_id') required String categoryId,
    @JsonKey(name: 'category_name') required String categoryName,
    @JsonKey(name: 'icon_name') required String iconName,
    @JsonKey(name: 'color_hex') required String colorHex,
    @JsonKey(fromJson: _totalFromJson) required double total,
    @JsonKey(fromJson: _countFromJson) required int count,
  }) = _SpendingByCategoryModel;

  const SpendingByCategoryModel._();

  factory SpendingByCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SpendingByCategoryModelFromJson(json);

  SpendingByCategory toEntity() => SpendingByCategory(
        categoryId: categoryId,
        categoryName: categoryName,
        iconName: iconName,
        colorHex: colorHex,
        total: total,
        count: count,
      );
}
