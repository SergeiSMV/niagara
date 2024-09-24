import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/cities/data/local/data_source/cities_local_data_source.dart';
import 'package:niagara_app/features/locations/cities/data/mappers/city_dto_mapper.dart';
import 'package:niagara_app/features/locations/cities/data/mappers/city_entity_mapper.dart';
import 'package:niagara_app/features/locations/cities/data/remote/data_source/cities_remote_data_source.dart';
import 'package:niagara_app/features/locations/cities/domain/models/city.dart';
import 'package:niagara_app/features/locations/cities/domain/repositories/cities_repository.dart';

@LazySingleton(as: ICitiesRepository)
class CitiesRepository extends BaseRepository implements ICitiesRepository {
  CitiesRepository(
    super._logger,
    super._networkInfo,
    this._citiesRDS,
    this._citiesLDS,
  );

  final ICitiesRemoteDataSource _citiesRDS;
  final ICitiesLocalDataSource _citiesLDS;

  @override
  Failure get failure => const CitiesRepositoryFailure();

  @override
  Future<Either<Failure, List<City>>> getCities() => execute(
        () => _citiesRDS.getCities().fold(
              (failure) => throw failure,
              (dtos) => dtos.map((dto) => dto.toModel()).toList(),
            ),
      );

  @override
  Future<Either<Failure, City>> getCity() => execute(
        () async => _citiesLDS.getCity().fold(
              (failure) => throw failure,
              (entity) => entity.toModel(),
            ),
      );

  @override
  Future<Either<Failure, void>> setCity({required City city}) => execute(
        () async => _citiesRDS.setCity(city: city.toDto()).fold(
              (failure) => throw failure,
              (established) => established
                  ? _citiesLDS.setCity(city.toEntity())
                  : throw failure,
            ),
      );
}
