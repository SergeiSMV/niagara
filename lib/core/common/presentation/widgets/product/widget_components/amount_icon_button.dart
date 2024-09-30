import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/cart_item_action.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

/// Иконка-кнопка для увеличения или уменьшения количества товара при покупке
/// или в корзине.
class AmountIconButton extends StatelessWidget {
  const AmountIconButton({
    super.key,
    required this.itemAction,
    required this.onTap,
  });

  /// Действие, которое будет выполнено при нажатии на кнопку.
  final ItemAction itemAction;

  /// Обработчик нажатия на кнопку.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: AppBorders.kCircular4,
          color: context.colors.buttonColors.accent,
        ),
        child: Padding(
          padding: AppInsets.kAll4,
          child: itemAction.icon.svg(
            width: AppSizes.kIconSmall,
            height: AppSizes.kIconSmall,
            colorFilter: ColorFilter.mode(
              context.colors.textColors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
