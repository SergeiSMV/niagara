import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../../../../../core/common/presentation/widgets/loaders/app_center_loader.dart';
import '../../../../../core/utils/constants/app_borders.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../../core/common/presentation/widgets/app_network_image_widget.dart';

/// Виджет для отображения оборудования.
class EquipmentWidget extends StatelessWidget {
  const EquipmentWidget({
    required this.imageUrl,
    required this.equipmentName,
    super.key,
  });

  /// URL изображения оборудования.
  final String imageUrl;

  /// Название оборудования.
  final String equipmentName;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
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
                child: AppNetworkImageWidget(
                  url: imageUrl,
                  height: AppSizes.kImageSize100,
                  width: AppSizes.kImageSize100,
                  fit: BoxFit.fitHeight,
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
