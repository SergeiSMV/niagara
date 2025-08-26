import '../../../../../../core/core.dart';
import '../../mappers/address_entity_mapper.dart';
import '../entities/addresses_entity.dart';

/// Интерфейс для работы с адресами в локальной базе данных.
abstract interface class IAddressesLocalDatasource {
  Future<Either<Failure, List<AddressEntity>>> getAddresses();

  Future<Either<Failure, void>> saveAddresses(List<AddressEntity> locations);

  Future<Either<Failure, void>> addAddress(AddressEntity location);

  Future<Either<Failure, void>> updateAddress(AddressEntity location);

  Future<Either<Failure, void>> deleteAddress(AddressEntity location);
}

@LazySingleton(as: IAddressesLocalDatasource)
class AddressesLocalDatasource implements IAddressesLocalDatasource {
  AddressesLocalDatasource(this._database);

  final AppDatabase _database;

  @override
  Future<Either<Failure, List<AddressEntity>>> getAddresses() => _execute(
        () async => (await _database.allAddresses.getAddresses())
            .map((table) => table.toEntity())
            .toList(),
      );

  @override
  Future<Either<Failure, void>> saveAddresses(List<AddressEntity> locations) =>
      _execute(
        () => _database.allAddresses.insertAddresses(
          locations.map((entity) => entity.toCompanion()).toList(),
        ),
      );

  @override
  Future<Either<Failure, void>> addAddress(AddressEntity location) => _execute(
        () => _database.allAddresses.insertAddress(location.toCompanion()),
      );

  @override
  Future<Either<Failure, void>> updateAddress(AddressEntity location) =>
      _execute(
        () => _database.allAddresses.updateAddress(location.toCompanion()),
      );

  @override
  Future<Either<Failure, void>> deleteAddress(AddressEntity location) =>
      _execute(
        () => _database.allAddresses.deleteAddress(location.toCompanion()),
      );

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } on Failure catch (e) {
      return Left(AddressesLocalDataFailure(e.toString()));
    }
  }
}
