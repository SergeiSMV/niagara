import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/data/cities/local/data_source/cities_local_data_source.dart';
import 'package:niagara_app/features/location/data/cities/mappers/city_dto_mapper.dart';
import 'package:niagara_app/features/location/data/cities/mappers/city_entity_mapper.dart';
import 'package:niagara_app/features/location/data/cities/remote/data_source/cities_remote_data_source.dart';
import 'package:niagara_app/features/location/domain/models/city.dart';
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
              (dtos) => dtos.map((dto) => dto.toModel()).toList(),
            ),
      );

  @override
  Future<Either<Failure, City>> getCity() => execute(
        () async => _local.getCity().fold(
              (failure) => throw failure,
              (entity) => entity.toModel(),
            ),
      );

  @override
  Future<Either<Failure, void>> setCity({required City city}) =>
      execute(() async => _local.setCity(city.toEntity()));
}
