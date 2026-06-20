import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet_wise/features/accounts/domain/entities/account.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

AccountType _accountTypeFromJson(String value) =>
    AccountTypeX.fromDbValue(value);

String _accountTypeToJson(AccountType type) => type.dbValue;

double _balanceFromJson(dynamic value) {
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value) ?? 0;
  }
  return 0;
}

String _balanceToJson(double value) => value.toStringAsFixed(2);

@freezed
abstract class AccountModel with _$AccountModel {
  const factory AccountModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String name,
    @JsonKey(
      fromJson: _accountTypeFromJson,
      toJson: _accountTypeToJson,
    )
    required AccountType type,
    @JsonKey(fromJson: _balanceFromJson, toJson: _balanceToJson)
    required double balance,
    @JsonKey(name: 'currency_code') required String currencyCode,
    @JsonKey(name: 'color_hex') required String colorHex,
    @JsonKey(name: 'icon_name') required String iconName,
    @JsonKey(name: 'is_primary') required bool isPrimary,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _AccountModel;

  const AccountModel._();

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Account toEntity() => Account(
        id: id,
        userId: userId,
        name: name,
        type: type,
        balance: balance,
        currencyCode: currencyCode,
        colorHex: colorHex,
        iconName: iconName,
        isPrimary: isPrimary,
        createdAt: createdAt,
      );
}

Map<String, dynamic> accountToSupabaseJson(Account account) {
  final Map<String, dynamic> json = <String, dynamic>{
    'user_id': account.userId,
    'name': account.name,
    'type': account.type.dbValue,
    'balance': account.balance.toStringAsFixed(2),
    'currency_code': account.currencyCode,
    'color_hex': account.colorHex,
    'icon_name': account.iconName,
    'is_primary': account.isPrimary,
  };

  if (account.id.isNotEmpty) {
    json['id'] = account.id;
  }

  return json;
}

AccountModel accountEntityToModel(Account account) => AccountModel(
      id: account.id,
      userId: account.userId,
      name: account.name,
      type: account.type,
      balance: account.balance,
      currencyCode: account.currencyCode,
      colorHex: account.colorHex,
      iconName: account.iconName,
      isPrimary: account.isPrimary,
      createdAt: account.createdAt,
    );
