import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';

abstract interface class IGeocoderRepository {
  /// Получает адрес по координатам.
  ///
  /// - [latitude] - широта.
  /// - [longitude] - долгота.
  ///
  /// Возвращает:
  /// - [String] если адрес был получен.
  /// - [Failure] если адрес не был получен.
  Future<Either<Failure, Location>> getAddressByCoordinates({
    required double latitude,
    required double longitude,
  });

  /// Получает список адресов по запросу.
  ///
  /// - [query] - запрос.
  ///
  /// Возвращает:
  /// - [List<String>] если адреса были получены.
  /// - [Failure] если адреса не были получены.
  Future<Either<Failure, List<Location>>> getAddressesByQuery({
    required String query,
  });
}
