import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/cleaning_statuses.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/equipment/presentation/widgets/cleaning_status_widget.dart';

class EquipmentItemWidget extends StatelessWidget {
  const EquipmentItemWidget({
    super.key,
    required this.status,
  });

  final CleaningStatuses status;

  Color _backgroundItemColor(BuildContext context) => switch (status) {
        CleaningStatuses.no => context.colors.infoColors.bgBlue,
        CleaningStatuses.cleaningIsRequired => context.colors.infoColors.bgRed,
        CleaningStatuses.cleaningIsExpected =>
          context.colors.infoColors.lightGreen,
      };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kVertical16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (status != CleaningStatuses.cleaningIsExpected) ...[
            Text(
              t.equipments.address,
              style: context.textStyle.headingTypo.h3
                  .withColor(context.colors.textColors.main),
            ),
            AppBoxes.kHeight8,
            Text(
              // TODO заменить на данные с бэка
              'улица имени Виктора Нарыкова, д. 50, кв. 23',
              style: context.textStyle.textTypo.tx2Medium
                  .withColor(context.colors.textColors.main),
            ),
            AppBoxes.kHeight16,
          ],
          Container(
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
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.colors.mainColors.white,
                            ),
                            child: ExtendedImage.network(
                              // TODO заменить на данные с бэка
                              '',
                              height: AppSizes.kImageSize84,
                              width: AppSizes.kImageSize84,
                              fit: BoxFit.fitHeight,
                              loadStateChanged: (state) =>
                                  state.extendedImageLoadState ==
                                          LoadState.loading
                                      ? const AppCenterLoader()
                                      : null,
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
                Container(
                  padding: /*AppInsets.kHorizontal12 +*/ AppInsets.kVertical16,
                  decoration: BoxDecoration(
                    color: context.colors.mainColors.bgCard,
                    borderRadius: AppBorders.kCircular12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: AppInsets.kHorizontal12,
                        child: Text(
                          // TODO заменить на данные с бэка
                          'Диспенсер Ecotronic K25-LCE black Marble',
                          style: context.textStyle.textTypo.tx2SemiBold
                              .withColor(context.colors.textColors.main),
                        ),
                      ),
                      AppBoxes.kHeight8,
                      _CleaningDateInfo(
                        title: t.equipments.lastCleaning,
                        // TODO заменить на данные с бэка
                        date: '01 января 2024',
                      ),
                      _CleaningDateInfo(
                        title: t.equipments.scheduledCleaning,
                        // TODO заменить на данные с бэка
                        date: '01 января 2024',
                      ),
                      Divider(
                        height: AppSizes.kGeneral2,
                        thickness: AppSizes.kGeneral1,
                        color: context.colors.otherColors.separator30,
                      ),
                      _CleaningDateInfo(
                        title: status == CleaningStatuses.cleaningIsRequired
                            ? t.equipments.cleaningIsOverdueFor
                            : t.equipments.nextCleaningIsThrough,
                        // TODO заменить на данные с бэка
                        date: '20 дней',
                        boldFont: true,
                        cleaningIsOverdue:
                            status == CleaningStatuses.cleaningIsRequired,
                      ),
                      if (status != CleaningStatuses.cleaningIsExpected) ...[
                        AppBoxes.kHeight16,
                        Padding(
                          padding: AppInsets.kHorizontal12,
                          child: AppTextButton.accent(
                            text: t.equipments.orderCleaning,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CleaningDateInfo extends StatelessWidget {
  const _CleaningDateInfo({
    required this.title,
    required this.date,
    this.boldFont = false,
    this.cleaningIsOverdue = false,
  });

  final String title;
  final String date;
  final bool boldFont;
  final bool cleaningIsOverdue;

  @override
  Widget build(BuildContext context) {
    final textStyle = boldFont
        ? context.textStyle.textTypo.tx2SemiBold.withColor(
            cleaningIsOverdue
                ? context.colors.mainColors.white
                : context.colors.textColors.main,
          )
        : context.textStyle.textTypo.tx2Medium.withColor(
            cleaningIsOverdue
                ? context.colors.mainColors.white
                : context.colors.textColors.main,
          );

    return Container(
      padding: AppInsets.kVertical8 + AppInsets.kHorizontal12,
      decoration: BoxDecoration(
        borderRadius: AppBorders.kCircular4,
        color: cleaningIsOverdue
            ? context.colors.infoColors.red
            : Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textStyle,
          ),
          Text(
            date,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
