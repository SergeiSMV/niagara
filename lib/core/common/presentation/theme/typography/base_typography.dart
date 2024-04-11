import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/theme/typography/button_typo.dart';
import 'package:niagara_app/core/common/presentation/theme/typography/caption_typo.dart';
import 'package:niagara_app/core/common/presentation/theme/typography/description_typo.dart';
import 'package:niagara_app/core/common/presentation/theme/typography/heading_typo.dart';
import 'package:niagara_app/core/common/presentation/theme/typography/text_typo.dart';

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
