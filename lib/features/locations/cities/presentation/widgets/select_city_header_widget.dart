import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class SelectCityHeaderWidget extends StatelessWidget {
  const SelectCityHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kAll16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.cities.selectCity,
            style: context.textStyle.headingTypo.h3
                .withColor(context.colors.textColors.main),
          ),
          AppBoxes.kBoxV12,
          Text(
            t.cities.description,
            style: context.textStyle.textTypo.tx1Medium
                .withColor(context.colors.textColors.secondary),
          ),
        ],
      ),
    );
   
  }
}
