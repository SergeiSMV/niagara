import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/addresses/data/remote/dto/address_dto.dart';

/// Интерфейс для работы с адресами в удаленном источнике данных.
abstract interface class IAddressesRemoteDatasource {
  Future<Either<Failure, List<AddressDto>>> getAddresses();

  Future<Either<Failure, String>> addAddress({
    required AddressDto address,
    required String phone,
  });

  Future<Either<Failure, String>> updateAddress({
    required AddressDto address,
  });

  Future<Either<Failure, bool>> deleteAddress({
    required AddressDto address,
  });

  Future<Either<Failure, bool>> checkAddress({
    required AddressDto address,
  });
}

@LazySingleton(as: IAddressesRemoteDatasource)
class AddressesRemoteDatasource implements IAddressesRemoteDatasource {
  AddressesRemoteDatasource(this._requestHandler);

  final RequestHandler _requestHandler;

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

  @override
  Future<Either<Failure, String>> addAddress({
    required AddressDto address,
    required String phone,
  }) async {
    return _requestHandler.sendRequest<String, Map<String, dynamic>>(
      request: (dio) => dio.post(
        ApiConst.kAddLocation,
        data: {
          ...address.toJson(),
          // ? Для добавления нового адреса нужен номер телефона/логин
          'PHONE': phone,
        },
      ),
      converter: (json) {
        if (json['success'] == false) throw const AddressesRemoteDataFailure();
        return json['id'] as String;
      },
      failure: AddressesRemoteDataFailure.new,
    );
  }

  @override
  Future<Either<Failure, String>> updateAddress({
    required AddressDto address,
  }) async {
    return _requestHandler.sendRequest<String, Map<String, dynamic>>(
      request: (dio) => dio.post(
        ApiConst.kUpdateLocation,
        data: address.toJson(),
      ),
      converter: (json) {
        if (json['success'] == false) throw const AddressesRemoteDataFailure();
        return json['id'] as String;
      },
      failure: AddressesRemoteDataFailure.new,
    );
  }

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
        converter: (json) => json['susses'] as bool, // ! susses -> success
        failure: AddressesRemoteDataFailure.new,
      );

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
