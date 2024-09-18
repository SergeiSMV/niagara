import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/bloc/prepaid_water_buying_cubit.dart/water_balance_buying_cubit.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_groups/recommend_products_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_add_to_cart_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_coins_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_description_with_properties_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_favorite_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_images_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_tag_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_title_with_prices_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/features/prepaid_water/presentation/widgets/buy_prepaid_water_button.dart';

@RoutePage()
class ProductPage extends StatelessWidget {
  const ProductPage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderWaterAmountCubit(),
      child: Scaffold(
        backgroundColor: context.colors.mainColors.bgCard,
        body: CustomScrollView(
          slivers: [
            SliverAppBarWidget(
              automaticallyImplyTitle: false,
              actions: [
                ProductFavoriteButton(
                  product: product,
                  size: AppSizes.kIconLarge,
                ),
                AppBoxes.kWidth12,
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  AppBoxes.kHeight4,
                  Stack(
                    children: [
                      ProductImagesWidget(product: product),
                      Positioned(
                        top: AppSizes.kGeneral12,
                        left: AppSizes.kGeneral8,
                        right: AppSizes.kGeneral8,
                        child: Padding(
                          padding: AppInsets.kAll8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ProductTagWidget(
                                label: product.label,
                                labelColor: product.labelColor,
                                isBigSize: true,
                              ),
                              ProductCoinsWidget(
                                count: product.bonus,
                                size: AppSizes.kIconLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppBoxes.kHeight12,
                  ProductTitleWithPricesWidget(product: product),
                  AppBoxes.kHeight12,
                  ProductDescriptionWithPropertiesWidget(product: product),
                  AppBoxes.kHeight12,
                  RecommendProductsWidget(product: product),
                  AppBoxes.kHeight24,
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: product.isWater
            ? BuyPrepaidWaterButton(product: product)
            : ProductAddToCartButton(product: product),
      ),
    );
  }
}
