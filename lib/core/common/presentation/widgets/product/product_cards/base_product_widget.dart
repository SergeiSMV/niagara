import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cards/product_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/amount_controls_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_card_price_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_image_with_labels.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/product_short_description.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/water_banalce_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/unauthorized_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';

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
    this.outOfStock = false,
    this.isOnWaterBalancePage = false,
  });

  /// Означает, что товар добавлен в корзину, но отсутствует в наличии.
  final bool outOfStock;

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
            /// Изображение, "избранное" и бонусы за покупку.
            Flexible(
              flex: 8,
              child: AspectRatio(
                aspectRatio: 1,
                child: ProductImageWithLabels(
                  product: product,
                  isOnWaterBalancePage: isOnWaterBalancePage,
                ),
              ),
            ),

            /// Название, описание, цена и кнопки управления количеством.
            Flexible(
              flex: 7,
              child: Padding(
                padding: AppInsets.kHorizontal6 + AppInsets.kBottom8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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

                    // Описание товара + скидка от количества за покупку.
                    ProductShortDescription(
                      product: product,
                      isWaterBalance: isOnWaterBalancePage,
                    ),

                    /// Прижимает цену / баланс к низу карточки перед кнопками.
                    const Spacer(),

                    /// Баланс предоплатной воды или цена товара.
                    if (isOnWaterBalancePage)
                      WaterBanalceWidget(product: product)
                    else
                      ProductCardPriceWidget(product: product),

                    AppBoxes.kHeight4,

                    // Переключатели количества товара.
                    AmountControlsWidget(
                      outOfStock: outOfStock,
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
            ),
          ],
        ),
      ),
    );
  }
}
