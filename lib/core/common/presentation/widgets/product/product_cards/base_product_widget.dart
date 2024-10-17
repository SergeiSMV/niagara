import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cards/product_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/amount_controls_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_coins_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_favorite_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_tag_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/unauthorized_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Базовый виджет карточки товара.
///
/// Используется вместе с [BlocProvider], который предоставит [product],
/// [count], [onAdd] и [onRemove].
///
/// Для примера см. [ProductWidget].
class BaseProductWidget extends StatelessWidget {
  const BaseProductWidget({
    super.key,
    required this.product,
    required this.count,
    required this.onAdd,
    required this.onRemove,
    required this.authorized,
    this.isOnWaterBalancePage = false,
  });

  /// Товар, отображаемый в карточке.
  final Product product;

  /// Количество товара, отображаемое при добавлении / удалении.
  final int count;

  /// Коллбек, вызываемый при увеличении количества товара.
  final VoidCallback onAdd;

  /// Коллбек, вызываемый при уменьшении количества товара.
  final VoidCallback onRemove;

  /// Индикатор того, что данный виджет отображает предоплатную воду **на
  /// балансе**.
  ///
  /// В таком случае не рисуются бонусы, цена и часть описания, а также
  /// отключается переход в карточку товара по нажатии.
  final bool isOnWaterBalancePage;

  /// Авторизован ли текущий пользователь. Нужно для открытия модальных окон с
  /// авторизацией.
  final bool authorized;

  /// Перенаправляет пользователя на страницу товара.
  void _goToProductPage(BuildContext context) => context.pushRoute(
        ProductRoute(
          key: ValueKey(product.id),
          product: product,
        ),
      );

  /// Открывает модальное окно авторизации.
  void _showAuthModal(BuildContext context) =>
      AuthorizationWidget.showModal(context);

  @override
  Widget build(BuildContext context) {
    /// Если товар - предоплатная вода и при этом не отображается на странице
    /// баланса. В таком случае все нажатия должны открывать карточку товара.
    final bool isWaterPromotion = product.isWater && !isOnWaterBalancePage;

    return InkWell(
      onTap: isOnWaterBalancePage ? null : () => _goToProductPage(context),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.mainColors.bgCard,
          borderRadius: AppBorders.kCircular8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: AppInsets.kAll6,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _ProductImage(product: product),
                    _ProductLabelAndFavorite(
                      product: product,
                      isWaterBalance: isOnWaterBalancePage,
                    ),
                    if (product.bonus > 0)
                      _BonusesForPurchaseWidget(product: product),
                  ],
                ),
              ),
            ),
            Padding(
              padding: AppInsets.kAll6 + AppInsets.kBottom2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Название товара.
                  Text(
                    product.name,
                    style: context.textStyle.textTypo.tx2Medium.withColor(
                      context.colors.textColors.main,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppBoxes.kHeight8,

                  // Описание товара + скидка от количества за покупку.
                  _ProductShortDescription(
                    product: product,
                    isWaterBalance: isOnWaterBalancePage,
                  ),
                  AppBoxes.kHeight8,

                  // Цена товара.
                  if (!isOnWaterBalancePage)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${product.price} ${t.common.rub}'
                              .spaceSeparateNumbers(),
                          style:
                              context.textStyle.textTypo.tx1SemiBold.withColor(
                            context.colors.textColors.main,
                          ),
                        ),
                        AppBoxes.kWidth4,
                        if (product.hasDiscount)
                          Text(
                            '${product.priceOld} ${t.common.rub}'
                                .spaceSeparateNumbers(),
                            style:
                                context.textStyle.descriptionTypo.des3.copyWith(
                              color: context.colors.textColors.secondary,
                              decoration: TextDecoration.lineThrough,
                              decorationColor:
                                  context.colors.textColors.secondary,
                            ),
                          ),
                      ],
                    ),

                  // Хотя такой случай и не имеет смысла, из-за ошибки `count`
                  // может оказаться `0`.
                  if (isOnWaterBalancePage)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          t.prepaidWater.balance,
                          style:
                              context.textStyle.descriptionTypo.des3.copyWith(
                            color: context.colors.textColors.secondary,
                          ),
                        ),
                        Text(
                          '${product.count} ${t.pieces}',
                          style: context.textStyle.textTypo.tx2SemiBold,
                        ),
                      ],
                    ),
                  AppBoxes.kHeight4,

                  // Переключатели количества товара.
                  AmountControlsWidget(
                    count: count,
                    onRemove: !authorized
                        ? () => _showAuthModal(context)
                        : isWaterPromotion
                            ? () => _goToProductPage(context)
                            : onRemove,
                    onAdd: !authorized
                        ? () => _showAuthModal(context)
                        : isWaterPromotion
                            ? () => _goToProductPage(context)
                            : onAdd,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductShortDescription extends StatelessWidget {
  const _ProductShortDescription({
    required this.product,
    required this.isWaterBalance,
  });

  final Product product;
  final bool isWaterBalance;

  @override
  Widget build(BuildContext context) {
    final bool displaySecondPart =
        product.discountOfCount.isNotEmpty && !isWaterBalance;

    return RichText(
      text: TextSpan(
        children: [
          if (product.description.isNotEmpty)
            TextSpan(
              text: product.description +
                  (displaySecondPart ? t.common.dotSeparator : ''),
              style: context.textStyle.descriptionTypo.des3.copyWith(
                color: context.colors.textColors.secondary,
              ),
            ),
          if (displaySecondPart)
            TextSpan(
              text: product.discountOfCount,
              style: context.textStyle.captionTypo.c1.withColor(
                context.colors.infoColors.green,
              ),
            ),
        ],
      ),
    );
  }
}

/// Отображает бонусы за покупку товара.
class _BonusesForPurchaseWidget extends StatelessWidget {
  const _BonusesForPurchaseWidget({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: ProductCoinsWidget(
        count: product.bonus,
      ),
    );
  }
}

// Отображает тег товара и кнопку "В избранное".
class _ProductLabelAndFavorite extends StatelessWidget {
  const _ProductLabelAndFavorite({
    required this.product,
    required this.isWaterBalance,
  });

  final Product product;

  final bool isWaterBalance;

  @override
  Widget build(BuildContext context) {
    final bool shouldDisplay = product.label.isNotEmpty && !isWaterBalance;

    return Positioned.fill(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (shouldDisplay)
            Padding(
              padding: AppInsets.kHorizontal6 + AppInsets.kVertical4,
              child: ProductTagWidget(
                label: product.label,
                labelColor: product.labelColor,
              ),
            ),
          const Spacer(),
          ProductFavoriteButton(product: product),
        ],
      ),
    );
  }
}

/// Отображает изображение товара.
class _ProductImage extends StatelessWidget {
  const _ProductImage({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppBorders.kCircular6,
      child: ExtendedImage.network(
        product.imageUrl,
        fit: BoxFit.cover,
        loadStateChanged: (state) =>
            state.extendedImageLoadState == LoadState.loading
                ? const AppCenterLoader()
                : null,
      ),
    );
  }
}
