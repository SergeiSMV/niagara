import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cards/base_product_widget.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/widgets/unauthorized_address_widget.dart';

/// Виджет карточки товара.
///
/// Отображает информацию о товаре и позволяет увеличивать / уменьшать его
/// количество в корзине.
///
/// Использует [CartBloc] и влияет на состояние корзины.
class ProductWidget extends StatelessWidget {
  const ProductWidget({
    required this.product,
    this.isWaterBalance = false,
    super.key,
  });

  /// Товар, отображаемый в карточке.
  final Product product;

  /// Индикатор того, что данный виджет отображает предоплатную воду на балансе.
  ///
  /// Если `true`, то добавление товара в корзину происходит через механизм
  /// предоплаты воды. В таком случае цена товара будет нулевой.
  final bool isWaterBalance;

  /// Возвращает количество товара в корзине.
  int _getCount(Product product, CartState state) {
    final Cart? cart = state.maybeWhen(
      loaded: (cart, _) => cart,
      loading: (cart, _) => cart,
      orElse: () => null,
    );

    return cart?.countInStock(product, ignoreComplect: !isWaterBalance) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartBloc>();

    // Тип события зависит от того, добавляем мы обычный товар или предоплатную
    // воду на списание с баланса.
    final CartEvent addEvent =
        CartEvent.addToCart(product: product, prepaidWater: isWaterBalance);
    final CartEvent removeEvent = CartEvent.removeFromCart(
      product: product,
      prepaidWater: isWaterBalance,
    );

    void showAuthModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        backgroundColor: context.colors.mainColors.white,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (ctx) {
          return const AuthorizationWidget(modal: true);
        },
      );
    }

    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) {
        final int oldCount = _getCount(product, previous);
        final int newCount = _getCount(product, current);

        return oldCount != newCount;
      },
      builder: (context, state) {
        void onAdd() {
          if (bloc.unauthrorized) {
            showAuthModal(context);
            return;
          }
          bloc.add(addEvent);
        }

        void onRemove() {
          if (bloc.unauthrorized) {
            showAuthModal(context);
            return;
          }
          bloc.add(removeEvent);
        }

        return BaseProductWidget(
          product: product,
          count: _getCount(product, state),
          onAdd: onAdd,
          onRemove: onRemove,
          isWaterBalance: isWaterBalance,
        );
      },
    );
  }
}
