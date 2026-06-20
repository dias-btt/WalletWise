import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getCategories();
}
