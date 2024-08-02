import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/common/presentation/widgets/date_selection_widget/date_selection_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/date_selection_widget/list_time_slots_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class SelectDateWidget extends StatelessWidget {
  const SelectDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // timeSlots - mock data
    const List<TimeSlot> timeSlots = [
      TimeSlot(
        timeBegin: '8:00',
        timeEnd: '9:00',
      ),
      TimeSlot(
        timeBegin: '10:00',
        timeEnd: '11:00',
      ),
      TimeSlot(
        timeBegin: '12:00',
        timeEnd: '13:00',
      ),
      TimeSlot(
        timeBegin: '14:00',
        timeEnd: '15:00',
      ),
      TimeSlot(
        timeBegin: '8:00',
        timeEnd: '9:00',
      ),
      TimeSlot(
        timeBegin: '10:00',
        timeEnd: '11:00',
      ),
      TimeSlot(
        timeBegin: '12:00',
        timeEnd: '13:00',
      ),
      TimeSlot(
        timeBegin: '14:00',
        timeEnd: '15:00',
      ),
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: AppInsets.kVertical16 + AppInsets.kTop8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppInsets.kHorizontal16,
              child: Text(
                t.equipments.selectCleaningDate,
                style: context.textStyle.textTypo.tx1SemiBold
                    .withColor(context.colors.textColors.main),
              ),
            ),
            AppBoxes.kHeight12,
            const DateSelectionWidget(
              firstDate: 'Сегодня',
              secondDate: 'Завтра',
            ),
            AppBoxes.kHeight16,
            const ListTimeSlotsWidget(timeSlots: timeSlots),
          ],
        ),
      ),
    );
  }
}
