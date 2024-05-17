import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class BonusesFooterButton extends StatelessWidget {
  const BonusesFooterButton({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  final SvgGenImage icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          icon.svg(
            width: AppConst.kIconMedium,
            height: AppConst.kIconMedium,
          ),
          AppConst.kCommon12.horizontalBox,
          Text(
            title,
            style: context.textStyle.textTypo.tx2Medium.withColor(
              context.colors.textColors.main,
            ),
          ),
          const Spacer(),
          Assets.icons.arrowRight.svg(
            width: AppConst.kIconMedium,
            height: AppConst.kIconMedium,
          ),
        ],
      ),
    ).paddingSymmetric(vertical: AppConst.kCommon16);
  }
}
