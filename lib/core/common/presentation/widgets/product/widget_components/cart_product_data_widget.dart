import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/amount_icon_button.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/cart_item_action.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class CartProductDataWidget extends StatelessWidget {
  const CartProductDataWidget({
    required this.product,
    required this.isAvailable,
    required this.openSlideMenu,
    required this.count,
    required this.onPlus,
    required this.onMinus,
    required this.interactive,
  });

  final Product product;
  final int count;
  final bool isAvailable;
  final VoidCallback openSlideMenu;
  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final bool interactive;

  @override
  Widget build(BuildContext context) {
    final bool withdrawingWater = product.isWater && product.price == 0;
    final bool displaySecondPart =
        !withdrawingWater && product.discountOfCount.isNotEmpty;

    // В карточках с предоплатной водой цена рисуется в зависимости от
    // количества наборов.
    final int price = product.price * (product.isWater ? count : 1);
    final int oldPrice = product.priceOld * (product.isWater ? count : 1);

    // Кол-во бутылей в наборе * кол-во преобретаемых наборов.
    final int? complectCount = product.isWater && product.count != null
        ? product.count! * count
        : null;

    final Widget pricesAndCount = _PricesAndCount(
      price: price,
      product: product,
      interactive: interactive,
      oldPrice: oldPrice,
      openSlideMenu: openSlideMenu,
      complectCount: complectCount,
    );

    return Flexible(
      flex: AppSizes.kGeneral2.toInt(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (interactive) ...[
            pricesAndCount,
            AppBoxes.kHeight8,
          ],
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
                  '${product.description}${displaySecondPart ? t.common.dotSeparator : ''}',
                  style: context.textStyle.descriptionTypo.des3.copyWith(
                    color: context.colors.textColors.secondary,
                  ),
                ),
              if (displaySecondPart)
                Text(
                  product.discountOfCount,
                  style: context.textStyle.captionTypo.c1.withColor(
                    context.colors.infoColors.green,
                  ),
                ),
            ],
          ),
          AppBoxes.kHeight24,
          if (isAvailable && interactive)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AmountIconButton(
                  itemAction: ItemAction.minus,
                  onTap: onMinus,
                ),
                Padding(
                  padding: AppInsets.kHorizontal16,
                  child: Text(
                    '$count ${t.pieces}',
                    style: context.textStyle.textTypo.tx2SemiBold.withColor(
                      context.colors.mainColors.primary,
                    ),
                  ),
                ),
                AmountIconButton(
                  itemAction: ItemAction.plus,
                  onTap: onPlus,
                ),
              ],
            )
          else if (!isAvailable)
            Text(
              t.cart.notAvailable,
              style: context.textStyle.textTypo.tx2SemiBold.withColor(
                context.colors.textColors.secondary,
              ),
            ),
          if (!interactive) ...[
            AppBoxes.kHeight8,
            pricesAndCount,
          ],
        ],
      ),
    );
  }
}

class _PricesAndCount extends StatelessWidget {
  const _PricesAndCount({
    required this.price,
    required this.product,
    required this.interactive,
    required this.oldPrice,
    required this.openSlideMenu,
    required this.complectCount,
  });

  final int price;
  final Product product;
  final bool interactive;
  final int oldPrice;
  final VoidCallback openSlideMenu;
  final int? complectCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Новая цена
        Text(
          '$price ${t.common.rub}'.spaceSeparateNumbers(),
          style: context.textStyle.textTypo.tx1SemiBold.withColor(
            context.colors.textColors.main,
          ),
        ),
        AppBoxes.kWidth4,

        // Старая цена
        if (product.hasDiscount && interactive)
          Text(
            '$oldPrice ${t.common.rub}'.spaceSeparateNumbers(),
            style: context.textStyle.textTypo.tx3Medium.copyWith(
              color: context.colors.textColors.secondary,
              decoration: TextDecoration.lineThrough,
              decorationColor: context.colors.textColors.secondary,
            ),
          ),
        const Spacer(),

        // Меню "..."
        if (interactive)
          InkWell(
            onTap: openSlideMenu,
            child: Assets.icons.menuDots.svg(),
          )

        // TODO(kvbykov):
        // Суммарное кол-во бутылей
        else if (complectCount != null)
          Text(
            '$complectCount ${t.pieces}',
            style: context.textStyle.textTypo.tx1SemiBold.withColor(
              context.colors.textColors.main,
            ),
          ),
      ],
    );
  }
}
