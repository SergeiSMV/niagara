import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';

// TODO(kvbykov): Тут можно улучишить UX (`loading` тоже даёт корзину)
class CartProductsIndicatorWidget extends StatelessWidget {
  const CartProductsIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) => state.maybeWhen(
        loaded: (cart, _) => cart.products.isNotEmpty
            ? Container(
                margin: AppInsets.kLeft22 + AppInsets.kTop2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.infoColors.green,
                ),
                child: Padding(
                  padding: AppInsets.kAll2,
                  child: Center(
                    child: Text(
                      cart.products.length.toString(),
                      style: context.textStyle.captionTypo.c2
                          .withColor(context.colors.mainColors.white),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}
