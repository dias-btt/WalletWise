import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet_wise/core/errors/exceptions.dart';
import 'package:wallet_wise/features/transactions/data/models/category_model.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';

abstract class CategoryRemoteDatasource {
  Future<List<Category>> getCategories();
}

class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource {
  CategoryRemoteDatasourceImpl(this._client);

  final SupabaseClient _client;

  static const String _table = 'categories';

  @override
  Future<List<Category>> getCategories() async {
    try {
      final List<dynamic> response = await _client
          .from(_table)
          .select()
          .order('sort_order', ascending: true);

      return response
          .cast<Map<String, dynamic>>()
          .map(CategoryModel.fromJson)
          .map((CategoryModel model) => model.toEntity())
          .toList();
    } on PostgrestException catch (error) {
      throw NetworkException(message: error.message);
    } catch (error) {
      throw UnexpectedException(message: error.toString());
    }
  }
}
