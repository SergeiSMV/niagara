import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/close_modal_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/draggable_pin_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';

/// Строка с информацией о стоимости доставки.
///
/// По нажатии открывает модальное окно с информацией о рассчете стоимости
/// доставки.
class CartDataDeliveryWidget extends StatelessWidget {
  const CartDataDeliveryWidget({
    super.key,
    required this.cart,
  });

  final Cart cart;

  int get _deliveryFee => cart.cartData.deliveryFee.round();

  void _onTap(BuildContext context) => showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        backgroundColor: context.colors.mainColors.white,
        useSafeArea: true,
        builder: (ctx) => SafeArea(
          child: _DeliveryInfoModalContent(cart: cart),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (_deliveryFee == 0) return const SizedBox.shrink();

    return Padding(
      padding: AppInsets.kVertical4,
      child: Row(
        children: [
          Text(
            t.cart.deliveryFee,
            style: context.textStyle.textTypo.tx2Medium
                .withColor(context.colors.textColors.main),
          ),
          AppBoxes.kWidth4,
          InkWell(
            onTap: () => _onTap(context),
            child: Assets.icons.question.svg(
              width: AppSizes.kIconSmall,
              height: AppSizes.kIconSmall,
            ),
          ),
          const Spacer(),
          Text(
            '$_deliveryFee ${t.common.rub}',
            style: context.textStyle.textTypo.tx2Medium
                .withColor(context.colors.textColors.main),
          ),
        ],
      ),
    );
  }
}

class _DeliveryInfoModalContent extends StatelessWidget {
  const _DeliveryInfoModalContent({
    required this.cart,
  });

  final Cart cart;

  Future<void> _onCloseModal(BuildContext context) async => context.maybePop();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const PinWidget(),
          AppBoxes.kHeight12,
          Row(
            children: [
              Text(
                t.cart.deliveryInfo,
                style: context.textStyle.headingTypo.h3
                    .withColor(context.colors.textColors.main),
              ),
              const Spacer(),
              CloseModalButton(onTap: () => _onCloseModal(context)),
            ],
          ),
          AppBoxes.kHeight12,
          Text.rich(
            t.cart.minimumOrderAmountDescription(
              n: TextSpan(
                text: cart.minLimit.minAmount.toInt().toString(),
              ),
              withoutMainProduct: (text) => TextSpan(
                text: text,
                style: context.textStyle.textTypo.tx2SemiBold.copyWith(
                  color: context.colors.mainColors.primary,
                ),
              ),
            ),
            style: context.textStyle.descriptionTypo.des2,
          ),
          AppBoxes.kHeight24,
        ],
      ),
    );
  }
}
