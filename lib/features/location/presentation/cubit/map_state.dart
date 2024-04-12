part of 'map_cubit.dart';

@freezed
class MapState with _$MapState {
  const factory MapState.initial() = _MapInitialState;
  const factory MapState.complete() = _MapCompleteState;
}
