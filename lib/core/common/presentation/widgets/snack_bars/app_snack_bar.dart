import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/snack_bars/base_snack_bar.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class AppSnackBar extends BaseSnackBar {
  /// Создает экземпляр [AppSnackBar] стиля ошибки.
  ///
  /// Описание параметров см. в [BaseSnackBar].
  AppSnackBar._error({
    required String title,
    String? subtitle,
    Color? barColor,
  }) : super(
          title,
          subtitle,
          barColor,
          Assets.icons.errorIcon,
        );

  /// Создает экземпляр [AppSnackBar] стиля информации.
  ///
  /// Описание параметров см. в [BaseSnackBar].
  AppSnackBar._info({
    required String title,
    String? subtitle,
    Color? barColor,
  }) : super(
          title,
          subtitle,
          barColor,
          Assets.icons.successIcon,
        );

  /// Показывает снекбар с информацией.
  static void showInfo(
    BuildContext context, {
    required String title,
    String? subtitle,
    Color? barColor,
  }) =>
      AnimatedSnackBar(
        mobilePositionSettings: AppInsets.snakBarPadding,
        builder: (context) => AppSnackBar._info(
          title: title,
          subtitle: subtitle,
          barColor: barColor ?? context.colors.mainColors.bgCard,
        ),
      ).show(context);

  /// Показывает снекбар с ошибкой.
  static void showErrorShackBar(
    BuildContext context, {
    required String title,
    String? subtitle,
    Color? barColor,
  }) =>
      AnimatedSnackBar(
        mobilePositionSettings: AppInsets.snakBarPadding,
        builder: (context) => AppSnackBar._error(
          title: title,
          subtitle: subtitle,
          barColor: barColor ?? context.colors.infoColors.bgRed,
        ),
      ).show(context);
}
