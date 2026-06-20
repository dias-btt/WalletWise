import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet_wise/core/errors/exceptions.dart';
import 'package:wallet_wise/features/budgets/data/models/budget_model.dart';
import 'package:wallet_wise/features/budgets/data/models/spending_by_category_model.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget.dart';

abstract class BudgetRemoteDatasource {
  Future<List<BudgetModel>> getActiveBudgets(String userId);

  Future<BudgetModel> createBudget(Budget budget);

  Future<BudgetModel> updateBudget(Budget budget);

  Future<void> deactivateBudget(String budgetId);

  Future<List<SpendingByCategoryModel>> getSpendingByCategory({
    required String userId,
    required DateTime periodStart,
    required DateTime periodEnd,
  });
}

class BudgetRemoteDatasourceImpl implements BudgetRemoteDatasource {
  BudgetRemoteDatasourceImpl(this._client);

  final SupabaseClient _client;

  static const String _budgetsTable = 'budgets';

  @override
  Future<List<BudgetModel>> getActiveBudgets(String userId) async {
    try {
      final List<dynamic> response = await _client
          .from(_budgetsTable)
          .select()
          .eq('user_id', userId)
          .eq('is_active', true);

      return response
          .map(
            (dynamic row) =>
                BudgetModel.fromJson(row as Map<String, dynamic>),
          )
          .toList();
    } on PostgrestException catch (error) {
      throw NetworkException(message: error.message);
    } catch (error) {
      throw UnexpectedException(message: error.toString());
    }
  }

  @override
  Future<BudgetModel> createBudget(Budget budget) async {
    try {
      final Map<String, dynamic> payload = budgetToSupabaseJson(budget)
        ..remove('id');

      final Map<String, dynamic> response = await _client
          .from(_budgetsTable)
          .insert(payload)
          .select()
          .single();

      return BudgetModel.fromJson(response);
    } on PostgrestException catch (error) {
      throw NetworkException(message: error.message);
    } catch (error) {
      throw UnexpectedException(message: error.toString());
    }
  }

  @override
  Future<BudgetModel> updateBudget(Budget budget) async {
    try {
      final Map<String, dynamic> response = await _client
          .from(_budgetsTable)
          .update(budgetToSupabaseJson(budget)..remove('id'))
          .eq('id', budget.id)
          .select()
          .single();

      return BudgetModel.fromJson(response);
    } on PostgrestException catch (error) {
      throw NetworkException(message: error.message);
    } catch (error) {
      throw UnexpectedException(message: error.toString());
    }
  }

  @override
  Future<void> deactivateBudget(String budgetId) async {
    try {
      await _client
          .from(_budgetsTable)
          .update(<String, dynamic>{'is_active': false})
          .eq('id', budgetId);
    } on PostgrestException catch (error) {
      throw NetworkException(message: error.message);
    } catch (error) {
      throw UnexpectedException(message: error.toString());
    }
  }

  @override
  Future<List<SpendingByCategoryModel>> getSpendingByCategory({
    required String userId,
    required DateTime periodStart,
    required DateTime periodEnd,
  }) async {
    try {
      final List<dynamic> response = await _client.rpc(
        'get_spending_by_category',
        params: <String, dynamic>{
          'p_user_id': userId,
          'p_start': _formatDate(periodStart),
          'p_end': _formatDate(periodEnd),
        },
      );

      return response
          .map(
            (dynamic row) => SpendingByCategoryModel.fromJson(
              row as Map<String, dynamic>,
            ),
          )
          .toList();
    } on PostgrestException catch (error) {
      throw NetworkException(message: error.message);
    } catch (error) {
      throw UnexpectedException(message: error.toString());
    }
  }

  String _formatDate(DateTime date) {
    return DateTime(date.year, date.month, date.day).toIso8601String();
  }
}
