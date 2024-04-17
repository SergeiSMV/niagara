part of 'address_selection_cubit.dart';

@freezed
class AddressSelectionState with _$AddressSelectionState {
  const factory AddressSelectionState.initial() = _Initial;

  const factory AddressSelectionState.searching() = _Searching;

  const factory AddressSelectionState.complete({
    required String address,
  }) = _Complete;

  const factory AddressSelectionState.approve({
    required String address,
    @Default('') String flat,
    @Default('') String entrance,
    @Default('') String floor,
    @Default('') String comment,
  }) = _Approve;

  const factory AddressSelectionState.denied() = _Denied;
}
