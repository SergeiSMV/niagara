import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/bloc/prepaid_water_buying_cubit.dart/water_balance_buying_cubit.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/close_modal_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cards/base_product_cart_widget.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/prepaid_water/domain/model/prepaid_water_order_data.dart';
import 'package:niagara_app/features/prepaid_water/presentation/bloc/balance_cubit/water_balance_cubit.dart';

/// Кнопка "Купить" для предоплатной воды.
///
/// При нажатии на кнопку открывается модальное окно с выбором количества воды и
/// возможностью перехода к оплате.
///
/// Используется в `bottomNavigationBar` на странице продукта.
class BuyPrepaidWaterButton extends StatelessWidget {
  const BuyPrepaidWaterButton({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OrderWaterAmountCubit>();

    void onSuccess() {
      getIt<WaterBalanceCubit>().getBottles();
      context.navigateTo(OrderResultRoute(isSuccessful: true));
    }

    void onCancelled() =>
        context.navigateTo(OrderResultRoute(isSuccessful: false));

    /// Переход к оплате.
    void goToPayment() => context.navigateTo(
          PaymentWrapper(
            prepaidWaterData: OrderWaterData(
              productId: product.id,
              count: cubit.state,
            ),
            children: [
              PaymentCreationRoute(
                pageTitle: t.prepaidWater.buyingComplect,
                purchasedProductWidget: BaseProductCartWidget(
                  // key: ValueKey('${product.id}_noninteractive'),
                  product: product,
                  onAdd: () {},
                  onRemove: () {},
                  count: cubit.state,
                  interactive: false,
                ),
                onSuccess: onSuccess,
                onCancelled: onCancelled,
                amountRub: (product.price * cubit.state).toString(),
                productCount: cubit.state,
                payButtonText: t.vip.pay,
              ),
            ],
          ),
        );

    /// Открывает модальное окно с настройкой количества покупаемых комплектов
    /// воды.
    void showAmountModal() => showModalBottomSheet(
          context: context,
          backgroundColor: context.colors.mainColors.white,
          builder: (context) => _ModalContent(
            product: product,
            cubit: cubit,
            onTap: () {
              goToPayment();
            },
          ),
        );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        boxShadow: [
          BoxShadow(
            color: context.colors.textColors.main
                .withOpacity(AppSizes.kShadowOpacity),
            blurRadius: AppSizes.kGeneral12,
            offset: AppConstants.kShadowTop,
          ),
        ],
      ),
      child: Padding(
        padding: AppInsets.kHorizontal16,
        child: Padding(
          padding: AppInsets.kAll16,
          child: AppTextButton.primary(
            text: t.prepaidWater.buy,
            onTap: showAmountModal,
          ),
        ),
      ),
    );
  }
}

class _ModalContent extends StatefulWidget {
  const _ModalContent({
    required this.product,
    required this.cubit,
    required this.onTap,
  });

  final Product product;
  final OrderWaterAmountCubit cubit;
  final VoidCallback onTap;

  @override
  State<_ModalContent> createState() => _ModalContentState();
}

class _ModalContentState extends State<_ModalContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kTop32 + AppInsets.kBottom16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.prepaidWater.selectCount,
                style: context.textStyle.headingTypo.h3,
              ),
              CloseModalButton(onTap: context.maybePop),
            ],
          ),
          AppBoxes.kHeight24,
          BlocBuilder<OrderWaterAmountCubit, int>(
            bloc: widget.cubit,
            builder: (context, count) {
              return BaseProductCartWidget(
                product: widget.product,
                onAdd: widget.cubit.increment,
                onRemove: widget.cubit.decrement,
                count: count,
              );
            },
          ),
          AppBoxes.kHeight24,
          AppTextButton.primary(
            text: t.prepaidWater.payment,
            onTap: widget.onTap,
          ),
        ],
      ),
    );
  }
}

class PrepaidWaterOrderPreview extends StatelessWidget {
  const PrepaidWaterOrderPreview({
    super.key,
    required this.product,
    this.interactive = true,
  });

  /// Продукт.
  final Product product;

  /// Разрешено ли изменять количество комплектов.
  final bool interactive;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderWaterAmountCubit, int>(
      builder: (context, state) => BaseProductCartWidget(
        product: product,
        onAdd: () => context.read<OrderWaterAmountCubit>().increment(),
        onRemove: () => context.read<OrderWaterAmountCubit>().decrement(),
        count: state,
        interactive: interactive,
      ),
    );
  }
}
