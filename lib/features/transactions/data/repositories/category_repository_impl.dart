import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/exceptions.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/transactions/data/datasources/category_remote_datasource.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';
import 'package:wallet_wise/features/transactions/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl(this._remoteDatasource);

  final CategoryRemoteDatasource _remoteDatasource;

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final List<Category> categories = await _remoteDatasource.getCategories();
      return Right<Failure, List<Category>>(categories);
    } on AppException catch (error) {
      return Left<Failure, List<Category>>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, List<Category>>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  Failure _mapAppException(AppException exception) {
    return switch (exception) {
      NetworkException() => NetworkFailure(message: exception.message),
      UnexpectedException() => UnexpectedFailure(message: exception.message),
      _ => UnexpectedFailure(message: exception.message),
    };
  }
}
