import 'package:flutter/material.dart';
import '../../../../../core/common/presentation/widgets/app_network_image_widget.dart';
import '../../../../../core/utils/constants/app_borders.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/enums/cleaning_statuses.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import '../../../domain/model/equipment.dart';
import '../cleaning_status_widget.dart';
import 'equipment_item_content_widget.dart';

class EquipmentItemWidget extends StatelessWidget {
  const EquipmentItemWidget({
    required this.equipment,
    super.key,
  });

  final Equipment equipment;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          if (equipment.status == CleaningStatuses.no)
            _HeadingWidget(address: equipment.locationName),
          _TitleWidget(
            status: equipment.status,
            imageUrl: equipment.imageUrl,
            content: EquipmentItemContentWidget(equipment: equipment),
          ),
        ],
      );
}

/// Виджет с адресом
class _HeadingWidget extends StatelessWidget {
  const _HeadingWidget({
    required this.address,
  });

  final String address;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.equipments.address,
            style: context.textStyle.headingTypo.h3
                .withColor(context.colors.textColors.main),
          ),
          AppBoxes.kHeight8,
          Text(
            address,
            style: context.textStyle.textTypo.tx2Medium
                .withColor(context.colors.textColors.main),
          ),
          AppBoxes.kHeight16,
        ],
      );
}

/// Виджет с изображением и статусом чистки
class _TitleWidget extends StatelessWidget {
  const _TitleWidget({
    required this.status,
    required this.content,
    required this.imageUrl,
  });

  final CleaningStatuses status;
  final Widget content;
  final String imageUrl;

  Color _backgroundItemColor(BuildContext context) => switch (status) {
        CleaningStatuses.no => context.colors.infoColors.bgBlue,
        CleaningStatuses.cleaningIsRequired => context.colors.infoColors.bgRed,
        CleaningStatuses.cleaningIsExpected =>
          context.colors.infoColors.lightGreen,
      };

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: _backgroundItemColor(context),
          borderRadius: AppBorders.kCircular12,
        ),
        child: Column(
          children: [
            AppBoxes.kHeight8,
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: AppBorders.kCircular72,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.colors.mainColors.white,
                        ),
                        child: AppNetworkImageWidget(
                          url: imageUrl,
                          height: AppSizes.kImageSize84,
                          width: AppSizes.kImageSize84,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ],
                ),
                if (status != CleaningStatuses.no)
                  Padding(
                    padding: AppInsets.kTop4 + AppInsets.kRight12,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CleaningStatusWidget(status: status),
                    ),
                  ),
              ],
            ),
            AppBoxes.kHeight8,
            content,
          ],
        ),
      );
}
