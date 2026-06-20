import 'package:equatable/equatable.dart';

class BudgetRingSummary extends Equatable {
  const BudgetRingSummary({
    required this.categoryName,
    required this.spent,
    required this.limit,
    required this.colorHex,
    this.categoryIconName,
  });

  final String categoryName;
  final double spent;
  final double limit;
  final String colorHex;
  final String? categoryIconName;

  double get progress => limit > 0 ? (spent / limit).clamp(0.0, 1.0) : 0;

  int get percentLabel => (progress * 100).round();

  @override
  List<Object?> get props => <Object?>[
        categoryName,
        spent,
        limit,
        colorHex,
        categoryIconName,
      ];
}
