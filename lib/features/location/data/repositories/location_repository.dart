import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/data/datasources/locations_remote_datasource.dart';
import 'package:niagara_app/features/location/data/mappers/city_to_location_mapper.dart';
import 'package:niagara_app/features/location/domain/entities/location.dart';
import 'package:niagara_app/features/location/domain/repositories/location_repository.dart';

@LazySingleton(as: ILocationRepository)
class LocationRepository extends BaseRepository implements ILocationRepository {
  LocationRepository({
    required ILocationsRemoteDatasource remoteDatasource,
    required super.logger,
  }) : _remoteDatasource = remoteDatasource;

  final ILocationsRemoteDatasource _remoteDatasource;

  @override
  Future<Either<Failure, List<Location>>> getCities() =>
      execute(_getCities, const CitiesDataFailure());

  Future<List<Location>> _getCities() async {
    return _remoteDatasource.getCities().fold(
      (failure) => throw const CitiesDataFailure(),
      (cities) {
        if (cities.isEmpty) throw const CitiesDataFailure();
        return cities.map((city) => city.toLocation()).toList();
      },
    );
  }

  @override
  Future<Either<Failure, Location>> getCity() {
   
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> setCity(Location location) {
  
    throw UnimplementedError();
  }
}
