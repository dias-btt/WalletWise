import 'package:equatable/equatable.dart';

enum CategoryGroup {
  foodAndDrink,
  transport,
  housing,
  shopping,
  entertainment,
  health,
  education,
  income,
  other,
}

extension CategoryGroupX on CategoryGroup {
  String get dbValue => switch (this) {
        CategoryGroup.foodAndDrink => 'food_and_drink',
        CategoryGroup.transport => 'transport',
        CategoryGroup.housing => 'housing',
        CategoryGroup.shopping => 'shopping',
        CategoryGroup.entertainment => 'entertainment',
        CategoryGroup.health => 'health',
        CategoryGroup.education => 'education',
        CategoryGroup.income => 'income',
        CategoryGroup.other => 'other',
      };

  static CategoryGroup fromDbValue(String value) {
    return CategoryGroup.values.firstWhere(
      (CategoryGroup group) => group.dbValue == value,
      orElse: () => CategoryGroup.other,
    );
  }
}

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    required this.iconName,
    required this.colorHex,
    required this.groupName,
    required this.isSystem,
    required this.sortOrder,
    this.userId,
  });

  final String id;
  final String? userId;
  final String name;
  final String iconName;
  final String colorHex;
  final CategoryGroup groupName;
  final bool isSystem;
  final int sortOrder;

  @override
  List<Object?> get props => <Object?>[
        id,
        userId,
        name,
        iconName,
        colorHex,
        groupName,
        isSystem,
        sortOrder,
      ];
}
