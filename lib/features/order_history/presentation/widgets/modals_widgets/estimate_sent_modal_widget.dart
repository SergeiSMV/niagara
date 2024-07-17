import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class EstimateSentModalWidget extends StatelessWidget {
  const EstimateSentModalWidget({super.key});
  Future<void> _onCloseModal(BuildContext context) async => context.maybePop();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppInsets.kHorizontal8 + AppInsets.kBottom48,
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical24,
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        borderRadius: AppBorders.kCircular20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.greenCheck.image(
            height: AppSizes.kImageSize120,
            width: AppSizes.kImageSize120,
          ),
          AppBoxes.kHeight24,
          Text(
            t.recentOrders.reviewHasBeenSent,
            style: context.textStyle.headingTypo.h3
                .withColor(context.colors.textColors.main),
          ),
          AppBoxes.kHeight8,
          Text(
            t.recentOrders.thankYouForYourAssessment,
            style: context.textStyle.textTypo.tx1Medium
                .withColor(context.colors.textColors.secondary),
          ),
          AppBoxes.kHeight24,
          AppTextButton.primary(
            text: t.recentOrders.well,
            onTap: () => _onCloseModal(context),
          ),
        ],
      ),
    );
  }
}
