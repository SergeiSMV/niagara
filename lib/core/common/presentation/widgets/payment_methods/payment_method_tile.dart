import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Элемент списка выбора метода оплаты.
class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.image,
    required this.title,
    required this.selected,
    required this.onTap,
  }) : addingNewCard = false;

  /// Добавление новой карты.
  PaymentMethodTile.addNewCard({required this.onTap})
      : image = Assets.images.newCard,
        title = t.paymentMethods.addCard,
        selected = false,
        addingNewCard = true;

  /// Иконка метода оплаты.
  final AssetGenImage image;

  /// Название метода оплаты.
  final String title;

  /// Индикатор, выбран ли этот метод оплаты.
  final bool selected;

  /// Индикатор, добавляется ли новая карта.
  final bool addingNewCard;

  /// Коллбек, отрабатывающий при нажатии.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.mainColors.bgCard,
          borderRadius: AppBorders.kCircular12,
        ),
        child: Padding(
          padding: AppInsets.kAll12,
          child: Row(
            children: [
              image.image(
                height: AppSizes.kGeneral24,
                width: AppSizes.kGeneral32,
              ),
              AppBoxes.kWidth12,
              Text(
                title,
                style: context.textStyle.textTypo.tx1Medium,
              ),
              const Spacer(),
              if (addingNewCard)
                Assets.icons.add.svg(
                  height: AppSizes.kIconMedium,
                  width: AppSizes.kIconMedium,
                )
              else
                selected
                    ? Assets.icons.check.svg(
                        height: AppSizes.kIconMedium,
                        width: AppSizes.kIconMedium,
                      )
                    : Assets.icons.unchecked.svg(
                        height: AppSizes.kIconMedium,
                        width: AppSizes.kIconMedium,
                      ),
            ],
          ),
        ),
      ),
    );
  }
}
