part of 'address_selection_cubit.dart';

@freezed
class AddressSelectionState with _$AddressSelectionState {
  const factory AddressSelectionState.initial() = _AddressSelectionInitialState;

  const factory AddressSelectionState.searching() =
      _AddressSelectionSearchingState;

  const factory AddressSelectionState.complete({
    required String address,
  }) = _AddressSelectionCompleteState;

  const factory AddressSelectionState.approve({
    required String address,
    @Default('') String flat,
    @Default('') String entrance,
    @Default('') String floor,
    @Default('') String comment,
  }) = _AddressSelectionApproveState;

  const factory AddressSelectionState.denied() = _AddressSelectionDeniedState;
}
