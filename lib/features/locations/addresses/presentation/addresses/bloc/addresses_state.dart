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

  /// Возвращает полное название адреса по умолчанию для авторизованного
  /// пользователя.
  String? get fullLocationName => whenOrNull(
        loaded: (_, addresses) {
          final location = defaultLocation;
          if (location == null) return null;

          return '${location.name}, ${location.additional}';
        },
      );

  /// Возвращает адрес по умолчанию для авторизованного пользователя.
  Address? get defaultLocation => maybeWhen(
        loaded: (_, addresses) => addresses.firstWhereOrNull(
          (address) => address.isDefault,
        ),
        orElse: () => null,
      );

  /// Возвращает `true`, если пользователь авторизован и имеет выбранный адрес
  /// доставки.
  bool get hasLocation => defaultLocation?.name.isNotEmpty ?? false;

  /// Возвращает `true`, если у пользователя есть хотя бы один адрес, не
  /// обязательно выбранный.
  bool get hasAnyLocation => maybeWhen(
        loaded: (_, addresses) => addresses.isNotEmpty,
        orElse: () => false,
      );

  /// Возвращает телефон, связанный с городом адреса.
  String get phone => maybeWhen(
        loaded: (city, _) => city.phone,
        unauthorized: (city) => city.phone,
        orElse: () => '',
      );
}
