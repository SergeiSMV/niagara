import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:niagara_app/features/order_history/domain/models/user_order.dart';
import 'package:niagara_app/features/order_history/presentation/bloc/repeat_order_cubit/repeat_order_cubit.dart';

class RepeatOrderModalWidget extends StatelessWidget {
  const RepeatOrderModalWidget({
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
  /// Отображает снекбары с информацией о результате повторения заказа.
  void _stateListener(BuildContext context, RepeatOrderState state) =>
      state.mapOrNull(
        success: (_) {
          AppSnackBar.showInfo(
            outerContext,
            title: t.recentOrders.orderRepeated,
          );

          return getIt<CartBloc>().add(const CartEvent.getCart());
        },
        error: (_) {
          return AppSnackBar.showError(
            outerContext,
            title: t.recentOrders.repeatOrderError,
          );
        },
      );

  /// Повторяемый заказ.
  final UserOrder order;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RepeatOrderCubit>(),
      child: BlocConsumer<RepeatOrderCubit, RepeatOrderState>(
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
    final cubit = context.read<RepeatOrderCubit>();

    final bool isLoading = cubit.state == const RepeatOrderState.loading();

    void closeModal() => context.maybePop();
    void repeatOrder() => cubit.repeatOrder(order.id);

    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.recentOrders.repeatOrderModalTitle,
            style: context.textStyle.headingTypo.h3,
            textAlign: TextAlign.center,
          ),
          AppBoxes.kHeight24,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: AppTextButton.secondary(
                  onTap: closeModal,
                  text: t.common.cancel,
                ),
              ),
              AppBoxes.kWidth12,
              Expanded(
                child: AppTextButton.primary(
                  onTap: isLoading ? null : repeatOrder,
                  text: isLoading ? null : t.recentOrders.add,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
