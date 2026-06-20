import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget_ring_summary.dart';

abstract class BudgetRepository {
  Future<Either<Failure, List<BudgetRingSummary>>> getActiveBudgetsSummary(
    String userId,
  );
}
