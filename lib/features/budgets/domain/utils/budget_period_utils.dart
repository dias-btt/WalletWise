import 'package:wallet_wise/features/budgets/domain/entities/budget.dart';

class BudgetPeriodRange {
  const BudgetPeriodRange({
    required this.start,
    required this.end,
  });

  final DateTime start;
  final DateTime end;
}

abstract final class BudgetPeriodUtils {
  static BudgetPeriodRange getCurrentPeriod(Budget budget) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    return switch (budget.period) {
      BudgetPeriod.monthly => _monthlyPeriod(today, budget.startDate),
      BudgetPeriod.weekly => _weeklyPeriod(today, budget.startDate),
    };
  }

  static BudgetPeriodRange _monthlyPeriod(DateTime today, DateTime anchor) {
    final int anchorDay = anchor.day;
    DateTime periodStart = _safeDate(today.year, today.month, anchorDay);

    if (today.isBefore(periodStart)) {
      periodStart = _safeDate(today.year, today.month - 1, anchorDay);
    }

    final DateTime periodEnd = _safeDate(
      periodStart.year,
      periodStart.month + 1,
      anchorDay,
    );

    return BudgetPeriodRange(start: periodStart, end: periodEnd);
  }

  static BudgetPeriodRange _weeklyPeriod(DateTime today, DateTime anchor) {
    final DateTime anchorDay = DateTime(
      anchor.year,
      anchor.month,
      anchor.day,
    );
    final int daysSinceAnchor = today.difference(anchorDay).inDays;
    final int periodsElapsed = daysSinceAnchor >= 0
        ? daysSinceAnchor ~/ 7
        : (daysSinceAnchor - 6) ~/ 7;
    final DateTime periodStart =
        anchorDay.add(Duration(days: periodsElapsed * 7));
    final DateTime periodEnd = periodStart.add(const Duration(days: 7));

    return BudgetPeriodRange(start: periodStart, end: periodEnd);
  }

  static DateTime _safeDate(int year, int month, int day) {
    final int lastDay = DateTime(year, month + 1, 0).day;
    return DateTime(year, month, day.clamp(1, lastDay));
  }
}
