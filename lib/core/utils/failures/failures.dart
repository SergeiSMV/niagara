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

// ! ------------------------------- Base ------------------------------- ! //

class NoInternetFailure extends Failure {
  const NoInternetFailure([super.error = 'No internet connection']);
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

class AddressesLocalDataFailure extends Failure {
  const AddressesLocalDataFailure([
    super.error = 'Locations local data failure',
  ]);
}

class AddressesRepositoryFailure extends Failure {
  const AddressesRepositoryFailure([
    super.error = 'Locations repository failure',
  ]);
}

class AddressesRemoteDataFailure extends Failure {
  const AddressesRemoteDataFailure([
    super.error = 'Locations remote data failure',
  ]);
}

// ! ------------------------------- Shops ------------------------------- ! //
class ShopsRepositoryFailure extends Failure {
  const ShopsRepositoryFailure([super.error = 'Shops repo failure']);
}

class ShopsLocalDataFailure extends Failure {
  const ShopsLocalDataFailure([super.error = 'Shops local data failure']);
}

class ShopsRemoteDataFailure extends Failure {
  const ShopsRemoteDataFailure([super.error = 'Shops remote data failure']);
}

// ! ------------------------------ Profile ------------------------------ ! //

class ProfileRepositoryFailure extends Failure {
  const ProfileRepositoryFailure([super.error = 'Profile repo failure']);
}

class ProfileRemoteDataFailure extends Failure {
  const ProfileRemoteDataFailure([super.error = 'Profile remote data failure']);
}

class UserLocalDataFailure extends Failure {
  const UserLocalDataFailure([super.error = 'User local data failure']);
}

class BonusesLocalDataFailure extends Failure {
  const BonusesLocalDataFailure([super.error = 'Bonuses local data failure']);
}

class BonusesRepositoryFailure extends Failure {
  const BonusesRepositoryFailure([super.error = 'Bonuses repo data failure']);
}

// ! --------------------------- Bonus Program --------------------------- ! //

class BonusProgramRepositoryFailure extends Failure {
  const BonusProgramRepositoryFailure([
    super.error = 'Bonus program repo failure',
  ]);
}

class BonusProgramLocalDataFailure extends Failure {
  const BonusProgramLocalDataFailure([
    super.error = 'Bonus program local data failure',
  ]);
}

class BonusProgramRemoteDataFailure extends Failure {
  const BonusProgramRemoteDataFailure([
    super.error = 'Bonus program remote data failure',
  ]);
}

// ! ---------------------------- Promotions ------------------------------ ! //

class PromotionsRepositoryFailure extends Failure {
  const PromotionsRepositoryFailure([
    super.error = 'Promotions repo failure',
  ]);
}

class PromotionsRemoteDataFailure extends Failure {
  const PromotionsRemoteDataFailure([
    super.error = 'Promotions remote data failure',
  ]);
}

// ! ------------------------------ Groups -------------------------------- ! //

class GroupsRepositoryFailure extends Failure {
  const GroupsRepositoryFailure([super.error = 'Groups repo failure']);
}

class GroupsLocalDataFailure extends Failure {
  const GroupsLocalDataFailure([super.error = 'Groups local data failure']);
}

class GroupsRemoteDataFailure extends Failure {
  const GroupsRemoteDataFailure([super.error = 'Groups remote data failure']);
}

// ! ----------------------------- Favorites ------------------------------ ! //

class FavoritesRepositoryFailure extends Failure {
  const FavoritesRepositoryFailure([super.error = 'Favorites repo failure']);
}

class FavoritesLocalDataFailure extends Failure {
  const FavoritesLocalDataFailure([
    super.error = 'Favorites local data failure',
  ]);
}

class FavoritesRemoteDataFailure extends Failure {
  const FavoritesRemoteDataFailure([
    super.error = 'Favorites remote data failure',
  ]);
}

// ! --------------------------- Notifications ---------------------------- ! //

class NotificationsRepositoryFailure extends Failure {
  const NotificationsRepositoryFailure([
    super.error = 'Notifications repo failure',
  ]);
}

class NotificationsRemoteDataFailure extends Failure {
  const NotificationsRemoteDataFailure([
    super.error = 'Notifications remote data failure',
  ]);
}

// ! -------------------------------- Cart ------------------------------- ! //

class CartRepositoryFailure extends Failure {
  const CartRepositoryFailure([super.error = 'Cart repo failure']);
}

class CartLocalDataFailure extends Failure {
  const CartLocalDataFailure([super.error = 'Cart local data failure']);
}

class CartRemoteDataFailure extends Failure {
  const CartRemoteDataFailure([super.error = 'Cart remote data failure']);
}

// ! ---------------------------- New products ---------------------------- ! //
class NewProductsDataFailure extends Failure {
  const NewProductsDataFailure([super.error = 'New products data failure']);
}

class NewProductsRepositoryFailure extends Failure {
  const NewProductsRepositoryFailure([
    super.error = 'New products repo failure',
  ]);
}
