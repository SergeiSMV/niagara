import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';

abstract interface class IAddressRepository {
  /// Получает все адреса доставки
  Future<Either<Failure, List<Address>>> getAddresses();

  /// Добавляет адрес доставки.
  Future<Either<Failure, void>> addAddress(Address address);

  /// Обновляет адрес доставки.
  Future<Either<Failure, void>> updateAddress(Address address);

  /// Удаляет адрес доставки.
  Future<Either<Failure, void>> deleteAddress(Address address);

  /// Устанавливает адрес по умолчанию.
  Future<Either<Failure, void>> setDefaultAddress(Address address);

  /// Проверка на возможность доставки в указанный адрес.
  Future<Either<Failure, bool>> checkDelivery(Address address);
}
