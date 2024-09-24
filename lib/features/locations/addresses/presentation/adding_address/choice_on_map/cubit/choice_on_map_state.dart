part of 'choice_on_map_cubit.dart';

@freezed
class ChoiceOnMapState with _$ChoiceOnMapState {
  const ChoiceOnMapState._();

  const factory ChoiceOnMapState.initial() = _Initial;

  const factory ChoiceOnMapState.complete({
    required Address address,
  }) = _Complete;

  const factory ChoiceOnMapState.noDelivery({
    required Address address,
  }) = _NoDelivery;

  const factory ChoiceOnMapState.approve({
    required Address address,
  }) = _Approve;

  const factory ChoiceOnMapState.denied() = _Denied;

  const factory ChoiceOnMapState.noAddressFound() = _NoAddressFound;

  bool get availableToAddendum => maybeWhen(
        complete: (address) => address.hasHouse,
        orElse: () => false,
      );
}
