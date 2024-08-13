import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/snack_bars/base_snack_bar.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

class AppSnackBar extends BaseSnackBar {
  /// Создает экземпляр [AppSnackBar] стиля ошибки.
  /// Описание параметров см. в [BaseSnackBar].
  const AppSnackBar._error({
    required String title,
    String? subtitle,
    Color? barColor,
  }) : super.error(
          title,
          subtitle,
          barColor,
        );

  static void showErrorShackBar(
    BuildContext context, {
    required String title,
    String? subtitle,
    Color? barColor,
  }) {
    AnimatedSnackBar(
      builder: (context) => AppSnackBar._error(
        title: title,
        subtitle: subtitle,
        barColor: barColor ?? context.colors.infoColors.bgRed,
      ),
    ).show(context);
  }
}
