import 'package:collection/collection.dart';

import '../../../../../core/core.dart';
import '../../../../../core/utils/enums/auth_status.dart';
import '../../../../profile/user/data/local/data_source/user_local_data_source.dart';
import '../../domain/models/address.dart';
import '../../domain/repositories/address_repository.dart';
import '../local/data_source/addresses_local_data_source.dart';
import '../mappers/address_dto_mapper.dart';
import '../mappers/address_entity_mapper.dart';
import '../remote/data_source/addresses_remote_data_source.dart';
import '../remote/dto/address_dto.dart';

/// Репозиторий адресов
@LazySingleton(as: IAddressRepository)
class AddressesRepository extends BaseRepository implements IAddressRepository {
  AddressesRepository(
    super._logger,
    super._networkInfo,
    this._authLDS,
    this._addressesLDS,
    this._addressesRDS,
    this._userLDS,
  );

  /// Локальные источники данных (для доступа к данным из БД)
  final IAuthLocalDataSource _authLDS;

  /// Локальные источники данных адресов
  final IAddressesLocalDatasource _addressesLDS;

  /// Удаленные источники данных адресов
  final IAddressesRemoteDatasource _addressesRDS;

  /// Локальные источники данных пользователя
  final IUserLocalDataSource _userLDS;

  /// Ошибка репозитория
  @override
  Failure get failure => const AddressesRepositoryFailure();

  /// Получить адреса
  @override
  Future<Either<Failure, List<Address>>> getAddresses() => execute(
        () async {
          final hasAuth = await _authLDS
              .checkAuthStatus()
              .then((value) => AuthenticatedStatus.values[value].hasAuth);

          if (!hasAuth) return [];

          final localAddresses = await _getLocalAddresses();
          // if (localAddresses.isNotEmpty) return localAddresses;

          final remoteAddresses = await _getRemoteAddresses();

          if (remoteAddresses.isNotEmpty) {
            /// Получаем дефолтный адрес из локальной БД
            final defaultAddress =
                localAddresses.firstWhereOrNull((address) => address.isDefault);
            final addressEntities = remoteAddresses
                .mapIndexed((index, dto) => dto.toEntity(id: index + 1))
                .toList();
            await _addressesLDS.saveAddresses(addressEntities);

            if (defaultAddress != null) {
              await _addressesLDS.updateAddress(
                defaultAddress.toEntity(isDefault: true),
              );
            }

            final savedAddresses = await _getLocalAddresses();

            if (!savedAddresses.any((address) => address.isDefault)) {
              await _addressesLDS.updateAddress(
                savedAddresses.first.toEntity(isDefault: true),
              );
            }
            return _getLocalAddresses();
          }

          return [];
        },
      );

  /// Добавить адрес
  @override
  Future<Either<Failure, void>> addAddress(Address address) =>
      execute(() async {
        // Получить телефон пользователя из локального источника данных
        final phone = await _getUserPhone();
        if (phone == null) throw const AddressesRepositoryFailure();

        // Добавить местоположение в удаленный источник данных и локальную БД
        await _addAddress(address, phone);

        // Обновить дефолтный адрес
        await _updateDefaultAddress(address);
      });

  /// Обновить адрес
  @override
  Future<Either<Failure, void>> updateAddress(Address address) =>
      execute(() async => _updateAddress(address));

  /// Удалить адрес
  @override
  Future<Either<Failure, void>> deleteAddress(Address address) =>
      execute(() async => _deleteLocation(address));

  /// Установить адрес по умолчанию
  @override
  Future<Either<Failure, void>> setDefaultAddress(Address address) =>
      execute(() async => _updateDefaultAddress(address));

  /// Получить адрес по умолчанию
  @override
  Future<Either<Failure, Address?>> getDefaultAddress() async =>
      execute(() async {
        final addresses = await _getLocalAddresses();
        Address? defaultAddress =
            addresses.firstWhereOrNull((address) => address.isDefault);

        // Если не нашлось адреса в локальной БД, делаем запрос в сеть
        // (иногда этот метод может вызываться до того, как адреса загрузились).
        return defaultAddress ??= await getAddresses().fold(
          (failure) => null,
          (addresses) =>
              addresses.firstWhereOrNull((address) => address.isDefault),
        );
      });

  /// Проверить возможность доставки по адресу
  @override
  Future<Either<Failure, bool>> checkDelivery(Address address) async =>
      _addressesRDS
          .checkAddress(address: address.toDto())
          .fold((failure) => throw failure, Right.new);

  /// Получить телефон пользователя
  Future<String?> _getUserPhone() async => _userLDS.getUser().fold(
        (failure) => throw failure,
        (user) => user?.phone,
      );

  /// Получить адреса из локального источника данных
  Future<List<Address>> _getLocalAddresses() async =>
      _addressesLDS.getAddresses().fold(
            (failure) => throw failure,
            (entities) => entities.map((entity) => entity.toModel()).toList(),
          );

  /// Получить адреса из удаленного источника данных
  Future<List<AddressDto>> _getRemoteAddresses() async =>
      _addressesRDS.getAddresses().fold(
            (failure) => throw failure,
            (address) => address,
          );

  /// Добавить адрес в удаленный источник данных и локальную БД
  Future<void> _addAddress(Address address, String phone) async =>
      _addressesRDS.addAddress(address: address.toDto(), phone: phone).fold(
            (failure) => throw AddressesRepositoryFailure(failure.error),
            (locationId) => null,

            /*
            async => _addressesLDS.addAddress(
              address.toEntity(
                isDefault: true,
                locationId: locationId,
              ),
            ),
            */
          );

  /// Обновить адрес в удаленном источнике данных и локальной БД
  Future<void> _updateAddress(Address address) async =>
      _addressesRDS.updateAddress(address: address.toDto()).fold(
        (failure) => throw AddressesRepositoryFailure(failure.error),
        (locationId) async {
          await _addressesLDS.updateAddress(address.toEntity());
        },
      );

  /// Удалить адрес из удаленного источника данных и локальной БД
  Future<void> _deleteLocation(Address address) async =>
      _addressesRDS.deleteAddress(address: address.toDto()).fold(
        (failure) => throw AddressesRepositoryFailure(failure.error),
        (success) async {
          if (!success) throw const AddressesRepositoryFailure();
          await _addressesLDS.deleteAddress(address.toEntity());
        },
      );

  /// Обновить адрес по умолчанию
  Future<void> _updateDefaultAddress(Address address) async {
    final addresses = await _getLocalAddresses();
    for (final adr in addresses) {
      if (adr.isDefault) {
        await _addressesLDS.updateAddress(adr.toEntity(isDefault: false));
      }

      if (adr.id == address.id) {
        await _addressesLDS.updateAddress(adr.toEntity(isDefault: true));
      }
    }
  }
}
