// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spending_by_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpendingByCategoryModel _$SpendingByCategoryModelFromJson(
  Map<String, dynamic> json,
) => _SpendingByCategoryModel(
  categoryId: json['category_id'] as String,
  categoryName: json['category_name'] as String,
  iconName: json['icon_name'] as String,
  colorHex: json['color_hex'] as String,
  total: _totalFromJson(json['total']),
  count: _countFromJson(json['count']),
);

Map<String, dynamic> _$SpendingByCategoryModelToJson(
  _SpendingByCategoryModel instance,
) => <String, dynamic>{
  'category_id': instance.categoryId,
  'category_name': instance.categoryName,
  'icon_name': instance.iconName,
  'color_hex': instance.colorHex,
  'total': instance.total,
  'count': instance.count,
};
