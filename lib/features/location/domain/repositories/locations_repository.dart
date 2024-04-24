import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/entities/locality.dart';

abstract interface class ILocationsRepository {
  /// Получает все адреса доставки
  Future<Either<Failure, List<Location>>> getLocations();

  /// Добавляет адрес доставки.
  Future<Either<Failure, void>> addLocation(Location location);

  /// Обновляет адрес доставки.
  Future<Either<Failure, void>> updateLocation(Location location);

  /// Удаляет адрес доставки.
  Future<Either<Failure, void>> deleteLocation(Location location);
}
