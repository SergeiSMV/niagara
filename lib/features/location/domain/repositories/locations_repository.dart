import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';

abstract interface class ILocationsRepository {
  /// Получает все адреса доставки
  Future<Either<Failure, List<Location>>> getLocations();

  /// Добавляет адрес доставки.
  Future<Either<Failure, void>> addLocation(Location location);

  /// Обновляет адрес доставки.
  Future<Either<Failure, void>> updateLocation(Location location);

  /// Удаляет адрес доставки.
  Future<Either<Failure, void>> deleteLocation(Location location);

  /// Устанавливает адрес по умолчанию.
  Future<Either<Failure, void>> setDefaultLocation(Location location);
}
