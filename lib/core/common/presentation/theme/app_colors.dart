import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/base_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/buttons_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/field_border_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/gradient_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/info_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/main_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/map_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/other_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/text_colors.dart';

/// Класс [AppColors] содержит цветовую тему приложения.
/// Все изменения в цветовой теме производятся в этом классе.
@singleton
class AppColors extends BaseColors {
  const AppColors()
      : super(
          mainColors: const _MainColors(),
          textColors: const _TextColors(),
          buttonColors: const _ButtonColors(),
          fieldBordersColors: const _FieldBordersColors(),
          infoColors: const _InfoColors(),
          gradientColors: const _GradientColors(),
          mapColors: const _MapColors(),
          otherColors: const _OtherColors(),
        );

  @override
  ThemeExtension<BaseColors> copyWith() => const AppColors();

  @override
  ThemeExtension<BaseColors> lerp(
    covariant ThemeExtension<BaseColors>? other,
    double t,
  ) {
    if (other! is AppColors) return this;
    return const AppColors();
  }
}

class _MainColors extends MainColors {
  const _MainColors()
      : super(
          primary: const Color(0xFF044B75),
          accent: const Color(0xFF1B6A99),
          light: const Color(0xFFDBE0F8),
          bgCard: const Color(0xFFF1F3FC),
          white: const Color(0xFFFFFFFF),
        );
}

class _TextColors extends TextColors {
  const _TextColors()
      : super(
          main: const Color(0xFF020F17),
          accent: const Color(0xFF044B75),
          error: const Color(0xFFEE2A1D),
          secondary: const Color(0xFF87898D),
          white: const Color(0xFFFFFFFF),
        );
}

class _ButtonColors extends ButtonColors {
  const _ButtonColors()
      : super(
          primary: const Color(0xFF044B75),
          accent: const Color(0xFF1B6A99),
          inactive: const Color(0xFF6893AC),
          secondary: const Color(0xFFEEEFF5),
        );
}

class _FieldBordersColors extends FieldBordersColors {
  const _FieldBordersColors()
      : super(
          main: const Color(0xFFC6C9CB),
          accent: const Color(0xFF044B75),
          negative: const Color(0xFFF25C68),
          focus: const Color(0xFFD7E2E9),
        );
}

class _InfoColors extends InfoColors {
  const _InfoColors()
      : super(
          red: const Color(0xFFF25C68),
          bgRed: const Color(0xFFFFE2E5),
          green: const Color(0xFF44C3A5),
          blue: const Color(0xFF0F78FF),
          bgBlue: const Color(0xFFE5EFFF),
          yellow: const Color(0xFFFFD263),
        );
}

class _GradientColors extends GradientColors {
  const _GradientColors()
      : super(
          bgGradient: const [
            Color(0xFF274886),
            Color(0xFF49AAC3),
          ],
          coinAndStars: const [
            Color(0xFFFBAB7E),
            Color(0xFFF7CE68),
          ],
          storyPreview: const [
            Color(0xFF52B0CE),
            Color(0xFF00348F),
          ],
          bgStoryDark1: const [
            Color.fromRGBO(0, 0, 0, 0.96),
            Color.fromRGBO(0, 0, 0, 0.3),
            Color.fromRGBO(0, 0, 0, 0.29),
            Color.fromRGBO(0, 0, 0, 0.06),
          ],
          bgStoryDark2: const [
            Color.fromRGBO(0, 0, 0, 0.38),
            Color.fromRGBO(0, 0, 0, 0.29),
            Color.fromRGBO(0, 0, 0, 0.1),
            Color.fromRGBO(0, 0, 0, 0.05),
          ],
          bgStoryLight1: const [
            Color.fromRGBO(255, 255, 255, 0.384),
            Color.fromRGBO(255, 255, 255, 0.288),
            Color.fromRGBO(255, 255, 255, 0.048),
            Colors.transparent,
          ],
          bgStoryLight2: const [
            Color.fromRGBO(255, 255, 255, 0.96),
            Color.fromRGBO(255, 255, 255, 0.288),
            Colors.transparent,
          ],
        );
}

class _MapColors extends MapColors {
  const _MapColors()
      : super(
          deliveryEnabled: const Color(0xFF044B75),
          deliveryDisabled: const Color(0xFFF25C68),
        );
}

class _OtherColors extends OtherColors {
  const _OtherColors()
      : super(
          background70: const Color(0x70000000),
          separator30: const Color(0x30C6C9CB),
          itemShadow: const Color(0xFFEEEEEE),
          background30: const Color(0x4B000000),
        );
}
