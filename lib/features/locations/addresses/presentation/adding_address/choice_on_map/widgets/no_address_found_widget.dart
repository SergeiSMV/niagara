import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class NoAddressFoundWidget extends StatelessWidget {
  const NoAddressFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Assets.icons.attention.svg(
              colorFilter: ColorFilter.mode(
                context.colors.infoColors.red,
                BlendMode.srcIn,
              ),
            ),
            AppConst.kCommon12.horizontalBox,
            Text(
              t.locations.noAddressFound,
              style: context.textStyle.textTypo.tx1SemiBold,
            ).paddingSymmetric(vertical: AppConst.kCommon24),
          ],
        ),
        AppTextButton.primary(
          text: t.locations.yeahThatsRight,
        ),
        AppTextButton.secondary(
          text: t.locations.enterManually,
          onTap: () {},
        ).paddingSymmetric(vertical: AppConst.kCommon12),
        AppConst.kCommon12.verticalBox,
      ],
    ).paddingSymmetric(horizontal: AppConst.kCommon16);
  }
}
