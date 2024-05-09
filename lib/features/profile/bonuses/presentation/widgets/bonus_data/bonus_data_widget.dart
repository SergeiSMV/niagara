import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class BonusDataWidget extends StatelessWidget {
  const BonusDataWidget({
    
    required this.title,
    required this.value,
    required this.icon,
    super.key,
  });

  final String title;
  final String value;
  final SvgGenImage icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        borderRadius: BorderRadius.circular(AppConst.kCommon12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textStyle.textTypo.tx4Medium,
          ),
          AppConst.kCommon8.verticalBox,
          Row(
            children: [
              icon.svg(
                width: AppConst.kIconMedium,
                height: AppConst.kIconMedium,
              ),
              AppConst.kCommon6.horizontalBox,
              Text(
                value,
                style: context.textStyle.textTypo.tx2SemiBold,
              ),
            ],
          ),
        ],
      ).paddingAll(AppConst.kCommon8),
    );
  }
}
