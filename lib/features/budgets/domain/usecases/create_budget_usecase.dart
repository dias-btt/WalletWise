import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget.dart';
import 'package:wallet_wise/features/budgets/domain/repositories/budget_repository.dart';
import 'package:wallet_wise/shared/domain/usecase.dart';

class CreateBudgetUseCase extends UseCase<Budget, Budget> {
  CreateBudgetUseCase(this._repository);

  final BudgetRepository _repository;

  @override
  Future<Either<Failure, Budget>> call(Budget params) {
    return _repository.createBudget(params);
  }
}
