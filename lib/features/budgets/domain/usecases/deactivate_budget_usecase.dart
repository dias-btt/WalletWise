import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/budgets/domain/repositories/budget_repository.dart';
import 'package:wallet_wise/shared/domain/usecase.dart';

class DeactivateBudgetParams extends Equatable {
  const DeactivateBudgetParams({required this.budgetId});

  final String budgetId;

  @override
  List<Object?> get props => <Object?>[budgetId];
}

class DeactivateBudgetUseCase extends UseCase<void, DeactivateBudgetParams> {
  DeactivateBudgetUseCase(this._repository);

  final BudgetRepository _repository;

  @override
  Future<Either<Failure, void>> call(DeactivateBudgetParams params) {
    return _repository.deactivateBudget(params.budgetId);
  }
}
