import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/cleaning_statuses.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет со всей информацией об оборудовании
class EquipmentItemContentWidget extends StatelessWidget {
  const EquipmentItemContentWidget({
    required this.status,
  });

  final CleaningStatuses status;

  void _goToPage(BuildContext context) =>
      context.navigateTo(const CleaningRequestRoute());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.kVertical16,
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
              'Диспенсер Ecotronic K25-LCE black Marble',
              style: context.textStyle.textTypo.tx2SemiBold
                  .withColor(context.colors.textColors.main),
            ),
          ),
          if (status != CleaningStatuses.cleaningIsExpected) ...[
            AppBoxes.kHeight8,
            _CleaningDateInfo(
              title: t.equipments.lastCleaning,
              date: '01 января 2024',
            ),
            _CleaningDateInfo(
              title: t.equipments.scheduledCleaning,
              date: '01 января 2024',
            ),
            Padding(
              padding: AppInsets.kHorizontal12,
              child: Divider(
                height: AppSizes.kGeneral2,
                thickness: AppSizes.kGeneral1,
                color: context.colors.otherColors.separator30,
              ),
            ),
          ],
          _CleaningInfo(status: status),
          if (status != CleaningStatuses.cleaningIsExpected) ...[
            AppBoxes.kHeight16,
            Padding(
              padding: AppInsets.kHorizontal12,
              child: AppTextButton.accent(
                text: t.equipments.orderCleaning,
                onTap: () => _goToPage(context),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CleaningInfo extends StatelessWidget {
  const _CleaningInfo({
    required this.status,
  });
  final CleaningStatuses status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      CleaningStatuses.no => _CleaningDateInfo(
          title: t.equipments.nextCleaningIsThrough,
          date: '20 дней',
          boldFont: true,
        ),
      CleaningStatuses.cleaningIsRequired => _CleaningDateInfo(
          title: t.equipments.cleaningIsOverdueFor,
          date: '20 дней',
          boldFont: true,
          cleaningIsOverdue: true,
        ),
      CleaningStatuses.cleaningIsExpected => _CleaningDateInfo(
          title: t.equipments.cleaningDate,
          date: 'Пн. 16.02, 12:00-16:00',
        ),
    };
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
          Text(title, style: textStyle),
          Text(date, style: textStyle),
        ],
      ),
    );
  }
}
