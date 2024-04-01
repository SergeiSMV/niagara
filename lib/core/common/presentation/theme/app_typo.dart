import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/theme/typography/base_typography.dart';
import 'package:niagara_app/core/common/presentation/theme/typography/button_typo.dart';
import 'package:niagara_app/core/common/presentation/theme/typography/caption_typo.dart';
import 'package:niagara_app/core/common/presentation/theme/typography/description_typo.dart';
import 'package:niagara_app/core/common/presentation/theme/typography/heading_typo.dart';
import 'package:niagara_app/core/common/presentation/theme/typography/text_typo.dart';
import 'package:niagara_app/core/utils/gen/fonts.gen.dart';

/// Класс [AppTypo] содержит типографику приложения.
/// Все изменения в типографике производятся в этом классе.
@singleton
class AppTypo extends BaseTypography {
  /// Конструктор для типографики приложения
  const AppTypo()
      : super(
          headingTypo: const _HeadingTypography(),
          textTypo: const _TextTypography(),
          captionTypo: const _CaptionTypography(),
          descriptionTypo: const _DescriptionTypography(),
          buttonTypo: const _ButtonTypography(),
        );

  @override
  ThemeExtension<BaseTypography> copyWith() => const AppTypo();

  @override
  ThemeExtension<BaseTypography> lerp(
    covariant ThemeExtension<BaseTypography>? other,
    double t,
  ) {
    if (other! is AppTypo) return this;
    return const AppTypo();
  }
}

class _HeadingTypography extends HeadingTypography {
  const _HeadingTypography()
      : super(
          h1: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.54,
            height: 38 / 30,
            fontFamily: FontFamily.montserrat,
          ),
          h2: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.36,
            height: 30 / 24,
            fontFamily: FontFamily.montserrat,
          ),
          h3: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
            height: 24 / 20,
            fontFamily: FontFamily.montserrat,
          ),
        );
}

class _TextTypography extends TextTypography {
  const _TextTypography()
      : super(
          tx1SemiBold: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 22 / 16,
            fontFamily: FontFamily.montserrat,
          ),
          tx1Medium: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 22 / 16,
            fontFamily: FontFamily.montserrat,
          ),
          tx2SemiBold: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 20 / 14,
            fontFamily: FontFamily.montserrat,
          ),
          tx2Medium: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 20 / 14,
            fontFamily: FontFamily.montserrat,
          ),
          tx3SemiBold: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            height: 16 / 12,
            fontFamily: FontFamily.montserrat,
          ),
          tx3Medium: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 16 / 12,
            fontFamily: FontFamily.montserrat,
          ),
          tx4Medium: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            height: 14 / 11,
            fontFamily: FontFamily.montserrat,
          ),
        );
}

class _CaptionTypography extends CaptionTypography {
  const _CaptionTypography()
      : super(
          c1: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            height: 12 / 10,
            fontFamily: FontFamily.montserrat,
          ),
          c2: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w600,
            height: 10 / 8,
            fontFamily: FontFamily.montserrat,
          ),
        );
}

class _DescriptionTypography extends DescriptionTypography {
  const _DescriptionTypography()
      : super(
          des1: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 24 / 16,
            fontFamily: FontFamily.montserrat,
          ),
          des2: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 20 / 14,
            fontFamily: FontFamily.montserrat,
          ),
          des3: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 16 / 12,
            fontFamily: FontFamily.montserrat,
          ),
          des4: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            height: 12 / 10,
            fontFamily: FontFamily.montserrat,
          ),
        );
}

class _ButtonTypography extends ButtonTypography {
  const _ButtonTypography()
      : super(
          btn1b: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 22 / 16,
            fontFamily: FontFamily.montserrat,
          ),
          btn1sb: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 22 / 16,
            fontFamily: FontFamily.montserrat,
          ),
          btn2b: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 20 / 14,
            fontFamily: FontFamily.montserrat,
          ),
          btn2sb: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 20 / 14,
            fontFamily: FontFamily.montserrat,
          ),
          btn3b: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            height: 16 / 12,
            fontFamily: FontFamily.montserrat,
          ),
          btn3sb: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            height: 16 / 12,
            fontFamily: FontFamily.montserrat,
          ),
        );
}
