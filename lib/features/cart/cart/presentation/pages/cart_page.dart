import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/dependencies/di.dart';
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
import 'package:niagara_app/features/cart/cart/presentation/widgets/free_delivery_info_widget.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/return_tares_selection_widget.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/bloc/addresses_bloc.dart';
import 'package:niagara_app/features/order_placing/presentation/widget/delivery_address_widget.dart';

@RoutePage()
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void onRefresh(BuildContext context) =>
      context.read<CartBloc>().add(const CartEvent.getCart());

  @override
  Widget build(BuildContext context) => BlocBuilder<CartBloc, CartState>(
        builder: (_, state) => state.when(
          empty: EmptyCartWidget.new,
          loading: _Content.new,
          loaded: _Content.new,
          error: () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ErrorRefreshWidget(onRefresh: () => onRefresh(context))],
          ),
        ),
      );
}

class _Content extends StatelessWidget {
  const _Content(
    this.cart,
    this.recommends,
  );

  final Cart? cart;
  final List<Product>? recommends;

  bool get hasData => cart != null && recommends != null;

  void _onAddressChanged(BuildContext context, AddressesState state) {
    print('[AddressesBloc listener] fired listener');
    final String? locationId = state.defaultLocation?.locationId;
    print(
        '[AddressesBloc listener] current locationId: $locationId, cart: ${cart?.locationId}');
    if (locationId != null && locationId != cart?.locationId) {
      context.read<CartBloc>().add(const CartEvent.getCart());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!hasData) return const AppCenterLoader();

    return Scaffold(
      body: BlocListener<AddressesBloc, AddressesState>(
        bloc: getIt<AddressesBloc>(),
        listener: _onAddressChanged,
        child: SafeArea(
          child: Padding(
            padding: AppInsets.kTop64,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const DeliveryAddressWidget(editable: true),
                  FreeDeliveryInfoWidget(cart: cart!),
                  AppBoxes.kHeight16,
                  CartProductListWidget(cart: cart!),
                  const ReturnTaresSelectionWidget(),
                  AppBoxes.kHeight16,
                  CartUnavailableProductsWidget(
                    unavailableProducts: cart!.unavailableProducts,
                  ),
                  AppBoxes.kHeight16,
                  CartPromocodeWidget(cart: cart!),
                  AppBoxes.kHeight16,
                  CartBonusesWidget(cart: cart!),
                  AppBoxes.kHeight16,
                  CartDataPricesWidget(cart: cart!),
                  AppBoxes.kHeight16,
                  CartRecommendsWidget(products: recommends!),
                  AppBoxes.kHeight16,
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: PayButton(
        cart: cart!,
        text: t.cart.payable,
        redirectRoute: OrderPlacingWrapper(
          allowedPaymentMethods: cart!.paymentMethods,
          children: [
            OrderPlacingRoute(cart: cart!),
          ],
        ),
      ),
    );
  }
}
