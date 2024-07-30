import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class TableCalendarWidget extends StatelessWidget {
  const TableCalendarWidget({
    super.key,
    required this.onValueChanged,
    required this.value,
  });

  final Function(List<DateTime>)? onValueChanged;
  final DateTime? value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyle = context.textStyle;

    return Container(
      margin: AppInsets.kHorizontal16,
      padding: AppInsets.kHorizontal12 + AppInsets.kVertical16,
      decoration: BoxDecoration(
        borderRadius: AppBorders.kCircular16,
        color: context.colors.mainColors.white,
      ),
      child: CalendarDatePicker2(
        value: [value],
        onValueChanged: onValueChanged,
        config: CalendarDatePicker2Config(
          calendarViewMode: CalendarDatePicker2Mode.day,
          // controlsHeight: 100,
          selectedDayHighlightColor: colors.mainColors.bgCard,
          disableModePicker: true,
          daySplashColor: colors.mainColors.bgCard,
          allowSameValueSelection: true,
          disableMonthPicker: false,
          hideMonthPickerDividers: true,
          dynamicCalendarRows: true,
          lastMonthIcon: Assets.icons.arrowLeft.svg(
            height: AppSizes.kIconLarge,
            width: AppSizes.kIconLarge,
          ),
          nextMonthIcon: Assets.icons.arrowRight.svg(
            height: AppSizes.kIconLarge,
            width: AppSizes.kIconLarge,
          ),
          weekdayLabelTextStyle:
              textStyle.captionTypo.c1.withColor(colors.textColors.secondary),
          controlsTextStyle:
              textStyle.headingTypo.h3.withColor(colors.textColors.main),
          dayTextStyle:
              textStyle.textTypo.tx1Medium.withColor(colors.textColors.main),
          selectedDayTextStyle: textStyle.textTypo.tx1SemiBold
              .withColor(colors.mainColors.primary),
          todayTextStyle:
              textStyle.textTypo.tx1Medium.withColor(colors.textColors.main),
        ),
      ),
    );
  }
}
