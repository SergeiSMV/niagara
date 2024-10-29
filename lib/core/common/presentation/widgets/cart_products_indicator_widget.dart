import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';

class CartProductsIndicatorWidget extends StatelessWidget {
  const CartProductsIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final int count = state.maybeWhen(
          loaded: (cart, _) => cart.products.length,
          loading: (cart, _) => cart?.products.length ?? 0,
          orElse: () => 0,
        );

        if (count == 0) return const SizedBox.shrink();

        return Container(
          margin: AppInsets.kLeft22 + AppInsets.kTop2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colors.infoColors.green,
          ),
          child: Padding(
            padding: AppInsets.kAll2,
            child: Center(
              child: Text(
                count.toString(),
                style: context.textStyle.captionTypo.c2
                    .withColor(context.colors.mainColors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
