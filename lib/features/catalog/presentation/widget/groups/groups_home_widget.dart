import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/catalog/presentation/widget/groups/groups_widget.dart';

class GroupsHomeWidget extends StatelessWidget {
  const GroupsHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.mainColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBoxes.kHeight32,
          Padding(
            padding: AppInsets.kHorizontal16,
            child: Text(
              t.catalog.categories,
              style: context.textStyle.headingTypo.h3
                  .withColor(context.colors.textColors.main),
            ),
          ),
          const GroupsWidget(),
        ],
      ),
    );
  }
}
