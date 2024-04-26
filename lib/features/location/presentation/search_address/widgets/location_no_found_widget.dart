import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class LocationNotFoundWidget extends StatelessWidget {
  const LocationNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textColors = context.colors.textColors;
    final textStyle = context.textStyle;

    return Center(
      heightFactor: AppConst.kCommon2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Spacer(),
              Flexible(
                flex: AppConst.kCommon2.toInt(),
                child: Assets.images.search3D.image(),
              ),
              const Spacer(),
            ],
          ),
          AppConst.kCommon16.verticalBox,
          Text(
            t.search.thatAddressDoesntExist,
            style: textStyle.headingTypo.h3.withColor(textColors.main),
            textAlign: TextAlign.center,
          ),
          AppConst.kCommon8.verticalBox,
          Text(
            t.search.enterADifferentAddress,
            style: textStyle.textTypo.tx3Medium.withColor(textColors.secondary),
            textAlign: TextAlign.center,
          ),
        ],
      ).paddingAll(AppConst.kCommon16),
    );
  }
}
