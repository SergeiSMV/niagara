import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/core/utils/extensions/iterable_ext.dart';
import 'package:niagara_app/features/authorization/phone_auth/data/data_sources/auth_local_data_source.dart';
import 'package:niagara_app/features/locations/addresses/data/local/data_source/addresses_local_data_source.dart';
import 'package:niagara_app/features/locations/addresses/data/mappers/address_dto_mapper.dart';
import 'package:niagara_app/features/locations/addresses/data/mappers/address_entity_mapper.dart';
import 'package:niagara_app/features/locations/addresses/data/remote/data_source/addresses_remote_data_source.dart';
import 'package:niagara_app/features/locations/addresses/data/remote/dto/address_dto.dart';

import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:niagara_app/features/locations/addresses/domain/repositories/address_repository.dart';
import 'package:niagara_app/features/profile/user/data/local/data_source/user_local_data_source.dart';
import 'package:talker_flutter/talker_flutter.dart';

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

  final IAuthLocalDataSource _authLDS;
  final IAddressesLocalDatasource _addressesLDS;
  final IAddressesRemoteDatasource _addressesRDS;
  final IUserLocalDataSource _userLDS;

  @override
  Failure get failure => const AddressesRepositoryFailure();

  @override
  Future<Either<Failure, List<Address>>> getAddresses() => execute(
        () async {
          final hasAuth = await _authLDS
              .checkAuthStatus()
              .then((value) => AuthenticatedStatus.values[value].hasAuth);

          if (!hasAuth) return [];

          final localAddresses = await _getLocalAddresses();
          if (localAddresses.isNotEmpty) return localAddresses;

          final remoteAddresses = await _getRemoteAddresses();

          if (remoteAddresses.isNotEmpty) {
            final addressEntities = remoteAddresses
                .mapIndexed((index, dto) => dto.toEntity(id: index + 1))
                .toList();
            await _addressesLDS.saveAddresses(addressEntities);

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

  @override
  Future<Either<Failure, void>> updateAddress(Address address) =>
      execute(() async => _updateAddress(address));

  @override
  Future<Either<Failure, void>> deleteAddress(Address address) =>
      execute(() async => _deleteLocation(address));

  @override
  Future<Either<Failure, void>> setDefaultAddress(Address address) =>
      execute(() async => _updateDefaultAddress(address));

  @override
  Future<Either<Failure, Address>> getDefaultAddress() async =>
      execute(() async {
        final addresses = await _getLocalAddresses();
        final defaultAddress =
            addresses.firstWhereOrNull((address) => address.isDefault);
        if (defaultAddress == null) throw failure;

        return defaultAddress;
      });

  @override
  Future<Either<Failure, bool>> checkDelivery(Address address) async =>
      _addressesRDS
          .checkAddress(address: address.toDto())
          .fold((failure) => throw failure, Right.new);

  Future<String?> _getUserPhone() async => _userLDS.getUser().fold(
        (failure) => throw failure,
        (user) => user?.phone,
      );

  Future<List<Address>> _getLocalAddresses() async =>
      _addressesLDS.getAddresses().fold(
            (failure) => throw failure,
            (entities) => entities.map((entity) => entity.toModel()).toList(),
          );

  Future<List<AddressDto>> _getRemoteAddresses() async =>
      _addressesRDS.getAddresses().fold(
            (failure) => throw failure,
            (address) => address,
          );

  Future<void> _addAddress(Address address, String phone) async =>
      _addressesRDS.addAddress(address: address.toDto(), phone: phone).fold(
            (failure) => throw failure,
            (locationId) async => _addressesLDS.addAddress(
              address.toEntity(
                isDefault: true,
                locationId: locationId,
              ),
            ),
          );

  Future<void> _updateAddress(Address address) async =>
      _addressesRDS.updateAddress(address: address.toDto()).fold(
        (failure) => throw failure,
        (locationId) async {
          await _addressesLDS.updateAddress(address.toEntity());
        },
      );

  Future<void> _deleteLocation(Address address) async =>
      _addressesRDS.deleteAddress(address: address.toDto()).fold(
        (failure) => throw failure,
        (success) async {
          if (!success) throw const AddressesRepositoryFailure();
          await _addressesLDS.deleteAddress(address.toEntity());
        },
      );

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
