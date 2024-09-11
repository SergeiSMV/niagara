import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/activation_option.dart';
import 'package:niagara_app/features/vip/presentation/bloc/vip_activation_selection_cubit/vip_activation_selection_cubit.dart';
import 'package:niagara_app/features/vip/presentation/widget/vip_purchase_description.dart';

/// Кнопка "оформить подписку".
class VipSubcribeButton extends StatelessWidget {
  const VipSubcribeButton();

  /// Обработчик нажатия на кнопку.
  void onTap(BuildContext context, ActivationOption option) {
    context.navigateTo(
      PaymentWrapper(
        activationOption: option,
        children: [
          PaymentCreationRoute(
            pageTitle: t.vip.subscribing,
            purchasedProductWidget: VipPurchaseDescription(option: option),
            onSuccess: () {},
            onCancelled: () {},
            amountRub: option.sum,
            payButtonText: t.vip.pay,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<VipActivationSelectionCubit>();

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
        padding: AppInsets.kHorizontal16 +
            AppInsets.kVertical12 +
            AppInsets.kBottom12,
        child: AppTextButton.primary(
          text: t.vip.subscribe,
          onTap:
              cubit.state != null ? () => onTap(context, cubit.state!) : null,
        ),
      ),
    );
  }
}
