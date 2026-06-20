import 'dart:convert';

import 'package:isar_community/isar.dart';
import 'package:wallet_wise/features/budgets/data/models/budget_model.dart';

part 'budget_schema.g.dart';

@collection
class CachedBudget {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String budgetId;

  @Index()
  late String userId;

  late String payloadJson;

  late DateTime cachedAt;

  @Index()
  late String cacheKey;

  BudgetModel toModel() {
    final Map<String, dynamic> json =
        jsonDecode(payloadJson) as Map<String, dynamic>;
    return BudgetModel.fromJson(json);
  }

  static CachedBudget fromModel({
    required BudgetModel model,
    required String cacheKey,
    required DateTime cachedAt,
  }) {
    return CachedBudget()
      ..budgetId = model.id
      ..userId = model.userId
      ..payloadJson = jsonEncode(model.toJson())
      ..cachedAt = cachedAt
      ..cacheKey = cacheKey;
  }
}
