import 'package:isar_community/isar.dart';
import 'package:wallet_wise/core/errors/exceptions.dart';
import 'package:wallet_wise/features/accounts/data/isar/account_schema.dart';
import 'package:wallet_wise/features/accounts/data/models/account_model.dart';

abstract class AccountLocalDatasource {
  Future<List<AccountModel>?> getCachedAccounts(String userId);

  Future<void> cacheAccounts({
    required String userId,
    required List<AccountModel> accounts,
  });

  Future<List<AccountModel>?> getStaleAccounts(String userId);

  Future<void> upsertAccount(AccountModel account);

  Future<void> removeAccount(String accountId);

  Future<void> clearCache();
}

class AccountLocalDatasourceImpl implements AccountLocalDatasource {
  AccountLocalDatasourceImpl(this._isar);

  final Isar _isar;

  static const Duration cacheTtl = Duration(minutes: 5);

  static String buildCacheKey(String userId) => 'accounts:$userId';

  @override
  Future<List<AccountModel>?> getCachedAccounts(String userId) async {
    final String cacheKey = buildCacheKey(userId);
    final DateTime now = DateTime.now().toUtc();
    final List<CachedAccount> cached = await _isar.cachedAccounts
        .filter()
        .cacheKeyEqualTo(cacheKey)
        .findAll();

    if (cached.isEmpty) {
      return null;
    }

    final bool isExpired = cached.any(
      (CachedAccount item) => now.difference(item.cachedAt) > cacheTtl,
    );

    if (isExpired) {
      return null;
    }

    return cached.map((CachedAccount item) => item.toModel()).toList();
  }

  @override
  Future<List<AccountModel>?> getStaleAccounts(String userId) async {
    final List<CachedAccount> cached = await _isar.cachedAccounts
        .filter()
        .userIdEqualTo(userId)
        .findAll();

    if (cached.isEmpty) {
      return null;
    }

    return cached.map((CachedAccount item) => item.toModel()).toList();
  }

  @override
  Future<void> cacheAccounts({
    required String userId,
    required List<AccountModel> accounts,
  }) async {
    final DateTime cachedAt = DateTime.now().toUtc();
    final String cacheKey = buildCacheKey(userId);

    await _isar.writeTxn(() async {
      await _isar.cachedAccounts
          .filter()
          .cacheKeyEqualTo(cacheKey)
          .deleteAll();

      final List<CachedAccount> entries = accounts
          .map(
            (AccountModel model) => CachedAccount.fromModel(
              model: model,
              cacheKey: cacheKey,
              cachedAt: cachedAt,
            ),
          )
          .toList();

      await _isar.cachedAccounts.putAll(entries);
    });
  }

  @override
  Future<void> upsertAccount(AccountModel account) async {
    final DateTime cachedAt = DateTime.now().toUtc();
    final CachedAccount entry = CachedAccount.fromModel(
      model: account,
      cacheKey: buildCacheKey(account.userId),
      cachedAt: cachedAt,
    );

    await _isar.writeTxn(() async {
      await _isar.cachedAccounts.put(entry);
    });
  }

  @override
  Future<void> removeAccount(String accountId) async {
    await _isar.writeTxn(() async {
      final CachedAccount? existing = await _isar.cachedAccounts
          .filter()
          .accountIdEqualTo(accountId)
          .findFirst();
      if (existing != null) {
        await _isar.cachedAccounts.delete(existing.id);
      }
    });
  }

  @override
  Future<void> clearCache() async {
    try {
      await _isar.writeTxn(() async {
        await _isar.cachedAccounts.clear();
      });
    } catch (error) {
      throw CacheException(message: error.toString());
    }
  }
}
