part of 'addresses_bloc.dart';

@freezed
class AddressesEvent with _$AddressesEvent {
  const factory AddressesEvent.initial() = _InitialEvent;

  const factory AddressesEvent.loadAddresses() = _LoadAddressesEvent;

  const factory AddressesEvent.addAddress(
    Address address,
  ) = _AddAddressEvent;

  const factory AddressesEvent.updateAddress(
    Address address,
  ) = _UpdateAddressEvent;

  const factory AddressesEvent.deleteAddress(
    Address address,
  ) = _DeleteAddressEvent;

  const factory AddressesEvent.setDefaultAddress(
    Address address,
  ) = _SetDefaultAddressEvent;
}
