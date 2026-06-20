// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    _CategoryModel(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      name: json['name'] as String,
      iconName: json['icon_name'] as String,
      colorHex: json['color_hex'] as String,
      groupName: _groupFromJson(json['group_name'] as String),
      isSystem: json['is_system'] as bool,
      sortOrder: (json['sort_order'] as num).toInt(),
    );

Map<String, dynamic> _$CategoryModelToJson(_CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'icon_name': instance.iconName,
      'color_hex': instance.colorHex,
      'group_name': _groupToJson(instance.groupName),
      'is_system': instance.isSystem,
      'sort_order': instance.sortOrder,
    };
