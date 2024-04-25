import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/api_constants.dart';
import 'package:niagara_app/features/location/data/locations/remote/dto/location_dto.dart';

/// Интерфейс для работы с локациями в удаленном источнике данных.
abstract interface class ILocationsRemoteDatasource {
  Future<Either<Failure, List<LocationDto>>> getLocations();
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
}
