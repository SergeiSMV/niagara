import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../../../utils/constants/app_borders.dart';
import '../../../../../utils/constants/app_boxes.dart';
import '../../../../../utils/constants/app_insets.dart';
import '../../../../../utils/constants/app_sizes.dart';
import '../../../../../utils/extensions/build_context_ext.dart';
import '../../../../../utils/gen/assets.gen.dart';
import '../../../../domain/models/product.dart';
import '../../app_bar.dart';
import '../../app_network_image_widget.dart';

/// Виджет для отображения изображений продукта.
class ProductImagesWidget extends HookWidget {
  const ProductImagesWidget({
    required this.product,
    super.key,
  });

  /// Продукт.
  final Product product;

  /// Список изображений.
  List<String> get _images =>
      {product.imageUrl, ...product.additionalImages}.toList();

  /// Возвращает true, если количество изображений больше одного.
  bool get _isScrollable => _images.length > 1;

  /// Показывает полноэкранное изображение.
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
        builder: (ctx) => _FullScreenImages(
          images: _images,
          product: product,
          isScrollable: _isScrollable,
        ),
      );

  @override
  Widget build(BuildContext context) {
    /// Активный индекс.
    final active = useState(0);

    return Column(
      children: [
        _ImagesCarouselWidget(
          images: _images,
          product: product,
          isScrollable: _isScrollable,
          active: active,
          onTap: (index) async => _showFullImagesDialog(
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

class _FullScreenImages extends HookWidget {
  const _FullScreenImages({
    required List<String> images,
    required this.product,
    required bool isScrollable,
  })  : _images = images,
        _isScrollable = isScrollable;

  /// Список изображений.
  final List<String> _images;

  /// Продукт.
  final Product product;

  /// Возвращает true, если количество изображений больше одного.
  final bool _isScrollable;

  @override
  Widget build(BuildContext context) {
    final active = useState(0);
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          automaticallyImplyLeading: false,
          automaticallyImplyTitle: false,
          actions: [
            InkWell(
              onTap: () async => context.maybePop(),
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
              child: PhotoViewGallery.builder(
                itemCount: _images.length,
                onPageChanged: (index) => active.value = index,
                builder: (BuildContext context, int index) =>
                    PhotoViewGalleryPageOptions(
                  imageProvider: ExtendedNetworkImageProvider(_images[index]),
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  basePosition: Alignment.center,
                ),
                loadingBuilder: (context, event) => const Center(
                  child: CircularProgressIndicator(),
                ),
                backgroundDecoration: BoxDecoration(
                  color: context.colors.mainColors.white,
                ),
              ),
            ),
            if (_isScrollable)
              Padding(
                padding: AppInsets.kVertical32,
                child: _PaginationImagesWidget(
                  images: _images,
                  active: active,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PaginationImagesWidget extends StatelessWidget {
  const _PaginationImagesWidget({
    required List<String> images,
    required this.active,
  }) : _images = images;

  /// Список изображений.
  final List<String> _images;

  /// Активный индекс.
  final ValueNotifier<int> active;

  @override
  Widget build(BuildContext context) => Row(
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
      );
}

/// Виджет для отображения изображений в виде карусели.
class _ImagesCarouselWidget extends StatelessWidget {
  const _ImagesCarouselWidget({
    required List<String> images,
    required this.product,
    required bool isScrollable,
    required this.active,
    this.onTap,
  })  : _images = images,
        _isScrollable = isScrollable;

  /// Список изображений.
  final List<String> _images;

  /// Продукт.
  final Product product;

  /// Возвращает true, если количество изображений больше одного.
  final bool _isScrollable;

  /// Активный индекс.
  final ValueNotifier<int> active;

  /// Функция для обработки нажатия на изображение.
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) => CarouselSlider.builder(
        itemCount: _images.length,
        itemBuilder: (_, index, __) => InkWell(
          onTap: onTap != null ? () => onTap!(index) : null,
          key: ValueKey(_images[index]),
          child: Container(
            width: double.infinity,
            padding: AppInsets.kAll8,
            child: ClipRRect(
              borderRadius: AppBorders.kCircular16 + AppBorders.kCircular2,
              child: AppNetworkImageWidget(url: _images[index]),
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
