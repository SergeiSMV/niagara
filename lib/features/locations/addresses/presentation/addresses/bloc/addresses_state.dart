part of 'addresses_bloc.dart';

@freezed
class AddressesState with _$AddressesState {
  const AddressesState._();
  const factory AddressesState.initial() = _Initial;

  const factory AddressesState.loading() = _Loading;

  const factory AddressesState.loaded({
    required City city,
    required List<Address> address,
  }) = _Loaded;

  const factory AddressesState.error({
    City? city,
  }) = _Error;

  const factory AddressesState.unauthorized({
    required City city,
  }) = _Unauthorized;

  String get cityFullName => maybeWhen(
        loaded: (city, _) => '${city.locality}, ${city.province}',
        orElse: () => '',
      );

  String get locationName => maybeWhen(
        loaded: (city, addresses) {
          final primaryLocation = addresses.firstWhereOrNull(
            (address) => address.isDefault,
          );

          return (primaryLocation ?? city).name;
        },
        unauthorized: (city) => city.name,
        orElse: () => '',
      );

  String get phone => maybeWhen(
        loaded: (city, _) => city.phone,
        unauthorized: (city) => city.phone,
        orElse: () => '',
      );
}
