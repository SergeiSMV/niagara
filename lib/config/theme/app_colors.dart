import 'package:flutter/material.dart';
import 'package:niagara_app/config/theme/buttons_colors.dart';
import 'package:niagara_app/config/theme/field_border_colors.dart';
import 'package:niagara_app/config/theme/gradient_colors.dart';
import 'package:niagara_app/config/theme/info_colors.dart';
import 'package:niagara_app/config/theme/main_colors.dart';
import 'package:niagara_app/config/theme/text_colors.dart';

/// Основные цвета приложения, используемые в макетах
abstract class AppThemeColors extends ThemeExtension<AppThemeColors> {
  /// Конструктор для основных цветов темы
  const AppThemeColors({
    required this.mainColors,
    required this.textColors,
    required this.buttonColors,
    required this.fieldBordersColors,
    required this.infoColors,
    required this.gradientColors,
  });

  /// Основные цвета
  final MainColors mainColors;

  /// Цвета текста
  final TextColors textColors;

  /// Цвета кнопок
  final ButtonColors buttonColors;

  /// Цвета границ полей ввода
  final FieldBordersColors fieldBordersColors;

  /// Цвета информационных элементов
  final InfoColors infoColors;

  /// Градиентные цвета
  final GradientColors gradientColors;
}
