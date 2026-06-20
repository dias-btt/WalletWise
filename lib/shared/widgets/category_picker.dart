import 'package:flutter/material.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';

IconData categoryIconFromName(String iconName) {
  return switch (iconName) {
    'restaurant' => Icons.restaurant,
    'shopping_cart' => Icons.shopping_cart,
    'directions_car' => Icons.directions_car,
    'home' => Icons.home,
    'bolt' => Icons.bolt,
    'movie' => Icons.movie,
    'local_hospital' => Icons.local_hospital,
    'school' => Icons.school,
    'payments' => Icons.payments,
    'work' => Icons.work,
    'coffee' => Icons.coffee,
    'flight' => Icons.flight,
    'fitness_center' => Icons.fitness_center,
    'pets' => Icons.pets,
    'child_care' => Icons.child_care,
    'swap_horiz' => Icons.swap_horiz,
    _ => Icons.category,
  };
}

Color categoryColorFromHex(String colorHex) {
  final String normalized = colorHex.replaceAll('#', '');
  final String value =
      normalized.length == 6 ? 'FF$normalized' : normalized.padLeft(8, 'F');
  return Color(int.parse(value, radix: 16));
}

class CategoryPicker extends StatelessWidget {
  const CategoryPicker({
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
    this.crossAxisCount = 3,
    super.key,
  });

  final List<Category> categories;
  final String? selectedCategoryId;
  final ValueChanged<Category> onCategorySelected;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.95,
      ),
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        final Category category = categories[index];
        final bool isSelected = category.id == selectedCategoryId;
        final Color backgroundColor = categoryColorFromHex(category.colorHex);

        return CategoryIconChip(
          category: category,
          isSelected: isSelected,
          backgroundColor: backgroundColor,
          onTap: () => onCategorySelected(category),
        );
      },
    );
  }
}

class CategoryIconChip extends StatelessWidget {
  const CategoryIconChip({
    required this.category,
    required this.backgroundColor,
    required this.onTap,
    this.isSelected = false,
    super.key,
  });

  final Category category;
  final Color backgroundColor;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? theme.colorScheme.primary : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 20,
                backgroundColor: backgroundColor,
                child: Icon(
                  categoryIconFromName(category.iconName),
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
