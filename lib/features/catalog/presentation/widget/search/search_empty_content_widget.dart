import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class SearchEmptyContentWidget extends StatelessWidget {
  const SearchEmptyContentWidget();

  @override
  Widget build(BuildContext context) {
    final textColors = context.colors.textColors;
    final textStyle = context.textStyle;

    return Padding(
      padding: AppInsets.kAll16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: AppInsets.kHorizontal64,
            child: Assets.images.search3D.image(),
          ),
          AppBoxes.kHeight16,
          Text(
            t.catalog.nothingWasFound,
            style: textStyle.headingTypo.h3.withColor(textColors.main),
            textAlign: TextAlign.center,
          ),
          AppBoxes.kHeight8,
          Text(
            t.catalog.changingQueryOrGoToCatalog,
            style: textStyle.textTypo.tx3Medium.withColor(textColors.secondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
