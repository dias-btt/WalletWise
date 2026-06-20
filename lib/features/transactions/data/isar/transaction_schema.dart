import 'dart:convert';

import 'package:isar_community/isar.dart';
import 'package:wallet_wise/features/transactions/data/models/transaction_model.dart';

part 'transaction_schema.g.dart';

@collection
class CachedTransaction {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String transactionId;

  @Index()
  late String accountId;

  @Index()
  late DateTime transactionDate;

  late String payloadJson;

  late DateTime cachedAt;

  @Index()
  late String cacheKey;

  TransactionModel toModel() {
    final Map<String, dynamic> json =
        jsonDecode(payloadJson) as Map<String, dynamic>;
    return TransactionModel.fromJson(json);
  }

  static CachedTransaction fromModel({
    required TransactionModel model,
    required String cacheKey,
    required DateTime cachedAt,
  }) {
    return CachedTransaction()
      ..transactionId = model.id
      ..accountId = model.accountId
      ..transactionDate = model.date
      ..payloadJson = jsonEncode(model.toJson())
      ..cachedAt = cachedAt
      ..cacheKey = cacheKey;
  }
}
