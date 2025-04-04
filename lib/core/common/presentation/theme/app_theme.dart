import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/constants/app_borders.dart';
import '../../../utils/extensions/text_style_ext.dart';
import '../../../utils/gen/assets.gen.dart';
import 'app_colors.dart';
import 'app_typo.dart';
import 'colors/base_colors.dart';
import 'decorations/custom_outline_input_border.dart';
import 'typography/base_typography.dart';

/// Класс [AppTheme] содержит основную тему приложения, которая объединяет в
/// себе цветовую тему и типографику. Все изменения в теме приложения
/// производятся в этом классе.
@singleton
class AppTheme {
  AppTheme(this._appColors, this._appTypo);

  final AppColors _appColors;
  final AppTypo _appTypo;

  ThemeData get lightTheme => ThemeData.light().copyWith(
        extensions: <ThemeExtension>[_appColors, _appTypo],
        scaffoldBackgroundColor: _appColors.mainColors.white,
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
        textTheme: ThemeData.light().textTheme.apply(
              displayColor: _appColors.textColors.main,
              bodyColor: _appColors.textColors.main,
              decorationColor: _appColors.textColors.main,
            ),
      );

  static AppBarTheme _appBarTheme({
    required BaseColors colors,
    required BaseTypography typography,
  }) =>
      AppBarTheme(
        backgroundColor: colors.mainColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: typography.textTypo.tx1SemiBold.withColor(
          colors.textColors.main,
        ),
      );

  static BottomNavigationBarThemeData _bottomNavBarTheme({
    required BaseColors colors,
    required BaseTypography typography,
  }) =>
      BottomNavigationBarThemeData(
        backgroundColor: colors.mainColors.primary,
        selectedItemColor: colors.textColors.white,
        unselectedItemColor: colors.textColors.white.withOpacity(.6),
        selectedLabelStyle: typography.textTypo.tx4Medium,
        unselectedLabelStyle: typography.textTypo.tx4Medium,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        enableFeedback: true,
      );

  static InputDecorationTheme _inputDecorationTheme({
    required BaseColors colors,
    required BaseTypography typography,
  }) =>
      InputDecorationTheme(
        border: _buildBorder(colors.fieldBordersColors.main),
        focusedBorder: _buildBorder(colors.fieldBordersColors.accent),
        errorBorder: _buildBorder(colors.fieldBordersColors.negative),
        focusedErrorBorder: _buildBorder(colors.fieldBordersColors.negative),
        disabledBorder: _buildBorder(colors.fieldBordersColors.inactive),
        labelStyle: typography.descriptionTypo.des1
            .withColor(colors.textColors.secondary),
        floatingLabelStyle: typography.descriptionTypo.des3
            .withColor(colors.textColors.secondary),
      );

  static CustomOutlineInputBorder _buildBorder(Color color) =>
      CustomOutlineInputBorder(
        borderRadius: AppBorders.kCircular12,
        borderSide: BorderSide(color: color),
      );
}
