import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/personalized_prices_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/special_status_q_r_widget.dart';

class SpecialStatusWidget extends StatelessWidget {
  const SpecialStatusWidget({
    super.key,
    required this.bonuses,
  });

  final Bonuses bonuses;

  /// Перенаправляет на страницу баланса предоплатной воды.
  void _navigateToPrepaidWater(BuildContext context) {
    context.navigateTo(
      const ProfileWrapper(
        children: [
          ProfileRoute(),
          PrepaidWaterRoute(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpecialStatusQRWidget(bonuses: bonuses),
        AppBoxes.kHeight16,
        const PersonalizedPricesWidget(),
        AppBoxes.kHeight16,
        InkWell(
          onTap: () => _navigateToPrepaidWater(context),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.colors.mainColors.white,
              borderRadius: AppBorders.kCircular8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: AppBorders.kCircular8,
                    child: Assets.images.aboutBonuses.prepaidWater.image(),
                  ),
                ),
                AppBoxes.kWidth12,
                Expanded(
                  flex: AppSizes.kGeneral2.toInt(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.bonuses.prepaidWater,
                        style: context.textStyle.textTypo.tx2SemiBold.withColor(
                          context.colors.textColors.main,
                        ),
                      ),
                      AppBoxes.kHeight4,
                      Text(
                        t.bonuses.prepaidWaterBalance(
                          count: bonuses.bottles.count,
                        ),
                        style: context.textStyle.textTypo.tx2Medium.withColor(
                          context.colors.textColors.main,
                        ),
                      ),
                    ],
                  ),
                ),
                AppBoxes.kWidth12,
                Assets.icons.arrowRight.svg(
                  width: AppSizes.kIconMedium,
                  height: AppSizes.kIconMedium,
                ),
                AppBoxes.kWidth8,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
