import 'dart:convert';

import 'package:isar_community/isar.dart';
import 'package:wallet_wise/features/accounts/data/models/account_model.dart';

part 'account_schema.g.dart';

@collection
class CachedAccount {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String accountId;

  @Index()
  late String userId;

  late String payloadJson;

  late DateTime cachedAt;

  @Index()
  late String cacheKey;

  AccountModel toModel() {
    final Map<String, dynamic> json =
        jsonDecode(payloadJson) as Map<String, dynamic>;
    return AccountModel.fromJson(json);
  }

  static CachedAccount fromModel({
    required AccountModel model,
    required String cacheKey,
    required DateTime cachedAt,
  }) {
    return CachedAccount()
      ..accountId = model.id
      ..userId = model.userId
      ..payloadJson = jsonEncode(model.toJson())
      ..cachedAt = cachedAt
      ..cacheKey = cacheKey;
  }
}
