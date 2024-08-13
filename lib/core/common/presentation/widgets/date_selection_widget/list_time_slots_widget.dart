import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/common/presentation/bloc/time_slot_selection_cubit/time_slot_selection_cubit.dart';
import 'package:niagara_app/core/common/presentation/widgets/date_selection_widget/time_slot_widget.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

/// Виджет выбора промежутков времени
class ListTimeSlotsWidget extends StatelessWidget {
  const ListTimeSlotsWidget({
    super.key,
    required this.timeSlots,
    required this.onValueChanged,
  });

  /// [onValueChanged] - возвращает выбранный промежуток времени [TimeSlot]
  final Function(TimeSlot) onValueChanged;

  /// [timeSlots] - список промежутков времени
  final List<TimeSlot> timeSlots;

  /// [_selectTimeSlot] - метод выбора промежутка времени
  void _selectTimeSlot(
    BuildContext context,
    String timeSlotTitle,
    TimeSlot timeSlot,
  ) {
    context.read<TimeSlotSelectionCubit>().selectTimeSlot(timeSlotTitle);
    onValueChanged(timeSlot);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TimeSlotSelectionCubit>(),
      child: BlocBuilder<TimeSlotSelectionCubit, TimeSlotSelectionState>(
        builder: (context, state) {
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
                childAspectRatio:
                    context.screenWidth / context.screenHeight / 1.8,
              ),
              itemBuilder: (context, index) {
                final timeSlotTitle =
                    '${timeSlots[index].timeBegin}-${timeSlots[index].timeEnd}';

                return TimeSlotWidget(
                  title: timeSlotTitle,
                  onTap: () => _selectTimeSlot(
                    context,
                    timeSlotTitle,
                    timeSlots[index],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
