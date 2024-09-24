import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class PersonalizedPricesWidget extends StatelessWidget {
  const PersonalizedPricesWidget({
    super.key,
  });

  void _goToBonuses(BuildContext context) => context.navigateTo(
        const ProfileWrapper(
          children: [
            ProfileRoute(),
            MyBonusesRoute(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _goToBonuses(context),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.mainColors.white,
          borderRadius: AppBorders.kCircular8,
        ),
        child: Padding(
          padding: AppInsets.kAll8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Assets.images.aboutBonuses.money.image(
                        width: AppSizes.kIconMedium,
                        height: AppSizes.kIconMedium,
                      ),
                      AppBoxes.kWidth6,
                      Text(
                        t.bonuses.personalizedPrices,
                        style: context.textStyle.textTypo.tx2SemiBold.withColor(
                          context.colors.textColors.accent,
                        ),
                      ),
                    ],
                  ),
                  AppBoxes.kHeight8,
                  Text(
                    t.bonuses.specialPricesGoods,
                    style: context.textStyle.textTypo.tx4Medium.withColor(
                      context.colors.textColors.main,
                    ),
                  ),
                ],
              ),
              AppBoxes.kWidth12,
              Assets.icons.arrowRight.svg(
                width: AppSizes.kIconMedium,
                height: AppSizes.kIconMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
