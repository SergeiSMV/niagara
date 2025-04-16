import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_borders.dart';
import '../../../../../utils/constants/app_insets.dart';
import '../../../../../utils/constants/app_sizes.dart';
import '../../../../../utils/enums/cart_item_action.dart';
import '../../../../../utils/extensions/build_context_ext.dart';

/// Иконка-кнопка для увеличения или уменьшения количества товара при покупке
/// или в корзине.
class AmountIconButton extends StatelessWidget {
  const AmountIconButton({
    required this.itemAction,
    required this.onTap,
    super.key,
    this.loading = false,
  });

  /// Действие, которое будет выполнено при нажатии на кнопку.
  final ItemAction itemAction;

  /// Обработчик нажатия на кнопку.
  final VoidCallback? onTap;

  /// Отображает индикатор загрузки.
  final bool loading;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: AppBorders.kCircular4,
            color: (loading || onTap == null)
                ? context.colors.buttonColors.inactive.withOpacity(0.5)
                : context.colors.buttonColors.accent,
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
