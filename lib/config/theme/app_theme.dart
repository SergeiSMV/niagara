import 'package:flutter/material.dart';
import 'package:niagara_app/config/theme/app_colors.dart';
import 'package:niagara_app/config/theme/app_typo.dart';

/// Класс [AppTheme] содержит основную тему приложения, которая объединяет в
/// себе цветовую тему и типографику. Все изменения в теме приложения
/// производятся в этом классе.
class AppTheme {
  AppTheme._();

  /// Основная тема приложения
  static final ThemeData lightTheme = ThemeData(
    extensions: const <ThemeExtension>[
      AppColors(),
      AppTypo(),
    ],
    brightness: Brightness.light,
  );
}
