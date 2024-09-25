import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Баннер с информацией о том, что адрес недоступен для редактирования.
class EditingUnavailablebanner extends StatelessWidget {
  const EditingUnavailablebanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppBorders.kCircular12,
        color: context.colors.infoColors.bgRed,
      ),
      child: Padding(
        padding: AppInsets.kAll12,
        child: Row(
          children: [
            Assets.icons.errorIcon.svg(
              height: AppSizes.kIconLarge,
              width: AppSizes.kIconLarge,
            ),
            AppBoxes.kWidth8,
            Text(
              t.locations.editUnavailable,
              style: context.textStyle.textTypo.tx2SemiBold,
            ),
          ],
        ),
      ),
    );
  }
}
