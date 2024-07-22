import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/base_button_size.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class EmptyOrdersListWidget extends StatelessWidget {
  const EmptyOrdersListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.emptyOrdersWidgetHeight,
      width: double.infinity,
      margin: AppInsets.kHorizontal16 + AppInsets.kTop16,
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        borderRadius: AppBorders.kCircular12,
        boxShadow: [
          BoxShadow(
            color: context.colors.textColors.main
                .withOpacity(AppSizes.kShadowOpacity),
            offset: AppConstants.kShadowDiagonal,
            blurRadius: AppSizes.kGeneral16,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: AppBorders.kCircular12,
            child: Assets.images.giftBasket.image(),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  t.recentOrders.addBonusesForFirstOrder,
                  style: context.textStyle.textTypo.tx1SemiBold
                      .withColor(context.colors.textColors.main),
                ),
                RichText(
                  textDirection: TextDirection.ltr,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: t.recentOrders.firstOrderAndBonus
                            .placeYourFirstOrder,
                        style: context.textStyle.textTypo.tx3Medium
                            .withColor(context.colors.textColors.secondary),
                      ),
                      TextSpan(
                        text: t.recentOrders.firstOrderAndBonus.fiftyBonuses,
                        style: context.textStyle.textTypo.tx2SemiBold
                            .withColor(context.colors.infoColors.blue),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: AppInsets.kRight72,
                  child: AppTextButton.primary(
                    size: BaseButtonSize.small,
                    text: t.recentOrders.forShopping,
                    onTap: () {},
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
