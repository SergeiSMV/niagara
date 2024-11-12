import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cards/base_product_cart_widget.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';

/// Виджет для отображения товара в корзине.
class ProductInCart extends StatelessWidget {
  const ProductInCart({super.key, required this.product});

  /// Товар, отображаемый в карточке.
  final Product product;

  /// Возвращает количество товара в корзине.
  int _getCount(Product product, CartState state) {
    final int count = state.maybeWhen(
      loaded: (cart, _) => cart.countInStock(product),
      loading: (cart, _) => cart?.countInStock(product) ?? 0,
      orElse: () => 0,
    );

    return count;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartBloc>();

    // Считаем, что товар - списываемая вода, если установлен нужный
    // [ProductType] и цена равна нулю. Иначе кроме как на списание с баланса
    // такой товар в корзину попасть не может.
    final bool isWaterBalance = product.isWater && product.price == 0;

    // Тип события зависит от того, добавляем мы обычный товар или предоплатную
    // воду на списание с баланса.
    final CartEvent addEvent =
        CartEvent.addToCart(product: product, prepaidWater: isWaterBalance);
    CartEvent removeEvent({required bool all}) => CartEvent.removeFromCart(
          product: product,
          prepaidWater: isWaterBalance,
          all: all,
        );

    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) {
        final int oldCount = _getCount(product, previous);
        final int newCount = _getCount(product, current);

        return oldCount != newCount;
      },
      builder: (context, state) {
        final int countInStok = _getCount(product, state);
        final bool loading = context.read<CartBloc>().isPendingProduct(product);

        return BaseProductCartWidget(
          product: product,
          onAdd: () => bloc.add(addEvent),
          onRemove: () => bloc.add(removeEvent(all: false)),
          onRemoveAll: () => bloc.add(removeEvent(all: true)),
          count: countInStok,
          isAvailable: countInStok != 0,
          loading: loading,
        );
      },
    );
  }
}
