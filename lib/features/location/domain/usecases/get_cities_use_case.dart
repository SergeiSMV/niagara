import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/entities/location.dart';
import 'package:niagara_app/features/location/domain/repositories/location_repository.dart';

@injectable
class GetCitiesUseCase extends UseCase<List<Location>, NoParams> {
  GetCitiesUseCase({
    required ILocationRepository locationRepository,
  }) : _locationRepository = locationRepository;

  final ILocationRepository _locationRepository;

  @override
  Future<Either<Failure, List<Location>>> call([NoParams? params]) =>
      _locationRepository.getCities();
}
