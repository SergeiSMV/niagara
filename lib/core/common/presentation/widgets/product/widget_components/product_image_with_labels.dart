import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/bonuses_for_purchase_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_label_and_favorite.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

class ProductImageWithLabels extends HookWidget {
  const ProductImageWithLabels({
    required this.product,
    required this.isOnWaterBalancePage,
  });

  final Product product;
  final bool isOnWaterBalancePage;

  /// Список изображений. (Убираем дубликаты)
  List<String> get _images => product.additionalImages.toSet().toList();

  /// Возвращает true, если количество изображений больше одного.
  bool get _isScrollable => _images.length > 1;

  @override
  Widget build(BuildContext context) {
    final active = useState(0);

    return Stack(
      fit: StackFit.expand,
      children: [
        CarouselSlider.builder(
          itemCount: _images.length,
          itemBuilder: (_, index, __) => ClipRRect(
            borderRadius: AppBorders.kCircular6,
            child: ExtendedImage.network(
              _images[index],
              fit: BoxFit.cover,
              loadStateChanged: (state) =>
                  state.extendedImageLoadState == LoadState.loading
                      ? const AppCenterLoader()
                      : null,
            ),
          ),
          options: CarouselOptions(
            enlargeCenterPage: true,
            viewportFraction: 1,
            enableInfiniteScroll: _isScrollable,
            scrollPhysics: _isScrollable
                ? const PageScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            onPageChanged: (index, _) => active.value = index,
          ),
        ),
        ProductLabelAndFavorite(
          product: product,
          isWaterBalance: isOnWaterBalancePage,
        ),
        if (product.bonus > 0) BonusesForPurchaseWidget(product: product),
        if (_isScrollable)
          Positioned(
            bottom: AppSizes.kGeneral6,
            right: AppSizes.kGeneral6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _images.map((url) {
                final index = _images.indexOf(url);
                return AnimatedContainer(
                  duration: Durations.medium1,
                  width: active.value == index
                      ? AppSizes.kGeneral12
                      : AppSizes.kGeneral6,
                  height: AppSizes.kGeneral6,
                  margin: AppInsets.kHorizontal2,
                  decoration: BoxDecoration(
                    borderRadius: AppBorders.kCircular4,
                    color: active.value == index
                        ? context.colors.mainColors.primary
                        : context.colors.mainColors.light,
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
