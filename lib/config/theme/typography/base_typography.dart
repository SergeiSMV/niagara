import 'package:flutter/material.dart';
import 'package:niagara_app/config/theme/typography/button_typo.dart';
import 'package:niagara_app/config/theme/typography/caption_typo.dart';
import 'package:niagara_app/config/theme/typography/description_typo.dart';
import 'package:niagara_app/config/theme/typography/heading_typo.dart';
import 'package:niagara_app/config/theme/typography/text_typo.dart';

/// Базовая типографика приложения (размеры шрифтов, межстрочные интервалы, etc)
abstract class BaseTypography extends ThemeExtension<BaseTypography> {
  /// Конструктор для базовой типографики
  const BaseTypography({
    required this.headingTypo,
    required this.textTypo,
    required this.captionTypo,
    required this.descriptionTypo,
    required this.buttonTypo,
  });

  /// Типографика заголовков
  final HeadingTypography headingTypo;

  /// Типографика текста
  final TextTypography textTypo;

  /// Типографика подписей
  final CaptionTypography captionTypo;

  /// Типографика описаний
  final DescriptionTypography descriptionTypo;

  /// Типографика кнопок
  final ButtonTypography buttonTypo;
}
