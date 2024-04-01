import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

/// Кнопка в AppBar для вызова действия (например, открытие экрана уведомлений)
/// Обязательные параметры:
/// * [icon] - иконка кнопки
/// * [onTap] - действие при нажатии на кнопку
class AppBarActionButton extends StatelessWidget {
  /// Создает виджет кнопки в AppBar для вызова действия
  const AppBarActionButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  /// Иконка кнопки действия
  final SvgGenImage icon;

  /// Действие при нажатии на кнопку
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: icon
          .svg(width: AppConst.kIconLarge, height: AppConst.kIconLarge)
          .paddingSymmetric(horizontal: AppConst.kPaddingMid),
    );
  }
}
