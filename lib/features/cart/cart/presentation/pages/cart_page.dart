import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/domain/models/product.dart';
import '../../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../../core/common/presentation/widgets/errors/error_refresh_widget.dart';
import '../../../../../core/common/presentation/widgets/loaders/app_center_loader.dart';
import '../../../../../core/common/presentation/widgets/unauthorized_widget.dart';
import '../../../../../core/dependencies/di.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import '../../../../locations/addresses/presentation/addresses/bloc/addresses_bloc.dart';
import '../../../../order_placing/presentation/widget/delivery_address_widget.dart';
import '../../domain/models/cart.dart';
import '../bloc/cart_bloc/cart_bloc.dart';
import '../widgets/cart_bonuses_widget.dart';
import '../widgets/cart_data/cart_data_prices_widget.dart';
import '../widgets/cart_pay_button.dart';
import '../widgets/cart_products_widget.dart';
import '../widgets/cart_promocode_widget.dart';
import '../widgets/cart_recommends_widget.dart';
import '../widgets/cart_unavailable_products_widget.dart';
import '../widgets/empty_cart_widget.dart';
import '../widgets/free_delivery_info_widget.dart';
import '../widgets/tare_inspection_widget.dart';
import '../widgets/tare_return/tare_return_widget.dart';

@RoutePage()
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (_, state) => state.when(
            empty: EmptyCartWidget.new,
            loading: _Content.new,
            loaded: _Content.new,
            error: _Error.new,
            unauthorized: () => const AuthorizationWidget(),
          ),
        ),
      );
}

class _Error extends StatelessWidget {
  const _Error({
    super.key,
  });

  void onRefresh(BuildContext context) =>
      context.read<CartBloc>().add(const CartEvent.getCart());

  @override
  Widget build(BuildContext context) =>
      Center(child: ErrorRefreshWidget(onRefresh: () => onRefresh(context)));
}

class _Content extends StatelessWidget {
  const _Content(
    this.cart,
    this.recommends, [
    this.test,
  ]);

  final Cart? cart;
  final List<Product>? recommends;
  final test;

  bool get hasData => cart != null && recommends != null;

  /// Обновляет состояние корзины при изменении адреса.
  void _onAddressChanged(BuildContext context, AddressesState state) {
    final String? locationId = state.defaultLocation?.locationId;
    if (locationId != cart?.locationId) {
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
                  const TareReturnWidget(),
                  const TareInspectionWidget(),
                  AppBoxes.kHeight16,
                  CartUnavailableProductsWidget(
                    unavailableProducts: cart!.unavailableProducts,
                  ),
                  AppBoxes.kHeight16,
                  CartRecommendsWidget(products: recommends!),
                  AppBoxes.kHeight16,
                  CartPromocodeWidget(cart: cart!),
                  AppBoxes.kHeight16,
                  CartBonusesWidget(cart: cart!),
                  AppBoxes.kHeight16,
                  CartDataPricesWidget(cart: cart!),
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
