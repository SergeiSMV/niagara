part of 'search_address_bloc.dart';

@freezed
class SearchAddressState with _$SearchAddressState {
  const factory SearchAddressState.initial() = _Initial;

  const factory SearchAddressState.loading() = _Loading;

  const factory SearchAddressState.loaded(List<Address> searchAddresses) =
      _Loaded;

  const factory SearchAddressState.error() = _Error;
}
