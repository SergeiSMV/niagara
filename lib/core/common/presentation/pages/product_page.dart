import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_coins_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_description_with_properties_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_favorite_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_images_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_tag_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_title_with_prices_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_to_card_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/recommend_products_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

@RoutePage()
class ProductPage extends StatelessWidget {
  const ProductPage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.mainColors.bgCard,
      appBar: AppBarWidget(
        automaticallyImplyTitle: false,
        actions: [
          ProductFavoriteButton(
            product: product,
            size: AppSizes.kIconLarge,
          ),
          AppBoxes.kWidth12,
        ],
      ),
      body: SingleChildScrollView(
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
      bottomNavigationBar: const ProductToCardButton(),
    );
  }
}
