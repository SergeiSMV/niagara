import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';

abstract interface class IGeocoderRepository {
  /// Получает адрес по координатам.
  ///
  /// - [latitude] - широта.
  /// - [longitude] - долгота.
  ///
  /// Возвращает:
  /// - [String] если адрес был получен.
  /// - [Failure] если адрес не был получен.
  Future<Either<Failure, Address>> getAddressByCoordinates({
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
  Future<Either<Failure, List<Address>>> getAddressesByQuery({
    required String query,
  });
}
