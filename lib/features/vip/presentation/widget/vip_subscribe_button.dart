import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/presentation/bloc/orders_bloc/orders_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/activation_option.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/user_bloc.dart';
import 'package:niagara_app/features/vip/presentation/bloc/vip_activation_selection_cubit/vip_activation_selection_cubit.dart';
import 'package:niagara_app/features/vip/presentation/widget/vip_purchase_description.dart';

/// Кнопка "оформить подписку".
class VipSubcribeButton extends StatelessWidget {
  const VipSubcribeButton();

  /// Обработчик успешного завершения покупки.
  void _onSuccess(BuildContext context) {
    // Обновляем список заказов.
    getIt<OrdersBloc>().add(const OrdersEvent.loading(isForceUpdate: true));
    context.navigateTo(const VipRoute());
  }

  /// Обработчик нажатия на кнопку.
  Future<void> _goToPayment(
      BuildContext context, ActivationOption option) async {
    final bool? authorized = await context.read<UserBloc>().isAuthorized;

    if (authorized == null) {
      return;
    } else if (!authorized && context.mounted) {
      context.pushRoute(const AuthWrapper(children: [AuthRoute()]));
      return;
    } else if (context.mounted) {
      context.navigateTo(
        PaymentWrapper(
          activationOption: option,
          children: [
            PaymentCreationRoute(
              pageTitle: t.vip.subscribing,
              purchasedProductWidget: VipPurchaseDescription(option: option),
              onSuccess: () => _onSuccess(context),
              onCancelled: () => context.navigateTo(const VipRoute()),
              amountRub: option.sum,
              payButtonText: t.vip.pay,
            ),
          ],
        ),
      );
    }
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
          onTap: cubit.state != null
              ? () => _goToPayment(context, cubit.state!)
              : null,
        ),
      ),
    );
  }
}
