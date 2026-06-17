import 'package:flutter/material.dart';
import 'package:wallet_wise/core/theme/app_colors.dart';

abstract final class AppTextStyles {
  static const String _fontFamily = 'Roboto';

  // Display
  static const TextStyle displayRegular = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w400,
    height: 1.25,
    letterSpacing: -0.5,
  );

  static const TextStyle displayBold = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.5,
  );

  // Headline
  static const TextStyle headlineRegular = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: -0.25,
  );

  static const TextStyle headlineBold = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.25,
  );

  // Body
  static const TextStyle bodyRegular = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle bodyBold = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  // Label
  static const TextStyle labelRegular = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.25,
  );

  static const TextStyle labelBold = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.25,
  );

  static TextStyle withColor(TextStyle style, Color color) =>
      style.copyWith(color: color);

  static TextTheme textTheme({required bool isDark}) {
    final Color primary =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color secondary =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return TextTheme(
      displayLarge: withColor(displayBold, primary),
      displayMedium: withColor(displayRegular, primary),
      headlineLarge: withColor(headlineBold, primary),
      headlineMedium: withColor(headlineRegular, primary),
      bodyLarge: withColor(bodyRegular, primary),
      bodyMedium: withColor(bodyBold, primary),
      labelLarge: withColor(labelBold, secondary),
      labelMedium: withColor(labelRegular, secondary),
    );
  }
}
