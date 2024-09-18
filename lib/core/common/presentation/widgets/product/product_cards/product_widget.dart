import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cards/base_product_widget.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';

/// Виджет карточки товара.
///
/// Отображает информацию о товаре и позволяет увеличивать / уменьшать его
/// количество в корзине.
///
/// Использует [CartBloc] и влияет на состояние корзины.
class ProductWidget extends StatelessWidget {
  const ProductWidget({
    required this.product,
    this.redirectRoute,
    this.isWaterBalance = false,
    super.key,
  });

  /// Товар, отображаемый в карточке.
  final Product product;

  /// Страница, на которую должен быть перенаправлен пользователь при нажатии.
  final PageRouteInfo? redirectRoute;

  /// Индикатор того, что данный виджет отображает предоплатную воду на балансе.
  ///
  /// Если `true`, то добавление товара в корзину происходит через механизм
  /// предоплаты воды. В таком случае цена товара будет нулевой.
  final bool isWaterBalance;

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

    // Тип события зависит от того, добавляем мы обычный товар или предоплатную
    // воду на списание с баланса.
    final CartEvent addEvent = isWaterBalance
        ? CartEvent.addPrepaidWaterToCart(product: product)
        : CartEvent.addToCart(product: product);
    final CartEvent removeEvent = isWaterBalance
        ? CartEvent.removePrepaidWaterFromCart(product: product)
        : CartEvent.removeFromCart(product: product);

    void onAdd() => bloc.add(addEvent);
    void onRemove() => bloc.add(removeEvent);

    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) {
        final int oldCount = _getCount(product, previous);
        final int newCount = _getCount(product, current);

        return oldCount != newCount;
      },
      builder: (context, state) {
        return BaseProductWidget(
          product: product,
          count: _getCount(product, state),
          onAdd: onAdd,
          onRemove: onRemove,
          redirectRoute: redirectRoute,
          isWaterBalance: isWaterBalance,
        );
      },
    );
  }
}
