import 'package:either_dart/either.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/entities/location.dart';

abstract interface class ILocationRepository {
  /// Получает список городов и магазинов.
  ///
  /// Возвращает список городов в виде списка [Location].
  Future<Either<Failure, List<Location>>> getCities();

  /// Выбирает город.
  /// 
  /// [location] - выбранный город.
  Future<Either<Failure, void>> setCity(Location location);

  /// Получает выбранный город.
  /// 
  /// Возвращает выбранный город в виде [Location].
  Future<Either<Failure, Location>> getCity();

}
