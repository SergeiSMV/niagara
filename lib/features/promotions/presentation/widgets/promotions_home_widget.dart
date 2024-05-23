import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/promotions/presentation/widgets/promotions_widget.dart';

class PromotionsHomeWidget extends StatelessWidget {
  const PromotionsHomeWidget({super.key});

  void _navigateToAllPromotions(BuildContext context) =>
      context.navigateTo(PromotionsRoute(isPersonal: false));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBoxes.kHeight32,
        Padding(
          padding: AppInsets.kHorizontal16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.promos.promotions,
                style: context.textStyle.headingTypo.h3
                    .withColor(context.colors.textColors.main),
              ),
              InkWell(
                onTap: () => _navigateToAllPromotions(context),
                child: Row(
                  children: [
                    Text(
                      t.common.all,
                      style: context.textStyle.buttonTypo.btn3semiBold
                          .withColor(context.colors.textColors.accent),
                    ),
                    Assets.icons.arrowRight.svg(
                      width: AppSizes.kIconSmall,
                      height: AppSizes.kIconSmall,
                      colorFilter: ColorFilter.mode(
                        context.colors.textColors.accent,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const PromotionsWidget(),
      ],
    );
  }
}
