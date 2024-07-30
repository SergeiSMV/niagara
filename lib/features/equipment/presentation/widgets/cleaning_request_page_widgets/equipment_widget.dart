import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';

class EquipmentWidget extends StatelessWidget {
  const EquipmentWidget({
    super.key,
    required this.imageUrl,
    required this.equipmentName,
  });

  final String imageUrl;
  final String equipmentName;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: AppInsets.kAll16 + AppInsets.kTop8,
        padding: AppInsets.kAll8,
        decoration: BoxDecoration(
          borderRadius: AppBorders.kCircular12,
          color: context.colors.mainColors.bgCard,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: AppBorders.kCircular8,
              child: ExtendedImage.network(
                imageUrl,
                height: AppSizes.kImageSize100,
                width: AppSizes.kImageSize100,
                fit: BoxFit.fitHeight,
                loadStateChanged: (state) =>
                    state.extendedImageLoadState == LoadState.loading
                        ? const AppCenterLoader()
                        : null,
              ),
            ),
            AppBoxes.kWidth12,
            Expanded(
              child: Padding(
                padding: AppInsets.kTop2,
                child: Text(
                  equipmentName,
                  style: context.textStyle.textTypo.tx2Medium
                      .withColor(context.colors.textColors.main),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
