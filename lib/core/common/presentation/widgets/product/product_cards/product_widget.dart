import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../features/cart/cart/domain/models/cart.dart';
import '../../../../../../features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import '../../../../domain/models/product.dart';
import 'base_product_widget.dart';

/// Виджет карточки товара.
///
/// Отображает информацию о товаре и позволяет увеличивать / уменьшать его
/// количество в корзине.
///
/// Использует [CartBloc] и влияет на состояние корзины.
class ProductWidget extends StatelessWidget {
  const ProductWidget({
    required this.product,
    this.isOnWaterBalancePage = false,
    super.key,
  });

  /// Товар, отображаемый в карточке.
  final Product product;

  /// Индикатор того, что данный виджет отображает предоплатную воду на балансе.
  ///
  /// Если `true`, то добавление товара в корзину происходит через механизм
  /// предоплаты воды. В таком случае цена товара будет нулевой.
  final bool isOnWaterBalancePage;

  /// Возвращает количество товара в корзине.
  int _getCount(Product product, CartState state) {
    final Cart? cart = state.maybeWhen(
      loaded: (cart, _) => cart,
      loading: (cart, _, __) => cart,
      orElse: () => null,
    );

    return cart?.countInStock(product, ignoreComplect: !isOnWaterBalancePage) ??
        0;
  }

  int? _getPrice(Product product, CartState state) {
    final Cart? cart = state.maybeWhen(
      loaded: (cart, _) => cart,
      loading: (cart, _, __) => cart,
      orElse: () => null,
    );

    return cart?.priceInStock(product, ignoreComplect: !isOnWaterBalancePage);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<CartBloc>();
    final bool outOfStock = bloc.isOutOfStock(product);
    final bool loading = bloc.isPendingProduct(product);

    // Тип события зависит от того, добавляем мы обычный товар или предоплатную
    // воду на списание с баланса.
    final CartEvent addEvent = CartEvent.addToCart(
      product: product,
      prepaidWater: isOnWaterBalancePage,
    );
    final CartEvent removeEvent = CartEvent.removeFromCart(
      product: product,
      prepaidWater: isOnWaterBalancePage,
    );

    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) {
        final int oldCount = _getCount(product, previous);
        final int newCount = _getCount(product, current);
        final int? oldCartPrice = _getPrice(product, previous);
        final int? newCartPrice = _getPrice(product, current);

        return oldCount != newCount || oldCartPrice != newCartPrice;
      },
      builder: (context, state) => BaseProductWidget(
        product: product,
        count: _getCount(product, state),
        price: _getPrice(product, state),
        onAdd: () => bloc.add(addEvent),
        onRemove: () => bloc.add(removeEvent),
        isOnWaterBalancePage: isOnWaterBalancePage,
        authorized: !bloc.unauthrorized,
        outOfStock: outOfStock,
        loading: loading,
      ),
    );
  }
}
