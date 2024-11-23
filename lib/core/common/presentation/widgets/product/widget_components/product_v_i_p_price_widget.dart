import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';

class ProductVIPPriceWidget extends StatelessWidget {
  const ProductVIPPriceWidget({
    super.key,
    required this.product,
  });

  final Product product;

  void _gotToVipPage(BuildContext context) => context.navigateTo(
        const LoyaltyProgramWrapper(children: [VipRoute()]),
      );

  int? _getVipPrice(Product product, CartState state) {
    final Cart? cart = state.maybeWhen(
      loaded: (cart, _) => cart,
      loading: (cart, _, __) => cart,
      orElse: () => null,
    );

    return cart?.vipPriceInStock(product);
  }

  int? _getPrice(Product product, CartState state) {
    final Cart? cart = state.maybeWhen(
      loaded: (cart, _) => cart,
      loading: (cart, _, __) => cart,
      orElse: () => null,
    );

    return cart?.priceInStock(product);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<CartBloc>();
    final int? vipPriceInStock = _getVipPrice(product, bloc.state);
    final int? priceInStock = _getPrice(product, bloc.state);

    /// Если ВИ-цена не приносит выгоды и при этом она вообще есть, убираем
    /// значок.
    if (vipPriceInStock == priceInStock && vipPriceInStock != null) {
      return const SizedBox.shrink();
    }

    // ВИП-цена отличается от изначально заданной из-за перерасчета в корзине и
    // при этом не равна 0.
    final bool hasVipDiscount = vipPriceInStock != null && vipPriceInStock != 0;

    return GestureDetector(
      onTap: () => _gotToVipPage(context),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.infoColors.green,
          borderRadius: AppBorders.kCircular8,
        ),
        child: Padding(
          padding: AppInsets.kAll8 + AppInsets.kLeft4,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${hasVipDiscount ? vipPriceInStock : product.priceVip} ${t.common.rub}'
                        .spaceSeparateNumbers(),
                    style: context.textStyle.headingTypo.h3.withColor(
                      context.colors.textColors.white,
                    ),
                  ),
                  AppBoxes.kHeight2,
                  Text(
                    t.catalog.withVIP,
                    style: context.textStyle.textTypo.tx4Medium.withColor(
                      context.colors.textColors.white,
                    ),
                  ),
                ],
              ),
              AppBoxes.kWidth4,
              Assets.icons.arrowRight.svg(
                width: AppSizes.kIconSmall,
                height: AppSizes.kIconSmall,
                colorFilter: ColorFilter.mode(
                  context.colors.textColors.white,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
