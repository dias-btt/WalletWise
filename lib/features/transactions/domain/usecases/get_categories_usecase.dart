import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';
import 'package:wallet_wise/features/transactions/domain/repositories/category_repository.dart';
import 'package:wallet_wise/shared/domain/usecase.dart';

class GetCategoriesUseCase extends UseCase<List<Category>, NoParams> {
  GetCategoriesUseCase(this._repository);

  final CategoryRepository _repository;

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) {
    return _repository.getCategories();
  }
}
