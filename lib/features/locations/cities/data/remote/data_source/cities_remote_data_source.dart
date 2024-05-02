import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/api_constants.dart';
import 'package:niagara_app/features/locations/cities/data/remote/dto/city_dto.dart';

/// Интерфейс для реализации удаленного источника данных локаций.
abstract interface class ICitiesRemoteDataSource {
  Future<Either<Failure, List<CityDto>>> getCities();
}

@LazySingleton(as: ICitiesRemoteDataSource)
class CitiesRemoteDatasource implements ICitiesRemoteDataSource {
  CitiesRemoteDatasource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, List<CityDto>>> getCities() =>
      _requestHandler.sendRequest<List<CityDto>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetCities,
        ),
        converter: (json) => json
            .map((e) => e as Map<String, dynamic>)
            .toList()
            .map(CityDto.fromJson)
            .toList(),
        failure: CitiesRemoteDataFailure.new,
      );
}
