import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/data/datasources/cities/local/cities_local_datasource.dart';
import 'package:niagara_app/features/location/data/datasources/cities/remote/cities_remote_datasource.dart';
import 'package:niagara_app/features/location/data/mappers/city_mapper.dart';
import 'package:niagara_app/features/location/domain/entities/locality.dart';
import 'package:niagara_app/features/location/domain/repositories/cities_repository.dart';

@LazySingleton(as: ICitiesRepository)
class CitiesRepository extends BaseRepository implements ICitiesRepository {
  CitiesRepository({
    required ICitiesRemoteDatasource remote,
    required ICitiesLocalDatasource local,
    required super.logger,
  })  : _remote = remote,
        _local = local;

  final ICitiesRemoteDatasource _remote;
  final ICitiesLocalDatasource _local;

  @override
  Failure get failure => const CitiesRepositoryFailure();

  @override
  Future<Either<Failure, List<City>>> getCities() => execute(
        () => _remote.getCities().fold(
              (failure) => throw failure,
              (cities) => cities.map((e) => e.toCity()).toList(),
            ),
      );

  @override
  Future<Either<Failure, City>> getCity() => execute(
        () async => _local.getCity().fold(
              (failure) => throw failure,
              (cityModel) => cityModel.toCity(),
            ),
      );

  @override
  Future<Either<Failure, void>> setCity({required City city}) =>
      execute(() async => _local.setCity(city.toModel()));
}
