import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet_wise/core/errors/exceptions.dart';
import 'package:wallet_wise/features/transactions/data/models/transaction_model.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';
import 'package:wallet_wise/features/transactions/domain/repositories/transaction_repository.dart';

abstract class TransactionRemoteDatasource {
  Future<List<TransactionModel>> getTransactions(GetTransactionsParams params);

  Future<TransactionModel> addTransaction(Transaction transaction);

  Future<TransactionModel> updateTransaction(Transaction transaction);

  Future<void> deleteTransaction(String id);

  Future<String?> getDefaultAccountId();
}

class TransactionRemoteDatasourceImpl implements TransactionRemoteDatasource {
  TransactionRemoteDatasourceImpl(this._client);

  final SupabaseClient _client;

  static const String _table = 'transactions';
  static const String _accountsTable = 'accounts';

  static const String _selectWithRelations =
      '*, accounts(name), categories(id, name, icon_name, color_hex, group_name, is_system, sort_order, user_id)';

  @override
  Future<List<TransactionModel>> getTransactions(
    GetTransactionsParams params,
  ) async {
    try {
      var query = _client.from(_table).select(_selectWithRelations);

      if (params.accountId.isNotEmpty) {
        query = query.eq('account_id', params.accountId);
      }

      if (params.type != null) {
        query = query.eq('type', _typeToDb(params.type!));
      }

      if (params.categoryId != null) {
        query = query.eq('category_id', params.categoryId!);
      }

      if (params.searchQuery != null && params.searchQuery!.isNotEmpty) {
        query = query.ilike('title', '%${params.searchQuery}%');
      }

      if (params.startDate != null) {
        query = query.gte('date', params.startDate!.toIso8601String());
      }

      if (params.endDate != null) {
        query = query.lte('date', params.endDate!.toIso8601String());
      }

      final List<dynamic> response = await query
          .order('date', ascending: false)
          .range(params.offset, params.offset + params.limit - 1);

      return response
          .cast<Map<String, dynamic>>()
          .map(TransactionModel.fromJson)
          .toList();
    } on PostgrestException catch (error) {
      throw NetworkException(message: error.message);
    } catch (error) {
      throw UnexpectedException(message: error.toString());
    }
  }

  @override
  Future<TransactionModel> addTransaction(Transaction transaction) async {
    try {
      final String accountId = await _resolveAccountId(transaction.accountId);
      final Map<String, dynamic> response = await _client
          .from(_table)
          .insert(
            transactionToSupabaseJson(
              transaction,
              accountId: accountId,
            ),
          )
          .select(_selectWithRelations)
          .single();

      return TransactionModel.fromJson(response);
    } on PostgrestException catch (error) {
      throw NetworkException(message: error.message);
    } on AppException {
      rethrow;
    } catch (error) {
      throw UnexpectedException(message: error.toString());
    }
  }

  @override
  Future<TransactionModel> updateTransaction(Transaction transaction) async {
    try {
      final String accountId = await _resolveAccountId(transaction.accountId);
      final Map<String, dynamic> response = await _client
          .from(_table)
          .update(
            transactionToSupabaseJson(
              transaction,
              accountId: accountId,
            ),
          )
          .eq('id', transaction.id)
          .select(_selectWithRelations)
          .single();

      return TransactionModel.fromJson(response);
    } on PostgrestException catch (error) {
      throw NetworkException(message: error.message);
    } on AppException {
      rethrow;
    } catch (error) {
      throw UnexpectedException(message: error.toString());
    }
  }

  @override
  Future<void> deleteTransaction(String id) async {
    try {
      await _client.from(_table).delete().eq('id', id);
    } on PostgrestException catch (error) {
      throw NetworkException(message: error.message);
    } catch (error) {
      throw UnexpectedException(message: error.toString());
    }
  }

  @override
  Future<String?> getDefaultAccountId() async {
    try {
      final String? userId = _client.auth.currentUser?.id;
      if (userId == null) {
        return null;
      }

      final Map<String, dynamic>? row = await _client
          .from(_accountsTable)
          .select('id')
          .eq('user_id', userId)
          .order('created_at')
          .limit(1)
          .maybeSingle();

      final String? accountId = row?['id'] as String?;
      if (accountId == null || accountId.isEmpty) {
        return null;
      }

      return accountId;
    } on PostgrestException catch (error) {
      throw NetworkException(message: error.message);
    } catch (error) {
      throw UnexpectedException(message: error.toString());
    }
  }

  Future<String> _resolveAccountId(String accountId) async {
    if (accountId.isNotEmpty) {
      return accountId;
    }

    final String? defaultAccountId = await getDefaultAccountId();
    if (defaultAccountId != null) {
      return defaultAccountId;
    }

    throw const NetworkException(
      message: 'No account found. Create an account before adding transactions.',
    );
  }

  String _typeToDb(TransactionType type) => switch (type) {
        TransactionType.income => 'income',
        TransactionType.expense => 'expense',
        TransactionType.transfer => 'transfer',
      };
}
