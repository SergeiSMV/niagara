import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/common/presentation/widgets/date_selection_widget/time_slot_widget.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

/// Виджет выбора промежутков времени
class ListTimeSlotsWidget extends StatelessWidget {
  const ListTimeSlotsWidget({
    super.key,
    required this.timeSlots,
  });

  final List<TimeSlot> timeSlots;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.timeSlotsHeight,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: timeSlots.length,
        padding: AppInsets.kHorizontal16,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: AppSizes.kGeneral8,
          crossAxisSpacing: AppSizes.kGeneral8,
          childAspectRatio: context.screenWidth / context.screenHeight / 1.8,
        ),
        itemBuilder: (context, index) {
          return TimeSlotWidget(
            title: '${timeSlots[index].timeBegin}-${timeSlots[index].timeEnd}',
          );
        },
      ),
    );
  }
}
