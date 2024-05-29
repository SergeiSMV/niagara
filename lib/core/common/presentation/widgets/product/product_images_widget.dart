import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class ProductImagesWidget extends HookWidget {
  const ProductImagesWidget({
    super.key,
    required this.product,
  });

  final Product product;

  bool get _isScrollable => product.additionalImages.isNotEmpty;
  List<String> get _images => [product.imageUrl, ...product.additionalImages];

  Future<void> _showFullImagesDialog(
    BuildContext context, {
    required List<String> images,
    required int index,
  }) async =>
      showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        backgroundColor: context.colors.mainColors.white,
        barrierColor: context.colors.mainColors.white,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (ctx) => SafeArea(
          child: Scaffold(
            appBar: AppBarWidget(
              automaticallyImplyLeading: false,
              automaticallyImplyTitle: false,
              actions: [
                InkWell(
                  onTap: () => ctx.maybePop(),
                  child: Container(
                    width: AppSizes.kIconLarge,
                    height: AppSizes.kIconLarge,
                    padding: AppInsets.kHorizontal2,
                    child: Assets.icons.close.svg(
                      colorFilter: ColorFilter.mode(
                        context.colors.textColors.main,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                AppBoxes.kWidth16,
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: _ImagesCarouselWidget(
                    images: images,
                    product: product,
                    isScrollable: false,
                    active: ValueNotifier(index),
                  ),
                ),
                if (_isScrollable)
                  Padding(
                    padding: AppInsets.kVertical32,
                    child: _PaginationImagesWidget(
                      images: _images,
                      active: ValueNotifier(index),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final active = useState(0);
    return Column(
      children: [
        _ImagesCarouselWidget(
          images: _images,
          product: product,
          isScrollable: _isScrollable,
          active: active,
          onTap: (index) => _showFullImagesDialog(
            context,
            images: _images,
            index: index,
          ),
        ),
        AppBoxes.kHeight8,
        if (_isScrollable)
          _PaginationImagesWidget(
            images: _images,
            active: active,
          ),
      ],
    );
  }
}

class _PaginationImagesWidget extends StatelessWidget {
  const _PaginationImagesWidget({
    required List<String> images,
    required this.active,
  }) : _images = images;

  final List<String> _images;
  final ValueNotifier<int> active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _images.map((url) {
        final index = _images.indexOf(url);
        return AnimatedContainer(
          duration: Durations.medium1,
          width:
              active.value == index ? AppSizes.kGeneral32 : AppSizes.kGeneral6,
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
    );
  }
}

class _ImagesCarouselWidget extends StatelessWidget {
  const _ImagesCarouselWidget({
    required List<String> images,
    required this.product,
    required bool isScrollable,
    required this.active,
    this.onTap,
  })  : _images = images,
        _isScrollable = isScrollable;

  final List<String> _images;
  final Product product;
  final bool _isScrollable;
  final ValueNotifier<int> active;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: _images.length,
      itemBuilder: (_, index, __) => InkWell(
        onTap: onTap != null ? () => onTap!(index) : null,
        child: Container(
          width: double.infinity,
          padding: AppInsets.kAll8,
          child: ClipRRect(
            borderRadius: AppBorders.kCircular16 + AppBorders.kCircular2,
            child: CachedNetworkImage(
              imageUrl: product.imageUrl,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
      options: CarouselOptions(
        aspectRatio: 1,
        viewportFraction: 1,
        enableInfiniteScroll: _isScrollable,
        onPageChanged: (index, _) => active.value = index,
      ),
    );
  }
}
