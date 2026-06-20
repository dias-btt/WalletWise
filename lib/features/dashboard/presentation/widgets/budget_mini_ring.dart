import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wallet_wise/core/theme/app_colors.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget_ring_summary.dart';
import 'package:wallet_wise/shared/widgets/category_picker.dart';

class BudgetMiniRing extends StatelessWidget {
  const BudgetMiniRing({
    required this.summary,
    required this.onTap,
    super.key,
  });

  final BudgetRingSummary summary;
  final VoidCallback onTap;

  Color get _ringColor {
    final int percent = summary.percentLabel;
    if (percent >= 100) {
      return AppColors.expenseRed;
    }
    if (percent >= 70) {
      return AppColors.warningAmber;
    }
    return AppColors.incomeGreen;
  }

  @override
  Widget build(BuildContext context) {
    final Color categoryColor = categoryColorFromHex(summary.colorHex);
    final double progress = summary.progress;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 88,
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 72,
              height: 72,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  PieChart(
                    PieChartData(
                      startDegreeOffset: -90,
                      sectionsSpace: 0,
                      centerSpaceRadius: 26,
                      sections: <PieChartSectionData>[
                        PieChartSectionData(
                          value: progress * 100,
                          color: _ringColor,
                          radius: 8,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: (1 - progress) * 100,
                          color: AppColors.borderLight,
                          radius: 8,
                          showTitle: false,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    categoryIconFromName(
                      summary.categoryIconName ?? 'category',
                    ),
                    color: categoryColor,
                    size: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${summary.percentLabel}%',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: _ringColor,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              summary.categoryName,
              style: Theme.of(context).textTheme.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
