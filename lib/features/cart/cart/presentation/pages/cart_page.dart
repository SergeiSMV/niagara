import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_bonuses_widget.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_data/cart_data_prices_widget.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_pay_button.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_products_widget.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_promocode_widget.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_recommends_widget.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/cart_unavailable_products_widget.dart';
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
          loading: _Loading.new,
          loaded: _Content.new,
          orElse: () => ErrorRefreshWidget(onRefresh: () => onRefresh(context)),
        ),
      );
}

class _Loading extends StatelessWidget {
  const _Loading(
    this.cart,
    this.recommends,
  );

  final Cart? cart;
  final List<Product>? recommends;

  bool get hasData => cart != null && recommends != null;

  @override
  Widget build(BuildContext context) =>
      hasData ? _Content(cart!, recommends!) : const AppCenterLoader();
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
                  CartProductsWidget(cart: cart),
                  AppBoxes.kHeight16,
                  CartUnavailableProductsWidget(
                    unavailableProducts: cart.unavailableProducts,
                  ),
                  AppBoxes.kHeight16,
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
        bottomNavigationBar: PayButton(
          cart: cart,
          text: t.cart.payable,
          redirectRoute: OrderPlacingWrapper(
            children: [
              OrderPlacingRoute(cart: cart),
            ],
          ),
        ),
      );
}
