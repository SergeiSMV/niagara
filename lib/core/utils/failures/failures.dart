// ignore_for_file: public_member_api_docs

part of '../../core.dart';

/// Класс [Failure] является базовым классом для всех ошибок, которые могут
/// возникнуть в приложении. Содержит описание ошибки (при наличии).
sealed class Failure with EquatableMixin implements Exception {
  /// Создает экземпляр [Failure].
  /// - [error] - описание ошибки.
  const Failure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}

// ! ------------------------------- Token ------------------------------- ! //

class TokenRepositoryFailure extends Failure {
  const TokenRepositoryFailure([super.error = 'Token repo failure']);
}

class GetTokenFailure extends Failure {
  const GetTokenFailure([super.error = 'Token fetching failure']);
}

class TokenNotFoundFailure extends Failure {
  const TokenNotFoundFailure([super.error = 'Token not found']);
}

// ! ----------------------------- Device ID ----------------------------- ! //
class DeviceIdFailure extends Failure {
  const DeviceIdFailure([super.error = 'Device ID failure']);
}

// ! -------------------------------- Auth ------------------------------- ! //

class AuthRepositoryFailure extends Failure {
  const AuthRepositoryFailure([super.error = 'Auth repo failure']);
}

class CreateCodeFailure extends Failure {
  const CreateCodeFailure([super.error = 'Invalid phone number']);
}

class ValidateCodeFailure extends Failure {
  const ValidateCodeFailure([super.error = 'Invalid auth code']);
}

class CheckAuthStatusFailure extends Failure {
  const CheckAuthStatusFailure([super.error = 'Auth status failure']);
}

class ResendCodeFailure extends Failure {
  const ResendCodeFailure([super.error = 'Resend code failure']);
}

class SkipAuthFailure extends Failure {
  const SkipAuthFailure([super.error = 'Skip auth failure']);
}

class PhoneNotFoundFailure extends Failure {
  const PhoneNotFoundFailure([super.error = 'Phone not found']);
}

// ! -------------------------------- City -------------------------------- ! //

class CitiesRepositoryFailure extends Failure {
  const CitiesRepositoryFailure([super.error = 'Cities repo failure']);
}

class CitiesLocalDataFailure extends Failure {
  const CitiesLocalDataFailure([super.error = 'City local data failure']);
}

class CitiesRemoteDataFailure extends Failure {
  const CitiesRemoteDataFailure([super.error = 'City remote data failure']);
}

// ! ------------------------------ Location ------------------------------ ! //

class ServiceNotEnabledException extends Failure {
  const ServiceNotEnabledException([super.error = 'Location service failure']);
}

class LocationDataFailure extends Failure {
  const LocationDataFailure([super.error = 'Location data failure']);
}

class GeocoderRepositoryFailure extends Failure {
  const GeocoderRepositoryFailure([super.error = 'Geocoder repo failure']);
}

class AddressDataFailure extends Failure {
  const AddressDataFailure([super.error = 'Address data failure']);
}

class SearchAddressFailure extends Failure {
  const SearchAddressFailure([super.error = 'Search address failure']);
}

class LocationsLocalDataFailure extends Failure {
  const LocationsLocalDataFailure([
    super.error = 'Locations local data failure',
  ]);
}

class LocationsRepositoryFailure extends Failure {
  const LocationsRepositoryFailure([
    super.error = 'Locations repository failure',
  ]);
}

class LocationsRemoteDataFailure extends Failure {
  const LocationsRemoteDataFailure([
    super.error = 'Locations remote data failure',
  ]);
}

// ! ------------------------------- Shops ------------------------------- ! //
class ShopsRepositoryFailure extends Failure {
  const ShopsRepositoryFailure([super.error = 'Shops repo failure']);
}
