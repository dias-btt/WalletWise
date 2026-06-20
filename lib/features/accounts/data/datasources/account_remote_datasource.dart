import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet_wise/core/errors/exceptions.dart';
import 'package:wallet_wise/features/accounts/data/models/account_model.dart';
import 'package:wallet_wise/features/accounts/domain/entities/account.dart';

abstract class AccountRemoteDatasource {
  Future<List<AccountModel>> getAccounts(String userId);

  Future<AccountModel> createAccount(Account account);

  Future<AccountModel> updateAccount(Account account);

  Future<void> deleteAccount(String id);
}

class AccountRemoteDatasourceImpl implements AccountRemoteDatasource {
  AccountRemoteDatasourceImpl(this._client);

  final SupabaseClient _client;

  static const String _table = 'accounts';

  @override
  Future<List<AccountModel>> getAccounts(String userId) async {
    try {
      final List<dynamic> response = await _client
          .from(_table)
          .select()
          .eq('user_id', userId)
          .order('is_primary', ascending: false)
          .order('created_at');

      return response
          .cast<Map<String, dynamic>>()
          .map(AccountModel.fromJson)
          .toList();
    } on PostgrestException catch (error) {
      throw NetworkException(message: error.message);
    } catch (error) {
      throw UnexpectedException(message: error.toString());
    }
  }

  @override
  Future<AccountModel> createAccount(Account account) async {
    try {
      final Map<String, dynamic> response = await _client
          .from(_table)
          .insert(accountToSupabaseJson(account))
          .select()
          .single();

      return AccountModel.fromJson(response);
    } on PostgrestException catch (error) {
      throw NetworkException(message: error.message);
    } catch (error) {
      throw UnexpectedException(message: error.toString());
    }
  }

  @override
  Future<AccountModel> updateAccount(Account account) async {
    try {
      final Map<String, dynamic> response = await _client
          .from(_table)
          .update(accountToSupabaseJson(account))
          .eq('id', account.id)
          .select()
          .single();

      return AccountModel.fromJson(response);
    } on PostgrestException catch (error) {
      throw NetworkException(message: error.message);
    } catch (error) {
      throw UnexpectedException(message: error.toString());
    }
  }

  @override
  Future<void> deleteAccount(String id) async {
    try {
      await _client.from(_table).delete().eq('id', id);
    } on PostgrestException catch (error) {
      throw NetworkException(message: error.message);
    } catch (error) {
      throw UnexpectedException(message: error.toString());
    }
  }
}
