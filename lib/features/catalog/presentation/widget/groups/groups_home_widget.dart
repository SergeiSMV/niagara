import 'package:flutter/material.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import 'groups_widget.dart';

/// Виджет для отображения категорий на главной странице
class GroupsHomeWidget extends StatelessWidget {
  const GroupsHomeWidget({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
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
