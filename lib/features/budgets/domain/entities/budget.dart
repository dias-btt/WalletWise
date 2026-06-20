import 'package:equatable/equatable.dart';

enum BudgetPeriod {
  weekly,
  monthly,
}

extension BudgetPeriodX on BudgetPeriod {
  String get dbValue => switch (this) {
        BudgetPeriod.weekly => 'weekly',
        BudgetPeriod.monthly => 'monthly',
      };

  static BudgetPeriod fromDbValue(String value) => switch (value) {
        'weekly' => BudgetPeriod.weekly,
        _ => BudgetPeriod.monthly,
      };
}

class Budget extends Equatable {
  const Budget({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.limitAmount,
    required this.currencyCode,
    required this.period,
    required this.startDate,
    required this.isActive,
  });

  final String id;
  final String userId;
  final String categoryId;
  final double limitAmount;
  final String currencyCode;
  final BudgetPeriod period;
  final DateTime startDate;
  final bool isActive;

  @override
  List<Object?> get props => <Object?>[
        id,
        userId,
        categoryId,
        limitAmount,
        currencyCode,
        period,
        startDate,
        isActive,
      ];
}
