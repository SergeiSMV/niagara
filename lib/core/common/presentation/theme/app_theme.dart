import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/common/presentation/theme/app_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/app_typo.dart';
import 'package:niagara_app/core/common/presentation/theme/colors/base_colors.dart';
import 'package:niagara_app/core/common/presentation/theme/decorations/custom_outline_input_border.dart';
import 'package:niagara_app/core/common/presentation/theme/typography/base_typography.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

/// Класс [AppTheme] содержит основную тему приложения, которая объединяет в
/// себе цветовую тему и типографику. Все изменения в теме приложения
/// производятся в этом классе.
@singleton
class AppTheme {
  AppTheme({
    required AppColors colors,
    required AppTypo typography,
  })  : _appColors = colors,
        _appTypo = typography;

  final AppColors _appColors;
  final AppTypo _appTypo;

  // Основная тема приложения
  ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      extensions: <ThemeExtension>[_appColors, _appTypo],
      scaffoldBackgroundColor: const AppColors().mainColors.white,
      brightness: Brightness.light,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      appBarTheme: _appBarTheme(colors: _appColors, typography: _appTypo),
      bottomNavigationBarTheme: _bottomNavBarTheme(
        colors: _appColors,
        typography: _appTypo,
      ),
      inputDecorationTheme: _inputDecorationTheme(
        colors: _appColors,
        typography: _appTypo,
      ),
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (_) => Assets.icons.arrowLeft.svg(),
      ),
    );
  }

  // Тема для AppBar
  static AppBarTheme _appBarTheme({
    required BaseColors colors,
    required BaseTypography typography,
  }) {
    return AppBarTheme(
      backgroundColor: colors.mainColors.white,
      elevation: 0,
      titleTextStyle: typography.textTypo.tx1SemiBold.withColor(
        colors.textColors.main,
      ),
    );
  }

  // Тема нижней навигационной панели
  static BottomNavigationBarThemeData _bottomNavBarTheme({
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

  // Тема для полей ввода
  static InputDecorationTheme _inputDecorationTheme({
    required BaseColors colors,
    required BaseTypography typography,
  }) {
    return InputDecorationTheme(
      border: _buildBorder(colors.fieldBordersColors.main),
      focusedBorder: _buildBorder(colors.fieldBordersColors.accent),
      errorBorder: _buildBorder(colors.fieldBordersColors.negative),
      focusedErrorBorder: _buildBorder(colors.fieldBordersColors.negative),
      disabledBorder: _buildBorder(colors.fieldBordersColors.inactive),
    );
  }

  // Создание кастомных границ для полей ввода
  static CustomOutlineInputBorder _buildBorder(Color color) {
    return CustomOutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConst.kTextFieldRadius),
      borderSide: BorderSide(color: color),
    );
  }
}
