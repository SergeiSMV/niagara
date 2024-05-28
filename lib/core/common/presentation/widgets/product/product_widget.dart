import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
                  ClipRRect(
                    borderRadius: AppBorders.kCircular6,
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (_, __, ___) =>
                          const AppCenterLoader(),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (product.label.isNotEmpty)
                          Padding(
                            padding: AppInsets.kAll6,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: AppBorders.kCircular4,
                                color: product.labelColor,
                              ),
                              child: Padding(
                                padding: AppInsets.kHorizontal8 +
                                    AppInsets.kVertical4,
                                child: Text(
                                  product.label,
                                  style: context.textStyle.captionTypo.c1
                                      .withColor(
                                    context.colors.textColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        const Spacer(),
                        Padding(
                          padding: AppInsets.kAll4,
                          child: Assets.icons.like.svg(
                            width: AppSizes.kIconMedium,
                            height: AppSizes.kIconMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (product.discountOfCount.isNotEmpty)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: context.colors.mainColors.bgCard,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(AppSizes.kGeneral6),
                            bottomLeft: Radius.circular(AppSizes.kGeneral6),
                            topRight: Radius.circular(AppSizes.kGeneral6),
                          ),
                        ),
                        child: Row(
                          children: [
                            Assets.icons.coinNiagara.svg(
                              width: AppSizes.kIconSmall,
                              height: AppSizes.kIconSmall,
                            ),
                            AppBoxes.kWidth4,
                            Text(
                              product.discountOfCount,
                              style: context.textStyle.captionTypo.c1
                                  .withColor(context.colors.textColors.main),
                            ),
                            AppBoxes.kWidth6,
                          ],
                        ),
                      ),
                    ),
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
                        style: context.textStyle.descriptionTypo.des3.withColor(
                          context.colors.textColors.secondary,
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
                AppBoxes.kHeight4,
                Text(
                  '${product.price} ${t.common.rub}'.spaceSeparateNumbers(),
                  style: context.textStyle.textTypo.tx1SemiBold.withColor(
                    context.colors.textColors.main,
                  ),
                ),
                AppBoxes.kHeight8,
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colors.buttonColors.accent,
                    borderRadius: AppBorders.kCircular6,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: AppInsets.kVertical6,
                          child: Assets.icons.shoppingCart.svg(
                            width: AppSizes.kIconMedium,
                            height: AppSizes.kIconMedium,
                            colorFilter: ColorFilter.mode(
                              context.colors.textColors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
