// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  displayName: json['display_name'] as String,
  currencyCode: json['currency_code'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  avatarUrl: json['avatar_url'] as String?,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'display_name': instance.displayName,
      'avatar_url': instance.avatarUrl,
      'currency_code': instance.currencyCode,
      'created_at': instance.createdAt.toIso8601String(),
    };
