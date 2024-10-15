import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class ProductVIPPriceWidget extends StatelessWidget {
  const ProductVIPPriceWidget({
    super.key,
    required this.product,
  });

  final Product product;

  void _gotToVipPage(BuildContext context) => context.navigateTo(
        const ProfileWrapper(
          children: [
            VipRoute(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _gotToVipPage(context),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.infoColors.green,
          borderRadius: AppBorders.kCircular8,
        ),
        child: Padding(
          padding: AppInsets.kAll8 + AppInsets.kLeft4,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${product.priceVip} ${t.common.rub}'
                        .spaceSeparateNumbers(),
                    style: context.textStyle.headingTypo.h3.withColor(
                      context.colors.textColors.white,
                    ),
                  ),
                  AppBoxes.kHeight2,
                  Text(
                    t.catalog.withVIP,
                    style: context.textStyle.textTypo.tx4Medium.withColor(
                      context.colors.textColors.white,
                    ),
                  ),
                ],
              ),
              AppBoxes.kWidth4,
              Assets.icons.arrowRight.svg(
                width: AppSizes.kIconSmall,
                height: AppSizes.kIconSmall,
                colorFilter: ColorFilter.mode(
                  context.colors.textColors.white,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
