import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/api_constants.dart';
import 'package:niagara_app/features/location/data/locations/remote/dto/location_dto.dart';

/// Интерфейс для работы с локациями в удаленном источнике данных.
abstract interface class ILocationsRemoteDatasource {
  Future<Either<Failure, List<LocationDto>>> getLocations();

  Future<Either<Failure, String>> addLocation({
    required LocationDto location,
    String? phone,
  });

  Future<Either<Failure, bool>> deleteLocation({
    required LocationDto location,
  });

  Future<Either<Failure, bool>> checkLocation({
    required LocationDto location,
  });
}

@LazySingleton(as: ILocationsRemoteDatasource)
class LocationsRemoteDatasource implements ILocationsRemoteDatasource {
  LocationsRemoteDatasource({
    required RequestHandler requestHandler,
  }) : _requestHandler = requestHandler;

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, List<LocationDto>>> getLocations() =>
      _requestHandler.sendRequest<List<LocationDto>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetLocations,
        ),
        converter: (json) => json
            .map((e) => e as Map<String, dynamic>)
            .toList()
            .map(LocationDto.fromJson)
            .toList(),
        failure: LocationsRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, String>> addLocation({
    required LocationDto location,
    String? phone,
  }) async {
    return _requestHandler.sendRequest<String, Map<String, dynamic>>(
      request: (dio) => dio.post(
        ApiConst.kAddLocation,
        data: {
          // ? Для обновления адреса нужен locationId
          ...location.toJson(),
          // ? Для добавления нового адреса нужен номер телефона/логин
          if (location.locationId.isEmpty && phone != null) 'PHONE': phone,
        },
      ),
      converter: (json) {
        if (json['susses'] == false) {
          throw const LocationsRemoteDataFailure();
        }
        return json['id'] as String; // ! susses -> success
      },
      useDecode: true,
      failure: LocationsRemoteDataFailure.new,
    );
  }

  @override
  Future<Either<Failure, bool>> deleteLocation({
    required LocationDto location,
  }) async =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.delete(
          ApiConst.kDeleteLocation,
          data: {
            'LOCATION_ID': location.locationId,
          },
        ),
        converter: (json) => json['susses'] as bool, // ! susses -> success
        useDecode: true,
        failure: LocationsRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, bool>> checkLocation({
    required LocationDto location,
  }) async =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kCheckLocation,
          data: {
            'CITY': location.city,
            'LAT': location.latitude,
            'LON': location.longitude,
          },
        ),
        converter: (json) => json as bool,
        failure: LocationsRemoteDataFailure.new,
      );
}
