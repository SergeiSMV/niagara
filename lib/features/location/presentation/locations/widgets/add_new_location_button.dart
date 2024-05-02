import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class AddNewLocationButton extends StatelessWidget {
  const AddNewLocationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => context.pushRoute(const ChoiceOnMapRoute()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.locations.addNewAddress,
              style: context.textStyle.textTypo.tx1Medium
                  .withColor(context.colors.textColors.main),
            ).paddingSymmetric(vertical: AppConst.kCommon12),
            Assets.icons.add.svg(
              width: AppConst.kIconLarge,
              height: AppConst.kIconLarge,
            ),
          ],
        ).paddingSymmetric(horizontal: AppConst.kCommon16),
      );
}
