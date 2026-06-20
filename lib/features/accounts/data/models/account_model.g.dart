// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountModel _$AccountModelFromJson(Map<String, dynamic> json) =>
    _AccountModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      type: _accountTypeFromJson(json['type'] as String),
      balance: _balanceFromJson(json['balance']),
      currencyCode: json['currency_code'] as String,
      colorHex: json['color_hex'] as String,
      iconName: json['icon_name'] as String,
      isPrimary: json['is_primary'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AccountModelToJson(_AccountModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'type': _accountTypeToJson(instance.type),
      'balance': _balanceToJson(instance.balance),
      'currency_code': instance.currencyCode,
      'color_hex': instance.colorHex,
      'icon_name': instance.iconName,
      'is_primary': instance.isPrimary,
      'created_at': instance.createdAt.toIso8601String(),
    };
