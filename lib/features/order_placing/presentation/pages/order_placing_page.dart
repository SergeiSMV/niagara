import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/order_placing/presentation/widget/delivery_address_widget.dart';
import 'package:niagara_app/features/order_placing/presentation/widget/delivery_date_widget.dart';
import 'package:niagara_app/features/order_placing/presentation/widget/order_comment_widget.dart';

@RoutePage()
class OrderPlacingPage extends StatelessWidget {
  const OrderPlacingPage({super.key, required this.cart});

  /// Состояни корзины, которое будет использоваться при оформлении заказа.
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(),
          DeliveryAddressWidget(),
          DeliveryDateWidget(),
          OrderCommentWidget(),
        ],
      ),
    );
  }
}
