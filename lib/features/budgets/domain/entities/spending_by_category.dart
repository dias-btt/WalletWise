import 'package:equatable/equatable.dart';

class SpendingByCategory extends Equatable {
  const SpendingByCategory({
    required this.categoryId,
    required this.categoryName,
    required this.iconName,
    required this.colorHex,
    required this.total,
    required this.count,
  });

  final String categoryId;
  final String categoryName;
  final String iconName;
  final String colorHex;
  final double total;
  final int count;

  @override
  List<Object?> get props => <Object?>[
        categoryId,
        categoryName,
        iconName,
        colorHex,
        total,
        count,
      ];
}
