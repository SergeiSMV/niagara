import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../core/common/presentation/widgets/app_bar.dart';
import '../../../../core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import '../../../../core/dependencies/di.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../cart/cart/domain/models/cart.dart';
import '../../../cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import '../../../cart/cart/presentation/widgets/cart_data/cart_data_prices_widget.dart';
import '../../../order_history/presentation/bloc/orders_bloc/orders_bloc.dart';
import '../../../prepaid_water/presentation/bloc/balance_cubit/water_balance_cubit.dart';
import '../bloc/create_order/create_order_cubit.dart';
import '../widget/create_order_button.dart';
import '../widget/delivery_address_widget.dart';
import '../widget/delivery_date_widget.dart';
import '../widget/order_comment_widget.dart';
import '../widget/order_recepient_widget.dart';
import '../widget/payment_methods_widget.dart';

/// Страница оформления заказа.
///
/// Позволяет увидеть информацию о заказе, выбрать дату, метод оплаты, оставить
/// комментарий и оформить заказ.
@RoutePage()
class OrderPlacingPage extends StatelessWidget {
  const OrderPlacingPage({required this.cart, super.key});

  /// Состояни корзины, которое будет использоваться при оформлении заказа.
  final Cart cart;

  /// В случае успешного оформления заказа обновляет список заказов и состояние
  /// корзины.
  Future<void> _onSuccess() async {
    // Обновляем список заказов и состояние корзины
    getIt<OrdersBloc>().add(const OrdersEvent.loading(isForceUpdate: true));
    getIt<OrdersBloc>().add(const OrdersEvent.loadAll());
    getIt<CartBloc>().add(const CartEvent.cancelAllTare());
    getIt<CartBloc>().add(const CartEvent.getCart(clearParams: true));

    if (cart.containsComplect) {
      // Если списывали воду с баланса, нужно обновить его.
      await getIt<WaterBalanceCubit>().getBottles();
    }
  }

  /// Обработчик состояния оформления заказа.
  ///
  /// В случае ошибки отображает сообщение об ошибке.
  ///
  /// В случае успешного оформления заказа перенаправляет на страницу результата
  void _orderStateListener(BuildContext context, OrderCreationState state) =>
      state.mapOrNull(
        // TODO: Добавить отображение номера телефона при ошибке "нет интернета"
        // https://digitalburo.youtrack.cloud/issue/NIAGARA-341/Dobavit-nomer-telefona-v-plashku-Net-interneta
        error: (err) => AppSnackBar.showError(
          context,
          title: err.type.toErrorTitle,
        ),
        paymentRequired: (state) async => context.replaceRoute(
          // Если нужно оплатить заказ, перенаправляем на страницу оплаты.
          PaymentInstructionsRoute(
            tokenizationData: state.data,
            onSuccess: _onSuccess,
            onCancelled: () {},
          ),
        ),
        // Если созданный заказ не подразумевает онлайн оплаты, перенаправляем
        // на страницу результата.
        created: (_) async {
          context.replaceRoute(OrderResultRoute(isSuccessful: true));
          return _onSuccess();
        },
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocListener<OrderCreationCubit, OrderCreationState>(
          listener: _orderStateListener,
          child: CustomScrollView(
            slivers: [
              const SliverAppBarWidget(),
              SliverList(
                delegate: SliverChildListDelegate([
                  AppBoxes.kHeight8,
                  const OrderRecepientWidget(),
                  const DeliveryAddressWidget(),
                  const DeliveryDateWidget(),
                  if (cart.cartData.totalPrice != 0)
                    const OrderPaymentMethodWidget(),
                  const OrderCommentWidget(),
                  CartDataPricesWidget(cart: cart),
                  AppBoxes.kHeight16,
                ]),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CreateOrderButton(cart: cart),
      );
}
