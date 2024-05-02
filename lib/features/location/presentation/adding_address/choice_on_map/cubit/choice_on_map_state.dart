part of 'choice_on_map_cubit.dart';

@freezed
class ChoiceOnMapState with _$ChoiceOnMapState {
  const factory ChoiceOnMapState.initial() = _Initial;

  const factory ChoiceOnMapState.complete({
    required Location location,
  }) = _Complete;

  const factory ChoiceOnMapState.approve({
    required Location location,
  }) = _Approve;

  const factory ChoiceOnMapState.denied() = _Denied;

  const factory ChoiceOnMapState.noAddressFound() = _NoAddressFound;
}
