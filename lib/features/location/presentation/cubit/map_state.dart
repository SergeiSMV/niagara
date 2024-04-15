part of 'map_cubit.dart';

@freezed
class MapState with _$MapState {
  const factory MapState.initial() = _MapInitialState;

  const factory MapState.searching() = _MapSearchingState;

  const factory MapState.complete({
    required String address,
  }) = _MapCompleteState;

  const factory MapState.approve({
    required String address,
    String? flat,
    String? entrance,
    String? floor,
    String? comment,
  }) = _MapApproveState;
}
