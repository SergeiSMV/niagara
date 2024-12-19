import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/domain/models/user_order.dart';
import 'package:niagara_app/features/order_history/presentation/bloc/cancel_order_cubit/cancel_order_cubit.dart';
import 'package:niagara_app/features/order_history/presentation/bloc/orders_bloc/orders_bloc.dart';

class CancelOrderModalWidget extends StatelessWidget {
  const CancelOrderModalWidget({
    super.key,
    required this.order,
    required this.outerContext,
  });

  /// [BuildContext] внешнего виджета.
  ///
  /// Нужен для безопасного отображения снекбаров.
  final BuildContext outerContext;

  /// Обработчик изменения состояния.
  ///
  /// Отображает снекбары с информацией о результате отмены заказа.
  void _stateListener(BuildContext context, CancelOrderState state) =>
      state.mapOrNull(
        success: (_) {
          AppSnackBar.showInfo(
            outerContext,
            title: t.recentOrders.orderCanceled,
          );

          context.maybePop();

          return getIt<OrdersBloc>().add(const OrdersEvent.loadAll());
        },
        error: (_) {
          return AppSnackBar.showError(
            outerContext,
            title: t.recentOrders.orderCancelError,
          );
        },
      );

  /// Отменяемый заказ.
  final UserOrder order;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CancelOrderCubit>(),
      child: BlocConsumer<CancelOrderCubit, CancelOrderState>(
        listener: _stateListener,
        builder: (context, state) => _Content(order: order),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.order,
  });

  final UserOrder order;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CancelOrderCubit>();

    final bool isLoading = cubit.state == const CancelOrderState.loading();

    void closeModal() => context.maybePop();
    void cancelOrder() => cubit.cancelOrder(order.id);

    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.attention3D.image(
            height: AppSizes.kImageSize120,
            width: AppSizes.kImageSize120,
          ),
          AppBoxes.kHeight24,
          Text(
            t.recentOrders.confirmOrderCancel,
            style: context.textStyle.headingTypo.h3,
            textAlign: TextAlign.center,
          ),
          AppBoxes.kHeight24,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: AppTextButton.secondary(
                  onTap: isLoading ? null : cancelOrder,
                  text: isLoading ? null : t.common.cancel,
                ),
              ),
              AppBoxes.kWidth6,
              Expanded(
                child: AppTextButton.primary(
                  onTap: closeModal,
                  text: t.recentOrders.notCancel,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
