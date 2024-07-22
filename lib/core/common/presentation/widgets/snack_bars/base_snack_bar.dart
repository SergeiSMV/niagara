import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

abstract class BaseSnackBar extends StatelessWidget {
  /// Создает экземпляр [BaseSnackBar] основного стиля.
  const BaseSnackBar.error(
    this.title,
    this.subtitle,
  );

  /// Заголовок сообщения
  final String title;

  /// Подзаголовок сообщения
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AnimatedSnackBar.removeAll(),
      child: Container(
        padding: AppInsets.kAll12,
        decoration: BoxDecoration(
          borderRadius: AppBorders.kCircular12,
          color: context.colors.infoColors.bgRed,
        ),
        child: Row(
          children: [
            Assets.icons.errorIcon.svg(),
            AppBoxes.kWidth12,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textStyle.textTypo.tx2SemiBold
                      .withColor(context.colors.textColors.main),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: context.textStyle.descriptionTypo.des3
                        .withColor(context.colors.textColors.main),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
