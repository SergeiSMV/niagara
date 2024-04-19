import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/buttons_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/field_border_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/gradient_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/info_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/main_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/map_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/other_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/text_colors.dart';

/// Цвета приложения, используемые в макетах
abstract class BaseColors extends ThemeExtension<BaseColors> {
  const BaseColors({
    required this.mainColors,
    required this.textColors,
    required this.buttonColors,
    required this.fieldBordersColors,
    required this.infoColors,
    required this.gradientColors,
    required this.mapColors,
    required this.otherColors,
  });

  final MainColors mainColors;

  final TextColors textColors;

  final ButtonColors buttonColors;

  final FieldBordersColors fieldBordersColors;

  final InfoColors infoColors;

  final GradientColors gradientColors;

  final MapColors mapColors;

  final OtherColors otherColors;
}
