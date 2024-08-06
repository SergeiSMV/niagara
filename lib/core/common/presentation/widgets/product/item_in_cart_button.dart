import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';

enum ItemInCartButtonIcon {
  plus,
  minus;
}

class ItemInCartButton extends StatelessWidget {
  const ItemInCartButton({
    super.key,
    required this.product,
    required this.cartAction,
  });

  final Product product;
  final ItemInCartButtonIcon cartAction;

  void _onPlusPressed(BuildContext context) =>
      context.read<CartBloc>().add(CartEvent.addToCart(product: product));

  void _onMinusPressed(BuildContext context) =>
      context.read<CartBloc>().add(CartEvent.removeFromCart(product: product));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => (cartAction == ItemInCartButtonIcon.plus
          ? _onPlusPressed(context)
          : _onMinusPressed(context)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: AppBorders.kCircular4,
          color: context.colors.buttonColors.accent,
        ),
        child: Padding(
          padding: AppInsets.kAll4,
          child: (cartAction == ItemInCartButtonIcon.plus
                  ? Assets.icons.plus
                  : Assets.icons.minus)
              .svg(
            width: AppSizes.kIconSmall,
            height: AppSizes.kIconSmall,
            colorFilter: ColorFilter.mode(
              context.colors.textColors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
