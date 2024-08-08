part of 'get_time_slots_cubit.dart';

@freezed
class GetTimeSlotsState with _$GetTimeSlotsState {
  const factory GetTimeSlotsState.loading() = _Loading;

  const factory GetTimeSlotsState.error() = _Error;

  const factory GetTimeSlotsState.empty() = _Empty;

  const factory GetTimeSlotsState.loaded(List<TimeSlot> timeSlots) = _Loaded;
}
