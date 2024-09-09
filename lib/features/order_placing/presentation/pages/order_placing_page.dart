import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_data/cart_data_prices_widget.dart';
import 'package:niagara_app/features/order_placing/presentation/bloc/create_order/create_order_cubit.dart';
import 'package:niagara_app/features/order_placing/presentation/widget/create_order_button.dart';
import 'package:niagara_app/features/order_placing/presentation/widget/delivery_address_widget.dart';
import 'package:niagara_app/features/order_placing/presentation/widget/delivery_date_widget.dart';
import 'package:niagara_app/features/order_placing/presentation/widget/order_comment_widget.dart';
import 'package:niagara_app/features/order_placing/presentation/widget/order_recepient_widget.dart';
import 'package:niagara_app/features/order_placing/presentation/widget/payment_methods_widget.dart';

/// Страница оформления заказа.
///
/// Позволяет увидеть информацию о заказе, выбрать дату, метод оплаты, оставить
/// комментарий и оформить заказ.
@RoutePage()
class OrderPlacingPage extends StatelessWidget {
  const OrderPlacingPage({super.key, required this.cart});

  /// Состояни корзины, которое будет использоваться при оформлении заказа.
  final Cart cart;

  /// В случае успешного оформления заказа перенаправляет на страницу результата
  ///
  /// Также запрашивает обновление состояния корзины.
  void _onSuccess(BuildContext context) {
    context.replaceRoute(OrderResultRoute(isSuccessful: true));
    context.read<CartBloc>().add(const CartEvent.getCart());
  }

  /// Обработчик состояния оформления заказа.
  ///
  /// В случае ошибки отображает сообщение об ошибке.
  ///
  /// В случае успешного оформления заказа перенаправляет на страницу результата.
  void _orderStateListener(BuildContext context, OrderCreationState state) =>
      state.mapOrNull(
        // TODO: Добавить отображение номера телефона при ошибке "нет интернета"
        // https://digitalburo.youtrack.cloud/issue/NIAGARA-341/Dobavit-nomer-telefona-v-plashku-Net-interneta
        error: (err) => AppSnackBar.showErrorShackBar(
          context,
          title: err.type.toErrorTitle,
        ),
        paymentRequired: (state) => context.pushRoute(
          // Если нужно оплатить заказ, перенаправляем на страницу оплаты.
          PaymentRoute(
            tokenizationData: state.data,
            onSuccess: () => _onSuccess(context),
            onCancelled: () => context.replaceRoute(
              OrderResultRoute(isSuccessful: false),
            ),
          ),
        ),
        // Если созданный заказ не подразумевает онлайн оплаты, перенаправляем
        // на страницу результата.
        created: (_) => _onSuccess(context),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: context.read<OrderCreationCubit>(),
        listener: _orderStateListener,
        child: CustomScrollView(
          slivers: [
            const SliverAppBarWidget(),
            SliverList(
              delegate: SliverChildListDelegate([
                const OrderRecepientWidget(),
                DeliveryAddressWidget(address: cart.locationName),
                const DeliveryDateWidget(),
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
}
