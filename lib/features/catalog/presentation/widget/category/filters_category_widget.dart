import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';

class FiltersCategoryWidget extends StatelessWidget {
  const FiltersCategoryWidget({
    super.key,
    required this.group,
  });

  final Group group;

  void _onTapFilter(BuildContext context) => {};

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTapFilter(context),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: AppBorders.kCircular8,
          color: context.colors.mainColors.bgCard,
        ),
        child: Padding(
          padding: AppInsets.kHorizontal24 + AppInsets.kVertical12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icons.filter.svg(
                width: AppSizes.kIconMedium,
                height: AppSizes.kIconMedium,
              ),
              AppBoxes.kWidth8,
              Text(
                t.catalog.filter,
                style: context.textStyle.buttonTypo.btn2semiBold.withColor(
                  context.colors.textColors.accent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
