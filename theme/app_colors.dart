import 'package:flutter/material.dart';

/// Define
class AppColors extends ThemeExtension<AppColors> {
  final Color background;
  final Color surface;
  final Color primaryText;
  final Color secondaryText;
  final Color brandPrimary;
  final Color borderColor;
  final Color error;
  final Color cardAlt;

  const AppColors({
    required this.background,
    required this.surface,
    required this.primaryText,
    required this.secondaryText,
    required this.brandPrimary,
    required this.borderColor,
    required this.error,
    required this.cardAlt,
  });

  /// creating a copy of current color without changing the original(must included)
  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? primaryText,
    Color? secondaryText,
    Color? brandPrimary,
    Color? borderColor,
    Color? error,
    Color? cardAlt,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      brandPrimary: brandPrimary ?? this.brandPrimary,
      borderColor: borderColor ?? this.borderColor,
      error: error ?? this.error,
      cardAlt: cardAlt ?? this.cardAlt,
    );
  }

  /// animation changing theme(must included)
  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      brandPrimary: Color.lerp(brandPrimary, other.brandPrimary, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      error: Color.lerp(error, other.error, t)!,
      cardAlt: Color.lerp(cardAlt, other.cardAlt, t)!,
    );
  }
}

/// Light theme
const lightColors = AppColors(
  background: Color(0xFFF4F6FC),   // kBackgroundColor
  surface: Colors.white,           // 所有的卡片底色
  primaryText: Colors.black87,     // kTextBlack
  secondaryText: Colors.grey,      // kTextGrey
  brandPrimary: Color(0xFF0422A7), // kPrimaryBlue
  borderColor: Color(0xFFEEEEEE),  // kBorderColor
  error: Color(0xFFC62828),        // Log Out 红色
  cardAlt: Color(0xFFF9FAFB),      // Contact Card 背景
);

/// Dark theme
const darkColors = AppColors(
  background: Color(0xFF121212),
  surface: Color(0xFF1E1E1E),
  primaryText: Colors.white,
  secondaryText: Colors.white60,
  brandPrimary: Color(0xFF4D73FF), // 稍微亮一点的蓝色
  borderColor: Color(0xFF333333),
  error: Color(0xFFCF6679),
  cardAlt: Color(0xFF2C2C2C),
);

extension AppThemeExtension on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}