part of 'address_selection_cubit.dart';

@freezed
class AddressSelectionState with _$AddressSelectionState {
  const factory AddressSelectionState.initial() = _Initial;

  const factory AddressSelectionState.searching() = _Searching;

  const factory AddressSelectionState.complete({
    required Location location,
  }) = _Complete;

  const factory AddressSelectionState.approve({
    required Location location,
  }) = _Approve;

  const factory AddressSelectionState.denied() = _Denied;

  const factory AddressSelectionState.noAddressFound() = _NoAddressFound;
}
