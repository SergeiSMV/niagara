import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cart_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_bonuses_widget.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_data/cart_data_prices_widget.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_pay_button.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_promocode_widget.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_recommends_widget.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/empty_cart_widget.dart';

@RoutePage()
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void onRefresh(BuildContext context) =>
      context.read<CartBloc>().add(const CartEvent.getCart());

  @override
  Widget build(BuildContext context) => BlocBuilder<CartBloc, CartState>(
        builder: (_, state) => state.maybeWhen(
          empty: EmptyCartWidget.new,
          loaded: _Content.new,
          orElse: () => ErrorRefreshWidget(onRefresh: () => onRefresh(context)),
        ),
      );
}

class _Content extends StatelessWidget {
  const _Content(
    this.cart,
    this.recommends,
  );

  final Cart cart;
  final List<Product> recommends;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: AppInsets.kTop64,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: AppInsets.kHorizontal16,
                    child: Column(
                      children: cart.products
                          .map(
                            (product) => Padding(
                              padding: AppInsets.kVertical4,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: context.colors.mainColors.bgCard,
                                  borderRadius: AppBorders.kCircular12,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox.square(
                                      dimension: 100,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  CartPromocodeWidget(cart: cart),
                  AppBoxes.kHeight16,
                  CartBonusesWidget(cart: cart),
                  AppBoxes.kHeight16,
                  CartDataPricesWidget(cart: cart),
                  AppBoxes.kHeight16,
                  CartRecommendsWidget(products: recommends),
                  AppBoxes.kHeight16,
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CartPayButton(cart: cart),
      );
}
