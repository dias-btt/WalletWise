import 'package:isar_community/isar.dart';
import 'package:wallet_wise/core/errors/exceptions.dart';
import 'package:wallet_wise/features/budgets/data/isar/budget_schema.dart';
import 'package:wallet_wise/features/budgets/data/models/budget_model.dart';

abstract class BudgetLocalDatasource {
  Future<List<BudgetModel>?> getCachedBudgets(String userId);

  Future<void> cacheBudgets({
    required String userId,
    required List<BudgetModel> budgets,
  });

  Future<List<BudgetModel>?> getStaleBudgets(String userId);

  Future<void> upsertBudget(BudgetModel budget);

  Future<void> removeBudget(String budgetId);

  Future<BudgetModel?> getBudgetById(String budgetId);

  Future<void> clearCache();
}

class BudgetLocalDatasourceImpl implements BudgetLocalDatasource {
  BudgetLocalDatasourceImpl(this._isar);

  final Isar _isar;

  static const Duration cacheTtl = Duration(minutes: 5);

  static String buildCacheKey(String userId) => 'budgets:$userId';

  @override
  Future<List<BudgetModel>?> getCachedBudgets(String userId) async {
    final String cacheKey = buildCacheKey(userId);
    final DateTime now = DateTime.now().toUtc();
    final List<CachedBudget> cached = await _isar.cachedBudgets
        .filter()
        .cacheKeyEqualTo(cacheKey)
        .findAll();

    if (cached.isEmpty) {
      return null;
    }

    final bool isExpired = cached.any(
      (CachedBudget item) => now.difference(item.cachedAt) > cacheTtl,
    );

    if (isExpired) {
      return null;
    }

    return cached.map((CachedBudget item) => item.toModel()).toList();
  }

  @override
  Future<List<BudgetModel>?> getStaleBudgets(String userId) async {
    final List<CachedBudget> cached = await _isar.cachedBudgets
        .filter()
        .userIdEqualTo(userId)
        .findAll();

    if (cached.isEmpty) {
      return null;
    }

    return cached.map((CachedBudget item) => item.toModel()).toList();
  }

  @override
  Future<void> cacheBudgets({
    required String userId,
    required List<BudgetModel> budgets,
  }) async {
    final DateTime cachedAt = DateTime.now().toUtc();
    final String cacheKey = buildCacheKey(userId);

    await _isar.writeTxn(() async {
      await _isar.cachedBudgets
          .filter()
          .cacheKeyEqualTo(cacheKey)
          .deleteAll();

      final List<CachedBudget> entries = budgets
          .map(
            (BudgetModel model) => CachedBudget.fromModel(
              model: model,
              cacheKey: cacheKey,
              cachedAt: cachedAt,
            ),
          )
          .toList();

      await _isar.cachedBudgets.putAll(entries);
    });
  }

  @override
  Future<void> upsertBudget(BudgetModel budget) async {
    final DateTime cachedAt = DateTime.now().toUtc();
    final CachedBudget entry = CachedBudget.fromModel(
      model: budget,
      cacheKey: buildCacheKey(budget.userId),
      cachedAt: cachedAt,
    );

    await _isar.writeTxn(() async {
      await _isar.cachedBudgets.put(entry);
    });
  }

  @override
  Future<void> removeBudget(String budgetId) async {
    await _isar.writeTxn(() async {
      final CachedBudget? existing = await _isar.cachedBudgets
          .filter()
          .budgetIdEqualTo(budgetId)
          .findFirst();
      if (existing != null) {
        await _isar.cachedBudgets.delete(existing.id);
      }
    });
  }

  @override
  Future<BudgetModel?> getBudgetById(String budgetId) async {
    final CachedBudget? existing = await _isar.cachedBudgets
        .filter()
        .budgetIdEqualTo(budgetId)
        .findFirst();
    return existing?.toModel();
  }

  @override
  Future<void> clearCache() async {
    try {
      await _isar.writeTxn(() async {
        await _isar.cachedBudgets.clear();
      });
    } catch (error) {
      throw CacheException(message: error.toString());
    }
  }
}
