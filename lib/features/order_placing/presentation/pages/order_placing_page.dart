import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_data/cart_data_prices_widget.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_pay_button.dart';
import 'package:niagara_app/features/order_placing/presentation/widget/delivery_address_widget.dart';
import 'package:niagara_app/features/order_placing/presentation/widget/delivery_date_widget.dart';
import 'package:niagara_app/features/order_placing/presentation/widget/order_comment_widget.dart';
import 'package:niagara_app/features/order_placing/presentation/widget/order_recepient_widget.dart';
import 'package:niagara_app/features/order_placing/presentation/widget/payment_methods_widget.dart';

@RoutePage()
class OrderPlacingPage extends StatelessWidget {
  const OrderPlacingPage({super.key, required this.cart});

  /// Состояни корзины, которое будет использоваться при оформлении заказа.
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
      bottomNavigationBar: PayButton(
        cart: cart,
        text: t.orderPlacing.pay,
        // TODO: change that
        redirectRoute: OrderResultRoute(isSuccessful: false),
      ),
    );
  }
}
