// ignore_for_file: one_member_abstracts

import 'package:either_dart/either.dart';
import 'package:niagara_app/core/core.dart';

abstract interface class IGeocoderRepository {
  /// Получает адрес по координатам.
  ///
  /// - [latitude] - широта.
  /// - [longitude] - долгота.
  ///
  /// Возвращает:
  /// - [String] если адрес был получен.
  /// - [Failure] если адрес не был получен.
  Future<Either<Failure, String>> getAddressByCoordinates({
    required double latitude,
    required double longitude,
  });
}
