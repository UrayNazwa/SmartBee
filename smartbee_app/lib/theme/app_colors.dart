import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF81602D);
  static const Color primaryLight = Color(0xFFA78D78);
  static const Color primaryDark = Color(0xFF6E473B);
  static const Color darkest = Color(0xFF291C0E);

  static const Color background = Color(0xFFE1D9CD);
  static const Color surface = Color(0xFFEFEBE9);
  static const Color surfaceLight = Color(0xFFF5F1EB);
  static const Color surfaceDark = Color(0xFFC7B7A3);

  static const Color textPrimary = Color(0xFF2D1B10);
  static const Color textSecondary = Color(0xFF5D4037);
  static const Color textMuted = Color(0xFF9E9E9E);

  static const Color success = Color(0xFF718664);
  static const Color error = Color(0xFF8B0000);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  static const Color border = Color(0xFF2D1B10);
  static const Color borderLight = Color(0xFFB5A48B);

  static const Color roleSuperAdmin = Colors.purple;
  static const Color roleGuru = Colors.blue;
  static const Color roleSiswa = Colors.green;

  static const List<Color> gradient = [
    primaryLight,
    primaryDark,
    darkest,
  ];
}

class AppTextStyles {
  static TextStyle heading1(BuildContext context) {
    return const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle heading2(BuildContext context) {
    return const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle heading3(BuildContext context) {
    return const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle body(BuildContext context) {
    return const TextStyle(
      fontSize: 14,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle caption(BuildContext context) {
    return const TextStyle(
      fontSize: 12,
      color: AppColors.textSecondary,
    );
  }
}