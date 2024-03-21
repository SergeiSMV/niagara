import 'package:flutter/material.dart';
import 'package:niagara_app/config/theme/colors/buttons_colors.dart';
import 'package:niagara_app/config/theme/colors/field_border_colors.dart';
import 'package:niagara_app/config/theme/colors/gradient_colors.dart';
import 'package:niagara_app/config/theme/colors/info_colors.dart';
import 'package:niagara_app/config/theme/colors/main_colors.dart';
import 'package:niagara_app/config/theme/colors/text_colors.dart';

/// Основные цвета приложения, используемые в макетах
abstract class BaseColors extends ThemeExtension<BaseColors> {
  /// Конструктор для основных цветов темы
  const BaseColors({
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
