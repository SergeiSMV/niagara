import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/api_constants.dart';
import 'package:niagara_app/features/location/data/models/location_model.dart';

abstract interface class ILocationsRemoteDatasource {
  /// Получает список локаций
  Future<Either<Failure, List<LocationModel>>> getLocations();
}

@LazySingleton(as: ILocationsRemoteDatasource)
class LocationsRemoteDatasource implements ILocationsRemoteDatasource {
  LocationsRemoteDatasource({
    required RequestHandler requestHandler,
  }) : _requestHandler = requestHandler;

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, List<LocationModel>>> getLocations() =>
      _requestHandler.sendRequest<List<LocationModel>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetLocations,
        ),
        converter: (json) => json
            .map((e) => e as Map<String, dynamic>)
            .toList()
            .map(LocationModel.fromJson)
            .toList(),
        failure: LocationsRemoteDataFailure.new,
      );
}
