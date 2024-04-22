import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/api_constants.dart';
import 'package:niagara_app/features/location/data/models/city_model.dart';
import 'package:niagara_app/features/location/domain/entities/location.dart';

/// Интерфейс для реализации удаленного источника данных локаций.
///
/// Возвращает список городов и магазинов.
abstract interface class ILocationsRemoteDatasource {
  /// Получает список городов и магазинов.
  ///
  /// Возвращает список городов в виде списка [Location].
  Future<Either<Failure, List<CityModel>>> getCities();
}

@LazySingleton(as: ILocationsRemoteDatasource)
class LocationsRemoteDatasource implements ILocationsRemoteDatasource {
  LocationsRemoteDatasource({
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
        failure: CitiesDataFailure.new,
      );
}
