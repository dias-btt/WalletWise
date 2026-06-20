import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet_wise/core/errors/exceptions.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget_ring_summary.dart';

abstract class BudgetRemoteDatasource {
  Future<List<BudgetRingSummary>> getActiveBudgetsSummary(String userId);
}

class BudgetRemoteDatasourceImpl implements BudgetRemoteDatasource {
  BudgetRemoteDatasourceImpl(this._client);

  final SupabaseClient _client;

  static const String _budgetsTable = 'budgets';
  static const String _transactionsTable = 'transactions';

  static const String _selectWithCategory =
      '*, categories(name, icon_name, color_hex)';

  @override
  Future<List<BudgetRingSummary>> getActiveBudgetsSummary(
    String userId,
  ) async {
    try {
      final DateTime now = DateTime.now();
      final DateTime periodStart = DateTime(now.year, now.month);
      final DateTime periodEnd = DateTime(now.year, now.month + 1);

      final List<dynamic> budgetsResponse = await _client
          .from(_budgetsTable)
          .select(_selectWithCategory)
          .eq('user_id', userId)
          .eq('is_active', true);

      if (budgetsResponse.isEmpty) {
        return const <BudgetRingSummary>[];
      }

      final List<dynamic> transactionsResponse = await _client
          .from(_transactionsTable)
          .select('category_id, amount')
          .eq('type', 'expense')
          .gte('date', periodStart.toIso8601String())
          .lt('date', periodEnd.toIso8601String());

      final Map<String, double> spentByCategory = <String, double>{};
      for (final dynamic row in transactionsResponse) {
        final Map<String, dynamic> map = row as Map<String, dynamic>;
        final String? categoryId = map['category_id'] as String?;
        if (categoryId == null) {
          continue;
        }
        final double amount = _parseAmount(map['amount']);
        spentByCategory[categoryId] =
            (spentByCategory[categoryId] ?? 0) + amount;
      }

      return budgetsResponse.map((dynamic row) {
        final Map<String, dynamic> budget = row as Map<String, dynamic>;
        final Map<String, dynamic>? category =
            budget['categories'] as Map<String, dynamic>?;
        final String categoryId = budget['category_id'] as String;
        final double limit = _parseAmount(budget['limit_amount']);

        return BudgetRingSummary(
          categoryName: category?['name'] as String? ?? 'Budget',
          spent: spentByCategory[categoryId] ?? 0,
          limit: limit,
          colorHex: category?['color_hex'] as String? ?? '14213D',
          categoryIconName: category?['icon_name'] as String?,
        );
      }).toList();
    } on PostgrestException catch (error) {
      throw NetworkException(message: error.message);
    } catch (error) {
      throw UnexpectedException(message: error.toString());
    }
  }

  double _parseAmount(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value) ?? 0;
    }
    return 0;
  }
}
