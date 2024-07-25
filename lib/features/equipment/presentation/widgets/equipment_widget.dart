import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class EquipmentWidget extends StatelessWidget {
  const EquipmentWidget({super.key});

  void _goToEquipments(BuildContext context) {
    context.navigateTo(
      const ProfileWrapper(
        children: [
          ProfileRoute(),
          EquipmentsRoute(),
        ],
      ),
    );
  }

  void _closeAnnouncement() {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _goToEquipments(context),
      child: Container(
        height: AppSizes.kEquipmentWidgetHeight,
        margin: AppInsets.kHorizontal16 + AppInsets.kTop32,
        decoration: BoxDecoration(
          borderRadius: AppBorders.kCircular16,
          color: context.colors.mainColors.white,
          boxShadow: [
            BoxShadow(
              color: context.colors.textColors.main
                  .withOpacity(AppSizes.kShadowOpacity),
              offset: AppConstants.kShadowDiagonal,
              blurRadius: AppSizes.kGeneral16,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: AppBorders.kCircular16,
              child: Assets.images.equipment.image(),
            ),
            Expanded(
              child: Padding(
                padding: AppInsets.kAll8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => _closeAnnouncement(),
                          child: Assets.icons.closeFilling.svg(),
                        ),
                      ],
                    ),
                    Text(
                      t.equipments.equipmentCleaningIsRequired,
                      style: context.textStyle.textTypo.tx1SemiBold,
                    ),
                    AppBoxes.kHeight8,
                    Row(
                      children: [
                        Text(
                          t.profile.banners.more,
                          style: context.textStyle.buttonTypo.btn3semiBold
                              .withColor(context.colors.textColors.blue),
                        ),
                        Assets.icons.arrowRight.svg(
                          width: AppSizes.kIconSmall,
                          height: AppSizes.kIconSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
