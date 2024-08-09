part of 'time_slot_selection_cubit.dart';

@freezed
class TimeSlotSelectionState with _$TimeSlotSelectionState {
  const factory TimeSlotSelectionState.selected({
    required String timeSlot,
  }) = _Selected;
}
