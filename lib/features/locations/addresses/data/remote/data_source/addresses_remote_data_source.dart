import '../../../../../../core/core.dart';
import '../dto/address_dto.dart';

/// Интерфейс для работы с адресами в удаленном источнике данных.
abstract interface class IAddressesRemoteDatasource {
  Future<Either<Failure, List<AddressDto>>> getAddresses();

  /// Добавить адрес
  Future<Either<Failure, String>> addAddress({
    required AddressDto address,
    required String phone,
  });

  /// Обновить адрес
  Future<Either<Failure, String>> updateAddress({
    required AddressDto address,
  });

  /// Удалить адрес
  Future<Either<Failure, bool>> deleteAddress({
    required AddressDto address,
  });

  /// Проверить возможность доставки по адресу
  Future<Either<Failure, bool>> checkAddress({
    required AddressDto address,
  });
}

/// Источник данных адресов в удаленном источнике данных
@LazySingleton(as: IAddressesRemoteDatasource)
class AddressesRemoteDatasource implements IAddressesRemoteDatasource {
  AddressesRemoteDatasource(this._requestHandler);

  /// Обработчик запросов
  final RequestHandler _requestHandler;

  /// Получить адреса
  @override
  Future<Either<Failure, List<AddressDto>>> getAddresses() =>
      _requestHandler.sendRequest<List<AddressDto>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetLocations,
        ),
        converter: (json) => json
            .map((e) => e as Map<String, dynamic>)
            .toList()
            .map(AddressDto.fromJson)
            .toList(),
        failure: AddressesRemoteDataFailure.new,
      );

  /// Добавить адрес
  @override
  Future<Either<Failure, String>> addAddress({
    required AddressDto address,
    required String phone,
  }) async =>
      _requestHandler.sendRequest<String, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kAddLocation,
          data: {
            ...address.toJson(),
            // ? Для добавления нового адреса нужен номер телефона/логин
            'PHONE': phone,
          },
        ),
        converter: (json) {
          if (json['success'] == false) {
            throw AddressesRemoteDataFailure(json['error'] as String);
          }
          return json['id'] as String;
        },
        failure: AddressesRemoteDataFailure.new,
      );

  /// Обновить адрес
  @override
  Future<Either<Failure, String>> updateAddress({
    required AddressDto address,
  }) async =>
      _requestHandler.sendRequest<String, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kUpdateLocation,
          data: address.toJson(),
        ),
        converter: (json) {
          if (json['success'] == false) {
            throw AddressesRemoteDataFailure(json['error'] as String);
          }
          return json['id'] as String;
        },
        failure: AddressesRemoteDataFailure.new,
      );

  /// Удалить адрес
  @override
  Future<Either<Failure, bool>> deleteAddress({
    required AddressDto address,
  }) async =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.delete(
          ApiConst.kDeleteLocation,
          data: {
            'LOCATION_ID': address.locationId,
          },
        ),
        converter: (json) => json['success'] as bool,
        failure: AddressesRemoteDataFailure.new,
      );

  /// Проверить возможность доставки по адресу
  @override
  Future<Either<Failure, bool>> checkAddress({
    required AddressDto address,
  }) async =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kCheckLocation,
          data: {
            'CITY': address.city,
            'LAT': address.latitude,
            'LON': address.longitude,
          },
        ),
        converter: (json) => json['result'] as bool,
        failure: AddressesRemoteDataFailure.new,
      );
}
