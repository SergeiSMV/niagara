import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

class ProductImagesWidget extends HookWidget {
  const ProductImagesWidget({
    super.key,
    required this.product,
  });

  final Product product;

  bool get _isScrollable => product.additionalImages.isNotEmpty;
  List<String> get _images => [product.imageUrl, ...product.additionalImages];

  @override
  Widget build(BuildContext context) {
    final active = useState(0);
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _images.length,
          itemBuilder: (_, index, __) => Container(
            width: double.infinity,
            padding: AppInsets.kAll8,
            child: ClipRRect(
              borderRadius: AppBorders.kCircular16 + AppBorders.kCircular2,
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          options: CarouselOptions(
            aspectRatio: 1,
            viewportFraction: 1,
            enableInfiniteScroll: _isScrollable,
            onPageChanged: (index, _) => active.value = index,
          ),
        ),
        AppBoxes.kHeight8,
        if (_isScrollable)
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
