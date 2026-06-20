import 'package:isar_community/isar.dart';
import 'package:wallet_wise/core/errors/exceptions.dart';
import 'package:wallet_wise/features/transactions/data/isar/transaction_schema.dart';
import 'package:wallet_wise/features/transactions/data/models/transaction_model.dart';
import 'package:wallet_wise/features/transactions/domain/repositories/transaction_repository.dart';

abstract class TransactionLocalDatasource {
  Future<List<TransactionModel>?> getCachedTransactions({
    required String cacheKey,
    required String accountId,
    required int offset,
    required int limit,
  });

  Future<void> cacheTransactions({
    required String cacheKey,
    required List<TransactionModel> transactions,
  });

  Future<void> upsertTransaction(TransactionModel transaction);

  Future<void> removeTransaction(String transactionId);

  Future<void> clearCache();

  Future<List<TransactionModel>?> getStaleCache({
    required String accountId,
    required int offset,
    required int limit,
  });
}

class TransactionLocalDatasourceImpl implements TransactionLocalDatasource {
  TransactionLocalDatasourceImpl(this._isar);

  final Isar _isar;

  static const Duration cacheTtl = Duration(minutes: 5);

  static String buildCacheKey(GetTransactionsParams params) {
    return <String?>[
      params.accountId,
      params.type?.name,
      params.searchQuery,
      params.categoryId,
      params.startDate?.toIso8601String(),
      params.endDate?.toIso8601String(),
      params.offset.toString(),
      params.limit.toString(),
    ].join('|');
  }

  @override
  Future<List<TransactionModel>?> getCachedTransactions({
    required String cacheKey,
    required String accountId,
    required int offset,
    required int limit,
  }) async {
    final DateTime now = DateTime.now().toUtc();
    final List<CachedTransaction> cached = await _isar.cachedTransactions
        .filter()
        .cacheKeyEqualTo(cacheKey)
        .findAll();

    if (cached.isEmpty) {
      return null;
    }

    final bool isExpired = cached.any(
      (CachedTransaction item) => now.difference(item.cachedAt) > cacheTtl,
    );

    if (isExpired) {
      return null;
    }

    final List<CachedTransaction> sorted = List<CachedTransaction>.from(cached)
      ..sort(
        (CachedTransaction a, CachedTransaction b) =>
            b.transactionDate.compareTo(a.transactionDate),
      );

    final List<CachedTransaction> page = sorted.skip(offset).take(limit).toList();

    return page.map((CachedTransaction item) => item.toModel()).toList();
  }

  @override
  Future<List<TransactionModel>?> getStaleCache({
    required String accountId,
    required int offset,
    required int limit,
  }) async {
    final List<CachedTransaction> cached = accountId.isEmpty
        ? await _isar.cachedTransactions.where().findAll()
        : await _isar.cachedTransactions
            .filter()
            .accountIdEqualTo(accountId)
            .findAll();

    if (cached.isEmpty) {
      return null;
    }

    final List<CachedTransaction> sorted = List<CachedTransaction>.from(cached)
      ..sort(
        (CachedTransaction a, CachedTransaction b) =>
            b.transactionDate.compareTo(a.transactionDate),
      );

    final List<CachedTransaction> page = sorted.skip(offset).take(limit).toList();

    return page.map((CachedTransaction item) => item.toModel()).toList();
  }

  @override
  Future<void> cacheTransactions({
    required String cacheKey,
    required List<TransactionModel> transactions,
  }) async {
    final DateTime cachedAt = DateTime.now().toUtc();
    final List<CachedTransaction> entries = transactions
        .map(
          (TransactionModel model) => CachedTransaction.fromModel(
            model: model,
            cacheKey: cacheKey,
            cachedAt: cachedAt,
          ),
        )
        .toList();

    await _isar.writeTxn(() async {
      await _isar.cachedTransactions.putAll(entries);
    });
  }

  @override
  Future<void> upsertTransaction(TransactionModel transaction) async {
    final DateTime cachedAt = DateTime.now().toUtc();
    final CachedTransaction entry = CachedTransaction.fromModel(
      model: transaction,
      cacheKey: 'entity:${transaction.id}',
      cachedAt: cachedAt,
    );

    await _isar.writeTxn(() async {
      await _isar.cachedTransactions.put(entry);
    });
  }

  @override
  Future<void> removeTransaction(String transactionId) async {
    await _isar.writeTxn(() async {
      final CachedTransaction? existing = await _isar.cachedTransactions
          .filter()
          .transactionIdEqualTo(transactionId)
          .findFirst();
      if (existing != null) {
        await _isar.cachedTransactions.delete(existing.id);
      }
    });
  }

  @override
  Future<void> clearCache() async {
    try {
      await _isar.writeTxn(() async {
        await _isar.cachedTransactions.clear();
      });
    } catch (error) {
      throw CacheException(message: error.toString());
    }
  }
}
