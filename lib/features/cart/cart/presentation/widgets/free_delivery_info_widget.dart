import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';

/// Баннер с информацией о стоимости доставки и условиях бесплатной доставки.
///
/// Отображается только если стоимость доставки больше нуля.
class FreeDeliveryInfoWidget extends StatelessWidget {
  const FreeDeliveryInfoWidget({super.key, required this.cart});

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    final int deliveryFee = cart.cartData.deliveryFee.round();
    final int minSum = cart.minLimit.minAmount.round();
    final bool hasDeliveryFee = deliveryFee > 0;

    if (!hasDeliveryFee) return const SizedBox.shrink();

    return Padding(
      padding: AppInsets.kHorizontal16,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.infoColors.bgBlue,
          borderRadius: AppBorders.kCircular12,
        ),
        child: Padding(
          padding: AppInsets.kAll12,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.icons.infoFill.svg(
                width: AppSizes.kIconMedium,
                height: AppSizes.kIconMedium,
                color: context.colors.infoColors.blue,
              ),
              AppBoxes.kWidth12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${t.cart.deliveryCost} $deliveryFee${t.common.rub}',
                      style: context.textStyle.textTypo.tx2SemiBold,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    AppBoxes.kHeight4,
                    Text(
                      t.cart.freeDelivery(n: minSum),
                      style: context.textStyle.descriptionTypo.des3,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
