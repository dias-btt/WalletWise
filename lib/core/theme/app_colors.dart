import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFF14213D);
  static const Color primaryLight = Color(0xFF1F3560);
  static const Color primaryDark = Color(0xFF0D1526);

  // Surfaces
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1A1D24);
  static const Color backgroundLight = Color(0xFFF5F6F8);
  static const Color backgroundDark = Color(0xFF12141A);

  // Semantic
  static const Color error = Color(0xFFDC3545);
  static const Color incomeGreen = Color(0xFF2ECC71);
  static const Color expenseRed = Color(0xFFE74C3C);
  static const Color warningAmber = Color(0xFFF39C12);

  // Text
  static const Color textPrimaryLight = Color(0xFF1A1D24);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textPrimaryDark = Color(0xFFF5F6F8);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);

  // Borders & dividers
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF2D3139);
}
