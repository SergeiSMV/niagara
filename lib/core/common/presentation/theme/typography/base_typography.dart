import 'package:flutter/material.dart';
import 'button_typo.dart';
import 'caption_typo.dart';
import 'description_typo.dart';
import 'heading_typo.dart';
import 'text_typo.dart';

/// Базовая типографика приложения (размеры шрифтов, межстрочные интервалы, etc)
abstract class BaseTypography extends ThemeExtension<BaseTypography> {
  const BaseTypography({
    required this.headingTypo,
    required this.textTypo,
    required this.captionTypo,
    required this.descriptionTypo,
    required this.buttonTypo,
  });

  final HeadingTypography headingTypo;

  final TextTypography textTypo;

  final CaptionTypography captionTypo;

  final DescriptionTypography descriptionTypo;

  final ButtonTypography buttonTypo;
}
