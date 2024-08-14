import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'time_slot_selection_state.dart';
part 'time_slot_selection_cubit.freezed.dart';

@injectable
class TimeSlotSelectionCubit extends Cubit<TimeSlotSelectionState> {
  TimeSlotSelectionCubit()
      : super(const TimeSlotSelectionState.selected(timeSlot: ''));

  String selectedTimeSlotId = '';

  void selectTimeSlot(String timeSlot) {
    selectedTimeSlotId = timeSlot;
    emit(TimeSlotSelectionState.selected(timeSlot: timeSlot));
  }
}
