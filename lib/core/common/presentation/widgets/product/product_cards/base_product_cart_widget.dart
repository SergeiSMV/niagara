import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cards/product_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_amount_icon_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_coins_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_tag_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/slide_buttons_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/cart_item_action.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Развёрнутая горизонтально карточка товвара с кнопками `+` и `-`.
///
/// Используется для отображения в корзине и для преобретения предоплатной воды.
///
/// Используется вместе с [BlocProvider], который предоставит [product],
/// [count], [onAdd] и [onRemove].
///
/// Не путать с [ProductWidget], который используется для отображения товара
/// в каталоге.
class BaseProductCartWidget extends StatefulWidget {
  const BaseProductCartWidget({
    super.key,
    required this.product,
    required this.onAdd,
    required this.onRemove,
    required this.count,
    this.isAvailable = true,
  });

  /// Преобретаемый товар.
  final Product product;

  /// Доступен ли товар для покупки.
  final bool isAvailable;

  /// Обработчик нажатия на кнопку увеличения количества товара.
  final VoidCallback onAdd;

  /// Обработчик нажатия на кнопку уменьшения количества товара.
  final VoidCallback onRemove;

  /// Количество товара.
  final int count;

  @override
  State<BaseProductCartWidget> createState() => _BaseProductCartWidgetState();
}

class _BaseProductCartWidgetState extends State<BaseProductCartWidget>
    with SingleTickerProviderStateMixin {
  late final SlidableController slidableController;

  @override
  void initState() {
    slidableController = SlidableController(this);
    super.initState();
  }

  /// Переход на страницу товара.
  void _navigateToProductPage(BuildContext context) => context.navigateTo(
        CatalogWrapper(
          children: [
            ProductRoute(
              key: ValueKey(widget.product.id),
              product: widget.product,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Slidable(
      controller: slidableController,
      endActionPane: ActionPane(
        extentRatio: AppConstants.slideExtentRatio,
        motion: const ScrollMotion(),
        children: [
          SlideButtonsWidget(
            product: widget.product,
            onActionCompleted: () => slidableController.close(),
            onRemove: widget.onRemove,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _navigateToProductPage(context),
        child: Padding(
          padding: AppInsets.kVertical4,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.colors.mainColors.bgCard,
              borderRadius: AppBorders.kCircular12,
            ),
            child: Padding(
              padding: AppInsets.kAll8,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CartProductImageWidget(product: widget.product),
                  AppBoxes.kWidth12,
                  _CartProductDescriptionWidget(
                    product: widget.product,
                    isAvailable: widget.isAvailable,
                    openSlideMenu: () => slidableController.openEndActionPane(),
                    onPlus: widget.onAdd,
                    onMinus: widget.onRemove,
                    count: widget.count,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CartProductDescriptionWidget extends StatelessWidget {
  const _CartProductDescriptionWidget({
    required this.product,
    required this.isAvailable,
    required this.openSlideMenu,
    required this.count,
    required this.onPlus,
    required this.onMinus,
  });

  final Product product;
  final int count;
  final bool isAvailable;
  final VoidCallback openSlideMenu;

  final VoidCallback onPlus;
  final VoidCallback onMinus;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: AppSizes.kGeneral2.toInt(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${product.price} ${t.common.rub}'.spaceSeparateNumbers(),
                style: context.textStyle.textTypo.tx1SemiBold.withColor(
                  context.colors.textColors.main,
                ),
              ),
              AppBoxes.kWidth4,
              if (product.hasDiscount)
                Text(
                  '${product.priceOld} ${t.common.rub}'.spaceSeparateNumbers(),
                  style: context.textStyle.textTypo.tx3Medium.copyWith(
                    color: context.colors.textColors.secondary,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: context.colors.textColors.secondary,
                  ),
                ),
              const Spacer(),
              InkWell(
                onTap: openSlideMenu,
                child: Assets.icons.menuDots.svg(),
              ),
            ],
          ),
          AppBoxes.kHeight8,
          Text(
            product.name,
            style: context.textStyle.textTypo.tx2Medium.withColor(
              context.colors.textColors.main,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          AppBoxes.kHeight4,
          Row(
            children: [
              if (product.description.isNotEmpty)
                Text(
                  '${product.description} • ',
                  style: context.textStyle.descriptionTypo.des3.copyWith(
                    color: context.colors.textColors.secondary,
                    height: .1,
                  ),
                ),
              if (product.discountOfCount.isNotEmpty)
                Text(
                  product.discountOfCount,
                  style: context.textStyle.captionTypo.c1.withColor(
                    context.colors.infoColors.green,
                  ),
                ),
            ],
          ),
          AppBoxes.kHeight24,
          if (isAvailable)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ProductAmountIconButton(
                  product: product,
                  cartAction: CartItemAction.minus,
                  onTap: onMinus,
                ),
                Padding(
                  padding: AppInsets.kHorizontal16,
                  child: Text(
                    '${count} ${t.pieces}',
                    style: context.textStyle.textTypo.tx2SemiBold.withColor(
                      context.colors.mainColors.primary,
                    ),
                  ),
                ),
                ProductAmountIconButton(
                  product: product,
                  cartAction: CartItemAction.plus,
                  onTap: onPlus,
                ),
              ],
            )
          else
            Text(
              t.cart.notAvailable,
              style: context.textStyle.textTypo.tx2SemiBold.withColor(
                context.colors.textColors.secondary,
              ),
            ),
        ],
      ),
    );
  }
}

class _CartProductImageWidget extends StatelessWidget {
  const _CartProductImageWidget({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: AppBorders.kCircular6,
            child: ExtendedImage.network(
              product.imageUrl,
              fit: BoxFit.cover,
              loadStateChanged: (state) =>
                  state.extendedImageLoadState == LoadState.loading
                      ? const AppCenterLoader()
                      : null,
            ),
          ),
          if (product.label.isNotEmpty)
            Positioned.fill(
              child: Padding(
                padding: AppInsets.kHorizontal6 + AppInsets.kVertical4,
                child: ProductTagWidget(
                  label: product.label,
                  labelColor: product.labelColor,
                ),
              ),
            ),
          if (product.bonus > 0)
            Positioned(
              bottom: 0,
              left: 0,
              child: ProductCoinsWidget(
                count: product.bonus,
              ),
            ),
        ],
      ),
    );
  }
}
