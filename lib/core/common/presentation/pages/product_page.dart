import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_favorite_button.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
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
      body: Column(
        children: [
          AppBoxes.kHeight4,
          Flexible(
            child: Padding(
              padding: AppInsets.kAll8,
              child: Stack(
                children: [
                  ProductImagesWidget(product: product),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductImagesWidget extends HookWidget {
  const ProductImagesWidget({
    super.key,
    required this.product,
  });

  final Product product;

  bool get _isScrollable => product.additionalImages.isNotEmpty;
  List<String> get _images =>
      [product.imageUrl, product.imageUrl, ...product.additionalImages];

  @override
  Widget build(BuildContext context) {
    final active = useState(0);
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _images.length,
          itemBuilder: (_, index, __) => CachedNetworkImage(
            imageUrl: product.imageUrl,
            fit: BoxFit.cover,
          ),
          options: CarouselOptions(
            viewportFraction: 1,
            enableInfiniteScroll: _isScrollable,
            onPageChanged: (index, _) => active.value = index,
          ),
        ),
        AppBoxes.kHeight8,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _images.map((url) {
            final index = _images.indexOf(url);
            return AnimatedContainer(
              duration: Durations.medium1,
              width: active.value == index
                  ? AppSizes.kGeneral32
                  : AppSizes.kGeneral6,
              height: AppSizes.kGeneral6,
              margin: AppInsets.kHorizontal4,
              decoration: BoxDecoration(
                borderRadius: AppBorders.kCircular4,
                color: active.value == index
                    ? context.colors.mainColors.primary
                    : context.colors.mainColors.light,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
