import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/theme/app_colors.dart';
import 'package:niagara_app/core/theme/app_typo.dart';
import 'package:niagara_app/core/theme/colors/base_colors.dart';
import 'package:niagara_app/core/theme/typography/base_typography.dart';

/// Класс [AppTheme] содержит основную тему приложения, которая объединяет в
/// себе цветовую тему и типографику. Все изменения в теме приложения
/// производятся в этом классе.
@singleton
class AppTheme {
  /// Основная тема приложения
  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      extensions: const <ThemeExtension>[
        AppColors(),
        AppTypo(),
      ],
      brightness: Brightness.light,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      bottomNavigationBarTheme: _bottomNavigationBarThemeData(
        colors: const AppColors(),
        typography: const AppTypo(),
      ),
    );
  }

  static BottomNavigationBarThemeData _bottomNavigationBarThemeData({
    required BaseColors colors,
    required BaseTypography typography,
  }) =>
      BottomNavigationBarThemeData(
        backgroundColor: colors.mainColors.primary,
        selectedItemColor: colors.textColors.white,
        unselectedItemColor: colors.textColors.white.withOpacity(0.6),
        selectedLabelStyle: typography.textTypo.tx4Medium,
        unselectedLabelStyle: typography.textTypo.tx4Medium,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        enableFeedback: true,
      );
}
