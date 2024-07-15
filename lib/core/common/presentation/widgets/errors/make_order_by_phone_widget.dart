import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class MakeOrderByPhoneWidget extends StatelessWidget {
  const MakeOrderByPhoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppInsets.kVertical12 + AppInsets.kHorizontal16,
      padding: AppInsets.kAll12,
      decoration: BoxDecoration(
        color: context.colors.infoColors.bgBlue,
        borderRadius: AppBorders.kCircular12,
      ),
      child: Row(
        children: [
          Assets.icons.infoLightBlueFill.svg(),
          AppBoxes.kWidth16,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.common.makeOrderByPhone,
                style: context.textStyle.textTypo.tx2SemiBold.withColor(
                  context.colors.textColors.main,
                ),
              ),
              AppBoxes.kHeight4,
              Text(
                AppConstants.orderNumber,
                style: context.textStyle.textTypo.tx2SemiBold.withColor(
                  context.colors.infoColors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
