import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/api_constants.dart';
import 'package:niagara_app/features/location/data/models/city_model.dart';

/// Интерфейс для реализации удаленного источника данных локаций.
///
/// Возвращает список городов
abstract interface class ICitiesRemoteDatasource {
  /// Получает список городов
  Future<Either<Failure, List<CityModel>>> getCities();
}

@LazySingleton(as: ICitiesRemoteDatasource)
class CitiesRemoteDatasource implements ICitiesRemoteDatasource {
  CitiesRemoteDatasource({
    required RequestHandler requestHandler,
  }) : _requestHandler = requestHandler;

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, List<CityModel>>> getCities() =>
      _requestHandler.sendRequest<List<CityModel>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetCities,
        ),
        converter: (json) => json
            .map((e) => e as Map<String, dynamic>)
            .toList()
            .map(CityModel.fromJson)
            .toList(),
        failure: CitiesRemoteDataFailure.new,
      );
}
